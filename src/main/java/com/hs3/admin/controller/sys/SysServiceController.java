package com.hs3.admin.controller.sys;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.sys.SysService;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.sys.SysServiceService;
import com.hs3.utils.ListUtils;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping({"/admin/sys/sysService"})
public class SysServiceController
        extends AdminController {
    @Autowired
    private SysServiceService sysServiceService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/sys/sysService");

        mv.addObject("sysServiceList", this.sysServiceService.list(null));

        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list() {
        Page p = getPageWithParams();
        List<SysService> list = this.sysServiceService.list(p);

        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping({"/listWithOrder"})
    public Object listWithOrder() {
        Page p = getPageWithParams();
        List<SysService> list = this.sysServiceService.listWithOrder(p);

        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(SysService m) {
        this.sysServiceService.save(m);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping({"/editAll"})
    public Object editAll(Integer[] ids, Integer[] statuss, Integer[] userMarks) {
        if (ids != null) {
            for (int i = 0; i < ids.length; i++) {
                SysService m = this.sysServiceService.find(ids[i]);
                m.setStatus(statuss[i]);
                m.setUserMark(userMarks[i]);
                this.sysServiceService.update(m);
            }
        }
        return Jsoner.getByResult(true);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {
        return this.sysServiceService.find(id);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(SysService m) {
        return Jsoner.getByResult(this.sysServiceService.update(m) > 0);
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String id) {
        return Jsoner.getByResult(this.sysServiceService.delete(ListUtils.toIntList(id)) > 0);
    }
}
