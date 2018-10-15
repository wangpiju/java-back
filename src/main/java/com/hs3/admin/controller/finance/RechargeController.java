package com.hs3.admin.controller.finance;

import com.hs3.admin.controller.AdminController;
import com.hs3.commons.RechargeStatus;
import com.hs3.db.Page;
import com.hs3.entity.finance.Recharge;
import com.hs3.entity.users.Manager;
import com.hs3.exceptions.BaseCheckException;
import com.hs3.models.Excel;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.finance.RechargeService;
import com.hs3.utils.DateUtils;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

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
@RequestMapping({"/admin/finance/recharge"})
public class RechargeController
        extends AdminController {
    @Autowired
    private RechargeService rechargeService;

    @RequestMapping({"/index"})
    public Object index(Date t1, Date t2) {
        ModelAndView mv = getView("/finance/recharge");
        if (t1 != null) {
            if (t2 != null) {
                if (t1.getTime() < t2.getTime()) {
                    mv.addObject("begin", DateUtils.format(t1));
                    mv.addObject("end", DateUtils.format(t2));
                } else {
                    mv.addObject("begin", DateUtils.format(t2));
                    mv.addObject("end", DateUtils.format(t1));
                }
            } else {
                mv.addObject("begin", DateUtils.format(t1));
            }
        }
        return mv;
    }

    @RequestMapping({"/rechargeRecord"})
    public Object rechargeRecord() {
        ModelAndView mv = getView("/finance/rechargeRecord");

        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(Boolean isAll, Recharge recharge, Integer operatorType, String startTime, String endTime, Integer[] statusArray, Integer master) {
        Page p = (isAll != null) && isAll ? new Page(1, 10000) : getPageWithParams();
        Date st = DateUtils.toDateNull(startTime);
        Date et = DateUtils.toDateNull(endTime);
        if (recharge == null) {
            recharge = new Recharge();
        }
        if ((recharge.getStatus() != null) && (-1 != recharge.getStatus())) {
            statusArray = new Integer[]{recharge.getStatus()};
        }
        if ((recharge.getTest() == null) || (-1 == recharge.getTest())) {
            recharge.setTest(null);
        }
        if ((recharge.getRechargeType() == null) || (-1 == recharge.getRechargeType())) {
            recharge.setRechargeType(null);
        }
        operatorType = operatorType == null ? 0 : operatorType;
        List<Recharge> list = this.rechargeService.listByCond_Z((master != null) && (master == 0), recharge, operatorType, st, et, statusArray, p);

        return new PageData(p.getRowCount(), p.getObj(), list);
    }

    @ResponseBody
    @RequestMapping({"/exportExcel"})
    public void exportExcel(HttpServletRequest request, HttpServletResponse response, Excel excel, Recharge recharge, Integer operatorType, String startTime, String endTime, Integer[] statusArray, Integer master) {
        PageData pd = (PageData) list(Boolean.valueOf(true), recharge, operatorType, startTime, endTime, statusArray, master);
        try{
            List<List<String>> exceltitle = new ArrayList<>();
            exceltitle.add(Arrays.asList(" 商家订单号", "状态", " 充值金额", "手续费", " 实际上分金额", "充值类型", "卡号",  "昵称", "附言", "用户标识",
                    "充值账户", "用户类型", "充值银行卡", "充值时间", "最后处理时间", "操作管理员", "收款银行", "收款银行卡号", "收款银行支行地址", "收款银行开户名"
            , " 备注", "银行交易号"));
            exportExcel( request, response, (List) pd.getRows(), exceltitle);
        }
        catch (Exception e){
            e.printStackTrace();
        }
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(String id) {
        return this.rechargeService.find(id);
    }

    /**
     * @param m
     * @param operateType 0.拒绝  1.完成  10.挂起  11.取消挂起  12.取消拒绝
     * @param rechargePoundage
     * @return
     */
    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(Recharge m, Integer operateType, BigDecimal rechargePoundage) {
        m.setOperator(((Manager) getLogin()).getAccount());
        try {
            if (operateType == 0) {
                this.rechargeService.updateByReject(m);
            } else if (operateType == 10) {
                this.rechargeService.updateByReject_Z(m, RechargeStatus.hang_up.getStatus());
            } else if (operateType == 11) {
                this.rechargeService.updateByReject_Z(m, RechargeStatus.no_process.getStatus());
            } else if (operateType == 12) {
                this.rechargeService.updateByReject_Z(m, RechargeStatus.no_process.getStatus());
            } else if (operateType == 1) {
                this.rechargeService.updateBySuccess(m, rechargePoundage);
            } else {
                throw new BaseCheckException("操作不支持！");
            }
            return Jsoner.success();
        } catch (BaseCheckException e) {
            return Jsoner.error(e.getMessage());
        }
    }
}
