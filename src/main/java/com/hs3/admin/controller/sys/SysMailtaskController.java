package com.hs3.admin.controller.sys;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.sys.SysMailtask;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.sys.SysMailtaskService;
import com.hs3.utils.ListUtils;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping({"/admin/sys/sysMailtask"})
public class SysMailtaskController
        extends AdminController {
    @Autowired
    private SysMailtaskService sysMailtaskService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/sys/sysMailtask");

        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list() {
        Page p = getPageWithParams();
        List<SysMailtask> list = this.sysMailtaskService.list(p);

        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping({"/listWithOrder"})
    public Object listWithOrder() {
        Page p = getPageWithParams();
        List<SysMailtask> list = this.sysMailtaskService.listWithOrder(p);

        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(SysMailtask m) {
        this.sysMailtaskService.save(m);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {
        return this.sysMailtaskService.find(id);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(SysMailtask m) {
        return Jsoner.getByResult(this.sysMailtaskService.update(m) > 0);
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String id) {
        return Jsoner.getByResult(this.sysMailtaskService.delete(ListUtils.toIntList(id)) > 0);
    }
}
