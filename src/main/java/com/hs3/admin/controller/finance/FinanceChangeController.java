package com.hs3.admin.controller.finance;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.finance.FinanceChange;
import com.hs3.entity.lotts.AccountChangeType;
import com.hs3.entity.users.Manager;
import com.hs3.exceptions.BaseCheckException;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.finance.FinanceChangeService;
import com.hs3.service.finance.FinanceWithdrawService;
import com.hs3.service.lotts.AccountChangeTypeService;
import com.hs3.utils.DateUtils;
import com.hs3.utils.StrUtils;

import java.math.BigDecimal;
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
@RequestMapping({"/admin/finance/financeChange"})
public class FinanceChangeController
        extends AdminController {
    @Autowired
    private FinanceChangeService financeChangeService;
    @Autowired
    private AccountChangeTypeService accountChangeTypeService;
    @Autowired
    private FinanceWithdrawService financeWithdrawService;

    @RequestMapping({"/financeChangeAdd"})
    public Object financeChangeAdd() {
        ModelAndView mv = getView("/finance/financeChangeAdd");
        List<AccountChangeType> accountChangeTypeList = this.accountChangeTypeService.listByType(Integer.valueOf(1));
        mv.addObject("json", StrUtils.toJson(accountChangeTypeList));
        mv.addObject("accountChangeTypeList", accountChangeTypeList);
        return mv;
    }

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/finance/financeChange");
        List<AccountChangeType> accountChangeTypeList = this.accountChangeTypeService.listByType(Integer.valueOf(1));
        mv.addObject("json", StrUtils.toJson(accountChangeTypeList));
        mv.addObject("accountChangeTypeList", accountChangeTypeList);
        mv.addObject("financeWithdrawList", this.financeWithdrawService.list(null));
        return mv;
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(FinanceChange m, BigDecimal poundage, String receiveCard) {
        try {
            m.setOperator(((Manager) getLogin()).getAccount());
            this.financeChangeService.saveToApproval(m, poundage, receiveCard);
        } catch (BaseCheckException e) {
            return Jsoner.error(e.getMessage());
        }
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(FinanceChange finance, String startTime, String endTime, Integer isIncludeChildFlag, String[] accountChangeTypes) {
        Page p = getPageWithParams();


        Date st = DateUtils.toDateNull(startTime);
        Date et = DateUtils.toDateNull(endTime);

        if ((finance.getStatus() == null) || (-1 == finance.getStatus().intValue())) {
            finance.setStatus(null);
        }
        if ((finance.getTest() == null) || (-1 == finance.getTest().intValue())) {
            finance.setTest(null);
        }

        boolean isIncludeChild = (isIncludeChildFlag != null) && (isIncludeChildFlag.intValue() != 0);

        List<FinanceChange> list = this.financeChangeService.listByCond(finance, st, et, isIncludeChild, accountChangeTypes, p);

        return new PageData(p.getRowCount(), list);
    }
}
