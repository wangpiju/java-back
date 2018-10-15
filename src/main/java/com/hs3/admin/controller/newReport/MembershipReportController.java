package com.hs3.admin.controller.newReport;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.report.MembershipReport;
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
@RequestMapping({"/admin/newReport/membershipReport"})
public class MembershipReportController extends AdminController {

    @Autowired
    private CpsReportService cpsReportService;

    @RequestMapping({"/index"})
    public Object index(Date t1, Date t2) {
        ModelAndView mv = getView("/newReport/membershipReport");
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

    @ResponseBody
    @RequestMapping({"/membershipReport"})
    public Object membershipReport(String account, String parentAccount, Integer sorting, String startDateStr, String endDateStr) throws ParseException {
        Page p = getPageWithParams();

        Date beginDate = null;
        Date endDate = null;

        if(!StrUtils.hasEmpty(new Object[]{startDateStr})) beginDate = DateUtils.toDate(startDateStr);
        if(!StrUtils.hasEmpty(new Object[]{endDateStr})) endDate = DateUtils.toDate(endDateStr);


        List<Map<String, Object>> list = cpsReportService.membershipReport(account, parentAccount, null, beginDate, endDate, p);
        return new PageData(p.getRowCount(), p.getObj(), list);
    }



    @RequestMapping({"/indexNew"})
    public Object indexNew(Date t1, Date t2) {
        ModelAndView mv = getView("/newReport/membershipReportNew");
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

    @ResponseBody
    @RequestMapping({"/membershipReportNew"})
    public Object membershipReportNew(String account, String parentAccount, Integer sorting, Integer isBlurry, String startDateStr, String endDateStr) throws ParseException {
        Page p = getPageWithParams();

        Date beginDate = null;
        Date endDate = null;

        if(!StrUtils.hasEmpty(new Object[]{startDateStr})) beginDate = DateUtils.toDate(startDateStr);
        if(!StrUtils.hasEmpty(new Object[]{endDateStr})) endDate = DateUtils.toDate(endDateStr);

        String[] accountArr = null;
        if(!StrUtils.hasEmpty(new Object[]{account})) {
            accountArr = account.split(",");
            /*for(String accountStr: accountArr){
                System.out.println("=============membershipReportNew========accountStr======>>>>>" + accountStr);
            }*/
        }


        List<MembershipReport> list = cpsReportService.membershipReport_Z(accountArr, parentAccount, sorting, isBlurry, beginDate, endDate, p);
        return new PageData(p.getRowCount(), p.getObj(), list);
    }





}
