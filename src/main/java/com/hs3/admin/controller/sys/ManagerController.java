package com.hs3.admin.controller.sys;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.roles.Role;
import com.hs3.entity.sys.SysConfig;
import com.hs3.entity.users.Manager;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.roles.RoleService;
import com.hs3.service.sys.SysConfigService;
import com.hs3.service.user.ManagerService;
import com.hs3.utils.ListUtils;
import com.hs3.utils.NumUtils;
import com.hs3.utils.StrUtils;
import com.hs3.utils.auth.google.GoogleAuthenticatorUtils;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@Scope("prototype")
@RequestMapping({"/admin/manager"})
public class ManagerController
        extends AdminController {
    @Autowired
    private ManagerService managerService;
    @Autowired
    private RoleService roleService;
    @Autowired
    private SysConfigService sysConfigService;
    private static String PROJECT_NAME = null;

    private String getProjectName() {
        if (PROJECT_NAME == null) {
            SysConfig config = this.sysConfigService.find("PROJECT_NAME");

            if (config != null) {
                if (!StrUtils.hasEmpty(new Object[]{config.getVal()})) {
                }
                PROJECT_NAME = config.getVal();
            } else {
                PROJECT_NAME = "未命名" + NumUtils.getRandom(0, 9);
            }
        }

        return PROJECT_NAME;
    }

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/sys/manager");
        List<Role> roles = this.roleService.list();
        mv.addObject("roles", roles);
        mv.addObject("json", StrUtils.toJson(roles));
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list() {
        Page p = getPageWithParams();
        List<Manager> list = this.managerService.list(p);
        return new PageData(p.getRowCount(), list);
    }

    @RequestMapping(value = {"/password"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object password() {
        ModelAndView mv = getView("/password");
        return mv;
    }

    @ResponseBody
    @RequestMapping(value = {"/password"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object password(String old, String password1, String password2) {
        if (StrUtils.hasEmpty(new Object[]{old, password1, password2})) {
            return Jsoner.error("请填写完整信息");
        }
        if (!password2.equals(password1)) {
            return Jsoner.error("两次密码不一致");
        }
        if (old.equals(password1)) {
            return Jsoner.error("新密码不能与旧密码相同");
        }
        String account = ((Manager) getLogin()).getAccount();
        boolean success = this.managerService.updatePassword(account, old, password1);
        if (success) {
            return Jsoner.success();
        }
        return Jsoner.error("旧密码错误");
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(Manager m) {
        this.managerService.save(m);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(String id) {
        Manager manager = this.managerService.find(id);
        manager.setPassword(null);
        return manager;
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(Manager m) {
        if (StrUtils.hasEmpty(new Object[]{m.getAccount(), m.getNiceName()})) {
            return Jsoner.error("请认真填写");
        }
        if (this.managerService.update(m) == 1) {
            return Jsoner.success();
        }
        return Jsoner.error();
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String id) {
        List<Integer> ids = ListUtils.toIntList(id);
        if (ids.contains(((Manager) getLogin()).getId())) {
            return Jsoner.error("不能删除自己");
        }
        int c = this.managerService.delete(ids);
        if (c == 0) {
            return Jsoner.error();
        }
        return Jsoner.success();
    }

    @RequestMapping(value = {"/authKey"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object showKey(String account) {
        String key = this.managerService.getAuthKey(account);
        if (key == null) {
            key = GoogleAuthenticatorUtils.createSecretKey();
            this.managerService.updateAuthKey(account, key);
        }
        String issue = getProjectName();
        String c = GoogleAuthenticatorUtils.createGoogleAuthQRCodeData(key, account, issue);
        ModelAndView mv = getView("/sys/authKey");
        mv.addObject("qrCode", c);
        mv.addObject("account", account);
        return mv;
    }

    @ResponseBody
    @RequestMapping(value = {"/createKey"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object createKey(String account) {
        String key = GoogleAuthenticatorUtils.createSecretKey();
        this.managerService.updateAuthKey(account, key);
        String issue = getProjectName();
        String c = GoogleAuthenticatorUtils.createGoogleAuthQRCodeData(key, account, issue);
        return Jsoner.success(c);
    }
}
