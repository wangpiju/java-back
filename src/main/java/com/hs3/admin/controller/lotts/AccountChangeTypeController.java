package com.hs3.admin.controller.lotts;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.lotts.AccountChangeType;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.lotts.AccountChangeTypeService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@Scope("prototype")
@RequestMapping({"/admin/accountChangeType"})
public class AccountChangeTypeController extends AdminController {
    @Autowired
    private AccountChangeTypeService accountChangeTypeService;

    @RequestMapping({"/index"})
    public Object index(String account) {
        ModelAndView mv = getView("/lotts/accountChangeType");
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list() {
        Page p = getPageWithParams();
        List<AccountChangeType> list = this.accountChangeTypeService.list(p);
        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(AccountChangeType m) {
        AccountChangeType o = (AccountChangeType) this.accountChangeTypeService.find(Integer.valueOf(m.getId()));
        if (o != null) {
            return Jsoner.error();
        }
        this.accountChangeTypeService.save(m);
        return Jsoner.success();
    }


    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {
        return this.accountChangeTypeService.find(id);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(AccountChangeType m) {
        if (this.accountChangeTypeService.update(m) == 1) {
            return Jsoner.success();
        }
        return Jsoner.error();
    }
}
