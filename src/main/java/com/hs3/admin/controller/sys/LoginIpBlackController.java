package com.hs3.admin.controller.sys;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.sys.LoginIpBlack;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.sys.LoginIpBlackService;
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
@RequestMapping({"/admin/ipBlack"})
public class LoginIpBlackController
        extends AdminController {
    @Autowired
    private LoginIpBlackService loginIpBlackService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/sys/ipBlack");
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(LoginIpBlack black) {
        Page p = getPageWithParams();
        List<LoginIpBlack> list = this.loginIpBlackService.listByCond(black, p);
        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(LoginIpBlack black) {
        if (black != null) {
            if (!StrUtils.hasEmpty(new Object[]{black.getIp()})) {
            }
        } else {
            return Jsoner.error("IP不能为空！");
        }
        black.setIp(black.getIp().trim());
        this.loginIpBlackService.save(black);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(String ip) {
        return this.loginIpBlackService.find(ip);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(LoginIpBlack m) {
        return Jsoner.getByResult(this.loginIpBlackService.update(m) > 0);
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String ip) {
        List<String> ips = ListUtils.toList(ip);
        int c = this.loginIpBlackService.delete(ips);
        if (c == 0) {
            return Jsoner.error();
        }
        return Jsoner.success();
    }
}
