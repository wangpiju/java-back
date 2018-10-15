package com.hs3.admin.controller.webs;

import com.hs3.admin.controller.AdminController;
import com.hs3.entity.sys.SysConfig;
import com.hs3.entity.users.Manager;
import com.hs3.models.Jsoner;
import com.hs3.service.sys.LoginIpWhiteService;
import com.hs3.service.sys.SysConfigService;
import com.hs3.service.user.ManagerService;
import com.hs3.service.user.UserTokenService;
import com.hs3.utils.ListUtils;
import com.hs3.utils.StrUtils;
import com.hs3.utils.TokenUtils;
import com.hs3.utils.auth.google.GoogleAuthenticatorUtils;
import com.hs3.utils.sec.Des;
import com.hs3.web.auth.Auth;
import com.hs3.web.utils.MyDateEditor;

import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Hex;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@Scope("prototype")
@RequestMapping({"/admin"})
public class HomeController
        extends AdminController {
    private static final Logger logger = Logger.getLogger(HomeController.class);
    private static final String MANAGER_LOGIN_MAC = "MANAGER_LOGIN_MAC";
    private static final String DES_KEY = "sJc@v9#b";
    @Autowired
    private ManagerService managerService;
    @Autowired
    private LoginIpWhiteService loginIpWhiteService;
    @Autowired
    private SysConfigService sysConfigService;
    @Autowired
    private UserTokenService userTokenService;

    @RequestMapping(value = {"/index"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object index() {
        ModelAndView mv = getView("/index");
        mv.addObject("user", getLogin());
        return mv;
    }

    @Auth
    @RequestMapping(value = {"/"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object home() {
        return login();
    }

    @Auth
    @RequestMapping(value = {""}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object home2() {
        return login();
    }


    @Auth
    @RequestMapping({"/none"})
    public Object none() {
        return getViewName("/error/none");
    }

    private Object getUserToken() {
        String[] tokenArray = TokenUtils.getRandomKey(3);
        String tokenKey = "";
        for (int i = 0; i < tokenArray.length; i++) {
            tokenKey = tokenKey + tokenArray[i] + " ";
        }
        getSession().setAttribute("tokenArray", tokenArray);
        return tokenKey;
    }

    @Auth
    @ResponseBody
    @RequestMapping(value = {"/getToken"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object ajaxChangeValue() {
        return Jsoner.success(getUserToken());
    }

    @Auth
    @RequestMapping(value = {"/login"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object login() {
        String token = StrUtils.getRandomString(4);
        getSession().setAttribute("token", token);
        ModelAndView mv = getView("/login");

        mv.addObject("tokenKey", getUserToken());
        mv.addObject("ip", getIP());
        mv.addObject("token", token);

        SysConfig sysConfig = this.sysConfigService.find("LOGIN_TYPE");
        int type = 0;
        if ((sysConfig == null) || ("0".equals(sysConfig.getVal()))) {
            type = 0;
        } else if ("1".equals(sysConfig.getVal())) {
            type = 1;
        } else {
            type = 2;
        }
        mv.addObject("type", type);
        return mv;
    }

    @Auth
    @RequestMapping(value = {"/login"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public Object login(String account, String password, String code, String token) {
        Object t = getSession().getAttribute("token");
        String[] tokenArray = (String[]) getSession().getAttribute("tokenArray");
        String sessionToken = null;
        String msg = null;
        if (t != null) {
            sessionToken = t.toString();
            if (!this.loginIpWhiteService.vaild(getIP())) {
                msg = "您的IP已被禁止访问";
            } else if (StrUtils.hasEmpty(password, account)) {
                msg = "账号或密码不能为空";
            } else {
                boolean isok = true;
                SysConfig sysConfig = this.sysConfigService.find("LOGIN_TYPE");
                if ((sysConfig == null) || ("0".equals(sysConfig.getVal()))) {
                    if (!validationCode(code)) {
                        msg = "验证码错误";
                        isok = false;
                    }
                } else if ("1".equals(sysConfig.getVal())) {
                    String tokenCode = this.userTokenService.getTokenValue(account, tokenArray);
                    if (!tokenCode.equals(code)) {
                        msg = "令牌错误";
                        isok = false;
                    }
                } else {
                    String authKey = this.managerService.getAuthKey(account);
                    if (StrUtils.hasEmpty(authKey)) {
                        msg = "您没有动态密码,请联系管理员处理";
                        isok = false;
                    } else if (!GoogleAuthenticatorUtils.verify(authKey, code)) {
                        msg = "动态密码错误";
                        isok = false;
                    }
                }
                if (isok) {


                    Manager m = this.managerService.updateLogin(account, password, code, getSession().getId());
                    if (m != null) {
                        SysConfig config = this.sysConfigService.find("MANAGER_LOGIN_MAC");

                        if ((config.getVal().equals("1")) && (!"ALL".equals(m.getMac()))) {
                            if (StrUtils.hasEmpty(token)) {
                                msg = "无法登录,请联系管理员";
                                logger.info(account + "试图登录,IP:" + getIP());
                            } else {
                                String c = null;
                                try {
                                    byte[] src = Hex.decodeHex(token.toCharArray());
                                    c = Des.decrypt_des_cbc(src, "sJc@v9#b".getBytes()).replaceAll("\\s", "");


                                    List<String> macs = ListUtils.toList(m.getMac());

                                    for (String mac : macs) {
                                        if (c.equals(mac + "_" + sessionToken)) {
                                            getSession().removeAttribute("token");
                                            setLogin(m);
                                            return redirect("/admin/index");
                                        }
                                    }
                                } catch (Exception e) {
                                    if (c == null) {
                                        c = "没有MAC";
                                    }
                                    logger.error(account + "登录时解密失败,IP:" + getIP() + ",token:" + token + ",MAC:" + c, e);
                                }
                                msg = "禁止登录,请联系管理员";
                                logger.info("登录失败,IP:" + getIP() + ",token:" + token + ",MAC:" + c);
                            }
                        } else {
                            getSession().removeAttribute("token");
                            setLogin(m);
                            return redirect("/admin/index");
                        }
                    } else {
                        msg = "账号或密码错误";
                    }
                }
            }
        } else {
            msg = "会话超时，请重试";
        }

        sessionToken = StrUtils.getRandomString(4);
        getSession().setAttribute("token", sessionToken);

        ModelAndView mv = getView("/login");
        mv.addObject("tokenKey", getUserToken());
        mv.addObject("msg", msg);
        mv.addObject("ip", getIP());
        mv.addObject("token", sessionToken);
        mv.addObject("account", account);

        SysConfig sysConfig = this.sysConfigService.find("LOGIN_TYPE");
        int type = 0;
        if ((sysConfig == null) || ("0".equals(sysConfig.getVal()))) {
            type = 0;
        } else if ("1".equals(sysConfig.getVal())) {
            type = 1;
        } else {
            type = 2;
        }
        mv.addObject("type", type);
        return mv;
    }

    @Auth
    @RequestMapping(value = {"/logout"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public Object logout() {
        getSession().invalidate();
        return redirect("/admin/login");
    }

    /* Error */
    @ResponseBody
    @RequestMapping({"/exportExcel"})
    public void exportExcel(com.hs3.models.Excel excel)
            throws java.io.IOException {
        // Byte code:
        //   0: aload_0
        //   1: invokevirtual 392	com/hs3/admin/controller/webs/HomeController:getResponse	()Ljavax/servlet/http/HttpServletResponse;
        //   4: astore_2
        //   5: aload_2
        //   6: invokeinterface 396 1 0
        //   11: astore_3
        //   12: new 402	org/apache/poi/hssf/usermodel/HSSFWorkbook
        //   15: dup
        //   16: invokespecial 404	org/apache/poi/hssf/usermodel/HSSFWorkbook:<init>	()V
        //   19: astore 4
        //   21: aload 4
        //   23: invokevirtual 405	org/apache/poi/hssf/usermodel/HSSFWorkbook:createFont	()Lorg/apache/poi/hssf/usermodel/HSSFFont;
        //   26: astore 5
        //   28: aload 5
        //   30: sipush 700
        //   33: invokevirtual 409	org/apache/poi/hssf/usermodel/HSSFFont:setBoldweight	(S)V
        //   36: aload 4
        //   38: invokevirtual 415	org/apache/poi/hssf/usermodel/HSSFWorkbook:createCellStyle	()Lorg/apache/poi/hssf/usermodel/HSSFCellStyle;
        //   41: astore 6
        //   43: aload 6
        //   45: aload 5
        //   47: invokevirtual 419	org/apache/poi/hssf/usermodel/HSSFCellStyle:setFont	(Lorg/apache/poi/hssf/usermodel/HSSFFont;)V
        //   50: aload_1
        //   51: invokevirtual 425	com/hs3/models/Excel:getEms	()Ljava/util/List;
        //   54: invokeinterface 301 1 0
        //   59: astore 8
        //   61: goto +184 -> 245
        //   64: aload 8
        //   66: invokeinterface 307 1 0
        //   71: checkcast 431	com/hs3/models/ExcelSheet
        //   74: astore 7
        //   76: aload 4
        //   78: aload 7
        //   80: invokevirtual 433	com/hs3/models/ExcelSheet:getSheetName	()Ljava/lang/String;
        //   83: invokevirtual 436	org/apache/poi/hssf/usermodel/HSSFWorkbook:createSheet	(Ljava/lang/String;)Lorg/apache/poi/hssf/usermodel/HSSFSheet;
        //   86: astore 9
        //   88: iconst_0
        //   89: istore 10
        //   91: goto +139 -> 230
        //   94: aload 9
        //   96: iload 10
        //   98: invokevirtual 440	org/apache/poi/hssf/usermodel/HSSFSheet:createRow	(I)Lorg/apache/poi/hssf/usermodel/HSSFRow;
        //   101: astore 11
        //   103: iconst_0
        //   104: istore 12
        //   106: goto +96 -> 202
        //   109: aload 11
        //   111: iload 12
        //   113: invokevirtual 446	org/apache/poi/hssf/usermodel/HSSFRow:createCell	(I)Lorg/apache/poi/hssf/usermodel/HSSFCell;
        //   116: astore 13
        //   118: iload 10
        //   120: ifne +46 -> 166
        //   123: aload 13
        //   125: aload 6
        //   127: invokevirtual 452	org/apache/poi/hssf/usermodel/HSSFCell:setCellStyle	(Lorg/apache/poi/hssf/usermodel/HSSFCellStyle;)V
        //   130: aload 13
        //   132: aload 7
        //   134: invokevirtual 458	com/hs3/models/ExcelSheet:getEds	()Ljava/util/List;
        //   137: iload 10
        //   139: invokeinterface 461 2 0
        //   144: checkcast 302	java/util/List
        //   147: iload 12
        //   149: invokeinterface 461 2 0
        //   154: checkcast 465	com/hs3/models/ExcelData
        //   157: invokevirtual 467	com/hs3/models/ExcelData:getTitle	()Ljava/lang/String;
        //   160: invokevirtual 470	org/apache/poi/hssf/usermodel/HSSFCell:setCellValue	(Ljava/lang/String;)V
        //   163: goto +36 -> 199
        //   166: aload 13
        //   168: aload 7
        //   170: invokevirtual 458	com/hs3/models/ExcelSheet:getEds	()Ljava/util/List;
        //   173: iload 10
        //   175: invokeinterface 461 2 0
        //   180: checkcast 302	java/util/List
        //   183: iload 12
        //   185: invokeinterface 461 2 0
        //   190: checkcast 465	com/hs3/models/ExcelData
        //   193: invokevirtual 473	com/hs3/models/ExcelData:getFormatValue	()Ljava/lang/String;
        //   196: invokevirtual 470	org/apache/poi/hssf/usermodel/HSSFCell:setCellValue	(Ljava/lang/String;)V
        //   199: iinc 12 1
        //   202: iload 12
        //   204: aload 7
        //   206: invokevirtual 458	com/hs3/models/ExcelSheet:getEds	()Ljava/util/List;
        //   209: iload 10
        //   211: invokeinterface 461 2 0
        //   216: checkcast 302	java/util/List
        //   219: invokeinterface 476 1 0
        //   224: if_icmplt -115 -> 109
        //   227: iinc 10 1
        //   230: iload 10
        //   232: aload 7
        //   234: invokevirtual 458	com/hs3/models/ExcelSheet:getEds	()Ljava/util/List;
        //   237: invokeinterface 476 1 0
        //   242: if_icmplt -148 -> 94
        //   245: aload 8
        //   247: invokeinterface 326 1 0
        //   252: ifne -188 -> 64
        //   255: new 480	java/io/ByteArrayOutputStream
        //   258: dup
        //   259: invokespecial 482	java/io/ByteArrayOutputStream:<init>	()V
        //   262: astore 7
        //   264: aload 4
        //   266: aload 7
        //   268: invokevirtual 483	org/apache/poi/hssf/usermodel/HSSFWorkbook:write	(Ljava/io/OutputStream;)V
        //   271: aload_2
        //   272: ldc_w 487
        //   275: invokeinterface 489 2 0
        //   280: aload_2
        //   281: ldc_w 492
        //   284: new 92	java/lang/StringBuilder
        //   287: dup
        //   288: ldc_w 494
        //   291: invokespecial 100	java/lang/StringBuilder:<init>	(Ljava/lang/String;)V
        //   294: new 95	java/lang/String
        //   297: dup
        //   298: aload_1
        //   299: invokevirtual 496	com/hs3/models/Excel:getFileName	()Ljava/lang/String;
        //   302: ldc_w 499
        //   305: invokevirtual 501	java/lang/String:getBytes	(Ljava/lang/String;)[B
        //   308: ldc_w 504
        //   311: invokespecial 506	java/lang/String:<init>	([BLjava/lang/String;)V
        //   314: invokevirtual 103	java/lang/StringBuilder:append	(Ljava/lang/String;)Ljava/lang/StringBuilder;
        //   317: invokevirtual 109	java/lang/StringBuilder:toString	()Ljava/lang/String;
        //   320: invokeinterface 509 3 0
        //   325: aload 4
        //   327: aload_3
        //   328: invokevirtual 483	org/apache/poi/hssf/usermodel/HSSFWorkbook:write	(Ljava/io/OutputStream;)V
        //   331: aload_3
        //   332: invokevirtual 513	java/io/OutputStream:flush	()V
        //   335: goto +21 -> 356
        //   338: astore 4
        //   340: aload_3
        //   341: invokevirtual 518	java/io/OutputStream:close	()V
        //   344: goto +16 -> 360
        //   347: astore 14
        //   349: aload_3
        //   350: invokevirtual 518	java/io/OutputStream:close	()V
        //   353: aload 14
        //   355: athrow
        //   356: aload_3
        //   357: invokevirtual 518	java/io/OutputStream:close	()V
        //   360: return
        // Line number table:
        //   Java source line #259	-> byte code offset #0
        //   Java source line #260	-> byte code offset #5
        //   Java source line #263	-> byte code offset #12
        //   Java source line #265	-> byte code offset #21
        //   Java source line #266	-> byte code offset #28
        //   Java source line #267	-> byte code offset #36
        //   Java source line #268	-> byte code offset #43
        //   Java source line #270	-> byte code offset #50
        //   Java source line #272	-> byte code offset #76
        //   Java source line #274	-> byte code offset #88
        //   Java source line #275	-> byte code offset #94
        //   Java source line #276	-> byte code offset #103
        //   Java source line #277	-> byte code offset #109
        //   Java source line #278	-> byte code offset #118
        //   Java source line #279	-> byte code offset #123
        //   Java source line #280	-> byte code offset #130
        //   Java source line #281	-> byte code offset #163
        //   Java source line #282	-> byte code offset #166
        //   Java source line #276	-> byte code offset #199
        //   Java source line #274	-> byte code offset #227
        //   Java source line #270	-> byte code offset #245
        //   Java source line #288	-> byte code offset #255
        //   Java source line #289	-> byte code offset #264
        //   Java source line #291	-> byte code offset #271
        //   Java source line #292	-> byte code offset #280
        //   Java source line #294	-> byte code offset #325
        //   Java source line #295	-> byte code offset #331
        //   Java source line #296	-> byte code offset #335
        //   Java source line #298	-> byte code offset #340
        //   Java source line #297	-> byte code offset #347
        //   Java source line #298	-> byte code offset #349
        //   Java source line #299	-> byte code offset #353
        //   Java source line #298	-> byte code offset #356
        //   Java source line #300	-> byte code offset #360
        // Local variable table:
        //   start	length	slot	name	signature
        //   0	361	0	this	HomeController
        //   0	361	1	excel	com.hs3.models.Excel
        //   4	277	2	response	javax.servlet.http.HttpServletResponse
        //   11	346	3	os	java.io.OutputStream
        //   19	307	4	wb	org.apache.poi.hssf.usermodel.HSSFWorkbook
        //   338	1	4	localException	Exception
        //   26	20	5	font	org.apache.poi.hssf.usermodel.HSSFFont
        //   41	85	6	style	org.apache.poi.hssf.usermodel.HSSFCellStyle
        //   74	159	7	em	com.hs3.models.ExcelSheet
        //   262	5	7	output	java.io.ByteArrayOutputStream
        //   59	187	8	localIterator	java.util.Iterator
        //   86	9	9	sheet	org.apache.poi.hssf.usermodel.HSSFSheet
        //   89	142	10	j	int
        //   101	9	11	row	org.apache.poi.hssf.usermodel.HSSFRow
        //   104	99	12	i	int
        //   116	51	13	cell	org.apache.poi.hssf.usermodel.HSSFCell
        //   347	7	14	localObject	Object
        // Exception table:
        //   from	to	target	type
        //   12	335	338	java/lang/Exception
        //   12	340	347	finally
    }

    @InitBinder
    protected void InitBinder(ServletRequestDataBinder bin) {
        bin.setAutoGrowCollectionLimit(10000);
        bin.registerCustomEditor(Date.class, new MyDateEditor());
    }
}
