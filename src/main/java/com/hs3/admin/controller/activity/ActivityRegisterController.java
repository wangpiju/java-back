package com.hs3.admin.controller.activity;

import com.hs3.admin.controller.AdminController;
import com.hs3.commons.ActivityType;
import com.hs3.entity.activity.Activity;
import com.hs3.models.activity.ActivityRechargeModel;
import com.hs3.service.activity.ActivityService;
import com.hs3.utils.FileUtils;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller
@Scope("prototype")
@RequestMapping({"/admin/activity/register"})
public class ActivityRegisterController extends AdminController {
    private static final String KEY = "register";
    @Autowired
    private ActivityService activityService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/activity/register");
        Activity activity = this.activityService.find(ActivityType.register.getType());
        mv.addObject("m", activity);
        return mv;
    }

    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(ActivityRechargeModel m, MultipartFile file) {
        if (!file.isEmpty()) {
            try {
                String fileName = FileUtils.save(getSession().getServletContext().getRealPath("/"), "/res/upload/", file);
                m.setIcon(fileName);
            } catch (Exception e) {
                return com.hs3.models.Jsoner.error("文件上传错误");
            }
        }
        this.activityService.update(m);
        return redirect("/admin/activity/register/index");
    }
}
