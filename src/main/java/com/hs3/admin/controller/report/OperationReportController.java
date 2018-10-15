package com.hs3.admin.controller.report;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.report.OperationReport;
import com.hs3.models.PageData;
import com.hs3.service.report.OperationReportService;
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
@RequestMapping({"/admin/report/operationReport"})
public class OperationReportController
        extends AdminController {
    @Autowired
    private OperationReportService operationReportService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/report/operationReport");

        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object listOperationReport(String startTime, String endTime) {
        Page page = getPageWithParams();
        Date reportDateBegin = DateUtils.toDateNull(startTime, "yyyy-MM-dd");
        if (reportDateBegin == null) {
            return null;
        }
        Date reportDateEnd = DateUtils.toDateNull(endTime, "yyyy-MM-dd");
        if (reportDateEnd == null) {
            reportDateEnd = DateUtils.getToDay();
        }
        List<OperationReport> list = this.operationReportService.list(reportDateBegin, reportDateEnd, page);
        return new PageData(page.getRowCount(), list);
    }
}
