package com.hs3.admin.controller.users;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.users.UserDoubleLogin;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.user.UserDoubleLoginService;
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
@RequestMapping({"/admin/userDoubleLogin"})
public class UserDoubleLoginController
        extends AdminController {
    @Autowired
    private UserDoubleLoginService userDoubleLoginService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/user/double");
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(String account, Integer status) {
        Page p = getPageWithParams();
        List<?> list = this.userDoubleLoginService.list(account, status, p);
        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(UserDoubleLogin m) {
        this.userDoubleLoginService.save(m);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {
        return this.userDoubleLoginService.find(id);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(UserDoubleLogin m) {
        if (this.userDoubleLoginService.update(m) == 1) {
            return Jsoner.success();
        }
        return Jsoner.error();
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String id) {
        List<Integer> ids = ListUtils.toIntList(id);
        int c = this.userDoubleLoginService.delete(ids);
        if (c == 0) {
            return Jsoner.error();
        }
        return Jsoner.success();
    }
}
