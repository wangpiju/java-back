package com.hs3.admin.controller.report;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.report.UserReport;
import com.hs3.models.PageData;
import com.hs3.service.report.UserReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@Scope("prototype")
@RequestMapping({"/admin/userReport"})
public class UserReportController extends AdminController {
    @Autowired
    private UserReportService userReportService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/report/userReport");
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(String account, String startDate, String endDate) {
        Page p = getPageWithParams();
        java.util.List<UserReport> list = this.userReportService.adminList(p, account, startDate, endDate);
        return new PageData(p.getRowCount(), list);
    }
}
