package com.hs3.admin.controller.activity;

import com.hs3.admin.controller.AdminController;
import com.hs3.models.Jsoner;
import com.hs3.models.activity.ActivitySignModel;
import com.hs3.service.activity.ActivitySignService;
import com.hs3.utils.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller
@Scope("prototype")
@RequestMapping({"/admin/activity/sign"})
public class ActivitySignController extends AdminController {
    @Autowired
    private ActivitySignService activitySignService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/activity/sign");
        ActivitySignModel activitySignModel = this.activitySignService.findFull();
        mv.addObject("m", activitySignModel);
        return mv;
    }

    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(ActivitySignModel m, MultipartFile file) {
        if (!file.isEmpty()) {
            try {
                String fileName = FileUtils.save(getSession().getServletContext().getRealPath("/"), "/res/upload/", file);
                m.setIcon(fileName);
            } catch (Exception e) {
                return Jsoner.error("文件上传错误");
            }
        }


        this.activitySignService.saveOrUpdate(m);
        return redirect("index");
    }
}
