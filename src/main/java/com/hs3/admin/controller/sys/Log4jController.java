package com.hs3.admin.controller.sys;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.sys.Log4j;
import com.hs3.models.PageData;
import com.hs3.service.sys.Log4jService;

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
@RequestMapping({"/admin/log4j"})
public class Log4jController
        extends AdminController {
    @Autowired
    private Log4jService log4jService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/sys/log4j");
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(String lever, String clazz, String method, String message, Date begin, Date end) {
        Page p = getPageWithParams();
        List<Log4j> list = this.log4jService.list(lever, clazz, method, message, begin, end, p);
        return new PageData(p.getRowCount(), list);
    }
}
