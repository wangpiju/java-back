package com.hs3.admin.controller.contract;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.models.PageData;
import com.hs3.service.contract.ContractMessageService;

import java.util.List;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@Scope("prototype")
@RequestMapping({"/admin/contractMessage"})
public class ContractMessageController extends AdminController {
    @org.springframework.beans.factory.annotation.Autowired
    private ContractMessageService contractMessageService;

    @RequestMapping({"/index"})
    public Object index() {
        return getViewName("/contract/contractMessage");
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list() {
        Page p = getPageWithParams();
        List<?> list = this.contractMessageService.list(p);
        return new PageData(p.getRowCount(), list);
    }
}
