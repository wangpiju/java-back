package com.hs3.admin.controller.lotts;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.lotts.LotterySaleTime;
import com.hs3.models.PageData;
import com.hs3.models.lotts.LotterySaleTimeEx;
import com.hs3.service.lotts.LotterySaleTimeService;
import com.hs3.utils.DateUtils;

import java.util.ArrayList;
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
@RequestMapping({"/admin/lotterySaleTime"})
public class LotterySaleTimeController
        extends AdminController {
    @Autowired
    private LotterySaleTimeService lotterySaleTimeService;

    @RequestMapping({"/index"})
    public Object index(String lotteryId) {
        ModelAndView mv = getView("/lotts/saleTime");
        mv.addObject("lotteryId", lotteryId);

        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(String lotteryId, Date begin, Date end) {
        Page p = getPageWithParams();
        List<LotterySaleTime> list = this.lotterySaleTimeService.list(lotteryId, begin, end, p);
        List<LotterySaleTimeEx> lste = new ArrayList();
        String serviceTime = DateUtils.format(new Date());
        for (int i = 0; i < list.size(); i++) {
            LotterySaleTimeEx ex = new LotterySaleTimeEx();
            LotterySaleTime lotterySaleTime = (LotterySaleTime) list.get(i);
            ex.setSeasonId(lotterySaleTime.getSeasonId());
            ex.setBeginTime(lotterySaleTime.getBeginTime());
            ex.setCurDate(lotterySaleTime.getCurDate());
            ex.setEndTime(lotterySaleTime.getEndTime());
            ex.setOpenAfterTime(lotterySaleTime.getOpenAfterTime());
            ex.setOpenStatus(lotterySaleTime.getOpenStatus());
            ex.setOpenTime(lotterySaleTime.getOpenTime());
            ex.setPlanStatus(lotterySaleTime.getPlanStatus());
            ex.setLotteryId(lotterySaleTime.getLotteryId());
            ex.setSettleStatus(lotterySaleTime.getSettleStatus());
            ex.setServiceTime(serviceTime);
            lste.add(ex);
        }
        return new PageData(p.getRowCount(), lste);
    }
}
