package com.hs3.admin.controller.lotts;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.lotts.BetInAmount;
import com.hs3.entity.lotts.BetInPrice;
import com.hs3.entity.lotts.BetInRule;
import com.hs3.exceptions.BaseCheckException;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.lotts.BetInAmountService;
import com.hs3.service.lotts.BetInPriceService;
import com.hs3.service.lotts.BetInRuleService;
import com.hs3.utils.ListUtils;
import com.hs3.utils.StrUtils;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping({"/admin/lotts/betInAmount"})
public class BetInAmountController
        extends AdminController {
    @Autowired
    private BetInAmountService betInAmountService;
    @Autowired
    private BetInPriceService betInPriceService;
    @Autowired
    private BetInRuleService betInRuleService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/lotts/betInAmount");
        List<BetInPrice> betInPriceList = this.betInPriceService.list(null);
        List<BetInRule> betInRuleList = this.betInRuleService.list(null);
        mv.addObject("betInPriceList", betInPriceList);
        mv.addObject("betInPriceJson", StrUtils.toJson(betInPriceList));
        mv.addObject("betInRuleList", betInRuleList);
        mv.addObject("betInRuleJson", StrUtils.toJson(betInRuleList));

        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(BetInAmount m) {
        Page p = getPageWithParams();
        List<BetInAmount> list = this.betInAmountService.listByCond(m, p);

        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping({"/listWithOrder"})
    public Object listWithOrder() {
        Page p = getPageWithParams();
        List<BetInAmount> list = this.betInAmountService.listWithOrder(p);

        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(BetInAmount m, BigDecimal[] probabilitys) {
        try {
            this.betInAmountService.saveBatch(m, probabilitys);
        } catch (BaseCheckException e) {
            return Jsoner.error(e.getMessage());
        }
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {
        Map<String, Object> map = new HashMap();
        BetInAmount betInAmount = this.betInAmountService.find(id);
        map.put("betInAmount", betInAmount);
        map.put("probabilityList", this.betInAmountService.listByRuleId(betInAmount.getRuleId(), betInAmount.getAmount()));
        return map;
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(BetInAmount m, BigDecimal[] probabilitys) {
        return Jsoner.getByResult(this.betInAmountService.update(m, probabilitys) > 0);
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String id) {
        return Jsoner.getByResult(this.betInAmountService.delete(ListUtils.toIntList(id)) > 0);
    }
}
