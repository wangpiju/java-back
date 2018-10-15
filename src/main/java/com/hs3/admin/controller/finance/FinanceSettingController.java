package com.hs3.admin.controller.finance;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.finance.FinanceSetting;
import com.hs3.entity.finance.FinanceWithdraw;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.finance.FinanceSettingService;
import com.hs3.service.finance.FinanceWithdrawService;
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
@RequestMapping({"/admin/finance/financeSetting"})
public class FinanceSettingController
        extends AdminController {
    @Autowired
    private FinanceSettingService financeSettingService;
    @Autowired
    private FinanceWithdrawService financeWithdrawService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/finance/financeSetting");
        List<FinanceWithdraw> list = this.financeWithdrawService.list(null);
        mv.addObject("financeWithdrawList", list);
        mv.addObject("financeWithdrawJson", StrUtils.toJson(list));
        return mv;
    }

    @RequestMapping({"/indexStatus"})
    public Object indexStatus() {
        ModelAndView mv = getView("/finance/financeSettingStatus");
        return mv;
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {
        return this.financeSettingService.find(id);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(FinanceSetting m) {
        return Jsoner.getByResult(this.financeSettingService.update(m) > 0);
    }

    @ResponseBody
    @RequestMapping(value = {"/editStatus"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object editStatus(FinanceSetting m) {
        FinanceSetting fs = this.financeSettingService.find(m.getId());
        fs.setDepositAuto(m.getDepositAuto());
        return Jsoner.getByResult(this.financeSettingService.update(fs) > 0);
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list() {
        List<FinanceSetting> list = this.financeSettingService.list();

        return new PageData(getPageWithParams().getRowCount(), list);
    }
}
