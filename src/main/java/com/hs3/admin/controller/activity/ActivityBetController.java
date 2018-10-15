package com.hs3.admin.controller.activity;

import com.hs3.admin.controller.AdminController;
import com.hs3.models.activity.ActivityBetModel;
import com.hs3.service.activity.ActivityBetService;
import com.hs3.service.third.DhThirdService;
import com.hs3.tasks.activity.ActivityBetJob;
import com.hs3.utils.DateUtils;
import com.hs3.utils.sys.WebDateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.util.Date;

@Controller
@Scope("prototype")
@RequestMapping({"/admin/activity/bet"})
public class ActivityBetController extends AdminController {
    @Autowired
    private ActivityBetService activityBetService;
    @Autowired
    private DhThirdService dhThirdService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/activity/bet");
        ActivityBetModel activityLossModel = this.activityBetService.findFullForBet();
        mv.addObject("m", activityLossModel);
        return mv;
    }

    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(ActivityBetModel m, MultipartFile file) {
        if (!file.isEmpty()) {
            try {
                String fileName = com.hs3.utils.FileUtils.save(getSession().getServletContext().getRealPath("/"), "/res/upload/", file);
                m.setIcon(fileName);
            } catch (Exception e) {
                return com.hs3.models.Jsoner.error("文件上传错误");
            }
        }


        this.activityBetService.saveOrUpdateForBet(m);
        Date begin = WebDateUtils.getActivityTaskStartTime(m.getBeginTime());
        Date end = WebDateUtils.getActivityTaskEndTime(m.getEndTime());

        dhThirdService.quartzAddJobWithStartEnd("投注佣金活动", "活动派发", null, DateUtils.format(begin,"yyyy-MM-dd HH:mm:ss"), DateUtils.format(end,"yyyy-MM-dd HH:mm:ss"), 86400, ActivityBetJob.class.getName());

        return redirect("index");
    }
}
