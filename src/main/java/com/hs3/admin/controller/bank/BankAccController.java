package com.hs3.admin.controller.bank;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.bank.BankAcc;
import com.hs3.entity.bank.BankApi;
import com.hs3.exceptions.BaseCheckException;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.bank.BankAccService;
import com.hs3.service.bank.BankApiService;
import com.hs3.utils.ListUtils;
import com.hs3.utils.StrUtils;
import com.pays.PayApiFactory;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping({"/admin/bankAcc"})
public class BankAccController
        extends AdminController {
    @Autowired
    private BankAccService bankAccService;
    @Autowired
    private BankApiService bankApiService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/bank/bankAcc");

        Map<String, String> bankKey = PayApiFactory.getMaps();
        mv.addObject("bankKey", bankKey);
        mv.addObject("bankKeyJson", StrUtils.toJson(bankKey));

        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(BankApi m, String[] classKeyArray) {
        Page p = getPageWithParams();

        List<BankApi> bankApiList = this.bankApiService.listByCond(m, classKeyArray, p);
        for (BankApi bankApi : bankApiList) {
            bankApi.setSign(null);
            bankApi.setPublicKey(null);
        }

        return new PageData(p.getRowCount(), bankApiList);
    }

    @ResponseBody
    @RequestMapping({"/listWithOrder"})
    public Object listWithOrder() {
        Page p = getPageWithParams();
        List<BankAcc> list = this.bankAccService.listWithOrder(p);

        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(BankAcc m) {
        this.bankAccService.save(m);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {
        BankApi bankApi = this.bankApiService.find(id);
        bankApi.setSign(null);
        bankApi.setPublicKey(null);
        return bankApi;
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(BankApi m) {
        try {
            this.bankApiService.update(m.getId(), m.getSpecialAccount(), m.getProxyLine(), m.getStatus().intValue());
        } catch (BaseCheckException e) {
            return Jsoner.error(e.getMessage());
        }
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String id) {
        return Jsoner.getByResult(this.bankAccService.delete(ListUtils.toIntList(id)) > 0);
    }
}
