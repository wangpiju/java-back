package com.hs3.admin.controller.activity;

import com.hs3.admin.controller.AdminController;
import com.hs3.models.activity.ActivityRechargeModel;
import com.hs3.service.activity.ActivityRechargeService;
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
@RequestMapping({"/admin/activity/recharge"})
public class ActivityRechargeController extends AdminController {
    @Autowired
    private ActivityRechargeService activityRechargeService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/activity/recharge");
        mv.addObject("m", this.activityRechargeService.findFull());
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
        this.activityRechargeService.saveOrUpdate(m);
        return redirect("index");
    }
}
