package com.hs3.admin.controller.webs;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.webs.ImgRegist;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.webs.ImgRegistService;
import com.hs3.utils.FileUtils;
import com.hs3.utils.ListUtils;

import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;


@Controller
@Scope("prototype")
@RequestMapping({"/admin/imgRegist"})
public class ImgRegistController
        extends AdminController {
    @Autowired
    private ImgRegistService imgRegistService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/img/imgRegist");
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list() {
        Page p = getPageWithParams();
        List<ImgRegist> list = this.imgRegistService.list(p);
        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(ImgRegist m, MultipartFile file) {
        if (!file.isEmpty()) {
            try {
                String fileName = FileUtils.save(getSession().getServletContext().getRealPath("/"), "/res/upload/", file);
                m.setImg(fileName);
            } catch (Exception e) {
                return Jsoner.error(e.getMessage());
            }
        } else {
            return Jsoner.error("必须上传图片");
        }
        this.imgRegistService.save(m);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {
        return this.imgRegistService.find(id);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(ImgRegist m, MultipartFile file) {
        if (!file.isEmpty()) {
            try {
                String fileName = FileUtils.save(getSession().getServletContext().getRealPath("/"), "/res/upload/", file);
                m.setImg(fileName);
            } catch (Exception e) {
                return Jsoner.error(e.getMessage());
            }
        } else {
            m.setImg(null);
        }
        if (this.imgRegistService.update(m) == 1) {
            return Jsoner.success();
        }
        return Jsoner.error();
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String id) {
        return Jsoner.getByResult(this.imgRegistService.delete(ListUtils.toIntList(id)) > 0);
    }
}
