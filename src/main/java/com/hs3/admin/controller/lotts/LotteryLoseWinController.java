package com.hs3.admin.controller.lotts;

import com.hs3.admin.controller.AdminController;
import com.hs3.service.lotts.LotteryLoseWinService;
import com.hs3.service.lotts.LotteryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Scope("prototype")
@RequestMapping({"/admin/lotts/loseWin"})
public class LotteryLoseWinController
        extends AdminController {
    @Autowired
    private LotteryService lotteryService;
    @Autowired
    private LotteryLoseWinService lotteryLoseWinService;
}
