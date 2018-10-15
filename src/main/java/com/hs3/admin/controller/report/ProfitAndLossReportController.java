package com.hs3.admin.controller.report;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.report.TeamReport;
import com.hs3.entity.users.User;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.models.report.TeamReportModel;
import com.hs3.service.report.TeamReportService;
import com.hs3.service.user.UserService;
import com.hs3.utils.DateUtils;
import com.hs3.utils.StrUtils;

import java.math.BigDecimal;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@Scope("prototype")
@RequestMapping({"/admin/profitReport"})
public class ProfitAndLossReportController
        extends AdminController {
    @Autowired
    private TeamReportService teamReportService;
    @Autowired
    private UserService userService;

    @RequestMapping(value = {"/index"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object index(String tabId) {
        ModelAndView mv = getView("/report/profitIndex");
        addAdminWebDefaultTime(mv);
        return mv;
    }


    @ResponseBody
    @RequestMapping({"/profitUser"})
    public Object profitUser(String account) {
        User user = this.userService.findByAccount(account);
        return Jsoner.success(user);
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object getAdminTeamList(String account, Integer status, Date begin, Date end, Integer test) {
        List<TeamReportModel> profitList = new ArrayList();
        Page p = getPageWithParams();
        if (status == null) {
            status = Integer.valueOf(1);
        }
        if (status.intValue() == 1) {
            List<TeamReport> list = this.teamReportService.getHisTeamDetails(p, account, begin, end, test);
            for (TeamReport a : list) {
                TeamReportModel model = getMerge(begin, end, test, a, status);
                profitList.add(model);
            }

        } else if (!StrUtils.hasEmpty(new Object[]{account})) {
            TeamReport teamReport = this.teamReportService.selfReport(account, begin, end, test);
            if (teamReport != null) {
                TeamReportModel model = getMerge(begin, end, test, teamReport, status);
                profitList.add(model);
            }
        } else {
            List<TeamReport> list = this.teamReportService.getAdminTeamData(p, account, begin, end, test);
            for (TeamReport a : list) {
                TeamReportModel model = getMerge(begin, end, test, a, status);
                profitList.add(model);
            }
        }

        return new PageData(p.getRowCount(), profitList);
    }


    @RequestMapping(value = {"/detailsIndex"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object detailsIndex(String account, Date begin, Date end, Integer test) {
        ModelAndView mv = getView("/report/detailsIndex");
        mv.addObject("account", account);
        mv.addObject("test", test);
        mv.addObject("begin", DateUtils.formatDate(begin));
        mv.addObject("end", DateUtils.formatDate(end));
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/viewDetails"})
    public Object viewDetails(String account, Date begin, Date end, Integer test) throws ParseException {
        Page p = getPageWithParams();
        List<TeamReportModel> profitList = new ArrayList();

        List<TeamReport> list = this.teamReportService.getAdminTeamData(p, account, begin, end, test);
        for (TeamReport a : list) {
            TeamReportModel model = getMerge(begin, end, test, a, Integer.valueOf(2));
            profitList.add(model);
        }
        return new PageData(p.getRowCount(), profitList);
    }


    private TeamReportModel getMerge(Date begin, Date end, Integer test, TeamReport a, Integer status) {
        TeamReportModel model = new TeamReportModel();
        model.setAccount(a.getAccount());
        model.setActivityAndSend(a.getActivityAndSend());
        model.setCreateDate(a.getCreateDate());
        model.setBetAmount(a.getBetAmount());
        model.setRebateAmount(a.getRebateAmount());
        model.setActualSaleAmount(a.getActualSaleAmount());
        model.setWinAmount(a.getWinAmount());
        model.setRechargeAmount(a.getRechargeAmount());
        model.setDrawingAmount(a.getDrawingAmount());
        model.setCount(a.getCount());
        model.setWages(a.getWages());
        BigDecimal marginDollar = a.getActualSaleAmount().subtract(a.getWinAmount());
        model.setMarginDollar(marginDollar);
        if (a.getActualSaleAmount().compareTo(BigDecimal.ZERO) == 0) {
            model.setMarginRatio(new BigDecimal("0"));
            model.setProfitRatio(new BigDecimal("0"));
        } else {
            model.setMarginRatio(marginDollar.divide(a.getActualSaleAmount(), 4, 0).multiply(new BigDecimal("100")));
            model.setProfitRatio(a.getCount().divide(a.getActualSaleAmount(), 4, 0).multiply(new BigDecimal("100")));
        }
        model.setStatus(status);
        model.setBegin(begin);
        model.setEnd(end);
        model.setTest(test);
        return model;
    }
}
