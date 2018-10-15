package com.hs3.admin.controller.bank;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.bank.BankName;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.bank.BankNameService;
import com.hs3.utils.ListUtils;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@Scope("prototype")
@RequestMapping({"/admin/bankName"})
public class BankNameController
        extends AdminController {
    @Autowired
    private BankNameService bankNameService;

    @RequestMapping({"/index"})
    public Object index(String account) {
        return getViewName("/bank/name");
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list() {
        Page p = getPageWithParams();
        List<?> list = this.bankNameService.list(p);
        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(BankName m) {
        this.bankNameService.save(m);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {
        return this.bankNameService.find(id);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(BankName m) {
        if (this.bankNameService.update(m) == 1) {
            return Jsoner.success();
        }
        return Jsoner.error();
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String id) {
        List<Integer> ids = ListUtils.toIntList(id);
        int c = this.bankNameService.delete(ids);
        if (c == 0) {
            return Jsoner.error();
        }
        return Jsoner.success();
    }
}
