package com.hs3.admin.controller.activity;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.models.PageData;
import com.hs3.service.activity.ActivityService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@Scope("prototype")
@RequestMapping({"/admin/activity"})
public class ActivityController extends AdminController {
    @Autowired
    private ActivityService activityService;

    @RequestMapping({"/index"})
    public Object index() {
        return getViewName("/activity/index");
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list() {
        Page p = getPageWithParams();
        List<?> list = this.activityService.listOrderBy(p);
        return new PageData(p.getRowCount(), list);
    }
}
