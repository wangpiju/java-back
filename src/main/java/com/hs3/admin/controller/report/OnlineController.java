package com.hs3.admin.controller.report;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.models.PageData;
import com.hs3.service.report.OnlineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@Scope("prototype")
@RequestMapping({"admin/report/onlineReport"})
public class OnlineController extends AdminController {
    @Autowired
    private OnlineService onlineService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/report/online");
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(String account, Integer userType, String ip, String info) {
        Page p = getPageWithParams();
        java.util.List<?> lst = this.onlineService.list(p, account, userType, ip, info);
        return new PageData(p.getRowCount(), lst);
    }
}
