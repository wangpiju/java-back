package com.hs3.admin.controller.users;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.service.user.PrivateRatioService;

import java.math.BigDecimal;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@Scope("prototype")
@RequestMapping({"/admin/privateRatio"})
public class PrivateRatioController
        extends AdminController {
    @Autowired
    private PrivateRatioService privateRatioService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/user/privateRatio");
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(String account, BigDecimal ratio, Date begin, Date end) {
        Page p = getPageWithParams();
        return this.privateRatioService.list(account, ratio, begin, end, p);
    }
}
