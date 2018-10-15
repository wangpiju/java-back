package com.hs3.admin.controller.finance;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.finance.Deposit;
import com.hs3.entity.finance.FinanceMission;
import com.hs3.entity.users.Manager;
import com.hs3.exceptions.BaseCheckException;
import com.hs3.models.Excel;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.finance.DepositService;
import com.hs3.service.finance.FinanceMissionService;
import com.hs3.utils.DateUtils;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@Controller
@Scope("prototype")
@RequestMapping({"/admin/finance/deposit"})
public class DepositController
        extends AdminController {
    @Autowired
    private DepositService depositService;
    @Autowired
    private FinanceMissionService financeMissionService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/finance/deposit");

        return mv;
    }

    @RequestMapping({"/depositRecord"})
    public Object depositRecord() {
        ModelAndView mv = getView("/finance/depositRecord");

        return mv;
    }

    @RequestMapping({"/depositAudit"})
    public Object depositAudit() {
        ModelAndView mv = getView("/finance/depositAudit");

        return mv;
    }

    @RequestMapping({"/depositMission"})
    public Object depositMission() {
        ModelAndView mv = getView("/finance/depositMission");

        List<FinanceMission> financeMissionList = this.financeMissionService.list(null);
        mv.addObject("financeMissionList", financeMissionList);
        mv.addObject("missionLength", financeMissionList.size());

        return mv;
    }

    @ResponseBody
    @RequestMapping({"/listMy"})
    public Object listMy(Deposit deposit, String startTime, String endTime, Integer[] statusArray, Integer master) {
        if (deposit == null) {
            deposit = new Deposit();
        }
        deposit.setOperator(((Manager) getLogin()).getAccount());

        return list(Boolean.valueOf(false), deposit, startTime, endTime, null, null, statusArray, master);
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(Boolean isAll, Deposit deposit, String startTime, String endTime, BigDecimal minAmount, BigDecimal maxAmount, Integer[] statusArray, Integer master) {
        Page p = (isAll != null) && (isAll.booleanValue()) ? new Page(Integer.valueOf(1), Integer.valueOf(10000)) : getPageWithParams();
        Date st = DateUtils.toDateNull(startTime);
        Date et = DateUtils.toDateNull(endTime);
        if (deposit == null) {
            deposit = new Deposit();
        }
        if ((deposit.getStatus() != null) && (-1 != deposit.getStatus().intValue())) {
            statusArray = new Integer[]{deposit.getStatus()};
        }
        if ((deposit.getTest() == null) || (-1 == deposit.getTest().intValue())) {
            deposit.setTest(null);
        }
        List<Map<String, Object>> list = this.depositService.listByCond_Z((master != null) && (master.intValue() == 0), deposit, st, et, minAmount, maxAmount, statusArray, p);
        if (list == null) {
            list =new ArrayList<>();
        }
        return new PageData(p.getRowCount(), p.getObj(), list);
    }

    @ResponseBody
    @RequestMapping({"/exportExcel"})
    public void exportExcel(HttpServletRequest request, HttpServletResponse response, Excel excel, Deposit deposit, String startTime, String endTime, BigDecimal minAmount, BigDecimal maxAmount, Integer[] statusArray, Integer master) {
        PageData pd = (PageData) list(Boolean.valueOf(true), deposit, startTime, endTime, minAmount, maxAmount, statusArray, master);
        try{
            List<List<String>> exceltitle = new ArrayList<>();
            exportExcel( request, response, (List) pd.getRows(), exceltitle);
        }
        catch (Exception e){
            e.printStackTrace();
        }
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(String id) {
        return this.depositService.find(id);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(Deposit m, Integer operateType) {
        m.setOperator(((Manager) getLogin()).getAccount());
        try {
            if (operateType.intValue() == 0) {
                this.depositService.updateByReject(m);
            } else if (operateType.intValue() == 1) {
                this.depositService.updateBySuccess(m);
            } else if (operateType.intValue() == 2) {
                this.depositService.updateByDoing(m);
            } else if (operateType.intValue() == 3) {
                this.depositService.updateByAudit(m);
            } else if (operateType.intValue() == 4) {
                this.depositService.updateByAuditReject(m);
            } else if (operateType.intValue() == 5) {
                this.depositService.updateByAuditSuccess(m);
            } else {
                throw new BaseCheckException("操作不支持！");
            }
            return Jsoner.success();
        } catch (BaseCheckException e) {
            return Jsoner.error(e.getMessage());
        }
    }

    @ResponseBody
    @RequestMapping(value = {"/editHand"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object editHand(String[] ids, Integer handType) {
        try {
            Manager manager = (Manager) getLogin();
            String[] arrayOfString;
            int j = (arrayOfString = ids).length;
            for (int i = 0; i < j; i++) {
                String id = arrayOfString[i];
                Deposit deposit = new Deposit();
                deposit.setId(id);
                deposit.setOperator(manager.getAccount());

                if (handType.intValue() == 0) {
                    this.depositService.updateByHandUp(deposit);
                } else if (handType.intValue() == 1) {
                    this.depositService.updateByHandDown(deposit);
                }
            }

            return Jsoner.success();
        } catch (BaseCheckException e) {
            return Jsoner.error(e.getMessage());
        }
    }
}
