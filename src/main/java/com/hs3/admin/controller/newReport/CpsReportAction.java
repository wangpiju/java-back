package com.hs3.admin.controller.newReport;

import com.hs3.dao.report.OnlineDao;
import com.hs3.dao.user.UserDao;
import com.hs3.db.Page;
import com.hs3.entity.report.CpsReport;
import com.hs3.admin.controller.HomeAction;
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

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
@Scope("prototype")
@RequestMapping({"/newReport/cpsNReport"})
public class CpsReportAction extends HomeAction {

    @Autowired
    private CpsReportService cpsReportService;

    @Autowired
    private UserDao userDao;

    @Autowired
    private OnlineDao onlineDao;

    private static final ObjectMapper mapper = new ObjectMapper();


    @ResponseBody
    @RequestMapping(value = {"/getCpsReportByDateFlag"}, method = {RequestMethod.GET})
    public JsonNode getCpsReportByDateFlag(Integer dateFlag) {
        HashMap<String, String> returnC = new HashMap<String, String>();
        try {
            //System.out.println("===============dateFlag=================>>>>>>" + dateFlag);
            if (dateFlag == null || (dateFlag != 0 && dateFlag != 1 && dateFlag != 2 && dateFlag != 3)) {
                returnC.put("message", "[时间区域]标记不合法！");
                return mapper.valueToTree(BaseBeanUtils.getFailReturn(returnC));
            }

            Date begin = null;
            Date end = null;
            String startTime = "";
            String endTime = "";

            Map<String, Object> cpsReportMap = null;
            CpsReport cpsReport = null;

            if(dateFlag == 0){
                String[] dayStrArr = getday(0);
                startTime = dayStrArr[0];
                endTime = dayStrArr[1];
                begin = DateUtils.toDate(startTime);
                end = DateUtils.toDate(endTime);
                cpsReportMap = cpsReportService.cpsReport_new(begin, end);
            } else {
                cpsReport = getCpsReportByDateHistoryFlag(dateFlag);
            }

            if(dateFlag == 0) return mapper.valueToTree(BaseBeanUtils.getSuccessReturn(cpsReportMap));
            else return mapper.valueToTree(BaseBeanUtils.getSuccessReturn(cpsReport));
        } catch (Exception e) {
            e.printStackTrace();
            returnC.put("message", e.getMessage());
            return mapper.valueToTree(BaseBeanUtils.getFailReturn(returnC));
        }
    }


    @ResponseBody
    @RequestMapping(value = {"/getCpsReportByDateHistoryFlag"}, method = {RequestMethod.GET})
    public CpsReport getCpsReportByDateHistoryFlag(Integer dateFlag) throws ParseException {

        Date begin = null;
        Date end = null;
        String startTime = "";
        String endTime = "";

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



        CpsReport cpsReport = null;

        if (dateFlag == 1) {//昨天
            String[] dayStrArr = getday(1);
            startTime = dayStrArr[0];
            endTime = dayStrArr[1];
            begin = DateUtils.toDate(startTime);
            end = DateUtils.toDate(endTime);
        } else if (dateFlag == 2) {//本月
            startTime = startTimeThisM;
            endTime = endTimeThisM;
            begin = DateUtils.toDate(startTime);
            end = DateUtils.toDate(endTime);
        } else if (dateFlag == 3) {//上月
            startTime = startTimeLastM;
            endTime = endTimeLastM;
            begin = DateUtils.toDate(startTime);
            end = DateUtils.toDate(endTime);
        }

        cpsReport = cpsReportService.fromList(begin, end, null);

        return cpsReport;
    }

    @ResponseBody
    @RequestMapping(value = {"/getCpsReportByDate"}, method = {RequestMethod.GET})
    public JsonNode getCpsReportByDate(String startDateStr, String endDateStr) {
        HashMap<String, String> returnC = new HashMap<String, String>();
        try {
            if(StrUtils.hasEmpty(new Object[]{startDateStr}) || StrUtils.hasEmpty(new Object[]{endDateStr})){
                returnC.put("message", "[时间区域]不能为空！");
                return mapper.valueToTree(BaseBeanUtils.getFailReturn(returnC));
            }

            Date begin = null;
            Date end = null;
            startDateStr += " 00:00:00";
            endDateStr += " 23:59:59";
            begin = DateUtils.toDate(startDateStr);
            end = DateUtils.toDate(endDateStr);

            CpsReport cpsReport = cpsReportService.fromList(begin, end, null);

            return mapper.valueToTree(BaseBeanUtils.getSuccessReturn(cpsReport));
        } catch (Exception e) {
            e.printStackTrace();
            returnC.put("message", e.getMessage());
            return mapper.valueToTree(BaseBeanUtils.getFailReturn(returnC));
        }
    }


    @ResponseBody
    @RequestMapping(value = {"/getAmountAllUser"}, method = {RequestMethod.GET})
    public JsonNode getAmountAllUser() {
        HashMap<String, String> returnC = new HashMap<String, String>();
        try {
            Map<String, Object> allAmount = userDao.amountUser(null);
            return mapper.valueToTree(BaseBeanUtils.getSuccessReturn(allAmount));
        } catch (Exception e) {
            e.printStackTrace();
            returnC.put("message", e.getMessage());
            return mapper.valueToTree(BaseBeanUtils.getFailReturn(returnC));
        }
    }


    @ResponseBody
    @RequestMapping(value = {"/getOnlineUserNum"}, method = {RequestMethod.GET})
    public JsonNode getOnlineUserNum() {
        HashMap<String, String> returnC = new HashMap<String, String>();
        try {
            Integer onlineUserNum = onlineDao.getOnlineUserNum();
            HashMap<String, Object> obData = new HashMap<String, Object>();
            obData.put("onlineUserNum", onlineUserNum);
            return mapper.valueToTree(BaseBeanUtils.getSuccessReturn(obData));
        } catch (Exception e) {
            e.printStackTrace();
            returnC.put("message", e.getMessage());
            return mapper.valueToTree(BaseBeanUtils.getFailReturn(returnC));
        }
    }


    @ResponseBody
    @RequestMapping(value = {"/setHistoryCpsReport"}, method = {RequestMethod.POST})
    public JsonNode setHistoryCpsReport(String historyDate) {
        HashMap<String, String> returnC = new HashMap<String, String>();
        try {
            cpsReportService.addWhenNotExists(historyDate);
            HashMap<String, Object> obData = new HashMap<String, Object>();
            obData.put("message", historyDate + " 创建历史综合报表数据成功！");
            return mapper.valueToTree(BaseBeanUtils.getSuccessReturn(obData));
        } catch (Exception e) {
            e.printStackTrace();
            returnC.put("message", e.getMessage());
            return mapper.valueToTree(BaseBeanUtils.getFailReturn(returnC));
        }
    }



    @ResponseBody
    @RequestMapping(value = {"/setHistoryAgentReport"}, method = {RequestMethod.POST})
    public JsonNode setHistoryAgentReport(String historyDate) {
        HashMap<String, String> returnC = new HashMap<String, String>();
        try {
            cpsReportService.addAgentsReportWhenNotExists(historyDate);
            HashMap<String, Object> obData = new HashMap<String, Object>();
            obData.put("message", historyDate + " 创建历史代理报表数据成功！");
            return mapper.valueToTree(BaseBeanUtils.getSuccessReturn(obData));
        } catch (Exception e) {
            e.printStackTrace();
            returnC.put("message", e.getMessage());
            return mapper.valueToTree(BaseBeanUtils.getFailReturn(returnC));
        }
    }



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




}
