package com.hs3.admin.controller.lotts;

import com.hs3.admin.controller.AdminController;
import com.hs3.entity.lotts.Lottery;
import com.hs3.lotts.LotteryFactory;
import com.hs3.models.lotts.PlayerModel;
import com.hs3.service.lotts.LotteryService;
import com.hs3.service.lotts.PlayerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
@Scope("prototype")
@RequestMapping({"/admin/player"})
public class PlayerController
        extends AdminController {
    @Autowired
    private LotteryService lotteryService;
    @Autowired
    private PlayerService playerService;

    @RequestMapping({"/index"})
    public Object index(String lotteryId) {
        ModelAndView mv = getView("/lotts/player");
        Lottery lo = this.lotteryService.find(lotteryId);
        if (lo != null) {
            mv.addObject("lott", lo);
            mv.addObject("players", this.playerService.listByLotteryId(lotteryId));
            mv.addObject("tree", LotteryFactory.getInstance(lo.getGroupName()));
        }
        return mv;
    }

    @RequestMapping({"/edit"})
    public Object edit(PlayerModel p, String lotteryId) {
        this.playerService.updateAll(p, lotteryId);
        return redirect("index?lotteryId=" + lotteryId);
    }
}
