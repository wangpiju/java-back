package com.hs3.admin.controller.lotts;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.lotts.BetInTotal;
import com.hs3.entity.lotts.Lottery;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.lotts.BetInTotalService;
import com.hs3.service.lotts.LotteryService;
import com.hs3.utils.ListUtils;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping({"/admin/lotts/betInTotal"})
public class BetInTotalController
        extends AdminController {
    @Autowired
    private BetInTotalService betInTotalService;
    @Autowired
    private LotteryService lotteryService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/lotts/betInTotal");
        List<Lottery> lotteryList = this.lotteryService.listAndOrder(null);
        mv.addObject("lotteryList", lotteryList);

        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(BetInTotal m, Date beginTime, Date endTime, Integer isIncludeChildFlag) {
        Page p = getPageWithParams();


        boolean isIncludeChild = (isIncludeChildFlag != null) && (isIncludeChildFlag.intValue() != 0);

        List<BetInTotal> list = this.betInTotalService.findByCond(true, m, beginTime, endTime, isIncludeChild, p);
        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping({"/listWithOrder"})
    public Object listWithOrder() {
        Page p = getPageWithParams();
        List<BetInTotal> list = this.betInTotalService.listWithOrder(p);

        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(BetInTotal m) {
        this.betInTotalService.save(m);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {
        return this.betInTotalService.find(id);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(BetInTotal m) {
        return Jsoner.getByResult(this.betInTotalService.update(m) > 0);
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String id) {
        return Jsoner.getByResult(this.betInTotalService.delete(ListUtils.toIntList(id)) > 0);
    }
}
