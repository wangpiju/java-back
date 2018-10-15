package com.hs3.admin.controller.bank;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.article.Article;
import com.hs3.entity.bank.BankApi;
import com.hs3.entity.sys.SysConfig;
import com.hs3.exceptions.BaseCheckException;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.article.ArticleService;
import com.hs3.service.bank.BankApiService;
import com.hs3.service.bank.BankLevelService;
import com.hs3.service.sys.SysConfigService;
import com.hs3.utils.FileUtils;
import com.hs3.utils.HttpUtils;
import com.hs3.utils.ListUtils;
import com.hs3.utils.StrUtils;
import com.pays.PayApi;
import com.pays.PayApiFactory;
import com.pays.WithdrawApiParam;

import java.io.File;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;


@Controller
@Scope("prototype")
@RequestMapping({"/admin/bankApi"})
public class BankApiController
        extends AdminController {
    private static final Logger logger = Logger.getLogger(BankApiController.class);
    private static final String PATH_TWO_CODE = "/res/upload/";
    @Autowired
    private BankApiService bankApiService;
    @Autowired
    private BankLevelService bankLevelService;
    @Autowired
    private ArticleService articleService;
    @Autowired
    private SysConfigService sysConfigService;

    @RequestMapping(value = {"/proxypay"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object proxypay() {
        ModelAndView mv = getView("/bank/proxypay");
        return mv;
    }

    @RequestMapping(value = {"/proxypay"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object proxypay(String classKey, String method, WithdrawApiParam param) {
        ModelAndView mv = getView("/bank/proxypay");

        String result = "";
        try {
            param.setGroupName(this.sysConfigService.find("PROJECT_NAME").getVal());

            PayApi payApi = PayApiFactory.getInstance(classKey);

            Map<String, String> params = payApi.getProxyParam(param);
            params.put(method + "Url", payApi.getProxyUrl());

            result = HttpUtils.postString(param.getShopUrl() + "/" + param.getGroupName() + "/" + method, params);
            logger.info(method + " result:" + result);
        } catch (Exception e) {
            mv.addObject("message", "异常:" + e.getMessage());
            logger.error(method + " exception:" + e.getMessage(), e);
        }
        mv.addObject("message", result);

        return mv;
    }

    @RequestMapping({"/index"})
    public Object index(String account) {
        ModelAndView mv = getView("/bank/api");
        List<?> bankLevel = this.bankLevelService.listAll(null);
        Map<String, String> bankKey = PayApiFactory.getMaps();
        mv.addObject("bankLevel", bankLevel);
        mv.addObject("bankKey", bankKey);
        mv.addObject("bankLevelJson", StrUtils.toJson(bankLevel));
        mv.addObject("bankKeyJson", StrUtils.toJson(bankKey));
        mv.addObject("sysConfigBankArticle", this.sysConfigService.find("RECHARGE_BANK_ARTICLE_ID"));
        mv.addObject("sysConfigBankRemark", this.sysConfigService.find("RECHARGE_BANK_REMARK"));

        Article cond = new Article();
        cond.setStatus(Integer.valueOf(0));
        mv.addObject("articleList", this.articleService.listByCond(cond, null));
        return mv;
    }

    @ResponseBody
    @RequestMapping({"/list"})
    public Object list(BankApi m, String[] classKeyArray) {
        Page p = getPageWithParams();
        List<BankApi> list = this.bankApiService.listByCond(m, classKeyArray, p);
        for (BankApi bankApi : list) {
            bankApi.setSign(null);
            bankApi.setPublicKey(null);
        }
        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(BankApi m, MultipartFile file) {
        try {
            if (!file.isEmpty()) {
                String fileName = FileUtils.save(getSession().getServletContext().getRealPath("/"), "/res/upload/", file);
                m.setTwoCode(fileName);
            }

            this.bankApiService.save(m);
        } catch (BaseCheckException e) {
            return Jsoner.error(e.getMessage());
        } catch (Exception e) {
            return Jsoner.error(e.getMessage());
        }
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {
        BankApi api = this.bankApiService.find(id);
        api.setSign(null);
        api.setPublicKey(null);
        return api;
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(BankApi m, MultipartFile file) {
        try {
            if (!file.isEmpty()) {
                String realPath = getSession().getServletContext().getRealPath("/");

                new File(realPath + this.bankApiService.find(m.getId()).getTwoCode()).deleteOnExit();
                String fileName = FileUtils.save(realPath, "/res/upload/", file);
                m.setTwoCode(fileName);
            }
            return Jsoner.getByResult(this.bankApiService.update(m) == 1);
        } catch (BaseCheckException e) {
            return Jsoner.error(e.getMessage());
        } catch (Exception e) {
            return Jsoner.error(e.getMessage());
        }
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object delete(String id) {
        List<Integer> ids = ListUtils.toIntList(id);
        return Jsoner.getByResult(this.bankApiService.delete(ids) > 0);
    }

    @ResponseBody
    @RequestMapping(value = {"/editBank"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object editBank(String bankArticleId, String bankRemark) {
        SysConfig sysConfig = this.sysConfigService.find("RECHARGE_BANK_ARTICLE_ID");
        sysConfig.setVal(bankArticleId);
        this.sysConfigService.update(sysConfig);

        sysConfig = this.sysConfigService.find("RECHARGE_BANK_REMARK");
        sysConfig.setVal(bankRemark);
        this.sysConfigService.update(sysConfig);
        return Jsoner.success();
    }
}
