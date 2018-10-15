package com.hs3.admin.controller.lotts;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.lotts.SeasonForDate;
import com.hs3.lotts.rule.SeasonBuilderFactory;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.lotts.SeasonForDateService;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@Scope("prototype")
@RequestMapping({"/admin/seasonForDate"})
public class SeasonForDateController
        extends AdminController {
    @Autowired
    private SeasonForDateService seasonForDateService;

    @RequestMapping({"/index"})
    public Object index(String lotteryId) {
        ModelAndView mv = getView("/lotts/seasonForDate");
        SeasonForDate seasonForDate = this.seasonForDateService.getByLotteryId(lotteryId);
        mv.addObject("lotteryId", lotteryId);
        mv.addObject("seasonForDate", seasonForDate);
        mv.addObject("seasonRules", SeasonBuilderFactory.getList());
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(String lotteryId) {
        Page p = getPageWithParams();
        List<?> list = this.seasonForDateService.list(lotteryId, p);
        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(SeasonForDate group) {
        if (("".equals(group.getFirstSeason())) || (group.getAutoCreateDay() == null) || (group.getSeasonDate() == null) ||
                (group.getSeasonRule() == null))
            return Jsoner.error("请填写完整信息");
        group.setLastTime(new Date());
        this.seasonForDateService.save(group);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {
        return this.seasonForDateService.find(id);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(SeasonForDate group) {
        if (this.seasonForDateService.update(group) == 1) {
            return Jsoner.success();
        }
        return Jsoner.error();
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(Integer id) {
        int c = this.seasonForDateService.delete(id);
        if (c == 0) {
            return Jsoner.error();
        }
        return Jsoner.success();
    }
}
