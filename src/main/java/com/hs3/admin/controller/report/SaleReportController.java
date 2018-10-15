package com.hs3.admin.controller.report;

import com.hs3.admin.controller.AdminController;
import com.hs3.service.lotts.LotteryService;
import com.hs3.service.report.SaleReportService;
import com.hs3.utils.StrUtils;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@Scope("prototype")
@RequestMapping({"/admin/saleReport"})
public class SaleReportController
        extends AdminController {
    @Autowired
    private SaleReportService saleReportService;
    @Autowired
    private LotteryService lotteryService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/report/sale");
        mv.addObject("list", this.lotteryService.list(null));
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object index(Date begin, Date end, String lotteryId, Integer test) {
        if ((begin == null) || (end == null)) return null;
        return this.saleReportService.getReport(begin, end, lotteryId, test);
    }

    @RequestMapping({"/seasonIndex"})
    public Object seasonIndex() {
        ModelAndView mv = getView("/report/season");
        mv.addObject("list", this.lotteryService.list(null));
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/seasonList"})
    public Object seasonList(Date date, String lotteryId, Integer test) {
        if (date != null) {
            if (!StrUtils.hasEmpty(new Object[]{lotteryId})) {
            }
        } else return null;
        return this.saleReportService.getSeasonReport(date, lotteryId, test);
    }
}
