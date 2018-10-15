package com.hs3.admin.controller.activity;

import com.hs3.admin.controller.AdminController;
import com.hs3.models.activity.ActivityFirstrechargeModel;
import com.hs3.service.activity.ActivityFirstrechargeService;
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
@RequestMapping({"/admin/activity/firstrecharge"})
public class ActivityFirstrechargeController extends AdminController {
    @Autowired
    private ActivityFirstrechargeService activityFirstRechargeService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/activity/firstrecharge");
        mv.addObject("m", this.activityFirstRechargeService.findFull());
        return mv;
    }

    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(ActivityFirstrechargeModel m, MultipartFile file) {
        if (!file.isEmpty()) {
            try {
                String fileName = FileUtils.save(getSession().getServletContext().getRealPath("/"), "/res/upload/", file);
                m.setIcon(fileName);
            } catch (Exception e) {
                return com.hs3.models.Jsoner.error("文件上传错误");
            }
        }
        this.activityFirstRechargeService.saveOrUpdate(m);
        return redirect("index");
    }
}
