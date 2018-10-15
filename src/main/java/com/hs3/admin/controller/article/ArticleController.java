package com.hs3.admin.controller.article;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.article.Article;
import com.hs3.entity.article.ArticleGroup;
import com.hs3.entity.users.Manager;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.article.ArticleGroupService;
import com.hs3.service.article.ArticleService;
import com.hs3.utils.ListUtils;
import com.hs3.utils.StrUtils;

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
@RequestMapping({"/admin/article/article"})
public class ArticleController
        extends AdminController {
    @Autowired
    private ArticleService articleService;
    @Autowired
    private ArticleGroupService articleGroupService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/article/article");
        List<ArticleGroup> articleGroupList = this.articleGroupService.listWithOrder(null);
        mv.addObject("json", StrUtils.toJson(articleGroupList));
        mv.addObject("articleGroup", articleGroupList);
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(Article article) {
        Page p = getPageWithParams();

        Article m = new Article();
        m.setTitle(article.getTitle());
        List<Article> list = this.articleService.listByCond(m, p);

        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(Article m) {
        m.setCreateTime(new Date());
        m.setAuthor(((Manager) getLogin()).getAccount());
        this.articleService.save(m);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {
        return this.articleService.find(id);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(Article m) {
        m.setCreateTime(new Date());
        m.setAuthor(((Manager) getLogin()).getAccount());
        return Jsoner.getByResult(this.articleService.update(m) > 0);
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String id) {
        return Jsoner.getByResult(this.articleService.delete(ListUtils.toIntList(id)) > 0);
    }
}
