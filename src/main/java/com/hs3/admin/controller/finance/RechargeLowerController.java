package com.hs3.admin.controller.finance;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.finance.RechargeLower;
import com.hs3.entity.users.Manager;
import com.hs3.exceptions.BaseCheckException;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.finance.RechargeLowerService;
import com.hs3.service.finance.RechargeService;
import com.hs3.utils.DateUtils;

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
@RequestMapping({"/admin/finance/rechargeLower"})
public class RechargeLowerController
        extends AdminController {
    @Autowired
    private RechargeLowerService rechargeLowerService;
    @Autowired
    private RechargeService rechargeService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/finance/rechargeLower");

        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(RechargeLower rechargeLower, String startTime, String endTime) {
        Page p = getPageWithParams();
        Date st = DateUtils.toDateNull(startTime);
        Date et = DateUtils.toDateNull(endTime);
        if (rechargeLower == null) {
            rechargeLower = new RechargeLower();
        }
        if ((rechargeLower.getStatus() == null) || (-1 == rechargeLower.getStatus().intValue())) {
            rechargeLower.setStatus(null);
        }
        List<RechargeLower> list = this.rechargeLowerService.listByCond(rechargeLower, st, et, p);

        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping({"/listWithOrder"})
    public Object listWithOrder() {
        Page p = getPageWithParams();
        List<RechargeLower> list = this.rechargeLowerService.listWithOrder(p);

        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(RechargeLower m) {
        this.rechargeLowerService.save(m);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(String id) {
        return this.rechargeLowerService.find(id);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(RechargeLower m, Integer operateType) {
        m.setOperator(((Manager) getLogin()).getAccount());
        try {
            if (operateType.intValue() == 0) {
                this.rechargeService.updateByReject(m);
            } else if (operateType.intValue() == 1) {
                this.rechargeService.updateBySuccess(m);
            } else {
                throw new BaseCheckException("操作不支持！");
            }
            return Jsoner.success();
        } catch (BaseCheckException e) {
            return Jsoner.error(e.getMessage());
        }
    }
}
