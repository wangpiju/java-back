package com.hs3.admin.controller.userAgents;

import com.hs3.admin.controller.AdminController;
import com.hs3.dao.lotts.LotteryDao;
import com.hs3.db.Page;
import com.hs3.entity.lotts.Lottery;
import com.hs3.entity.userAgents.UserAgentsDaily;
import com.hs3.entity.userAgents.UserAgentsDailyLottery;
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
@RequestMapping({"/admin/userAgents/dailyLottery"})
public class UserAgentsDailyLotteryController extends AdminController {

    @Autowired
    private UserAgentsService userAgentsService;

    @Autowired
    private LotteryDao lotteryDao;


    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/userAgents/userAgentsDailyLottery");
        List<Lottery> lotteryList = lotteryDao.listByHotNewSelf();
        mv.addObject("lotteryList", lotteryList);
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(String q_programName, Integer q_status) {
        Page p = getPageWithParams();
        List<UserAgentsDailyLottery> list = this.userAgentsService.userAgentsDailyLotteryList(q_programName, q_status, 1, p);
        return new PageData(p.getRowCount(), list);
    }


    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {

        if(StrUtils.hasEmpty(new Object[]{id})){
            return Jsoner.error("数据ID异常！");
        }

        return userAgentsService.findUserAgentsDailyLottery(id);
    }


    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(UserAgentsDailyLottery m) {
        m.setCycle(1);
        userAgentsService.saveUserAgentsDailyLottery(m);
        return Jsoner.success();
    }




}
