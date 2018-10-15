package com.hs3.admin.controller.lotts;

import com.hs3.admin.controller.AdminController;
import com.hs3.service.lotts.LotteryService;
import com.hs3.service.lotts.SettlementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Scope("prototype")
@RequestMapping({"/admin/settlement"})
public class SettlementController
        extends AdminController {
    @Autowired
    private SettlementService settlementService;
    @Autowired
    private LotteryService lotteryService;
}
