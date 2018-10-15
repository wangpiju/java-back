package com.hs3.admin.controller.contract;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.contract.ContractBonus;
import com.hs3.entity.users.Manager;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.contract.ContractBonusService;

import java.math.BigDecimal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@Scope("prototype")
@RequestMapping({"/admin/contractBonus"})
public class ContractBonusController extends AdminController {
    @Autowired
    private ContractBonusService contractBonusService;

    @RequestMapping({"/index"})
    public Object index() {
        return getViewName("/contract/contractBonus");
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(ContractBonus m) {
        Page p = getPageWithParams();
        java.util.List<?> list = this.contractBonusService.listByCondition(m, p);
        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/payout"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object sendDividendAmount(Integer id, String account, String parentAccount, BigDecimal dividendAmount) {
        int i = this.contractBonusService.saveToPayout(id, account, parentAccount, dividendAmount);
        if (i == 2)
            return Jsoner.error("余额不足。");
        if (i == 3) {
            return Jsoner.error("发放分红失败。");
        }
        return Jsoner.success("强制发放成功");
    }

    @ResponseBody
    @RequestMapping(value = {"/payoutDirectly"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object payoutDirectly(Integer id, String account, String parentAccount, BigDecimal dividendAmount) {
        int i = this.contractBonusService.saveToPayoutByAdmin(id, ((Manager) getLogin()).getAccount(), account, dividendAmount);
        if (i > 0) {
            return Jsoner.success("系统发放分红成功！");
        }
        return Jsoner.error("系统发放分红失败！");
    }

    @ResponseBody
    @RequestMapping(value = {"/refuseDirectly"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object refuseDirectly(Integer id) {
        if (this.contractBonusService.updateToRefuse(id)) {
            return Jsoner.success("系统拒发分红");
        }
        return Jsoner.error("系统拒发分红失败。");
    }
}
