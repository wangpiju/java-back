package com.hs3.admin.controller.lotts;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.lotts.Lottery;
import com.hs3.entity.lotts.LotteryGroup;
import com.hs3.entity.lotts.LotterySeason;
import com.hs3.entity.users.Manager;
import com.hs3.exceptions.BaseCheckException;
import com.hs3.lotts.LotteryBase;
import com.hs3.lotts.LotteryFactory;
import com.hs3.lotts.crawler.WebCrawlerManager;
import com.hs3.lotts.rule.SeasonBuilderFactory;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.models.lotts.SimpleSeason;
import com.hs3.models.lotts.SimpleSeasonModel;
import com.hs3.service.lotts.BetService;
import com.hs3.service.lotts.CreateSeasonService;
import com.hs3.service.lotts.LotteryGroupService;
import com.hs3.service.lotts.LotterySaleRuleService;
import com.hs3.service.lotts.LotterySaleTimeService;
import com.hs3.service.lotts.LotterySeasonService;
import com.hs3.service.lotts.LotteryService;
import com.hs3.service.lotts.PlayerService;
import com.hs3.service.lotts.SettlementService;
import com.hs3.utils.StrUtils;

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
@RequestMapping({"/admin/lotts"})
public class LotteryController
        extends AdminController {
    @Autowired
    private LotteryService lotteryService;
    @Autowired
    private LotteryGroupService lotteryGroupService;
    @Autowired
    private PlayerService playerService;
    @Autowired
    private LotterySaleTimeService lotterySaleTimeService;
    @Autowired
    private LotterySeasonService lotterySeasonService;
    @Autowired
    private BetService betService;
    @Autowired
    private CreateSeasonService createSeasonService;
    @Autowired
    private SettlementService settlementService;
    @Autowired
    private LotterySaleRuleService lotterySaleRuleService;

    @ResponseBody
    @RequestMapping({"/processEmergency"})
    public Object processEmergency(String lotteryId, String seasonIdBegin, Integer force) {
        try {
            String seasonIdBegintrim = seasonIdBegin.replaceAll(" ", "");
            if (StrUtils.hasEmpty(new Object[]{seasonIdBegintrim})) return Jsoner.error("请填写完整期号");
            this.settlementService.saveEmergency(lotteryId, seasonIdBegintrim, (force != null) && (force.intValue() == 0));
        } catch (BaseCheckException e) {
            return Jsoner.error(e.getMessage());
        }
        return Jsoner.success();
    }

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/lotts/index");
        mv.addObject("groups", LotteryFactory.getGroups());
        mv.addObject("seasonRules", SeasonBuilderFactory.getList());

        List<LotteryGroup> list = this.lotteryGroupService.list(null, null);
        mv.addObject("groupId", list);
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list() {
        Page p = getPageWithParams();
        List<Lottery> list = this.lotteryService.listAndOrder(p);
        return new PageData(p.getRowCount(), list);
    }

    @RequestMapping({"/open"})
    public Object open(String lotteryId) {
        ModelAndView mv = getView("/lotts/open");
        mv.addObject("lotteryId", lotteryId);
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/openList"})
    public Object openList(String lotteryId) {
        Page p = getPageWithParams();
        List<LotterySeason> list = this.lotterySeasonService.list(lotteryId, p);
        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(Lottery m) {
        LotteryBase lottBase = LotteryFactory.getInstance(m.getGroupName());
        if (lottBase == null) {
            return Jsoner.error("错误的彩种组");
        }
        m.setGroupId(lottBase.getGroupId());
        this.lotteryService.save(m);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(String id) {
        return this.lotteryService.find(id);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(Lottery m) {
        LotteryBase lottBase = LotteryFactory.getInstance(m.getGroupName());
        if (lottBase == null) {
            return Jsoner.error("错误的彩种组");
        }
        m.setGroupId(lottBase.getGroupId());
        if (this.lotteryService.update(m) == 1) {
            return Jsoner.success();
        }
        return Jsoner.error();
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String id) {
        this.lotteryService.deleteRelevance(id);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/cancel"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object cancel(String lotteryId, String startSeasonId, String endSeasonId) {
        if (StrUtils.hasEmpty(new Object[]{startSeasonId, endSeasonId})) return Jsoner.error("请填写完整期号");
        return this.betService.saveManCancelOrder(lotteryId, startSeasonId, endSeasonId, ((Manager) getLogin()).getAccount());
    }

    @ResponseBody
    @RequestMapping(value = {"/createSeason"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object createSeason(String lotteryId, Date startDate, Integer days) {
        if (days == null) return Jsoner.error("请填写完整信息");
        this.createSeasonService.saveSeason(lotteryId, startDate, days);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/reSettlement"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object reSettlement(String lotteryId, String seasonId, String openNum, Integer enforce) {
        String openNumtrim = openNum.replaceAll(" ", "");
        String seasonIdtrim = seasonId.replaceAll(" ", "");
        if (StrUtils.hasEmpty(new Object[]{seasonIdtrim, openNumtrim})) return Jsoner.error("请填写完整信息");
        if (openNum.length() >= 40) {
            openNumtrim = this.settlementService.jinuoZssc(openNumtrim);
        }
        Lottery lottery = this.lotteryService.find(lotteryId);
        LotteryBase lotteryBase = LotteryFactory.getInstance(lottery.getGroupName());
        if (!lotteryBase.checkNumber(openNumtrim)) {
            return Jsoner.error("填写号码有误!请重新填写");
        }
        return this.settlementService.saveReSettlement(lotteryId, seasonIdtrim, openNumtrim, ((Manager) getLogin()).getAccount(), enforce);
    }

    @ResponseBody
    @RequestMapping(value = {"/openByUser"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object openByUser(String lotteryId, String seasonId, String openNum) {
        String openNumtrim = openNum.replaceAll(" ", "");
        String seasonIdtrim = seasonId.replaceAll(" ", "");
        if (StrUtils.hasEmpty(new Object[]{seasonIdtrim, openNumtrim})) return Jsoner.error("请填写完整信息");
        if (openNum.length() >= 40) {
            openNumtrim = this.settlementService.jinuoZssc(openNumtrim);
        }
        Lottery lottery = this.lotteryService.find(lotteryId);
        LotteryBase lotteryBase = LotteryFactory.getInstance(lottery.getGroupName());
        if (!lotteryBase.checkNumber(openNumtrim)) {
            return Jsoner.error("填写号码有误!请重新填写");
        }
        WebCrawlerManager webCrawlerManager = new WebCrawlerManager();
        return webCrawlerManager.openByUser(lotteryId, seasonIdtrim, openNumtrim, ((Manager) getLogin()).getAccount());
    }

    @ResponseBody
    @RequestMapping(value = {"/addOpen"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object addOpen(String lotteryId, SimpleSeasonModel simpleSeasons, Integer enforce) {
        for (SimpleSeason ss : simpleSeasons.getSimpleSeasons()) {
            if (StrUtils.hasEmpty(new Object[]{ss.getSeason()})) {
                return Jsoner.error("期号不能为空！");
            }
            if (StrUtils.hasEmpty(new Object[]{ss.getNums()})) {
                return Jsoner.error("号码不能为空！");
            }
        }
        return this.lotterySeasonService.saveBatch(lotteryId, simpleSeasons, enforce);
    }

    @ResponseBody
    @RequestMapping({"/getOpened"})
    public Object getOpenList(String lotteryId, String startSeason, String endSeason) {
        return this.lotterySeasonService.getOpened(lotteryId, startSeason, endSeason);
    }
}
