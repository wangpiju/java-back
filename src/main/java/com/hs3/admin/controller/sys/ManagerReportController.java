package com.hs3.admin.controller.sys;

import com.hs3.admin.controller.AdminController;
import com.hs3.entity.sys.SysConfig;
import com.hs3.entity.users.DailyAcc;
import com.hs3.models.Jsoner;
import com.hs3.service.activity.ActivityBetService;
import com.hs3.service.activity.ActivityLossService;
import com.hs3.service.contract.ContractBonusService;
import com.hs3.service.finance.RechargeReportService;
import com.hs3.service.report.OperationReportService;
import com.hs3.service.report.TeamReportService;
import com.hs3.service.report.UserReportService;
import com.hs3.service.sys.SysConfigService;
import com.hs3.service.user.DailyAccService;
import com.hs3.service.user.PrivateRatioService;
import com.hs3.utils.DateUtils;
import com.hs3.utils.StrUtils;
import com.hs3.utils.sys.WebDateUtils;

import java.text.ParseException;
import java.util.Date;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@Scope("prototype")
@RequestMapping({"/admin/managerReport"})
public class ManagerReportController
        extends AdminController {
    private static final Logger logger = Logger.getLogger(ManagerReportController.class);
    @Autowired
    private UserReportService userReportService;
    @Autowired
    private TeamReportService teamReportService;
    @Autowired
    private ActivityBetService activityBetService;
    @Autowired
    private ActivityLossService activityLossService;
    @Autowired
    private OperationReportService operationReportService;
    @Autowired
    private SysConfigService sysConfigService;
    @Autowired
    private ContractBonusService contractBonusService;
    @Autowired
    private PrivateRatioService privateRatioService;
    @Autowired
    private DailyAccService dailyAccService;
    @Autowired
    private RechargeReportService rechargeReportService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/sys/managerReport");
        return mv;
    }

    @ResponseBody
    @RequestMapping(value = {"/createData"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object createData(Integer type, Date createDate) throws ParseException {
        if (StrUtils.hasEmpty(new Object[]{createDate})) {
            return Jsoner.error("日期不能为空！");
        }


        Date yesCreateDate = DateUtils.getDate(DateUtils.addDay(createDate, -1));
        try {
            if (type.intValue() == 0) {

                this.userReportService.deleteByCreateDate(DateUtils.addDay(createDate, -1));
                return Jsoner.getByResult(this.userReportService.createUserReportData(DateUtils.addDay(createDate, -1)));
            }
            if (type.intValue() == 1) {

                this.teamReportService.deleteByCreateDate(DateUtils.addDay(createDate, -1));
                return Jsoner.getByResult(this.teamReportService.createTeamReportData(DateUtils.addDay(createDate, -1)));
            }
            if (type.intValue() == 2) {
                this.activityBetService.updateAmountByBet(yesCreateDate, createDate);
            } else if (type.intValue() == 3) {
                this.activityLossService.updateAmountByLoss(yesCreateDate, createDate);
            } else if (type.intValue() == 4) {
                this.operationReportService.addWhenNotExists(DateUtils.format(DateUtils.addDay(createDate, -1), "yyyy-MM-dd"));
            } else if (type.intValue() == 5) {
                SysConfig sysConfig = this.sysConfigService.find("daliyWagesKey");
                int validAccountCount = sysConfig == null ? 500 : Integer.parseInt(sysConfig.getVal());

                Date beginTime = WebDateUtils.getBeginTime(yesCreateDate);
                Date endTime = WebDateUtils.getEndTime(yesCreateDate);


                for (DailyAcc da : this.dailyAccService.listTeam()) {
                    this.dailyAccService.updateTeamDailyData(da.getAccount(), beginTime, endTime, validAccountCount);
                }
            } else if (type.intValue() == 6) {
                if (!this.contractBonusService.isExistContractBonus(DateUtils.getDate(DateUtils.addDay(createDate, -1)))) {
                    this.contractBonusService.createBonus(createDate);
                } else {
                    return Jsoner.error("契约已存在,不可重复执行");
                }
            } else if (type.intValue() == 7) {
                this.privateRatioService.addRatioToUser(yesCreateDate);
            } else if (type.intValue() == 8) {
                this.rechargeReportService.createRecharge(yesCreateDate);
            }
        } catch (Exception e) {
            logger.error("操作失败：" + e.getMessage(), e);
            return Jsoner.error();
        }
        return Jsoner.success();
    }
}
