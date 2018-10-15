package com.hs3.admin.controller.users;

import com.hs3.admin.controller.AdminController;
import com.hs3.entity.users.PrivateRatioRuleDetails;
import com.hs3.models.Jsoner;
import com.hs3.service.user.PrivateRatioRuleDetailsService;
import com.hs3.utils.ListUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@Scope("prototype")
@RequestMapping({"/admin/privateRatioRuleDetails"})
public class PrivateRatioRuleDetailsController
        extends AdminController {
    @Autowired
    private PrivateRatioRuleDetailsService privateRatioRuleDetailsService;

    @RequestMapping({"/index"})
    public Object index(Integer id) {
        ModelAndView mv = getView("/user/privateRatioRuleDetails");
        mv.addObject("id", id);
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(Integer id) {
        return this.privateRatioRuleDetailsService.listByPid(id);
    }


    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(PrivateRatioRuleDetails m) {
        return Jsoner.getByResult(this.privateRatioRuleDetailsService.save(m) > 0);
    }


    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {
        return this.privateRatioRuleDetailsService.find(id);
    }


    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(PrivateRatioRuleDetails m) {
        return Jsoner.getByResult(this.privateRatioRuleDetailsService.update(m) > 0);
    }


    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String id) {
        return Jsoner.getByResult(this.privateRatioRuleDetailsService.delete(ListUtils.toIntList(id)) > 0);
    }
}
