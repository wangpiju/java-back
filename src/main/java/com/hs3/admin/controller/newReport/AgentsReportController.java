package com.hs3.admin.controller.newReport;


import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.report.AgentReport;
import com.hs3.models.PageData;
import com.hs3.service.newReport.CpsReportService;
import com.hs3.utils.DateUtils;
import com.hs3.utils.StrUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.text.ParseException;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
@Scope("prototype")
@RequestMapping({"/admin/newReport/agentsReport"})
public class AgentsReportController extends AdminController {


    @Autowired
    private CpsReportService cpsReportService;

    @RequestMapping({"/index"})
    public Object index(Date t1, Date t2) {
        ModelAndView mv = getView("/newReport/agentsReport");
        if (t1 != null) {
            if (t2 != null) {
                if (t1.getTime() < t2.getTime()) {
                    mv.addObject("begin", DateUtils.formatDate(t1));
                    mv.addObject("end", DateUtils.formatDate(t2));
                } else {
                    mv.addObject("begin", DateUtils.formatDate(t2));
                    mv.addObject("end", DateUtils.formatDate(t1));
                }
            } else {
                mv.addObject("begin", DateUtils.formatDate(t1));
            }
        }
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/agentsReport"})
    public Object agentsReport(String account, String startDateStr, String endDateStr, Integer sorting) throws ParseException {
        Page p = getPageWithParams();

        List<AgentReport> list = cpsReportService.agentsReport(account, sorting, startDateStr, endDateStr,1, p);

        return new PageData(p.getRowCount(), p.getObj(), list);
    }


}
