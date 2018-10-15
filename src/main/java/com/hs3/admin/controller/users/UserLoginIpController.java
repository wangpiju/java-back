package com.hs3.admin.controller.users;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.sys.LoginIpBlackService;
import com.hs3.service.user.UserLoginIpService;
import com.hs3.service.user.UserService;
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
@RequestMapping({"/admin/userLoginIp"})
public class UserLoginIpController
        extends AdminController {
    @Autowired
    private UserService userService;
    @Autowired
    private UserLoginIpService userloginIpService;
    @Autowired
    private LoginIpBlackService loginIpBlackService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/user/loginIp");
        mv.addObject("ipBlacks", StrUtils.toJson(this.loginIpBlackService.list(null)));
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(String ip, String account, String ipInfo) {
        Page p = getPageWithParams();
        List<?> list = this.userloginIpService.listByIp(ip, account, ipInfo, p);
        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping({"/logout"})
    public Object list(String account) {
        return Jsoner.getByResult(this.userService.setLogout(account));
    }
}
