package com.hs3.admin.controller.sys;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.sys.LogAll;
import com.hs3.models.PageData;
import com.hs3.service.sys.LogAllService;
import com.hs3.utils.DateUtils;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@Scope("prototype")
@RequestMapping({"/admin/sys/logAll"})
public class LogAllController extends AdminController {
    @Autowired
    private LogAllService logAllService;

    @RequestMapping({"/index"})
    public Object index() {
        return getViewName("/sys/logAll");
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list() {
        Page p = getPageWithParams();
        List<?> list = this.logAllService.list(p);
        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping({"/listByCond"})
    public Object listByCond(LogAll m, String startTime, String finishTime) {
        Date st = DateUtils.toDateNull(startTime);
        Date et = DateUtils.toDateNull(finishTime);
        Page p = getPageWithParams();
        List<?> list = this.logAllService.listByCond(m, st, et, p);
        return new PageData(p.getRowCount(), list);
    }
}
