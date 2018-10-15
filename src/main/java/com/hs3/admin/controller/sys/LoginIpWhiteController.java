package com.hs3.admin.controller.sys;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.sys.LoginIpWhite;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.sys.LoginIpWhiteService;
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
@RequestMapping({"/admin/ipWhite"})
public class LoginIpWhiteController
        extends AdminController {
    @Autowired
    private LoginIpWhiteService loginIpWhiteService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/sys/ip");
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(LoginIpWhite white) {
        Page p = getPageWithParams();
        List<LoginIpWhite> list = this.loginIpWhiteService.listByCond(white, p);
        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(String ip) {
        if (!StrUtils.hasEmpty(new Object[]{ip})) {
            if (!StrUtils.hasEmpty(new Object[]{ip = ip.trim()})) {
            }
        } else {
            return Jsoner.error("IP不能为空！");
        }
        this.loginIpWhiteService.save(ip);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String ip) {
        List<String> ips = ListUtils.toList(ip);
        int c = this.loginIpWhiteService.delete(ips);
        if (c == 0) {
            return Jsoner.error();
        }
        return Jsoner.success();
    }
}
