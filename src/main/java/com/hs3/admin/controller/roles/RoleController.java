package com.hs3.admin.controller.roles;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.roles.Role;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.roles.RoleService;
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
@RequestMapping({"/admin/role"})
public class RoleController
        extends AdminController {
    @Autowired
    private RoleService roleService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/roles/role");
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list() {
        Page p = getPageWithParams();
        List<Role> list = this.roleService.list(p);
        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(Role m) {
        this.roleService.save(m);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {
        return this.roleService.find(id);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(Role m) {
        return Jsoner.getByResult(this.roleService.update(m) == 1);
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String id) {
        List<Integer> ids = ListUtils.toIntList(id);
        return Jsoner.getByResult(this.roleService.delete(ids));
    }
}
