package com.hs3.admin.controller.activity;

import com.hs3.admin.controller.AdminController;
import com.hs3.models.Jsoner;
import com.hs3.models.activity.AcivityBetconsumerModel;
import com.hs3.service.activity.ActivityBetconsumerService;
import com.hs3.service.activity.ActivityLossService;
import com.hs3.service.activity.ActivityService;
import com.hs3.utils.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller
@Scope("prototype")
@RequestMapping({"/admin/activity/betconsumer"})
public class ActivitybetConsumerController extends AdminController {
    @Autowired
    private ActivityBetconsumerService activityBetconsumerService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/activity/betconsumer");
        AcivityBetconsumerModel m = this.activityBetconsumerService.findFull();
        mv.addObject("m", m);
        return mv;
    }

    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(AcivityBetconsumerModel m, MultipartFile file) {
        if (!file.isEmpty()) {
            try {
                String fileName = FileUtils.save(getSession().getServletContext().getRealPath("/"), "/res/upload/", file);
                m.setIcon(fileName);
            } catch (Exception e) {
                return Jsoner.error("文件上传错误");
            }
        }


        this.activityBetconsumerService.saveOrUpdate(m);
        return redirect("index");
    }
}
