package com.hs3.admin.controller.finance;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.finance.FinanceMission;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.finance.FinanceMissionService;
import com.hs3.utils.ListUtils;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping({"/admin/finance/financeMission"})
public class FinanceMissionController
        extends AdminController {
    @Autowired
    private FinanceMissionService financeMissionService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/finance/financeMission");

        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list() {
        Page p = getPageWithParams();
        List<FinanceMission> list = this.financeMissionService.list(p);

        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping({"/listWithOrder"})
    public Object listWithOrder() {
        Page p = getPageWithParams();
        List<FinanceMission> list = this.financeMissionService.listWithOrder(p);

        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(FinanceMission m) {
        this.financeMissionService.save(m);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {
        return this.financeMissionService.find(id);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(FinanceMission m) {
        return Jsoner.getByResult(this.financeMissionService.update(m) > 0);
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String id) {
        return Jsoner.getByResult(this.financeMissionService.delete(ListUtils.toIntList(id)) > 0);
    }
}
