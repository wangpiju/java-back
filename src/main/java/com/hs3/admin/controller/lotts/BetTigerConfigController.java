package com.hs3.admin.controller.lotts;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.lotts.BetTigerConfig;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.lotts.BetTigerConfigService;
import com.hs3.utils.ListUtils;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping({"/admin/lotts/betTigerConfig"})
public class BetTigerConfigController
        extends AdminController {
    @Autowired
    private BetTigerConfigService betTigerConfigService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/lotts/betTigerConfig");

        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list() {
        Page p = getPageWithParams();
        List<BetTigerConfig> list = this.betTigerConfigService.list(p);

        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping({"/listWithOrder"})
    public Object listWithOrder() {
        Page p = getPageWithParams();
        List<BetTigerConfig> list = this.betTigerConfigService.listWithOrder(p);

        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(BetTigerConfig m) {
        this.betTigerConfigService.save(m);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {
        return this.betTigerConfigService.find(id);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(BetTigerConfig m) {
        return Jsoner.getByResult(this.betTigerConfigService.update(m) > 0);
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String id) {
        return Jsoner.getByResult(this.betTigerConfigService.delete(ListUtils.toIntList(id)) > 0);
    }
}
