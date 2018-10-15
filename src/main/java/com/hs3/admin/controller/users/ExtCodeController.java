package com.hs3.admin.controller.users;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.lotts.BonusGroupService;
import com.hs3.service.user.ExtCodeService;
import com.hs3.utils.ListUtils;
import com.hs3.utils.StrUtils;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@Scope("prototype")
@RequestMapping({"/admin/extCode"})
public class ExtCodeController
        extends AdminController {
    @Autowired
    private ExtCodeService extCodeService;
    @Autowired
    private BonusGroupService bonusGroupService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/user/extCode");
        List<?> bonus = this.bonusGroupService.list(null);
        mv.addObject("json", StrUtils.toJson(bonus));
        mv.addObject("bonusGroup", bonus);
        return mv;
    }


    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(String account, String code, Date beginCreateTime, Date endCreateTime, Integer bonusGroupId, BigDecimal minRebateRatio, BigDecimal maxRebateRatio, Integer lastTime) {
        Page p = getPageWithParams();
        List<?> list = this.extCodeService.listWithRegistNum(account, code,
                beginCreateTime, endCreateTime, bonusGroupId, minRebateRatio,
                maxRebateRatio, lastTime, p);
        PageData rel = new PageData(p.getRowCount(), list);
        return rel;
    }

    @ResponseBody
    @RequestMapping(value = {"/status"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object status(Integer id, Integer status) {
        this.extCodeService.setStatus(id, status);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String id) {
        List<Integer> ids = ListUtils.toIntList(id);
        this.extCodeService.delete(ids);
        return Jsoner.success();
    }

    @RequestMapping({"/extCodeAnalyzeIndex"})
    public Object extCodeAnalyze(String code) {
        ModelAndView mv = getView("/user/extCodeAnalyze");
        mv.addObject("code", code);
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/listForExtCode"})
    public Object listForExtCode(String code, Date beginCreateTime, Date endCreateTime) {
        Page p = getPageWithParams();
        List<Map<String, Object>> list = this.extCodeService.listForExtCode(p, code, beginCreateTime, endCreateTime);
        return new PageData(p.getRowCount(), p.getObj(), list);
    }
}
