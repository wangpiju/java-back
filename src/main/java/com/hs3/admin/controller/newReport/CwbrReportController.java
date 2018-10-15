package com.hs3.admin.controller.newReport;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.models.PageData;
import com.hs3.service.finance.DepositService;
import com.hs3.service.newReport.CpsReportService;
import com.hs3.utils.BeanZUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@Scope("prototype")
@RequestMapping({"/admin/newReport/cwbrReport"})
public class CwbrReportController extends AdminController {


    @Autowired
    private CpsReportService cpsReportService;

    @Autowired
    private DepositService depositService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/newReport/cwbrReport");
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/cwbrReport"})
    public Object agentsReport(String account) {
        Page p = getPageWithParams();

        List<Map<String, Object>> list_Z = new ArrayList<Map<String, Object>>();

        List<Map<String, Object>> list = cpsReportService.cashWithdrawalBalanceReport(account, p);
        BigDecimal accountBalanceZ = BigDecimal.ZERO; //本次可提现帐变余额
        BigDecimal actualBalanceZ = BigDecimal.ZERO; //本次可提现实际余额
        BigDecimal lastRemainAmountZ = BigDecimal.ZERO; //上次提现后的可提现实际余额
        for(Map<String, Object> cpsReport: list){
            Map<String, Object> cpsReport_Z = new HashMap<String, Object>();

            String account_Z = String.valueOf(cpsReport.get("account"));
            HashMap<String, BigDecimal> userDepositAmount = depositService.getUserDepositAmount(account_Z);
            accountBalanceZ = userDepositAmount.get("accountBalanceZ");
            actualBalanceZ = userDepositAmount.get("actualBalanceZ");
            //lastRemainAmountZ = userDepositAmount.get("lastRemainAmountZ");

            cpsReport_Z.putAll(cpsReport);
            cpsReport_Z.put("accountBalanceZ",accountBalanceZ);
            cpsReport_Z.put("actualBalanceZ",actualBalanceZ);
            //cpsReport_Z.put("lastRemainAmountZ",lastRemainAmountZ);
            list_Z.add(cpsReport_Z);
        }


        return new PageData(p.getRowCount(), p.getObj(), list_Z);
    }


}
