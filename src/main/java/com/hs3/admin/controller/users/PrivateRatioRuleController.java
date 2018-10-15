package com.hs3.admin.controller.users;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.users.PrivateRatioRule;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.user.PrivateRatioRuleService;
import com.hs3.utils.ListUtils;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@Scope("prototype")
@RequestMapping({"/admin/privateRatioRule"})
public class PrivateRatioRuleController
        extends AdminController {
    @Autowired
    private PrivateRatioRuleService privateRatioRuleService;

    @RequestMapping({"/index"})
    public Object index(Integer id) {
        ModelAndView mv = getView("/user/privateRatioRule");
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list() {
        Page p = getPageWithParams();
        List<?> list = this.privateRatioRuleService.list(p);
        return new PageData(p.getRowCount(), list);
    }


    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(PrivateRatioRule m) {
        return Jsoner.getByResult(this.privateRatioRuleService.save(m) > 0);
    }


    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {
        return this.privateRatioRuleService.find(id);
    }


    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(PrivateRatioRule m) {
        return Jsoner.getByResult(this.privateRatioRuleService.update(m) > 0);
    }


    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String id) {
        return Jsoner.getByResult(this.privateRatioRuleService.delete(ListUtils.toIntList(id)) > 0);
    }
}
