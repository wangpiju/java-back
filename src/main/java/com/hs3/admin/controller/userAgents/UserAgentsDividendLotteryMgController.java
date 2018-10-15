package com.hs3.admin.controller.userAgents;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.userAgents.UserAgentsDividendLotteryMg;
import com.hs3.entity.userAgents.UserAgentsDividendMg;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.user.UserAgentsService;
import com.hs3.utils.DateUtils;
import com.hs3.utils.StrUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.Date;
import java.util.List;

@Controller
@Scope("prototype")
@RequestMapping({"/admin/userAgents/dividendLotteryMg"})
public class UserAgentsDividendLotteryMgController extends AdminController {

    @Autowired
    private UserAgentsService userAgentsService;

    @RequestMapping({"/index"})
    public Object index(Date t1, Date t2) {
        ModelAndView mv = getView("/userAgents/userAgentsDividendLotteryMg");
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
    @RequestMapping({"/list"})
    public Object list(String q_account, String q_programName, String q_begin, String q_end, String q_startTimeStr, String q_endTimeStr, Integer q_status) {
        Page p = getPageWithParams();

        Date q_startTime = DateUtils.toDateNull(q_startTimeStr);
        Date q_endTime = DateUtils.toDateNull(q_endTimeStr);

        List<UserAgentsDividendLotteryMg> list = this.userAgentsService.userAgentsDividendLotteryMgList(q_account, null, q_programName, q_begin, q_end, q_startTime, q_endTime, q_status, p);
        return new PageData(p.getRowCount(), list);
    }


    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {

        if(StrUtils.hasEmpty(new Object[]{id})){
            return Jsoner.error("数据ID异常！");
        }

        return userAgentsService.findUserAgentsDividendLotteryMg(id);
    }


    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(UserAgentsDividendLotteryMg m) {

        if(StrUtils.hasEmpty(new Object[]{m.getId()})){
            return Jsoner.error("数据ID异常！");
        }

        String operator  = getLogin().getAccount();
        m.setOperator(operator);

        userAgentsService.updateUserAgentsDividendLotteryMg(m);
        return Jsoner.success();
    }


}
