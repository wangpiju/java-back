package com.hs3.admin.controller.activity;

import com.hs3.admin.controller.AdminController;
import com.hs3.commons.ActivityType;
import com.hs3.entity.activity.Activity;
import com.hs3.models.Jsoner;
import com.hs3.models.activity.ActivityRechargeModel;
import com.hs3.service.activity.ActivityService;
import com.hs3.utils.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.math.BigDecimal;
import java.util.Date;

/**
 * program: java-back
 * des: 自定义活动类
 * author: Terra
 * create: 2018-06-06 11:47
 **/
@Controller
@Scope("prototype")
@RequestMapping({"/admin/activity/custom"})
public class ActivityCustomController extends AdminController {

    @Autowired
    private ActivityService activityService;


    @RequestMapping({"/index"})
    public Object index(@RequestParam(value = "id", required = false) Integer id) {
        ModelAndView mv = getView("/activity/custom");
        Activity activity = this.activityService.find(id);
        mv.addObject("m", activity);
        return mv;
    }
    @ResponseBody
    @RequestMapping({"/del"})
    public Object del(@RequestParam(value = "id", required = false) Integer id) {
        int result = activityService.del(id);
        if (result > 0) {
            return Jsoner.success();
        }
        return Jsoner.success("删除失败");
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {RequestMethod.GET})
    public Object edit(Integer id) {
        return activityService.find(id);
    }

    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(Activity m, MultipartFile file) {
        if (!file.isEmpty()) {
            try {
                String fileName = FileUtils.save(getSession().getServletContext().getRealPath("/"), "/res/upload/", file);
                m.setIcon(fileName);
            } catch (Exception e) {
                return com.hs3.models.Jsoner.error("文件上传错误");
            }
        }
        m.setActivityType(ActivityType.custom.getAlias());
        m.setAmountType(0);
        m.setMaxAmount(new BigDecimal(0));
        m.setNeedAttend(0);
        m.setNeedPrize(0);
        m.setBeginRegTime(new Date());
        m.setEndRegTime(new Date());
        this.activityService.saveOrUpdate(m);
        return redirect("index?id="+m.getId());
    }
}
