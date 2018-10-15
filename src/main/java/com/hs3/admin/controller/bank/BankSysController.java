package com.hs3.admin.controller.bank;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.bank.BankSys;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.bank.BankGroupService;
import com.hs3.service.bank.BankLevelService;
import com.hs3.service.bank.BankNameService;
import com.hs3.service.bank.BankSysService;
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
@RequestMapping({"/admin/bankSys"})
public class BankSysController
        extends AdminController {
    @Autowired
    private BankSysService bankSysService;
    @Autowired
    private BankLevelService bankLevelService;
    @Autowired
    private BankGroupService bankGroupService;
    @Autowired
    private BankNameService bankNameService;

    @RequestMapping({"/index"})
    public Object index(String account) {
        ModelAndView mv = getView("/bank/sys");
        List<?> bankLevel = this.bankLevelService.list(null);
        List<?> bankName = this.bankNameService.list(null);
        mv.addObject("bankLevel", bankLevel);
        mv.addObject("bankName", bankName);
        mv.addObject("bankLevelJson", StrUtils.toJson(bankLevel));
        mv.addObject("bankNameJson", StrUtils.toJson(bankName));
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list() {
        Page p = getPageWithParams();
        List<BankSys> list = this.bankSysService.list(p);
        for (BankSys bankSys : list) {
            bankSys.setSign(null);
        }
        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(BankSys m) {
        this.bankSysService.save(m);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {
        BankSys bankSys = this.bankSysService.find(id);
        bankSys.setSign(null);
        return bankSys;
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(BankSys m) {
        if (this.bankSysService.update(m) == 1) {
            return Jsoner.success();
        }
        return Jsoner.error();
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String id) {
        List<Integer> ids = ListUtils.toIntList(id);
        int c = this.bankSysService.delete(ids);
        if (c == 0) {
            return Jsoner.error();
        }
        return Jsoner.success();
    }
}
