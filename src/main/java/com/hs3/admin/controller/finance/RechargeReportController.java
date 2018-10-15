package com.hs3.admin.controller.finance;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.finance.RechargeReport;
import com.hs3.models.PageData;
import com.hs3.service.finance.RechargeReportService;
import com.hs3.utils.StrUtils;
import com.pays.PayApiFactory;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@Scope("prototype")
@RequestMapping({"/admin/finance/rechargeReport"})
public class RechargeReportController
        extends AdminController {
    @Autowired
    private RechargeReportService rechargeReportService;

    @RequestMapping({"/index"})
    public Object index() {
        Map<String, String> bankKey = PayApiFactory.getMaps();
        ModelAndView mv = getView("/finance/rechargeReport");
        mv.addObject("bankKeyJson", StrUtils.toJson(bankKey));
        mv.addObject("bankKey", bankKey);
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(Date begin, Date end, String receiveName, String receiveCard) {
        Page p = getPageWithParams();
        List<RechargeReport> list = this.rechargeReportService.list(begin, end, receiveName, receiveCard, p);
        return new PageData(p.getRowCount(), list);
    }
}
