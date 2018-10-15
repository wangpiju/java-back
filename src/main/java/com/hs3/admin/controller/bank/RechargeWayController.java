package com.hs3.admin.controller.bank;

import com.hs3.admin.controller.AdminController;
import com.hs3.db.Page;
import com.hs3.entity.bank.BankName;
import com.hs3.entity.bank.RechargeWay;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.bank.BankNameService;
import com.hs3.service.bank.RechargeWayService;
import com.hs3.utils.BeanZUtils;
import com.hs3.utils.DateUtils;
import com.hs3.utils.StrUtils;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import sun.misc.BASE64Encoder;

import java.io.File;
import java.io.IOException;
import java.util.*;

@Controller
@Scope("prototype")
@RequestMapping({"/admin/rechargeWay"})
public class RechargeWayController extends AdminController {

    @Autowired
    private RechargeWayService rechargeWayService;

    @Autowired
    private BankNameService bankNameService;

    @RequestMapping({"/index"})
    public Object index() {
        ModelAndView mv = getView("/bank/rechargeWay");
        List<BankName> bankNameList = bankNameService.bankByBnTypeList(2);
        mv.addObject("bankNameList", bankNameList);
        return mv;
    }


    @ResponseBody
    @RequestMapping({"/list"})
    public Object list() {
        Page p = getPageWithParams();
        List<RechargeWay> list = this.rechargeWayService.list(p);
        List<BankName> bankNameList = bankNameService.bankByBnTypeList(2);

        List<Map> listMap = new ArrayList<Map>();
        Map map = null;
        for(RechargeWay obj: list){
            map = BeanZUtils.transBeanMap(obj);

            String bnTitle = "";
            Integer waytype = obj.getWaytype();
            if(waytype != null && waytype == 1){
                for(BankName bankName: bankNameList){
                    if( obj.getBnId() != null && (obj.getBnId() == bankName.getId())){
                        bnTitle = bankName.getTitle();
                        break;
                    }
                }
            }

            map.put("bnTitle", bnTitle);
            listMap.add(map);
        }

        return new PageData(p.getRowCount(), listMap);
    }

    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object add(RechargeWay m, MultipartFile sourceFile) throws IOException {

        Integer waytype = m.getWaytype();
        if(waytype == null){
            return Jsoner.error("[渠道类型]不能为空！");
        }

        String imgData = getImgData(sourceFile);
        if (!StrUtils.hasEmpty(new Object[]{imgData})){
            m.setImgData(imgData);

            String randomNow = randomForFile();
            m.setRandomNow(randomNow);

        }

        this.rechargeWayService.save(m);
        return Jsoner.success();
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object edit(Integer id) {
        return this.rechargeWayService.find(id);
    }

    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object edit(RechargeWay m, MultipartFile sourceFile) throws IOException {

        Integer waytype = m.getWaytype();
        if(waytype == null){
            return Jsoner.error("[渠道类型]不能为空！");
        }

        String imgData = getImgData(sourceFile);
        if (!StrUtils.hasEmpty(new Object[]{imgData})){
            m.setImgData(imgData);

            String randomOld = m.getRandomNow();
            m.setRandomOld(randomOld);

            String randomNow = randomForFile();
            m.setRandomNow(randomNow);

        }

        if (this.rechargeWayService.update(m) == 1) {
            return Jsoner.success();
        }
        return Jsoner.error();
    }


    private String getImgData(MultipartFile sourceFile) throws IOException {

        String imgData = "";

        if(!sourceFile.isEmpty()){
            BASE64Encoder encoder = new BASE64Encoder();
            imgData = encoder.encode(sourceFile.getBytes());
        }

        return imgData;
    }


    private String randomForFile(){

        Date nowDate = new Date();
        String nowDateStr = DateUtils.formatPayTime(nowDate);

        int emailCodeInt = (int) ((Math.random() * 9 + 1) * 1000);
        String code = String.valueOf(emailCodeInt);

        String random = nowDateStr + code;

        return random;
    }


    private String setFile(MultipartFile sourceFile) throws IOException {

        String fileName = "";

        if(sourceFile != null) {

            Date nowDate = new Date();
            String nowDateStr = DateUtils.formatPayTime(nowDate);

            int emailCodeInt = (int) ((Math.random() * 9 + 1) * 1000);
            String code = String.valueOf(emailCodeInt);

            fileName = nowDateStr + code + ".jpg";
            String realPath = getSession().getServletContext().getRealPath("/");
            String targetPath = realPath + "/res/payQRCode/" + fileName;

            FileUtils.copyInputStreamToFile(sourceFile.getInputStream(), new File(targetPath));
        }

        return fileName;

    }


}
