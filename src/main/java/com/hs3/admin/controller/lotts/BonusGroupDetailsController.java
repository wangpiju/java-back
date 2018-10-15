package com.hs3.admin.controller.lotts;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.lotts.Lottery;
import com.hs3.lotts.LotteryFactory;
import com.hs3.models.BonusGroupDetailsModel;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.lotts.BonusGroupDetailsService;
import com.hs3.service.lotts.BonusGroupService;
import com.hs3.service.lotts.LotteryService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@Scope("prototype")
@RequestMapping({"/admin/bonusGroupDetails"})
public class BonusGroupDetailsController
        extends AdminController {
    @Autowired
    private LotteryService lotteryService;
    @Autowired
    private BonusGroupService bonusGroupService;
    @Autowired
    private BonusGroupDetailsService bonusGroupDetailsService;

    @RequestMapping({"/index"})
    public Object index(String lotteryId) {
        ModelAndView mv = getView("/lotts/bonusGroupDetails");
        Lottery lo = this.lotteryService.find(lotteryId);
        mv.addObject("lott", lo);
        mv.addObject("bonusGroups", this.bonusGroupService.list(null));
        mv.addObject("tree", LotteryFactory.getInstance(lo.getGroupName()));
        List<?> sss = this.bonusGroupDetailsService.listByLotteryId(lotteryId);
        mv.addObject("detail", sss);
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list() {
        Page p = getPageWithParams();
        List<?> list = this.bonusGroupService.list(p);
        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(BonusGroupDetailsModel model) {
        this.bonusGroupDetailsService.updateAll(model);
        return Jsoner.success();
    }
}
