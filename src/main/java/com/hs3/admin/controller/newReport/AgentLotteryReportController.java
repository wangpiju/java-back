package com.hs3.admin.controller.newReport;


import com.hs3.admin.controller.AdminController;
import com.hs3.dao.lotts.LotteryDao;
import com.hs3.db.Page;
import com.hs3.entity.lotts.Lottery;
import com.hs3.entity.report.AgentLotteryReport;
import com.hs3.entity.report.AgentReport;
import com.hs3.models.PageData;
import com.hs3.service.newReport.CpsReportService;
import com.hs3.utils.DateUtils;
import com.hs3.utils.StrUtils;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
@Scope("prototype")
@RequestMapping({"/admin/newReport/agentLotteryReport"})
public class AgentLotteryReportController extends AdminController {


    @Autowired
    private CpsReportService cpsReportService;

    @Autowired
    private LotteryDao lotteryDao;

    @RequestMapping({"/index"})
    public Object index(Date t1, Date t2) {
        ModelAndView mv = getView("/newReport/agentLotteryReport");
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
    @RequestMapping({"/agentLotteryReport"})
    public Object agentsReport(String account, String startDateStr, String endDateStr, String lotteryId) throws ParseException {
        Page p = getPageWithParams();
        Date beginDate = null;
        Date endDate = null;

        if(!StrUtils.hasEmpty(new Object[]{startDateStr})) beginDate = DateUtils.toDate(startDateStr + " 00:00:00");
        if(!StrUtils.hasEmpty(new Object[]{endDateStr})) endDate = DateUtils.toDate(endDateStr + " 23:59:59");
        String[] lotteryIdArr = null;
        if(!StrUtils.hasEmpty(new Object[]{lotteryId})) {
            lotteryIdArr = lotteryId.split(",");
            lotteryIdArr = replaceNull(lotteryIdArr);
            /*for(String lotteryIdStr: lotteryIdArr){
                System.out.println("=============betReport========lotteryIdStr======>>>>>" + lotteryIdStr);
            }*/
        }

        List<AgentLotteryReport> list = cpsReportService.agentLotteryReportList(account, lotteryIdArr, beginDate, endDate, p);

        return new PageData(p.getRowCount(), p.getObj(), list);
    }


    @ResponseBody
    @RequestMapping(value = {"/getLotterys"}, method = {RequestMethod.GET})
    public List<JSONObject> getLotterys() {

        List<Lottery> list = lotteryDao.listByHotNewSelf();
        JSONObject json = new JSONObject();
        json.put("id", "");
        json.put("text", "");

        List<JSONObject> childrenList = new ArrayList<JSONObject>();
        JSONObject lotteryJson = null;
        for(Lottery jobj: list){
            lotteryJson = new JSONObject();
            lotteryJson.put("id", jobj.getId());
            lotteryJson.put("text", jobj.getTitle());
            childrenList.add(lotteryJson);
        }

        json.put("children", childrenList);

        List<JSONObject> dataList = new ArrayList<JSONObject>();
        dataList.add(json);

        return dataList;
    }


    private String[] replaceNull(String[] str){
        //用StringBuffer来存放数组中的非空元素，用“;”分隔
        StringBuffer sb = new StringBuffer();
        for(int i=0; i<str.length; i++) {
            if("".equals(str[i])) {
                continue;
            }
            sb.append(str[i]);
            if(i != str.length - 1) {
                sb.append(";");
            }
        }
        //用String的split方法分割，得到数组
        str = sb.toString().split(";");
        return str;
    }


}
