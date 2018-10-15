package com.hs3.admin.controller.article;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.article.Menu;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.article.MenuService;
import com.hs3.utils.ListUtils;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@Scope("prototype")
@RequestMapping({"/admin/article/menu"})
public class MenuController
        extends AdminController {
    @Autowired
    private MenuService menuService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/article/menu");
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(Menu menu) {
        Page p = getPageWithParams();

        Menu m = new Menu();
        m.setPosition((menu.getPosition() == null) || (menu.getPosition().intValue() == -1) ? null : menu.getPosition());
        List<Menu> list = this.menuService.listByCond(m, p);

        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(Menu m) {
        this.menuService.save(m);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {
        return this.menuService.find(id);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(Menu m) {
        return Jsoner.getByResult(this.menuService.update(m) > 0);
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String id) {
        return Jsoner.getByResult(this.menuService.delete(ListUtils.toIntList(id)) > 0);
    }
}
