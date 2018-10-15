package com.hs3.admin.controller.users;

import com.hs3.admin.controller.AdminController;
import com.hs3.dao.user.UserDao;
import com.hs3.db.Page;
import com.hs3.entity.lotts.BonusGroup;
import com.hs3.entity.users.DailyRule;
import com.hs3.models.Jsoner;
import com.hs3.models.user.RootUser;
import com.hs3.models.user.RootUserAddModel;
import com.hs3.service.bank.BankGroupService;
import com.hs3.service.lotts.BonusGroupService;
import com.hs3.service.user.DailyRuleService;
import com.hs3.service.user.DomainService;
import com.hs3.service.user.PrivateRatioRuleService;
import com.hs3.service.user.UserService;
import com.hs3.utils.BeanZUtils;
import com.hs3.utils.ListUtils;
import com.hs3.utils.StrUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;
import java.util.regex.Pattern;


@Controller
@Scope("prototype")
@RequestMapping({"/admin/rootUser"})
public class RootUserController
        extends AdminController {
    @Autowired
    private UserService userService;
    @Autowired
    private BonusGroupService bonusGroupService;
    @Autowired
    private DomainService domainService;
    @Autowired
    private BankGroupService bankGroupService;
    @Autowired
    private DailyRuleService dailyRuleService;
    @Autowired
    private PrivateRatioRuleService privateRatioRuleService;

    @Autowired
    private UserDao userDao;

    @RequestMapping({"/team"})
    public Object index(String account) {
        ModelAndView mv = getView("/user/team");

        Page p = getPageWithParams();
        List<RootUser> list = this.userService.listWithTeam(account, p);
        List<Map<String, Object>> uMapList = null;
        if((list != null) && (list.size() > 0)) {
            uMapList = new ArrayList<Map<String, Object>>();
            Map<String, Object> rumap = null;
            for (RootUser ru : list) {
                rumap = BeanZUtils.transBeanMap(ru);
                int firstRechargeCount = 0;
                String account_z = ru.getAccount();

                List<Map<String, Object>> getRechargeTeamInfo = this.userDao.rechargeFirstUser(account_z, null, new Date());
                if ((getRechargeTeamInfo.size() > 0) && ((getRechargeTeamInfo.get(0)).get("account") != null)) {
                    firstRechargeCount = Integer.valueOf(getRechargeTeamInfo.size());
                }

                rumap.put("firstRechargeCount" , firstRechargeCount);
                uMapList.add(rumap);
            }
        }

        if ((list != null) && (list.size() > 0)) if (!StrUtils.hasEmpty(new Object[]{account})) {
            List<String> userTree = ListUtils.toList(((RootUser) list.get(0)).getParentList());
            mv.addObject("userTree", userTree);
        }
        mv.addObject("list", uMapList);
        mv.addObject("account", account);
        mv.addObject("p", p);


        List<?> bonus = this.bonusGroupService.list(null);
        mv.addObject("bonusGroup", bonus);
        mv.addObject("json", StrUtils.toJson(bonus));
        mv.addObject("bankGroup", this.bankGroupService.list(null));
        mv.addObject("dailyRuleList", this.dailyRuleService.listByStatus(Integer.valueOf(0)));


        mv.addObject("privateRebate", this.privateRatioRuleService.list(null));
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/findDailyRule"})
    public Object findDailyRule(String account, Integer dailyRuleId) {
        Map<String, Object> map = new HashMap();
        DailyRule dailyRule = this.dailyRuleService.find(dailyRuleId);
        if (dailyRule != null) {
            map.put("dailyRule", dailyRule);
        }
        map.put("account", account);
        return Jsoner.success(map);
    }

    @ResponseBody
    @RequestMapping({"/updateDailyRule"})
    public Object updateDailyRule(String account, Integer oldDailyRuleId, Integer dailyRuleId) {
        return Jsoner.getByResult(this.userService.updateDailyRule(account, oldDailyRuleId, dailyRuleId) == 1);
    }

    @ResponseBody
    @RequestMapping({"/bankGroup"})
    public Object bankGroup(String account, String bankGroup) {
        return Jsoner.getByResult(this.userService.setBankGroup(account, bankGroup) == 1);
    }

    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object add() {
        return addshow(null);
    }

    private ModelAndView addshow(String msg) {
        ModelAndView mv = getView("/user/add");
        List<BonusGroup> bonus = this.bonusGroupService.list(null);
        mv.addObject("json", StrUtils.toJson(bonus));
        mv.addObject("bonusGroup", bonus);
        mv.addObject("domains", this.domainService.list(null));
        mv.addObject("bankGroups", this.bankGroupService.list(null));
        if (!StrUtils.hasEmpty(new Object[]{msg})) {
            mv.addObject("msg", msg);
        }
        return mv;
    }

    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(RootUserAddModel user) {
        String account = user.getUser().getAccount();
        if (StrUtils.hasEmpty(new Object[]{account}))
            return addshow("请全部填写");
        if (!Pattern.matches("^[a-zA-Z][\\w]{5,11}", account))
            return addshow("账号必须以字母开头,且只能包含字母、数字、下划线,长度在6~12范围内!");
        if (this.userService.findRecordByAccount(account).intValue() > 0) {
            return addshow("用户名已存在");
        }
        this.userService.addRootUser(user);
        return redirect("team");
    }
}
