package com.hs3.admin.controller.lotts;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.lotts.Lottery;
import com.hs3.entity.lotts.LotteryCrawlerConfig;
import com.hs3.lotts.config.CrawlerUrlBuilderFactory;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.lotts.LotteryCrawlerConfigService;
import com.hs3.service.lotts.LotteryService;
import com.hs3.utils.ListUtils;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@Scope("prototype")
@RequestMapping({"/admin/crawler"})
public class CrawlerConfigController
        extends AdminController {
    @Autowired
    private LotteryCrawlerConfigService lotteryCrawlerConfigService;
    @Autowired
    private LotteryService lotteryService;

    @RequestMapping({"/index"})
    public Object index(String lotteryId) {
        ModelAndView mv = getView("/lotts/crawler");
        Lottery lott = this.lotteryService.find(lotteryId);
        mv.addObject("lott", lott);
        mv.addObject("urlBuilders", CrawlerUrlBuilderFactory.getList());
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(String lotteryId) {
        Page p = getPageWithParams();
        List<?> list = this.lotteryCrawlerConfigService.listByLotteryId(lotteryId, p);
        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(LotteryCrawlerConfig group) {
        this.lotteryCrawlerConfigService.save(group);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {
        return this.lotteryCrawlerConfigService.find(id);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(LotteryCrawlerConfig group) {
        if (this.lotteryCrawlerConfigService.update(group) == 1) {
            return Jsoner.success();
        }
        return Jsoner.error();
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String id) {
        List<Integer> ids = ListUtils.toIntList(id);
        int c = this.lotteryCrawlerConfigService.delete(ids);
        if (c == 0) {
            return Jsoner.error();
        }
        return Jsoner.success();
    }
}
