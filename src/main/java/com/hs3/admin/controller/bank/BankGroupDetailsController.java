package com.hs3.admin.controller.bank;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.bank.BankSys;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.bank.BankGroupService;
import com.hs3.service.bank.BankLevelService;
import com.hs3.service.bank.BankNameService;
import com.hs3.utils.ListUtils;
import com.hs3.utils.StrUtils;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@Scope("prototype")
@RequestMapping({"/admin/bankGroupDetails"})
public class BankGroupDetailsController
        extends AdminController {
    @Autowired
    private BankGroupService bankGroupService;
    @Autowired
    private BankLevelService bankLevelService;
    @Autowired
    private BankNameService bankNameService;

    @RequestMapping({"/index"})
    public Object index(Integer id) {
        ModelAndView mv = getView("/bank/groupDetails");
        mv.addObject("id", id);
        List<?> bankLevel = this.bankLevelService.list(null);
        List<?> bankName = this.bankNameService.list(null);
        mv.addObject("bankLevel", bankLevel);
        mv.addObject("bankName", bankName);
        mv.addObject("bankLevelJson", StrUtils.toJson(bankLevel));
        mv.addObject("bankNameJson", StrUtils.toJson(bankName));
        return mv;
    }


    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(Integer groupId) {
        return this.bankGroupService.listBanks(groupId);
    }


    @ResponseBody
    @RequestMapping({"/listNot"})
    public Object listNot(Integer groupId) {
        Page p = getPageWithParams();
        List<BankSys> list = this.bankGroupService.listBanksNot(groupId, p);
        return new PageData(p.getRowCount(), list);
    }


    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object add(Integer groupId, String id) {
        if (StrUtils.hasEmpty(new Object[]{id})) {
            return Jsoner.error("请选择银行卡");
        }
        List<Integer> idList = ListUtils.toIntList(id);
        if (idList.size() == 0) {
            return Jsoner.error("错误的参数列表：" + id);
        }
        this.bankGroupService.addBankList(groupId, idList);
        return Jsoner.success();
    }


    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(Integer groupId, String id) {
        if (StrUtils.hasEmpty(new Object[]{id})) {
            return Jsoner.error("请选择银行卡");
        }
        List<Integer> idList = ListUtils.toIntList(id);
        if (idList.size() == 0) {
            return Jsoner.error("错误的参数列表：" + id);
        }
        this.bankGroupService.deleteBankList(groupId, idList);
        return Jsoner.success();
    }
}
