package com.hs3.admin.controller.contract;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.contract.ContractConfig;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.contract.ContractConfigService;
import com.hs3.service.third.DhThirdService;
import com.hs3.tasks.contract.CheckContractBonusJob;
import com.hs3.tasks.contract.GenerateBonusJob;
import com.hs3.utils.ListUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@Scope("prototype")
@RequestMapping({"/admin/contractConfig"})
public class ContractConfigController extends AdminController {
    @Autowired
    private ContractConfigService contractConfigService;
    @Autowired
    private DhThirdService dhThirdService;

    @RequestMapping({"/index"})
    public Object index() {
        return getViewName("/contract/configIndex");
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list() {
        Page p = getPageWithParams();
        List<?> list = this.contractConfigService.list(p);
        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(ContractConfig m) {
        this.contractConfigService.save(m);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {
        return this.contractConfigService.find(id);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(ContractConfig m) {
        if (m.getBonusCycle() == null) {
            return Jsoner.error("周期不能为空！");
        }
        if (m.getDayNum() == null) {
            return Jsoner.error("检查契约逾期时间不能为空！");
        }
        if (this.contractConfigService.update(m) == 1) {
            if (m.getBonusCycle() == 0) {
                int one = m.getDayNum() + 1;
                int two = m.getDayNum() + 16;
                String cron = "0 0/10 6 " + one + "," + two + " * ? *";
                dhThirdService.quartzAddJobCron("生成契约分红", "契约分红活动", "0 0/10 6 1,16 * ? *", GenerateBonusJob.class.getName());
                dhThirdService.quartzAddJobCron("检查契约分红逾期派发", "契约分红活动", cron, CheckContractBonusJob.class.getName());

            } else {
                int one = m.getDayNum() + 1;
                String cron = "0 0/10 6 " + one + " * ? *";
                dhThirdService.quartzAddJobCron("生成契约分红", "契约分红活动", "0 0/10 6 1 * ? *", GenerateBonusJob.class.getName());
                dhThirdService.quartzAddJobCron("检查契约分红逾期派发", "契约分红活动", cron, CheckContractBonusJob.class.getName());
            }

            return Jsoner.success();
        }
        return Jsoner.error();
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String id) {
        List<Integer> ids = ListUtils.toIntList(id);
        int c = this.contractConfigService.delete(ids);
        if (c == 0) {
            return Jsoner.error();
        }
        return Jsoner.success();
    }
}
