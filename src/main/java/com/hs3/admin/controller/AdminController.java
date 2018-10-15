package com.hs3.admin.controller;

import com.hs3.commons.DepositType;
import com.hs3.commons.RechargeType;
import com.hs3.entity.finance.Recharge;
import com.hs3.entity.users.Manager;
import com.hs3.models.PageData;
import com.hs3.service.roles.RoleService;
import com.hs3.utils.DateUtils;
import com.hs3.utils.auth.AuthUtils;
import com.hs3.utils.sys.WebDateUtils;
import com.hs3.web.controller.BaseAction;
import com.hs3.web.utils.SpringContext;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Arrays;
import java.util.Date;
import java.util.List;


public class AdminController
        extends BaseAction<Manager> {
    public static final String KEY_SESSION = "ADMIN_SESSION";
    protected static final String DEFAULT_PROFIT_TIME_BEGIN = "webProfitDefaultBiginTime";
    protected static final String DEFAULT_PROFIT_TIME_END = "webProfitDefaultEndTime";
    public static final String THEME = "/easyui";

    protected String getTheme() {
        return "/easyui";
    }

    protected String getSessionKey() {
        return "ADMIN_SESSION";
    }

    protected void setLogin(Manager u) {
        super.setLogin(u);
        RoleService roleService = (RoleService) SpringContext.getBean("roleService");
        AuthUtils.saveAuth(getRequest(), roleService.getPaths(u.getRole()));
    }

    protected void addAdminWebDefaultTime(ModelAndView modelAndView) {
        Date now = new Date();
        modelAndView.addObject("webProfitDefaultEndTime", DateUtils.formatDate(WebDateUtils.getEndTime(now)));
        modelAndView.addObject("webProfitDefaultBiginTime", DateUtils.formatDate(WebDateUtils.getBeginTime(now)));
    }


    protected void exportExcel(HttpServletRequest request, HttpServletResponse response, List list,  List<List<String>> exceltitle) throws Exception {
        System.out.println("start !!!!");
        OutputStream os = null;
        Workbook wb =   new SXSSFWorkbook(1000); //大于1000行时会把之前的行写入硬盘，解决内存溢出 //工作薄
        try {
            Sheet sheet = wb.createSheet();

            //单元格
            Cell cell;


            if(list.get(0) instanceof  Recharge){
                for(int i = 0; i < list.size(); i++){
                    Recharge recharge = (Recharge) list.get(i);
                    //充值單狀態
                    int status =recharge.getStatus();
                    String statusStr="";

                    switch (status){
                        case 2:
                            statusStr = RechargeType.COMPLETE.desc();
                            break;
                        case 6:
                            statusStr = RechargeType.AUDIT.desc();
                            break;
                        case 1:
                            statusStr = RechargeType.REJECT.desc();
                            break;
                    }

                    //充值類型
                    int rechargeType = recharge.getRechargeType();
                    String rechargeTypeStr = "";

                    switch (rechargeType){
                        case 0:
                            rechargeTypeStr = DepositType.OFFLINE.desc();
                            break;
                        case 1:
                            rechargeTypeStr = DepositType.ONLINE.desc();
                            break;
                        case 2:
                            rechargeTypeStr = DepositType.CASH.desc();
                            break;
                    }

                    String isTest = "";

                    if(null != recharge.getTest() && recharge.getTest() == 1){
                        isTest = "测试";
                    }
                    else{
                        isTest = "非测试";
                    }

                    String createTimeStr = DateUtils.format(recharge.getCreateTime());
                    String lastTimeStr = DateUtils.format(recharge.getLastTime());

                    //organize content
                    exceltitle.add(Arrays.asList(recharge.getId(), statusStr, String.valueOf(recharge.getAmount()), String.valueOf(recharge.getPoundage()),
                            String.valueOf(recharge.getRealAmount()), rechargeTypeStr, recharge.getCard(), recharge.getNiceName(), recharge.getCheckCode(),
                            String.valueOf(recharge.getUserMark()), recharge.getAccount(), isTest, recharge.getBankName(), createTimeStr
                            , lastTimeStr, recharge.getOperator(), recharge.getReceiveBankName(), recharge.getReceiveCard(),
                            recharge.getReceiveAddress(), recharge.getReceiveNiceName(), recharge.getRemark(), recharge.getSerialNumber()
                    ));
                }
            }

            for(int i=0; i< exceltitle.size(); i++){
                //行
                Row row = sheet.createRow(i);
                for(int j =0; j< exceltitle.get(i).size(); j++ ){
                    cell = row.createCell(j);
                    cell.setCellValue(exceltitle.get(i).get(j));
                }
            }

            String fileName = "download.xlsx";
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(fileName, "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            os.flush();
            os.close();
            wb.close();
        }
    }
}
