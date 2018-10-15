package com.hs3.admin.controller.bank;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.bank.BankNameService;
import com.hs3.service.bank.BankUserService;
import com.hs3.service.user.UserService;
import com.hs3.utils.StrUtils;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@Scope("prototype")
@RequestMapping({"/admin/bankUserAll"})
public class BankUserAllController
        extends AdminController {
    @Autowired
    private UserService userService;
    @Autowired
    private BankUserService bankUserService;
    @Autowired
    private BankNameService bankNameService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/bank/all");
        List<?> list = this.bankNameService.list(null);
        mv.addObject("json", StrUtils.toJson(list));
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(String account, String niceName, String bankCard, Date begin, Date end) {
        Page p = getPageWithParams();
        List<?> list = this.bankUserService.listByAccount(1, account, niceName, bankCard, begin, end, p);
        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping({"/status"})
    public Object status(Integer id, Integer status) {
        this.bankUserService.updateStatus(id, status);
        return Jsoner.success();
    }


    @ResponseBody
    @RequestMapping({"/logout"})
    public Object list(String account) {
        return Jsoner.getByResult(this.userService.setLogout(account));
    }
}
