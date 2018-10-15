package com.hs3.admin.controller.contract;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.contract.ContractBadrecord;
import com.hs3.models.PageData;
import com.hs3.service.contract.ContractBadrecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@Scope("prototype")
@RequestMapping({"/admin/contractBadrecord"})
public class ContractBadrecordController extends AdminController {
    @Autowired
    private ContractBadrecordService contractBadrecordService;

    @RequestMapping({"/index"})
    public Object index() {
        return getViewName("/contract/contractBadrecord");
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(ContractBadrecord m) {
        Page p = getPageWithParams();
        java.util.List<?> list = this.contractBadrecordService.listByCondition(m, p);
        return new PageData(p.getRowCount(), list);
    }
}
