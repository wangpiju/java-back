package com.hs3.admin.controller.users;

import com.hs3.admin.controller.AdminController;
import com.hs3.admin.controller.users.vo.UserRebateDetail;
import com.hs3.dao.approval.ApprovalDao;
import com.hs3.db.Page;
import com.hs3.entity.approval.Approval;
import com.hs3.entity.lotts.BonusGroup;
import com.hs3.entity.lotts.BonusGroupDetails;
import com.hs3.entity.lotts.Lottery;
import com.hs3.entity.users.Manager;
import com.hs3.entity.users.PrivateRatioRule;
import com.hs3.entity.users.User;
import com.hs3.entity.users.UserQuota;
import com.hs3.exceptions.BaseCheckException;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.models.user.RootUser;
import com.hs3.service.lotts.BonusGroupDetailsService;
import com.hs3.service.lotts.BonusGroupService;
import com.hs3.service.lotts.LotteryService;
import com.hs3.service.user.PrivateRatioRuleService;
import com.hs3.service.user.UserQuotaService;
import com.hs3.service.user.UserService;
import com.hs3.utils.StrUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


@Controller
@Scope("prototype")
@RequestMapping({"/admin/user"})
public class UserController
        extends AdminController {
    private static final String[] playIds = {"ssc_star3_front", "n11x5_star3_front", "n3_star3", "pk10_star5", "k3_star1"};
    private static final String[] playNames = {"前三直选", "前三直选", "三星直选", "猜前五", "单骰"};

    @Autowired
    private UserService userService;

    @Autowired
    private UserQuotaService userQuotaService;

    @Autowired
    private BonusGroupService bonusGroupService;

    @Autowired
    private BonusGroupDetailsService bonusGroupDetailsService;

    @Autowired
    private LotteryService lotteryService;

    @Autowired
    private PrivateRatioRuleService privateRatioRuleService;
    @Autowired
    private ApprovalDao approvalDao;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/user/index");

        List<?> bonus = this.bonusGroupService.list(null);
        mv.addObject("json", StrUtils.toJson(bonus));
        mv.addObject("bonusGroup", bonus);


        mv.addObject("privateRebateJson", StrUtils.toJson(this.privateRatioRuleService.list(null)));
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object userList(String account, Integer bonusGroup, BigDecimal beginRebateRatio, BigDecimal endRebateRatio, BigDecimal beginAmount, BigDecimal endAmount, Integer regTime, Integer userType, Integer order, Integer test, Integer status, Integer userMark) {
        Page p = getPageWithParams();
        List<RootUser> list = this.userService.listAccountWithTeam(account, bonusGroup, beginRebateRatio, endRebateRatio, beginAmount, endAmount, regTime, userType, order, test, status, userMark, p);


        for (RootUser u : list) {
            u.setPassword(null);
            u.setSafePassword(null);
        }
        return new PageData(p.getRowCount(), list);
    }


    @ResponseBody
    @RequestMapping({"/rebateDetails"})
    public Object rebateDetails(String account) {
        User u = this.userService.findByAccount(account);
        Integer bonusGroupId = u.getBonusGroupId();
        BonusGroup bonusGroup = this.bonusGroupService.find(bonusGroupId);
        List<BonusGroupDetails> bonusGroupDetails = this.bonusGroupDetailsService.listByPlayIdAndGroupId(bonusGroupId, playIds);

        List<Lottery> lottery = this.lotteryService.listAndOrder(null);
        List<UserRebateDetail> list = new ArrayList<>();
        for (Lottery lott : lottery) {
            UserRebateDetail urd = new UserRebateDetail();
            urd.setLotteryName(lott.getTitle());
            for (BonusGroupDetails bgd : bonusGroupDetails) {
                if (bgd.getLotteryId().equals(lott.getId())) {
                    for (int i = 0; i < playIds.length; i++) {
                        if (playIds[i].equals(bgd.getId())) {
                            urd.setPlayName(playNames[i]);

                            BigDecimal userRebateRatio = bgd.getRebateRatio().subtract(bonusGroup.getRebateRatio());
                            userRebateRatio = userRebateRatio.add(u.getRebateRatio());

                            urd.setRebate(userRebateRatio);
                            break;
                        }
                    }
                }
            }
            list.add(urd);
        }
        return list;
    }

    @ResponseBody
    @RequestMapping(value = {"/rechargeInfo"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object rechargeInfo(User m) {
        return Jsoner.getByResult(this.userService.updateRechargeInfo(m));
    }

    @ResponseBody
    @RequestMapping({"/status"})
    public Object status(String account, Integer statusType, String remark, Integer loginStatus, Integer betStatus, Integer betInStatus, Integer depositStatus) {
        String manager = getLogin().getAccount();
        int status = this.userService.setStatus(account, manager, statusType, remark, loginStatus, betStatus, betInStatus, depositStatus);
        if (status == -1)
            return Jsoner.error("请填写备注");
        if (status == 0) {
            return Jsoner.error();
        }
        return Jsoner.success("操作成功:" + status + "人");
    }

    @ResponseBody
    @RequestMapping({"/setMark"})
    public Object status(String account, Integer userMark) {
        this.userService.setMark(account, userMark);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/password"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object password(String account, String password, String password2, Integer status, Integer userMark) {
        if (StrUtils.hasEmpty(new Object[]{account, password, password2}))
            return Jsoner.error("请填写完整信息");
        if (!password.equals(password2))
            return Jsoner.error("两次密码不一致");
        if (status.intValue() == 0) {
            if ((password.length() < 8) || (password.length() > 16)) {
                return Jsoner.error("登录密码长度必须在8~16范围内!");
            }
        } else {
            if ((password.length() != 6)) {
                return Jsoner.error("安全密码长度必须在6范围内!");
            }
        }
        Approval entity = new Approval();


        entity.setStatus(Integer.valueOf(0));
        entity.setUserName(account);
        entity.setPassword(StrUtils.MD5(password));
        entity.setUserIdentify(userMark);
        entity.setCreateTime(new Date());
        entity.setOperator(((Manager) getLogin()).getAccount());
        entity.setRemark("修改密码");
        if (status.intValue() == 0) {
            entity.setApplyContent("修改登录密码");
            entity.setApplyType(Integer.valueOf(0));
        } else {
            entity.setApplyContent("修改安全密码");
            entity.setApplyType(Integer.valueOf(1));
        }

        if (this.approvalDao.save(entity) > 0) {
            return Jsoner.success("修改成功，请联系其他操作人员，通过您的密码修改申请！");
        }
        return Jsoner.error();
    }

    @ResponseBody
    @RequestMapping(value = {"/quota"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object quota(String account) {
        ModelAndView mv = getView("/user/quota");
        mv.addObject("account", account);
        mv.addObject("list", this.userService.listQuota(account));
        return mv;
    }

    @RequestMapping(value = {"/quota"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object quota(UserQuota quota) {
        if (quota.getNum() != null) {
            this.userService.updateQuota(quota);
        }
        return redirect("quota?account=" + quota.getAccount());
    }

    @RequestMapping(value = {"/quotaAdd"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object quotaAdd(UserQuota quota) {
        if (quota.getNum() != null) {
            this.userQuotaService.save(quota);
        }
        return redirect("quota?account=" + quota.getAccount());
    }

    @ResponseBody
    @RequestMapping(value = {"/rebateRatio"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object rebateRatio(String account, BigDecimal rebateRatio) {
        return this.userService.updateQuotaByAdmin(account, rebateRatio);
    }

    @ResponseBody
    @RequestMapping(value = {"/privateRebate"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object privateRebate(String account, Integer privateRebate) {
        User u = this.userService.findByAccount(account);
        PrivateRatioRule oldRule = this.privateRatioRuleService.find(u.getPrivateRebate());
        PrivateRatioRule newRule = this.privateRatioRuleService.find(privateRebate);

        String old = oldRule == null ? "无规则" : oldRule.getName();
        String nos = newRule == null ? "无规则" : newRule.getName();


        Approval app = new Approval();
        app.setStatus(Integer.valueOf(0));
        app.setApplyType(Integer.valueOf(98));
        app.setCreateTime(new Date());
        app.setOperator(((Manager) getLogin()).getAccount());
        app.setUserName(account);
        app.setPassword(privateRebate.toString());
        app.setUserIdentify(u.getUserMark());
        app.setRemark("调整私返规则");
        app.setApplyContent("申请修改用户私返规则 由[" + old + "] 》[" + nos + "]");
        int n = this.approvalDao.save(app);
        if (n > 0) {
            return Jsoner.success("你的操作已提交，请等待风控审核");
        }
        return Jsoner.error();
    }

    @ResponseBody
    @RequestMapping(value = {"/unBank"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object unBank(String account) {
        return Jsoner.getByResult(this.userService.updateBankStatus(account, Integer.valueOf(0)) == 1);
    }


    @ResponseBody
    @RequestMapping(value = {"/modify"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object modify(String account) {
        return Jsoner.getByResult(this.userService.updateAccountType(account) == 1);
    }

    @ResponseBody
    @RequestMapping(value = {"/clearSafeAnswer"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object clearSafeAnswer(String account) {
        return Jsoner.getByResult(this.userService.deleteUserSafe(account) >= 0);
    }

    @ResponseBody
    @RequestMapping(value = {"/updateAremark"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object updateAremark(String account, String adminRemark) {
        return Jsoner.getByResult(this.userService.updateAremark(account, adminRemark) >= 0);
    }

    @ResponseBody
    @RequestMapping(value = {"/updateDailyWagesStatus"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object updateDailyWagesStatus(String account, Integer dailyWagesStatus) {
        int count = 0;
        try {
            count = this.userService.updateDailyWagesStatus(account, dailyWagesStatus);
        } catch (BaseCheckException e) {
            return Jsoner.error(e.getMessage());
        }
        return Jsoner.getByResult(count >= 1);
    }
}
