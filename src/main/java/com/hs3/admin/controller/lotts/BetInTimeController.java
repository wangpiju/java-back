package com.hs3.admin.controller.lotts;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.lotts.BetInRule;
import com.hs3.entity.lotts.BetInTime;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.lotts.BetInRuleService;
import com.hs3.service.lotts.BetInTimeService;
import com.hs3.utils.ListUtils;
import com.hs3.utils.StrUtils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping({"/admin/lotts/betInTime"})
public class BetInTimeController
        extends AdminController {
    @Autowired
    private BetInTimeService betInTimeService;
    @Autowired
    private BetInRuleService betInRuleService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/lotts/betInTime");
        List<BetInRule> betInRuleList = this.betInRuleService.list(null);
        mv.addObject("betInRuleList", betInRuleList);
        mv.addObject("betInRuleJson", StrUtils.toJson(betInRuleList));

        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(BetInTime m) {
        Page p = getPageWithParams();
        List<BetInTime> list = this.betInTimeService.listByCond(m, p);

        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping({"/listWithOrder"})
    public Object listWithOrder() {
        Page p = getPageWithParams();
        List<BetInTime> list = this.betInTimeService.listWithOrder(p);

        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(BetInTime m) {
        this.betInTimeService.save(m, getParams());
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {
        Map<String, Object> map = new HashMap();
        BetInTime betInTime = this.betInTimeService.find(id);
        map.put("betInTime", betInTime);
        map.put("probabilityList", this.betInTimeService.list(betInTime.getStartTime(), betInTime.getEndTime()));
        return map;
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(BetInTime m) {
        return Jsoner.getByResult(this.betInTimeService.update(m, getParams()) > 0);
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String id) {
        return Jsoner.getByResult(this.betInTimeService.delete(ListUtils.toIntList(id)) > 0);
    }
}
