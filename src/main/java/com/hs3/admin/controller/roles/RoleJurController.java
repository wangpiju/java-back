package com.hs3.admin.controller.roles;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.roles.Role;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.models.roles.JurisdictionEx;
import com.hs3.service.roles.RoleMapJurService;
import com.hs3.service.roles.RoleService;
import com.hs3.utils.ListUtils;
import com.hs3.utils.StrUtils;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@Scope("prototype")
@RequestMapping({"/admin/role_jur"})
public class RoleJurController
        extends AdminController {
    @Autowired
    private RoleService roleService;
    @Autowired
    private RoleMapJurService roleMapJurService;

    @RequestMapping({"/index"})
    public Object index(Integer id) {
        ModelAndView mv = getView("/roles/role_jur");
        Role role = this.roleService.find(id);
        List<Role> roles = this.roleService.list();
        mv.addObject("role", role);
        mv.addObject("json", StrUtils.toJson(roles));
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(Integer roleId) {
        if (roleId == null) return null;
        Page p = getPageWithParams();
        List<JurisdictionEx> list = this.roleMapJurService.listRJEx(p, roleId);
        return new PageData(p.getRowCount(), list);
    }


    @ResponseBody
    @RequestMapping({"/add"})
    public Object add(Integer roleId, String jurIds) {
        List<Integer> jurList = ListUtils.toIntList(jurIds);
        this.roleMapJurService.save(roleId, jurList);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/save"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object save(Integer roleId, String id) {
        List<Integer> ids = ListUtils.toIntList(id);

        return Jsoner.getByResult(this.roleMapJurService.deleteAndSave(roleId, ids));
    }
}
