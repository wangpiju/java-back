package com.hs3.admin.controller.numberSource;

import com.alibaba.fastjson.JSON;
import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.numberSource.Triggers;
import com.hs3.lotts.LotteryFactory;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.numberSource.TaskDetailsService;
import com.hs3.service.third.DhThirdService;
import com.hs3.utils.ip.IPUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@Scope("prototype")
@RequestMapping({"/admin/taskDetails"})
public class TaskDetailsController
        extends AdminController {
    @Autowired
    private TaskDetailsService taskDetailsService;
    @Autowired
    private DhThirdService dhThirdService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/numberSource/taskDetails");
        mv.addObject("groups", LotteryFactory.getGroups());
        return mv;
    }


    @ResponseBody
    @RequestMapping(value = {"/start"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object start(String jobgroup, String jobname, String triggergroup, String triggername) {
        try {
            String temptriggergroup = URLDecoder.decode(triggergroup, "UTF-8");
            String temptriggername = URLDecoder.decode(triggername, "UTF-8");
            dhThirdService.managerResumeTrigger(temptriggergroup,
                    temptriggername);

        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(String job_GROUP, String job_NAME, String trigger_GROUP, String trigger_NAME, String cron_EXPRESSION, String job_CLASS_NAME) {
        try {
            String tempjobgroup = URLDecoder.decode(job_GROUP, "UTF-8");
            String tempjobname = URLDecoder.decode(job_NAME, "UTF-8");
            String temptriggergroup = URLDecoder.decode(job_GROUP, "UTF-8");
            String temptriggername = URLDecoder.decode(job_NAME, "UTF-8");
            String tempclassname = URLDecoder.decode(job_CLASS_NAME, "UTF-8");
            String tempcorn = URLDecoder.decode(cron_EXPRESSION, "UTF-8");


            Map<String, Object> map = new HashMap<>();
            map.put("lotteryId", "cqssc");
            dhThirdService.managerAddJobTriggerEx(tempjobgroup, tempjobname,
                    temptriggergroup, temptriggername,
                    tempclassname, tempcorn, JSON.toJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Jsoner.success();
    }


    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(String job_GROUP, String job_NAME, String trigger_GROUP, String trigger_NAME, String cron_EXPRESSION, String job_CLASS_NAME) {
        try {
            String temptriggergroup = URLDecoder.decode(job_GROUP, "UTF-8");
            String temptriggername = URLDecoder.decode(job_NAME, "UTF-8");

            String tempcorn = URLDecoder.decode(cron_EXPRESSION, "UTF-8");
            dhThirdService.managerModifyJobTime(temptriggergroup,
                    temptriggername, tempcorn);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return Jsoner.success();
    }


    @ResponseBody
    @RequestMapping(value = {"/stop"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object stop(String jobgroup, String jobname, String triggergroup, String triggername) {
        try {
            String temptriggergroup = URLDecoder.decode(jobgroup, "UTF-8");
            String temptriggername = URLDecoder.decode(jobname, "UTF-8");
            dhThirdService.managerPauseTrigger(temptriggergroup,
                    temptriggername);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String jobgroup, String jobname, String triggergroup, String triggername) {
        try {
            String tempjobgroup = URLDecoder.decode(jobgroup, "UTF-8");
            String tempjobname = URLDecoder.decode(jobname, "UTF-8");
            String temptriggergroup = URLDecoder.decode(triggergroup, "UTF-8");
            String temptriggername = URLDecoder.decode(triggername, "UTF-8");
            dhThirdService.managerRemoveJobWithTrigger(tempjobgroup, tempjobname,
                    temptriggergroup, temptriggername);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(String group, String groupName) {
        Page p = getPageWithParams();
        if (group == null)
            group = "";
        if (groupName == null)
            groupName = "";
        List<Triggers> list = this.taskDetailsService.list(p, group, groupName);
        return new PageData(p.getRowCount(), list);
    }


    @ResponseBody
    @RequestMapping({"/stopAll"})
    public Object stopAll() {
        return Jsoner.getByResult(dhThirdService.quartzShutdownJobs() == 1);
    }


    @ResponseBody
    @RequestMapping({"/startAll"})
    public Object startAll() {
        return Jsoner.getByResult(dhThirdService.quartzStartJobs() == 1);
    }


    @ResponseBody
    @RequestMapping({"/getInfo"})
    public Object getInfo() {
        String info = "IP:" + IPUtils.getServerIP() + "<br/>";
        info = info + "正在执行任务:" + dhThirdService.quartzGetCurrentlyExecutingNums() + "<br/>";
        info = info + "调度是否开启:" + dhThirdService.quartzIsStarting() + "<br/>";
        return Jsoner.success(info);
    }
}
