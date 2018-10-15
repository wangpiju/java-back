package com.hs3.admin.controller.activity;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.users.Manager;
import com.hs3.models.Jsoner;
import com.hs3.service.activity.ActivityService;
import com.hs3.service.activity.ActivityUserService;
import com.hs3.utils.StrUtils;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@Scope("prototype")
@RequestMapping({"/admin/activity/user"})
public class ActivityUserController extends AdminController {
    @Autowired
    private ActivityUserService activityUserService;
    @Autowired
    private ActivityService activityService;

    @RequestMapping({"/index"})
    public Object index(String activityId) {
        ModelAndView mv = getView("/activity/user");
        mv.addObject("activityId", activityId);
        List<?> list = this.activityService.list(null);
        mv.addObject("list", list);
        mv.addObject("json", StrUtils.toJson(list));
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(Integer activityId, Integer status) {
        Page p = getPageWithParams();
        List<?> list = this.activityUserService.list(activityId, status, p);
        return new com.hs3.models.PageData(p.getRowCount(), list);
    }


    @ResponseBody
    @RequestMapping({"/status"})
    public Object status(Integer id) {
        boolean n = this.activityUserService.setStatus(id, 1, 2, ((Manager) getLogin()).getAccount());
        return Jsoner.getByResult(n);
    }


    @ResponseBody
    @RequestMapping({"/success"})
    public Object success(Integer id) {
        boolean n = this.activityUserService.setStatus(id, 2, 3, ((Manager) getLogin()).getAccount());
        return Jsoner.getByResult(n);
    }


    @ResponseBody
    @RequestMapping({"/fail"})
    public Object fail(Integer id) {
        boolean n = this.activityUserService.setStatus(id, 2, 4, getLogin().getAccount());
        return Jsoner.getByResult(n);
    }
}
