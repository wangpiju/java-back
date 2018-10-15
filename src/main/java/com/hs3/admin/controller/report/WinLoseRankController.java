package com.hs3.admin.controller.report;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.models.PageData;
import com.hs3.service.report.WinLoseRankService;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@Scope("prototype")
@RequestMapping({"admin/winLoseRankReport"})
public class WinLoseRankController extends AdminController {
    @Autowired
    private WinLoseRankService winLoseRankService;

    @RequestMapping({"/index"})
    public Object index() {
        org.springframework.web.servlet.ModelAndView mv = getView("/report/winLoseRank");
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object index(String historyAndNow, String account, BigDecimal count, Integer order, Date startTime, Date endTime, Integer test) {
        Page p = getPageWithParams();
        if (historyAndNow == null)
            return null;
        if ("0".equals(historyAndNow)) {
            List<?> lst = this.winLoseRankService.list(p, historyAndNow, account, count, order, test);
            return new PageData(p.getRowCount(), lst);
        }

        List<?> lst = this.winLoseRankService.historyList(p, historyAndNow, account, count, order, startTime, endTime, test);
        return new PageData(p.getRowCount(), lst);
    }
}
