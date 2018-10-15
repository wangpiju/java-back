package com.hs3.admin.controller.lotts;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.lotts.LotteryGroup;
import com.hs3.models.Jsoner;
import com.hs3.service.lotts.LotteryGroupService;
import com.hs3.utils.ListUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@Scope("prototype")
@RequestMapping({"/admin/lotteryGroup"})
public class LotteryGroupController extends AdminController {
    @Autowired
    private LotteryGroupService lotteryGroupService;

    @RequestMapping({"/index"})
    public Object index() {
        return getViewName("/lotts/lotteryGroup");
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list() {
        Page p = getPageWithParams();
        return this.lotteryGroupService.list(p, null);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {
        return this.lotteryGroupService.find(id);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(LotteryGroup m) {
        return Jsoner.getByResult(this.lotteryGroupService.update(m) > 0);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(LotteryGroup m) {
        if (m.getStatus() == null) {
            m.setStatus(Integer.valueOf(0));
        }
        if (m.getOrderId() == null) {
            m.setOrderId(Integer.valueOf(0));
        }
        return Jsoner.getByResult(this.lotteryGroupService.save(m) > 0);
    }

    @ResponseBody
    @RequestMapping({"/delete"})
    public Object add(String id) {
        return Jsoner.getByResult(this.lotteryGroupService.delete(ListUtils.toIntList(id)) > 0);
    }
}
