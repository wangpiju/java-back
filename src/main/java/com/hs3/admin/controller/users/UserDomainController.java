package com.hs3.admin.controller.users;

import com.hs3.admin.controller.AdminController;
import com.hs3.models.Jsoner;
import com.hs3.service.user.DomainService;
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
@RequestMapping({"/admin/userDomain"})
public class UserDomainController
        extends AdminController {
    @Autowired
    private DomainService domainService;

    @RequestMapping({"/index"})
    public Object index(String account) {
        ModelAndView mv = getView("/user/domain");
        mv.addObject("account", account);
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(String account) {
        return this.domainService.listByAccount(account);
    }

    @ResponseBody
    @RequestMapping({"/listNot"})
    public Object listNot(String account) {
        return this.domainService.listByAccountNot(account);
    }

    @RequestMapping({"/status"})
    public Object status(Integer id, Integer status) {
        this.domainService.setStatus(id, status);
        return redirect("index");
    }

    @ResponseBody
    @RequestMapping({"/add"})
    public Object add(String account, String id) {
        List<Integer> ids = ListUtils.toIntList(id);
        this.domainService.addByAccount(account, ids);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String account, String id) {
        if (StrUtils.hasEmpty(new Object[]{account})) {
            return Jsoner.success("请指定账户");
        }
        List<Integer> ids = ListUtils.toIntList(id);
        this.domainService.deleteByAccount(account, ids);
        return Jsoner.success();
    }
}
