package com.hs3.admin.controller.roles;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.roles.SecondMenu;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.models.roles.SecondMenuEx;
import com.hs3.service.roles.SecondMenuService;
import com.hs3.utils.ListUtils;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@Scope("prototype")
@RequestMapping({"/admin/secondMenu"})
public class SecondMenuController
        extends AdminController {
    @Autowired
    private SecondMenuService secondMenuService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/roles/secondMenu");
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list() {
        Page p = getPageWithParams();
        List<SecondMenuEx> list = this.secondMenuService.listEx(p);
        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(Integer firstName, String secondName) {
        SecondMenu m = new SecondMenu();
        m.setFirstMenuId(firstName);
        m.setSecondName(secondName);
        this.secondMenuService.save(m);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {
        return this.secondMenuService.findEx(id);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(Integer id, Integer firstMenuId, String secondName) {
        SecondMenu m = new SecondMenu();
        m.setId(id);
        m.setFirstMenuId(firstMenuId);
        m.setSecondName(secondName);
        return Jsoner.getByResult(this.secondMenuService.update(m) == 1);
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String id) {
        List<Integer> ids = ListUtils.toIntList(id);
        return Jsoner.getByResult(this.secondMenuService.delete(ids));
    }
}
