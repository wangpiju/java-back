package com.hs3.admin.controller.contract;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.contract.ContractConfig;
import com.hs3.entity.users.User;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.models.contract.ContractRuleModel;
import com.hs3.service.contract.ContractConfigService;
import com.hs3.service.contract.ContractRuleService;
import com.hs3.service.user.UserService;
import com.hs3.utils.StrUtils;
import com.hs3.web.utils.ContractCheckForm;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@Scope("prototype")
@RequestMapping({"/admin/contractRule"})
public class ContractRuleController extends AdminController {
    @Autowired
    private ContractRuleService contractRuleService;
    @Autowired
    private ContractConfigService contractConfigService;
    @Autowired
    private UserService userService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/contract/contractRule");

        ContractConfig contractConfig = this.contractConfigService.findEntity();

        mv.addObject("contractConfig", contractConfig);
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(String account) {
        Page p = getPageWithParams();
        java.util.List<?> list = this.contractRuleService.contractRuleList(p, account);
        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(String account, Integer contractStatus) {
        ContractRuleModel m = this.contractRuleService.findContractRule(account, contractStatus);
        return m;
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(ContractRuleModel m) {
        String str = ContractCheckForm.checkForm(m);
        if (!StrUtils.hasEmpty(new Object[]{str})) {
            return Jsoner.error(str);
        }
        if (m.getType() == null) {
            return Jsoner.error("契约上级类型不能为空！");
        }
        User u = this.userService.findByAccount(m.getAccount().trim());
        if (u == null) {
            return Jsoner.error("该用户不存在！");
        }
        return this.contractRuleService.updateContractBySys(u, m) > 0 ? Jsoner.success() : Jsoner.error("编辑契约失败");
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(ContractRuleModel m) {
        if (StrUtils.hasEmpty(new Object[]{m.getAccount()})) {
            return Jsoner.error("用户名不能为空！");
        }
        User u = this.userService.findByAccount(m.getAccount().trim());
        if (u == null) {
            return Jsoner.error("该用户不存在！");
        }
        if (this.contractRuleService.findByAccount(u.getAccount()) > 0) {
            return Jsoner.error("该用户已存在契约，请确认！");
        }
        String str = ContractCheckForm.checkForm(m);
        if (!StrUtils.hasEmpty(new Object[]{str})) {
            return Jsoner.error(str);
        }
        return this.contractRuleService.updateContractBySys(u, m) > 0 ? Jsoner.success() : Jsoner.error("添加契约失败");
    }

    @ResponseBody
    @RequestMapping(value = {"/activeContract"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object activeContract(String account) {
        int i = this.contractRuleService.updateToActive(account);
        if (i == 0) {
            return Jsoner.error();
        }
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/closeContract"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object closeContract(String account) {
        int i = this.contractRuleService.updateToclose(account);
        if (i == 0) {
            return Jsoner.error();
        }
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String account, Integer contractStatus) {
        int i = this.contractRuleService.deleteContract(account, contractStatus);
        if (i == 0) {
            return Jsoner.error();
        }
        return Jsoner.success();
    }
}
