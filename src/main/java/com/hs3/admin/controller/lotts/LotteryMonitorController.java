package com.hs3.admin.controller.lotts;

import com.hs3.admin.controller.AdminController;
import com.hs3.entity.lotts.Lottery;
import com.hs3.entity.lotts.LotterySaleTime;
import com.hs3.service.lotts.BetService;
import com.hs3.service.lotts.CreateSeasonService;
import com.hs3.service.lotts.LotteryGroupService;
import com.hs3.service.lotts.LotterySaleRuleService;
import com.hs3.service.lotts.LotterySaleTimeService;
import com.hs3.service.lotts.LotterySeasonService;
import com.hs3.service.lotts.LotteryService;
import com.hs3.service.lotts.PlayerService;
import com.hs3.service.lotts.SettlementService;
import com.hs3.utils.ListUtils;
import com.hs3.utils.StrUtils;

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
@RequestMapping({"/admin/lottsMonitor"})
public class LotteryMonitorController
        extends AdminController {
    @Autowired
    private LotteryService lotteryService;
    @Autowired
    private LotteryGroupService lotteryGroupService;
    @Autowired
    private PlayerService playerService;
    @Autowired
    private LotterySaleTimeService lotterySaleTimeService;
    @Autowired
    private LotterySeasonService lotterySeasonService;
    @Autowired
    private BetService betService;
    @Autowired
    private CreateSeasonService createSeasonService;
    @Autowired
    private SettlementService settlementService;
    @Autowired
    private LotterySaleRuleService lotterySaleRuleService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/lotts/monitor");
        List<Lottery> list = this.lotteryService.listAndOrderField("id,title");
        mv.addObject("lotterys", list);
        mv.addObject("json", StrUtils.toJson(list));
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(Date begin, String ignore) {
        List<LotterySaleTime> ids = this.lotterySaleTimeService.listException(begin);
        if (!StrUtils.hasEmpty(new Object[]{ignore})) {
            List<String> ignores = ListUtils.toList(ignore);
            for (int i = ids.size() - 1; i >= 0; i--) {
                String id = ((LotterySaleTime) ids.get(i)).getLotteryId();
                if (ignores.contains(id)) {
                    ids.remove(i);
                }
            }
        }
        return ids;
    }
}
