package com.hs3.admin.controller.article;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.article.Notice;
import com.hs3.entity.users.Manager;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.article.NoticeService;
import com.hs3.utils.ListUtils;

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
@RequestMapping({"/admin/article/notice"})
public class NoticeController
        extends AdminController {
    @Autowired
    private NoticeService noticeService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/article/notice");
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(Notice notice) {
        Page p = getPageWithParams();

        Notice m = new Notice();
        m.setTitle(notice.getTitle());
        List<Notice> list = this.noticeService.listByCond(m, p);

        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(Notice m) {
        m.setCreateTime(new Date());
        m.setAuthor(((Manager) getLogin()).getAccount());
        if (m.getOrderId() == null) {
            m.setOrderId(Integer.valueOf(0));
        }
        this.noticeService.save(m);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {
        return this.noticeService.find(id);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(Notice m) {
        m.setCreateTime(new Date());
        m.setAuthor(((Manager) getLogin()).getAccount());
        return Jsoner.getByResult(this.noticeService.update(m) > 0);
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String id) {
        return Jsoner.getByResult(this.noticeService.delete(ListUtils.toIntList(id)) > 0);
    }

    @ResponseBody
    @RequestMapping(value = {"/ajaxGetSwitch"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object ajaxGetSwitch(Integer switching) {
        return Jsoner.getByResult(this.noticeService.getOpenNum(switching) < 1);
    }

    @ResponseBody
    @RequestMapping(value = {"/updateOpenOrClose"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object updateOpenOrClose(String id, Integer switching) {
        int num = this.noticeService.updateOpenOrClose(id, switching);
        return Jsoner.getByResult(num > 0);
    }
}
