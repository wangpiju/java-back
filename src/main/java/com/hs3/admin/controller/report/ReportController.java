package com.hs3.admin.controller.report;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.lotts.AccountChangeType;
import com.hs3.entity.lotts.Bet;
import com.hs3.entity.lotts.BetBackup;
import com.hs3.entity.lotts.Lottery;
import com.hs3.entity.lotts.Trace;
import com.hs3.entity.report.UserState;
import com.hs3.entity.report.ZongDaiState;
import com.hs3.lotts.LotteryBase;
import com.hs3.lotts.LotteryFactory;
import com.hs3.lotts.PlayerBase;
import com.hs3.models.CommonModel;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.models.lotts.AdminBetDetail;
import com.hs3.models.lotts.TraceModel;
import com.hs3.models.report.AllChange;
import com.hs3.service.lotts.AccountChangeTypeService;
import com.hs3.service.lotts.BetBackupService;
import com.hs3.service.lotts.BetService;
import com.hs3.service.lotts.LotteryService;
import com.hs3.service.lotts.SettlementService;
import com.hs3.service.lotts.TraceService;
import com.hs3.service.report.UserStateService;
import com.hs3.utils.DateUtils;

import java.io.PrintStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@Scope("prototype")
@RequestMapping({"/admin/report"})
public class ReportController extends AdminController {
    @Autowired
    private SettlementService settlementService;
    @Autowired
    private BetService betService;
    @Autowired
    private TraceService traceService;
    @Autowired
    private AccountChangeTypeService accountChangeTypeService;
    @Autowired
    private LotteryService lotteryService;
    @Autowired
    private UserStateService userStateService;
    @Autowired
    private BetBackupService betBackupService;

    @ResponseBody
    @RequestMapping({"/listForSettlement"})
    public Object listForSettlement(CommonModel m) {
        Page p = getPageWithParams();
        List<AllChange> list = this.settlementService.newAdminList(p, m);
        return new PageData(p.getRowCount(), list);
    }

    @RequestMapping({"/settlementIndex"})
    public Object settlementIndex(String account, Date t1, Date t2) {
        ModelAndView mv = getView("/lotts/settlementIndex");
        mv.addObject("account", account);
        if (t1 != null) {
            if (t2 != null) {
                if (t1.getTime() < t2.getTime()) {
                    mv.addObject("begin", DateUtils.format(t1));
                    mv.addObject("end", DateUtils.format(t2));
                } else {
                    mv.addObject("begin", DateUtils.format(t2));
                    mv.addObject("end", DateUtils.format(t1));
                }
            } else {
                mv.addObject("begin", DateUtils.format(t1));
            }
        }
        List<AccountChangeType> accountChangeType = this.accountChangeTypeService.listByType(null);
        List<Lottery> lotteryList = this.lotteryService.list(null);
        mv.addObject("accountChangeTypeJson", accountChangeType);
        mv.addObject("lotteryList", lotteryList);
        mv.addObject("groups", LotteryFactory.getGroups());


        return mv;
    }

    @ResponseBody
    @RequestMapping({"/findForSettlement"})
    public Object findForSettlement(Integer id) {
        ModelAndView mv = getView("/lotts/settlement");
        com.hs3.entity.lotts.AmountChange model = this.settlementService.find(id);
        if (model != null) {
            mv.addObject("model", model);
        }
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/listForBet"})
    public Object listForBet(CommonModel m) {
        Page p = getPageWithParams();
        List<Map<String, Object>> list = this.betService.adminList_Z(p, m);
        return new PageData(p.getRowCount(), p.getObj(), list);
    }

    @ResponseBody
    @RequestMapping({"/listForBetBackup"})
    public Object listForBetBackup(CommonModel m) {
        Page p = getPageWithParams();
        if (m.getStartTime() == null) m.setStartTime(DateUtils.formatDate(new Date()) + " 00:00:00");
        if (m.getEndTime() == null) m.setEndTime(DateUtils.formatDate(new Date()) + " 23:59:59");
        List<BetBackup> list = this.betBackupService.adminList(p, m);
        return new PageData(p.getRowCount(), list);
    }

    @RequestMapping({"/userState"})
    public Object userState() {
        ModelAndView mv = getView("/lotts/userState");
        UserState userState = this.userStateService.getUserState();
        mv.addObject("userState", userState);
        return mv;
    }

    @RequestMapping({"/zongDaiIndex"})
    public Object getZongDaiState() {
        ModelAndView mv = getView("/lotts/zongDaiState");
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/listZongDaiState"})
    public Object listZongDaiState() {
        Page p = getPageWithParams();
        List<ZongDaiState> list = this.userStateService.getZongDaiState(p);
        return new PageData(p.getRowCount(), list);
    }

    @RequestMapping({"/betIndex"})
    public Object betIndex(String account, Date t1, Date t2) {
        ModelAndView mv = getView("/lotts/betIndex");
        mv.addObject("account", account);
        if (t1 != null) {
            if (t2 != null) {
                if (t1.getTime() < t2.getTime()) {
                    mv.addObject("begin", DateUtils.format(t1));
                    mv.addObject("end", DateUtils.format(t2));
                } else {
                    mv.addObject("begin", DateUtils.format(t2));
                    mv.addObject("end", DateUtils.format(t1));
                }
            } else {
                mv.addObject("begin", DateUtils.format(t1));
            }
        }
        List<Lottery> lotteryList = this.lotteryService.list(null);
        mv.addObject("lotteryList", lotteryList);
        mv.addObject("groups", LotteryFactory.getGroups());
        return mv;
    }

    @RequestMapping({"/betBackupIndex"})
    public Object betBackupIndex() {
        ModelAndView mv = getView("/lotts/betBackupIndex");
        List<Lottery> lotteryList = this.lotteryService.list(null);
        mv.addObject("lotteryList", lotteryList);
        mv.addObject("groups", LotteryFactory.getGroups());
        return mv;
    }

    @ResponseBody
    @RequestMapping(value = {"/contentBackupDetails"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object contentBackupDetails(String id, Integer n) {
        return Jsoner.success(this.betBackupService.findContentNext(id, n));
    }


    @ResponseBody
    @RequestMapping(value = {"/contentDetails"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object contentDetails(String id, Integer n) {
        return Jsoner.success(this.betService.findContentNext(id, n));
    }

    @ResponseBody
    @RequestMapping({"/findForBet"})
    public Object findForBet(String id) {
        ModelAndView mv = getView("/lotts/betList");
        Bet bet = this.betService.find(id);
        if (bet != null) {
            mv.addObject("bet", bet);
        }
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/listForTrace"})
    public Object listForTrace(TraceModel m) {
        Page p = getPageWithParams();
        List<Trace> list = this.traceService.adminList(p, m);
        return new PageData(p.getRowCount(), list);
    }

    @RequestMapping({"/traceIndex"})
    public Object traceIndex() {
        ModelAndView mv = getView("/lotts/traceIndex");
        List<Lottery> lotteryList = this.lotteryService.list(null);
        mv.addObject("lotteryList", lotteryList);
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/findForTrace"})
    public Object findForTrace(String id) {
        ModelAndView mv = getView("/lotts/traceList");
        List<Bet> bet = this.betService.findByTraceId(id);
        if (bet != null) {
            mv.addObject("bet", bet);
        }
        return mv;
    }

    @ResponseBody
    @RequestMapping(value = {"/getPlayName"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object getPlayName(String name) {
        if ((name != null) && (!"".equals(name))) {
            String title = "'" + name + "'";
            Lottery lottery = this.lotteryService.getGroupNameByLottery(title);
            if (lottery.getGroupName() != null) {
                LotteryBase lotts = LotteryFactory.getInstance(lottery.getGroupName());
                Collection<PlayerBase> players = lotts.getPlayers();
                System.out.println(players.iterator());
            }
        }

        return name;
    }

    @RequestMapping({"/traceDetailsIndex"})
    public Object traceDetailsIndex(String id) {
        ModelAndView mv = getView("/lotts/traceDetails");
        Trace trace = this.traceService.find(id);
        mv.addObject("trace", trace);
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/traceDetails"})
    public Object traceDetails(String traceId) {
        Page p = getPageWithParams();
        List<Bet> list = this.betService.summaryList(p, traceId);
        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/canCleOrder"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object canCleOrder(String id, String account) {
        List<String> strId = new ArrayList();
        strId.add(id);
        return this.betService.saveUserCancelOrder(strId, account);
    }

    @ResponseBody
    @RequestMapping(value = {"/cleAllOrder"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object cleAllOrder(String zid) {
        List<String> strId = new ArrayList();
        List<Bet> bets = this.betService.getAllTraceCanCancel(zid);
        if (bets.size() > 0) {
            for (Bet bet : bets) {
                strId.add(bet.getId());
            }

        } else {
            return Jsoner.error("没有相应的追号撤单");
        }
        return this.betService.saveUserCancelOrder(strId, ((Bet) bets.get(0)).getAccount());
    }

    @ResponseBody
    @RequestMapping(value = {"/showBetDetail"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object showBetDetail(String id, String account) {
        AdminBetDetail adminBetDetail = this.betService.showBetDetail(id, account);
        return adminBetDetail;
    }

    @ResponseBody
    @RequestMapping(value = {"/showBetBackupDetail"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object showBetBackupDetail(String id, String account) {
        AdminBetDetail adminBetDetail = this.betBackupService.showBetDetail(id, account);
        return adminBetDetail;
    }


    @ResponseBody
    @RequestMapping(value = {"/ajaxAdminSelect"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object ajaxAdminSelect(String lotteryId) {
        Map<String, String> map = new HashMap();
        if ((lotteryId != null) && (!"".equals(lotteryId))) {
            Lottery lottery = this.lotteryService.getGroupNameByLottery(lotteryId);
            LotteryBase base = LotteryFactory.getInstance(lottery.getGroupName());

            Collection<PlayerBase> playerBase = base.getPlayers();
            Iterator<PlayerBase> it = playerBase.iterator();
            while (it.hasNext()) {
                PlayerBase str = (PlayerBase) it.next();
                String id = str.getId();
                String name = str.getFullTitle();
                map.put(id, name);
            }
        }
        return map;
    }
}
