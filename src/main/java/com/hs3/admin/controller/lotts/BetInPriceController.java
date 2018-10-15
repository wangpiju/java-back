package com.hs3.admin.controller.lotts;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.lotts.BetInAmount;
import com.hs3.entity.lotts.BetInPrice;
import com.hs3.entity.lotts.BetInRule;
import com.hs3.entity.lotts.BetInTime;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.lotts.BetInAmountService;
import com.hs3.service.lotts.BetInPriceService;
import com.hs3.service.lotts.BetInRuleService;
import com.hs3.service.lotts.BetInTimeService;
import com.hs3.utils.ListUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping({"/admin/lotts/betInPrice"})
public class BetInPriceController
        extends AdminController {
    @Autowired
    private BetInPriceService betInPriceService;
    @Autowired
    private BetInRuleService betInRuleService;
    @Autowired
    private BetInAmountService betInAmountService;
    @Autowired
    private BetInTimeService betInTimeService;

    @RequestMapping({"/betInAll"})
    public Object betInAll() {
        ModelAndView mv = getView("/lotts/betInAll");

        List<BetInPrice> betInPriceList = this.betInPriceService.list(null);
        mv.addObject("betInPriceList", betInPriceList);

        List<BetInRule> betInRuleList = this.betInRuleService.list(null);
        mv.addObject("betInRuleList", betInRuleList);

        Map<Integer, List<BetInAmount>> ruleAmountMap = new HashMap();
        for (BetInRule betInRule : betInRuleList) {
            List<BetInAmount> betInAmountList = this.betInAmountService.listAmount(betInRule.getId());
            ruleAmountMap.put(betInRule.getId(), betInAmountList);
        }
        mv.addObject("ruleAmountMap", ruleAmountMap);

        List<BetInAmount> betInAmountList = this.betInAmountService.list(null);
        mv.addObject("betInAmountList", betInAmountList);

        Object betInAmountMap = new HashMap();
        for (BetInAmount betInAmount : betInAmountList) {
            ((Map) betInAmountMap).put(betInAmount.getRuleId() + "-" + betInAmount.getPriceId() + "-" + betInAmount.getAmount(), betInAmount);
        }
        mv.addObject("ruleAmountProbMap", betInAmountMap);

        List<BetInTime> betInTimeList = this.betInTimeService.list(null);
        mv.addObject("betInTimeList", betInTimeList);

        Object betInTimeMap = new TreeMap();
        Map<String, BetInTime> betInTimeProbMap = new HashMap();
        for (BetInTime betInTime : betInTimeList) {
            String key = betInTime.getStartTime() + "~" + betInTime.getEndTime();
            List<BetInTime> list = (List) ((Map) betInTimeMap).get(key);
            if (list == null) {
                list = new ArrayList();
            }
            list.add(betInTime);
            ((Map) betInTimeMap).put(key, list);
            betInTimeProbMap.put(key + "~" + betInTime.getRuleId(), betInTime);
        }
        mv.addObject("betInTimeMap", betInTimeMap);
        mv.addObject("betInTimeProbMap", betInTimeProbMap);

        return mv;
    }

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/lotts/betInPrice");

        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list() {
        Page p = getPageWithParams();
        List<BetInPrice> list = this.betInPriceService.list(p);

        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping({"/listWithOrder"})
    public Object listWithOrder() {
        Page p = getPageWithParams();
        List<BetInPrice> list = this.betInPriceService.listWithOrder(p);

        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(BetInPrice m) {
        this.betInPriceService.save(m);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {
        return this.betInPriceService.find(id);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(BetInPrice m) {
        return Jsoner.getByResult(this.betInPriceService.update(m) > 0);
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String id) {
        return Jsoner.getByResult(this.betInPriceService.delete(ListUtils.toIntList(id)) > 0);
    }
}
