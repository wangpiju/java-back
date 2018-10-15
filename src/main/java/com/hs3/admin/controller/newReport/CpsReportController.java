package com.hs3.admin.controller.newReport;

import com.hs3.admin.controller.AdminController;
import com.hs3.service.newReport.CpsReportService;
import com.hs3.utils.BaseBeanUtils;
import com.hs3.utils.DateUtils;
import com.hs3.utils.StrUtils;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
@Scope("prototype")
@RequestMapping({"/admin/newReport/cpsReport"})
public class CpsReportController extends AdminController {

    @Autowired
    private CpsReportService cpsReportService;

    @RequestMapping({"/index"})
    public Object index(Integer dateFlag, String startDateStr, String endDateStr) throws ParseException {
        ModelAndView mv = getView("/newReport/cpsReport");

        //System.out.println("=====================>>> CpsReportController + index(Integer dateFlag, String startDateStr, String endDateStr) ");
        //System.out.println("===========dateFlag==========>>> " + dateFlag);
        //System.out.println("===========startDateStr==========>>> " + startDateStr);
        //System.out.println("===========endDateStr==========>>> " + endDateStr);

        if(StrUtils.hasEmpty(new Object[]{dateFlag}) && (StrUtils.hasEmpty(new Object[]{startDateStr}) || StrUtils.hasEmpty(new Object[]{endDateStr}))){
            dateFlag = 0;
        }

        if(StrUtils.hasEmpty(new Object[]{startDateStr})) startDateStr = ""; else startDateStr += " 00:00:00";
        if(StrUtils.hasEmpty(new Object[]{endDateStr})) endDateStr = ""; else endDateStr += " 23:59:59";

        //------------本月------------
        Date beginThisM = null;
        Date endThisM = null;
        String startTimeThisM = "";
        String endTimeThisM = "";

        Calendar cal1 = Calendar.getInstance();
        int dateStr1 = cal1.get(Calendar.DATE);
        String[] dayStrArr1 = getday(dateStr1 - 1);
        startTimeThisM = dayStrArr1[0];
        String[] dayStrArrZ1 = getday(0);
        endTimeThisM = dayStrArrZ1[1];
        beginThisM = DateUtils.toDate(startTimeThisM);
        endThisM = DateUtils.toDate(endTimeThisM);

        //------------上月------------
        Date beginLastM = null;
        Date endLastM = null;
        String startTimeLastM = "";
        String endTimeLastM = "";

        String[] dayStrArr2 = getTerMonth(1);
        startTimeLastM = dayStrArr2[0];
        endTimeLastM = dayStrArr2[1];
        beginLastM = DateUtils.toDate(startTimeLastM);
        endLastM = DateUtils.toDate(endTimeLastM);



        Date begin = null;
        Date end = null;
        String startTime = "";
        String endTime = "";


        if(!StrUtils.hasEmpty(new Object[]{startDateStr}) && !StrUtils.hasEmpty(new Object[]{endDateStr})){
            startTime = startDateStr;
            endTime = endDateStr;
        }else {
            if (dateFlag == 0) {//今天
                String[] dayStrArr = getday(0);
                startTime = dayStrArr[0];
                endTime = dayStrArr[1];
            } else if (dateFlag == 1) {//昨天
                String[] dayStrArr = getday(1);
                startTime = dayStrArr[0];
                endTime = dayStrArr[1];
            } else if (dateFlag == 2) {//本月
                startTime = startTimeThisM;
                endTime = endTimeThisM;
            } else if (dateFlag == 3) {//上月
                startTime = startTimeLastM;
                endTime = endTimeLastM;
            }
        }

        begin = DateUtils.toDate(startTime);
        end = DateUtils.toDate(endTime);

        HashMap<String, Object> cpsReport = cpsReportService.cpsReport(begin, end, beginThisM, endThisM, beginLastM, endLastM);

        //System.out.println("***********dateFlag***********>>> " + dateFlag);
        //System.out.println("***********startDateStr***********>>> " + startDateStr);
        //System.out.println("***********endDateStr***********>>> " + endDateStr);
        HashMap<String, Object> parameterOb = new HashMap<String, Object>();
        parameterOb.put("dateFlag", dateFlag);
        parameterOb.put("startDateStr", startDateStr);
        parameterOb.put("endDateStr", endDateStr);

        mv.addObject("cpsReport", cpsReport);
        mv.addObject("parameterOb", parameterOb);
        return mv;
    }


    //我的账户-序21
    private static String[] getday(int num) {
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, -num);
        String dayStr = new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
        String startTime = dayStr + " 00:00:00";
        String endTime = dayStr + " 23:59:59";
        String[] dayStrArr = new String[2];
        dayStrArr[0] = startTime;
        dayStrArr[1] = endTime;
        return dayStrArr;
    }


    //我的账户-序22

    //取N个月前的时间区域
    private static String[] getTerMonth(int monthNum) {

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.MONTH, -monthNum);
        int dateStr = cal.get(Calendar.DATE);
        cal.add(Calendar.DATE, -(dateStr - 1));
        String dayStr = format.format(cal.getTime());
        String startTime = dayStr + " 00:00:00";

        cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
        String last = format.format(cal.getTime());

        String endTime = last + " 23:59:59";
        String[] dayStrArr = new String[2];
        dayStrArr[0] = startTime;
        dayStrArr[1] = endTime;
        return dayStrArr;
    }



    @RequestMapping({"/indexNew"})
    public Object indexNew(){
        ModelAndView mv = getView("/newReport/cpsReportNew");
        return mv;
    }





}
