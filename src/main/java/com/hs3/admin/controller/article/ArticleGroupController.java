package com.hs3.admin.controller.article;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.article.ArticleGroup;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.article.ArticleGroupService;
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
@RequestMapping({"/admin/article/articleGroup"})
public class ArticleGroupController
        extends AdminController {
    @Autowired
    private ArticleGroupService articleGroupService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/article/articleGroup");

        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list() {
        Page p = getPageWithParams();
        List<ArticleGroup> list = this.articleGroupService.listWithOrder(p);

        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(ArticleGroup m) {
        this.articleGroupService.save(m);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {
        return this.articleGroupService.find(id);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(ArticleGroup m) {
        return Jsoner.getByResult(this.articleGroupService.update(m) > 0);
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String id) {
        return Jsoner.getByResult(this.articleGroupService.delete(ListUtils.toIntList(id)) > 0);
    }
}
