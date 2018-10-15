package com.hs3.admin.controller.lotts;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.lotts.BetInRuleKill;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.lotts.BetInRuleKillService;
import com.hs3.utils.ListUtils;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping({"/admin/lotts/betInRuleKill"})
public class BetInRuleKillController
        extends AdminController {
    @Autowired
    private BetInRuleKillService betInRuleKillService;

    @RequestMapping({"/index"})
    public Object index() {
        return killIndex();
    }

    @RequestMapping({"/killIndex"})
    public Object killIndex() {
        ModelAndView mv = getView("/lotts/betInRuleKill");

        return mv;
    }

    @RequestMapping({"/fishIndex"})
    public Object fishIndex() {
        ModelAndView mv = getView("/lotts/betInRuleFish");

        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(BetInRuleKill m) {
        Page p = getPageWithParams();
        List<BetInRuleKill> list = this.betInRuleKillService.listByCond(m, p);

        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping({"/listWithOrder"})
    public Object listWithOrder() {
        Page p = getPageWithParams();
        List<BetInRuleKill> list = this.betInRuleKillService.listWithOrder(p);

        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(BetInRuleKill m) {
        this.betInRuleKillService.save(m);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {
        return this.betInRuleKillService.find(id);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(BetInRuleKill m) {
        return Jsoner.getByResult(this.betInRuleKillService.update(m) > 0);
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String id) {
        return Jsoner.getByResult(this.betInRuleKillService.delete(ListUtils.toIntList(id)) > 0);
    }
}
