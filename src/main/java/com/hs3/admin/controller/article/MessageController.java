package com.hs3.admin.controller.article;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.article.Message;
import com.hs3.entity.users.Manager;
import com.hs3.exceptions.BaseCheckException;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.article.MessageService;
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
@RequestMapping({"/admin/article/message"})
public class MessageController
        extends AdminController {
    @Autowired
    private MessageService messageService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/article/message");

        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(Message message) {
        Page p = getPageWithParams();

        Message m = new Message();
        m.setTitle(message.getTitle());
        m.setSender(message.getSender());
        m.setRever(message.getRever());
        List<Message> list = this.messageService.listByCond(m, p);

        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(Message m, Integer type) {
        Message message = new Message();

        message.setTitle(m.getTitle());
        message.setSendContent(m.getSendContent());
        message.setRever(m.getRever().trim());
        message.setRevStatus(Integer.valueOf(0));


        message.setSender(((Manager) getLogin()).getAccount());
        message.setSendType(Integer.valueOf(0));
        message.setSendStatus(Integer.valueOf(0));
        message.setSendTime(new Date());
        try {
            if (type == null) {
                throw new BaseCheckException("请选择发送方式");
            }
            if (type.intValue() == 0) {
                this.messageService.saveSingle(message);
            } else if (type.intValue() == 1) {
                this.messageService.saveList(message);
            } else if (type.intValue() == 2) {
                this.messageService.saveGroup(message);
            } else {
                throw new BaseCheckException("发送方式不支持");
            }
        } catch (BaseCheckException e) {
            return Jsoner.error(e.getMessage());
        }
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {
        return this.messageService.find(id);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(Message m) {
        return Jsoner.getByResult(this.messageService.update(m) > 0);
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String id) {
        return Jsoner.getByResult(this.messageService.delete(ListUtils.toIntList(id)) > 0);
    }

    @ResponseBody
    @RequestMapping(value = {"/cancel"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object cancel(String id) {
        return Jsoner.getByResult(this.messageService.updateCancel(Integer.valueOf(Integer.parseInt(id))) > 0);
    }
}
