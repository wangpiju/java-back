package com.hs3.admin.controller.finance;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.finance.FinanceWithdraw;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.finance.FinanceWithdrawService;
import com.hs3.utils.ListUtils;
import com.hs3.utils.StrUtils;
import com.pays.WithdrawApi;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping({"/admin/finance/financeWithdraw"})
public class FinanceWithdrawController
        extends AdminController {
    @Autowired
    private FinanceWithdrawService financeWithdrawService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/finance/financeWithdraw");
        mv.addObject("withdrawApiMap", WithdrawApi.getInstances());
        mv.addObject("withdrawApiJson", StrUtils.toJson(WithdrawApi.getInstances()));

        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list() {
        Page p = getPageWithParams();
        List<FinanceWithdraw> list = this.financeWithdrawService.list(p);
        for (FinanceWithdraw fw : list) {
            fw.setSign(null);
            fw.setPublicKey(null);
        }

        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(FinanceWithdraw m) {
        m.setCreateTime(new Date());
        this.financeWithdrawService.save(m);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {
        FinanceWithdraw fw = this.financeWithdrawService.find(id);
        fw.setSign(null);
        fw.setPublicKey(null);
        return fw;
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(FinanceWithdraw m) {
        m.setCreateTime(new Date());
        return Jsoner.getByResult(this.financeWithdrawService.update(m) > 0);
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String id) {
        return Jsoner.getByResult(this.financeWithdrawService.delete(ListUtils.toIntList(id)) > 0);
    }
}
