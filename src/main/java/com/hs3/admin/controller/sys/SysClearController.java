package com.hs3.admin.controller.sys;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.sys.SysClear;
import com.hs3.exceptions.BaseCheckException;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.sys.SysClearService;
import com.hs3.tasks.sys.SysClearJobFactory;
import com.hs3.utils.ListUtils;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping({"/admin/sys/sysClear"})
public class SysClearController
        extends AdminController {
    @Autowired
    private SysClearService sysClearService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/sys/sysClear");

        mv.addObject("jobs", SysClearJobFactory.getJobs());

        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list() {
        Page p = getPageWithParams();
        List<SysClear> list = this.sysClearService.list(p);

        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping({"/listWithOrder"})
    public Object listWithOrder() {
        Page p = getPageWithParams();
        List<SysClear> list = this.sysClearService.listWithOrder(p);

        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(SysClear m) {
        try {
            this.sysClearService.save(m);
        } catch (BaseCheckException bce) {
            return Jsoner.error(bce.getMessage());
        } catch (Exception e) {
            return Jsoner.error();
        }
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {
        return this.sysClearService.find(id);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(SysClear m) {
        return Jsoner.getByResult(this.sysClearService.update(m) > 0);
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String id) {
        return Jsoner.getByResult(this.sysClearService.delete(ListUtils.toIntList(id)) > 0);
    }
}
