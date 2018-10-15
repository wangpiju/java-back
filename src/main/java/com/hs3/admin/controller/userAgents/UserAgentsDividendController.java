package com.hs3.admin.controller.userAgents;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.userAgents.UserAgentsDividend;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.user.UserAgentsService;
import com.hs3.utils.StrUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@Scope("prototype")
@RequestMapping({"/admin/userAgents/dividend"})
public class UserAgentsDividendController extends AdminController {

    @Autowired
    private UserAgentsService userAgentsService;


    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/userAgents/userAgentsDividend");
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(String q_programName, Integer q_status) {
        Page p = getPageWithParams();
        List<UserAgentsDividend> list = this.userAgentsService.userAgentsDividendList(q_programName, null, q_status, 1, p);
        return new PageData(p.getRowCount(), list);
    }


    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {

        if(StrUtils.hasEmpty(new Object[]{id})){
            return Jsoner.error("数据ID异常！");
        }

        return userAgentsService.findUserAgentsDividend(id);
    }


    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(UserAgentsDividend m) {
        userAgentsService.saveUserAgentsDividend(m);
        return Jsoner.success();
    }




}
