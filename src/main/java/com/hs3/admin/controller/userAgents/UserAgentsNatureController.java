package com.hs3.admin.controller.userAgents;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.users.UserAgentsNature;
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
@RequestMapping({"/admin/userAgents/nature"})
public class UserAgentsNatureController extends AdminController {

    @Autowired
    private UserAgentsService userAgentsService;


    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/userAgents/userAgentsNature");
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(String q_account, String q_parentAccount, Integer q_isA, Integer q_isDaily, Integer q_isDividend, Integer q_isDailyLottery, Integer q_isDividendLottery) {
        Page p = getPageWithParams();
        List<UserAgentsNature> list = this.userAgentsService.userAgentsNatureList(q_account, q_parentAccount, q_isA, q_isDaily, q_isDividend, q_isDailyLottery, q_isDividendLottery, p);
        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(String account) {

        if(StrUtils.hasEmpty(new Object[]{account})){
            return Jsoner.error("账户异常！");
        }

        return userAgentsService.findByAccount(account);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(UserAgentsNature m) {

        String operator  = getLogin().getAccount();
        m.setOperator(operator);
        userAgentsService.save(m);

        return Jsoner.success();
    }



}
