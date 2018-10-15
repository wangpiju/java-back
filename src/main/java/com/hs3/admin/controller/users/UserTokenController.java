package com.hs3.admin.controller.users;

import com.hs3.admin.controller.AdminController;
import com.hs3.entity.users.UserToken;
import com.hs3.models.Jsoner;
import com.hs3.service.user.UserTokenService;
import com.hs3.utils.TokenUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@Scope("prototype")
@RequestMapping({"/admin/userToken"})
public class UserTokenController extends AdminController {
    @Autowired
    private UserTokenService userTokenService;

    @RequestMapping({"/index"})
    public Object index(String account) {
        ModelAndView mv = getView("/sys/userTokenIndex");
        mv.addObject("account", account);
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(String account) {
        java.util.List<UserToken> list = this.userTokenService.listByAccount(account);
        return TokenUtils.toTable(list);
    }

    @ResponseBody
    @RequestMapping(value = {"/ajaxDeleteAndCreate"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object ajaxDeleteAndCreate(String account) {
        this.userTokenService.deleteByAccount(account);
        this.userTokenService.createToken(account);
        return Jsoner.getByResult(true);
    }
}
