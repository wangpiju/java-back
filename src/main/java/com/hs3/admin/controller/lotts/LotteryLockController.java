package com.hs3.admin.controller.lotts;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.lotts.LotteryLock;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.lotts.LotteryLockService;
import com.hs3.utils.DateUtils;
import com.hs3.utils.ListUtils;

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
@RequestMapping({"/admin/lotts/lock"})
public class LotteryLockController
        extends AdminController {
    @Autowired
    private LotteryLockService lotteryLockService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/lotts/lock");
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list() {
        Page p = getPageWithParams();
        List<?> list = this.lotteryLockService.list(p);
        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {
        return this.lotteryLockService.find(id);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(LotteryLock m, Integer close) {
        if (close == null) {
            m.setCloseTime(null);
        } else {
            m.setCloseTime(DateUtils.addMinute(new Date(), close.intValue()));
        }
        return Jsoner.getByResult(this.lotteryLockService.update(m) == 1);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(LotteryLock m, Integer close) {
        if (close == null) {
            m.setCloseTime(null);
        } else {
            m.setCloseTime(DateUtils.addMinute(new Date(), close.intValue()));
        }
        this.lotteryLockService.save(m);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String id) {
        List<Integer> ids = ListUtils.toIntList(id);
        return Jsoner.getByResult(this.lotteryLockService.delete(ids) > 0);
    }
}
