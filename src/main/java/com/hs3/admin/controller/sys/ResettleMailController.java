package com.hs3.admin.controller.sys;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.lotts.Lottery;
import com.hs3.entity.sys.ResettleMail;
import com.hs3.exceptions.BaseCheckException;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.lotts.LotteryService;
import com.hs3.service.sys.ResettleMailService;
import com.hs3.utils.ListUtils;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping({"/admin/sys/resettleMail"})
public class ResettleMailController
        extends AdminController {
    @Autowired
    private ResettleMailService resettleMailService;
    @Autowired
    private LotteryService lotteryService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/sys/resettleMail");
        List<Lottery> lotterys = this.lotteryService.listByStatus(0);
        mv.addObject("lottery", lotterys);
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list() {
        Page p = getPageWithParams();
        List<ResettleMail> list = this.resettleMailService.list(p);
        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping({"/listWithOrder"})
    public Object listWithOrder() {
        Page p = getPageWithParams();
        List<ResettleMail> list = this.resettleMailService.listWithOrder(p);
        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(ResettleMail m) {
        try {
            this.resettleMailService.save(m);
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
        return this.resettleMailService.find(id);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(ResettleMail m) {
        return Jsoner.getByResult(this.resettleMailService.update(m) > 0);
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String id) {
        return Jsoner.getByResult(this.resettleMailService.delete(ListUtils.toIntList(id)) > 0);
    }
}
