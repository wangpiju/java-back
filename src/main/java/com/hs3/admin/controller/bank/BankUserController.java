package com.hs3.admin.controller.bank;

import com.hs3.admin.controller.AdminController;
import com.hs3.entity.bank.BankUser;
import com.hs3.models.Jsoner;
import com.hs3.service.bank.BankNameService;
import com.hs3.service.bank.BankUserService;
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
@RequestMapping({"/admin/bankUser"})
public class BankUserController
        extends AdminController {
    @Autowired
    private BankUserService bankUserService;
    @Autowired
    private BankNameService bankNameService;

    @RequestMapping({"/index"})
    public Object index(String account) {
        ModelAndView mv = getView("/bank/user");
        List<?> list = this.bankNameService.list(null);
        mv.addObject("json", StrUtils.toJson(list));
        mv.addObject("account", account);
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(String account) {
        return this.bankUserService.listByAccount(0, account, null, null, null, null, null);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(BankUser m) {
        this.bankUserService.save(m);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping({"/status"})
    public Object status(Integer id, Integer status) {
        this.bankUserService.updateStatus(id, status);
        return Jsoner.success();
    }


    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String id) {
        List<Integer> ids = ListUtils.toIntList(id);
        int c = this.bankUserService.delete(ids);
        if (c == 0) {
            return Jsoner.error();
        }
        return Jsoner.success();
    }
}
