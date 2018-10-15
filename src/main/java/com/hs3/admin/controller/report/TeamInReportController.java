package com.hs3.admin.controller.report;

import java.math.BigDecimal;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.report.TeamInReport;
import com.hs3.entity.users.User;
import com.hs3.models.PageData;
import com.hs3.models.report.TeamInReportModel;
import com.hs3.service.report.TeamInReportService;
import com.hs3.service.report.TeamReportService;
import com.hs3.service.user.UserService;
import com.hs3.utils.DateUtils;
import com.hs3.utils.StrUtils;


@Controller
@Scope("prototype")
@RequestMapping({"/admin/teamInReport"})
public class TeamInReportController
        extends AdminController {
    @Autowired
    private TeamInReportService teamInReportService;
    @Autowired
    private UserService userService;

    @RequestMapping(value = {"/index"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object index(String tabId) {
        ModelAndView mv = getView("/report/teamInIndex");
        addAdminWebDefaultTime(mv);
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(String account, String profitHistoryAndNow, String startTime, String endTime, Integer test) {
        Page p = getPageWithParams();
        TeamInReport m = new TeamInReport();
        List<TeamInReportModel> teamInList = new ArrayList<>();
        TeamInReport a;
        BigDecimal marginDollar;
        if ("0".equals(profitHistoryAndNow)) {
            if (!StrUtils.hasEmpty(new Object[]{account})) {
                Date curDate = new Date();
                m.setCreateDate(curDate);
                m.setAccount(account);
                m.setTest(test);
                List<TeamInReport> list = this.teamInReportService.list(p, m);
                for (Iterator<TeamInReport> localIterator = list.iterator(); localIterator.hasNext(); ) {
                    a = (TeamInReport) localIterator.next();
                    if (a.getBetAmount() != null) {
                        TeamInReportModel model = new TeamInReportModel();
                        model.setAccount(a.getAccount());
                        model.setCreateDate(a.getCreateDate());
                        model.setBetAmount(a.getBetAmount());
                        model.setWinAmount(a.getWinAmount());
                        model.setTotalAmount(a.getTotalAmount());
                        marginDollar = a.getBetAmount().subtract(a.getWinAmount());
                        model.setMarginDollar(marginDollar);
                        if (a.getBetAmount().equals(new BigDecimal("0.0000"))) {
                            model.setMarginRatio(new BigDecimal("0"));
                            model.setProfitRatio(new BigDecimal("0"));
                        } else {
                            model.setMarginRatio(marginDollar.divide(a.getBetAmount(), 4, 0).multiply(new BigDecimal("100")));
                            model.setProfitRatio(a.getTotalAmount().divide(a.getBetAmount(), 4, 0).multiply(new BigDecimal("100")));
                        }
                        model.setStatus(1);
                        model.setStartDate(startTime);
                        model.setEndDate(endTime);
                        model.setCurDate(curDate);
                        model.setTest(test);
                        teamInList.add(model);
                    }
                }
            } else {
                Date curDate = new Date();
                m.setCreateDate(curDate);
                m.setTest(test);
                teamInList = this.teamInReportService.getTodayProxyTeamData(m, startTime, endTime, 1);
            }
        } else if ("2".equals(profitHistoryAndNow)) {
            if (!StrUtils.hasEmpty(new Object[]{account})) {
                m.setAccount(account);
                m.setTest(test);
                List<TeamInReport> list = this.teamInReportService.adminNewHistoryDetails(p, m, startTime, endTime);
                for (TeamInReport a1 : list) {
                    TeamInReportModel model = new TeamInReportModel();
                    model.setAccount(a1.getAccount());
                    model.setCreateDate(a1.getCreateDate());
                    model.setBetAmount(a1.getBetAmount());
                    model.setWinAmount(a1.getWinAmount());
                    model.setTotalAmount(a1.getTotalAmount());
                    BigDecimal marginDollar1 = a1.getBetAmount().subtract(a1.getWinAmount());
                    model.setMarginDollar(marginDollar1);
                    if (a1.getBetAmount().equals(new BigDecimal("0.0000"))) {
                        model.setMarginRatio(new BigDecimal("0"));
                        model.setProfitRatio(new BigDecimal("0"));
                    } else {
                        model.setMarginRatio(marginDollar1.divide(a1.getBetAmount(), 4, 0).multiply(new BigDecimal("100")));
                        model.setProfitRatio(a1.getTotalAmount().divide(a1.getBetAmount(), 4, 0).multiply(new BigDecimal("100")));
                    }
                    model.setStatus(2);
                    model.setStartDate(startTime);
                    model.setEndDate(endTime);
                    model.setTest(test);
                    teamInList.add(model);
                }
            } else {
                List<User> accountList = this.userService.getAccountList(test);
                for (User u : accountList) {
                    m.setAccount(u.getAccount());
                    m.setTest(test);
//         Object list = this.teamInReportService.adminNewHistoryDetails(p, m, startTime, endTime);
                    List<TeamInReport> list = this.teamInReportService.adminNewHistoryDetails(p, m, startTime, endTime);
//          marginDollar = ((List)list).iterator(); continue;
                    TeamInReport a1 = list.get(0);
                    TeamInReportModel model = new TeamInReportModel();
                    model.setAccount(a1.getAccount());
                    model.setCreateDate(a1.getCreateDate());
                    model.setBetAmount(a1.getBetAmount());
                    model.setWinAmount(a1.getWinAmount());
                    model.setTotalAmount(a1.getTotalAmount());
                    BigDecimal marginDollar1 = a1.getBetAmount().subtract(a1.getWinAmount());
                    model.setMarginDollar(marginDollar1);
                    if (a1.getBetAmount().equals(new BigDecimal("0.0000"))) {
                        model.setMarginRatio(new BigDecimal("0"));
                        model.setProfitRatio(new BigDecimal("0"));
                    } else {
                        model.setMarginRatio(marginDollar1.divide(a1.getBetAmount(), 4, 0).multiply(new BigDecimal("100")));
                        model.setProfitRatio(a1.getTotalAmount().divide(a1.getBetAmount(), 4, 0).multiply(new BigDecimal("100")));
                    }
                    model.setStatus(2);
                    model.setStartDate(startTime);
                    model.setEndDate(endTime);
                    model.setTest(test);
                    teamInList.add(model);
                }

            }
        } else if ("1".equals(profitHistoryAndNow)) {
            if (!StrUtils.hasEmpty(new Object[]{account})) {
                m.setAccount(account);
                m.setTest(test);
                List<TeamInReport> list = this.teamInReportService.adminNewHistoryStatistics(p, m, startTime, endTime);
                for (TeamInReport a1 : list) {
                    TeamInReportModel model = new TeamInReportModel();
                    model.setAccount(a1.getAccount());
                    model.setCreateDate(a1.getCreateDate());
                    model.setBetAmount(a1.getBetAmount());
                    model.setWinAmount(a1.getWinAmount());
                    model.setTotalAmount(a1.getTotalAmount());
                    BigDecimal marginDollar1 = a1.getBetAmount().subtract(a1.getWinAmount());
                    model.setMarginDollar(marginDollar1);
                    if (a1.getBetAmount().equals(new BigDecimal("0.0000"))) {
                        model.setMarginRatio(new BigDecimal("0"));
                        model.setProfitRatio(new BigDecimal("0"));
                    } else {
                        model.setMarginRatio(marginDollar1.divide(a1.getBetAmount(), 4, 0).multiply(new BigDecimal("100")));
                        model.setProfitRatio(a1.getTotalAmount().divide(a1.getBetAmount(), 4, 0).multiply(new BigDecimal("100")));
                    }
                    model.setStatus(3);
                    model.setStartDate(startTime);
                    model.setEndDate(endTime);
                    model.setTest(test);
                    teamInList.add(model);
                }
            }
        }

        return new PageData(p.getRowCount(), teamInList);
    }


    @RequestMapping(value = {"/teamInDelIndex"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object detailsIndex(String account, Integer status, Integer test, String curDate, String startDate, String endDate) {
        ModelAndView mv = getView("/report/teamInDelIndex");
        mv.addObject("account", account);
        mv.addObject("status", status);
        mv.addObject("test", test);
        mv.addObject("curDate", curDate);
        mv.addObject("startDate", startDate);
        mv.addObject("endDate", endDate);
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/viewDetails"})
    public Object viewDetails(String account, Integer status, Integer test, String curDate, String startDate, String endDate) throws ParseException {
        Page p = getPageWithParams();
        List<TeamInReportModel> profitList = new ArrayList<>();
        if (status.intValue() == 1) {

            TeamInReport m = new TeamInReport();
            m.setAccount(account);
            m.setTest(test);
            m.setCreateDate(DateUtils.toDate(curDate));
            profitList = this.teamInReportService.getTodayTeamData(m, startDate, endDate, status);
        } else {
            TeamInReport m = new TeamInReport();
            m.setAccount(account);
            m.setTest(test);
            List<TeamInReport> list = this.teamInReportService.newHistoryDetails(p, m, startDate, endDate);
            for (TeamInReport a : list) {
                TeamInReportModel model = new TeamInReportModel();
                model.setAccount(a.getAccount());
                model.setCreateDate(a.getCreateDate());
                model.setBetAmount(a.getBetAmount());
                model.setWinAmount(a.getWinAmount());
                model.setTotalAmount(a.getTotalAmount());
                BigDecimal marginDollar = a.getBetAmount().subtract(a.getWinAmount());
                model.setMarginDollar(marginDollar);
                if (a.getBetAmount().equals(new BigDecimal("0.0000"))) {
                    model.setMarginRatio(new BigDecimal("0"));
                    model.setProfitRatio(new BigDecimal("0"));
                } else {
                    model.setMarginRatio(marginDollar.divide(a.getBetAmount(), 4, 0).multiply(new BigDecimal("100")));
                    model.setProfitRatio(a.getTotalAmount().divide(a.getBetAmount(), 4, 0).multiply(new BigDecimal("100")));
                }
                model.setStartDate(startDate);
                model.setEndDate(endDate);
                model.setStatus(status.intValue());
                model.setTest(test);
                profitList.add(model);
            }
        }
        return profitList;
    }
}
