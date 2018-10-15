package com.hs3.admin.controller.lotts;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.lotts.BetChange;
import com.hs3.exceptions.BaseCheckException;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.lotts.BetChangeService;
import com.hs3.service.lotts.SettlementService;
import com.hs3.service.user.UserService;
import com.hs3.utils.ListUtils;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping({"/admin/lotts/betChange"})
public class BetChangeController
        extends AdminController {
    @Autowired
    private BetChangeService betChangeService;
    @Autowired
    private UserService userService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/lotts/betChange");

        mv.addObject("betChangeLottery", SettlementService.BET_CHANGE_LOTTERY);

        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list() {
        Page p = getPageWithParams();
        List<BetChange> list = this.betChangeService.list(p);

        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping({"/listWithOrder"})
    public Object listWithOrder() {
        Page p = getPageWithParams();
        List<BetChange> list = this.betChangeService.listWithOrder(p);

        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(BetChange m) {
        try {
            check(m);
        } catch (BaseCheckException e) {
            return Jsoner.error(e.getMessage());
        }
        m.setPlayerId("ssc_star3_last_single");
        this.betChangeService.save(m);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {
        return this.betChangeService.find(id);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(BetChange m) {
        try {
            check(m);
        } catch (BaseCheckException e) {
            return Jsoner.error(e.getMessage());
        }
        return Jsoner.getByResult(this.betChangeService.update(m) > 0);
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String id) {
        return Jsoner.getByResult(this.betChangeService.delete(ListUtils.toIntList(id)) > 0);
    }

    private void check(BetChange m) {
        if (m == null) {
            throw new BaseCheckException("请填写信息！");
        }
        if (this.userService.findByAccount(m.getAccount()) == null) {
            throw new BaseCheckException(m.getAccount() + "不存在！");
        }
        if (m.getLotteryId() == null) {
            throw new BaseCheckException("请选择彩种！");
        }
        if (m.getStatus() == null) {
            throw new BaseCheckException("请选择状态！");
        }
    }
}
