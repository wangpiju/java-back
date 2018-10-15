package com.hs3.admin.controller.userAgents;

import com.hs3.admin.controller.HomeAction;
import com.hs3.service.user.UserAgentsService;
import com.hs3.utils.BaseBeanUtils;
import com.hs3.utils.DateUtils;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.HashMap;

@Controller
@Scope("prototype")
@RequestMapping({"/userAgents/setHistory"})
public class UserAgentsSetHistoryAction extends HomeAction {

    private static final ObjectMapper mapper = new ObjectMapper();

    @Autowired
    private UserAgentsService userAgentsService;


    @ResponseBody
    @RequestMapping(value = {"/setHistoryUserAgentsDailyMg"}, method = {RequestMethod.POST})
    public JsonNode setHistoryUserAgentsDailyMg(String historyDate) {
        HashMap<String, String> returnC = new HashMap<String, String>();
        try {
            userAgentsService.addUserAgentsDailyWhenNotExists(historyDate, false);
            HashMap<String, Object> obData = new HashMap<String, Object>();
            obData.put("message", historyDate + " 创建日工资派发数据成功！");
            return mapper.valueToTree(BaseBeanUtils.getSuccessReturn(obData));
        } catch (Exception e) {
            e.printStackTrace();
            returnC.put("message", e.getMessage());
            return mapper.valueToTree(BaseBeanUtils.getFailReturn(returnC));
        }
    }

    @ResponseBody
    @RequestMapping(value = {"/setHistoryUserAgentsDividendMg"}, method = {RequestMethod.POST})
    public JsonNode setHistoryUserAgentsDividendMg(String historyDateStr) {
        HashMap<String, String> returnC = new HashMap<String, String>();
        try {

            Date historyDate = null;
            historyDateStr += " 00:00:00";
            historyDate = DateUtils.toDate(historyDateStr);

            userAgentsService.addUserAgentsDividendWhenNotExists(historyDate);
            HashMap<String, Object> obData = new HashMap<String, Object>();
            obData.put("message", historyDate + " 创建周期分红派发数据成功！");
            return mapper.valueToTree(BaseBeanUtils.getSuccessReturn(obData));
        } catch (Exception e) {
            e.printStackTrace();
            returnC.put("message", e.getMessage());
            return mapper.valueToTree(BaseBeanUtils.getFailReturn(returnC));
        }
    }


    @ResponseBody
    @RequestMapping(value = {"/setHistoryUserAgentsDailyLotteryMg"}, method = {RequestMethod.POST})
    public JsonNode setHistoryUserAgentsDailyLotteryMg(String historyDate) {
        HashMap<String, String> returnC = new HashMap<String, String>();
        try {
            userAgentsService.addUserAgentsDailyLotteryWhenNotExists(historyDate, false);
            HashMap<String, Object> obData = new HashMap<String, Object>();
            obData.put("message", historyDate + " 创建日工资彩种加奖派发数据成功！");
            return mapper.valueToTree(BaseBeanUtils.getSuccessReturn(obData));
        } catch (Exception e) {
            e.printStackTrace();
            returnC.put("message", e.getMessage());
            return mapper.valueToTree(BaseBeanUtils.getFailReturn(returnC));
        }
    }


    @ResponseBody
    @RequestMapping(value = {"/setHistoryUserAgentsDividendLotteryMg"}, method = {RequestMethod.POST})
    public JsonNode setHistoryUserAgentsDividendLotteryMg(String historyDateStr) {
        HashMap<String, String> returnC = new HashMap<String, String>();
        try {

            Date historyDate = null;
            historyDateStr += " 00:00:00";
            historyDate = DateUtils.toDate(historyDateStr);

            userAgentsService.addUserAgentsDividendLotteryWhenNotExists(historyDate);
            HashMap<String, Object> obData = new HashMap<String, Object>();
            obData.put("message", historyDate + " 创建周期分红彩种加奖派发数据成功！");
            return mapper.valueToTree(BaseBeanUtils.getSuccessReturn(obData));
        } catch (Exception e) {
            e.printStackTrace();
            returnC.put("message", e.getMessage());
            return mapper.valueToTree(BaseBeanUtils.getFailReturn(returnC));
        }
    }




}
