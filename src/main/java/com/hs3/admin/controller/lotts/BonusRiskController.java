package com.hs3.admin.controller.lotts;

import com.hs.comm.service.lotts.BonusRiskService;
import com.hs3.admin.controller.AdminController;
import com.hs3.commons.Constants;
import com.hs3.db.Page;
import com.hs3.entity.lotts.BonusRisk;
import com.hs3.entity.lotts.Lottery;
import com.hs3.entity.sys.SysClear;
import com.hs3.models.PageData;
import com.hs3.models.lotts.BonusRiskEx;
import com.hs3.service.sys.SysClearService;
import com.hs3.web.auth.Auth;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * program: java-back
 * des:
 * author: Terra
 * create: 2018-06-22 21:37
 **/
@Controller
@Scope("prototype")
@RequestMapping({"/admin/risk/bonus"})
public class BonusRiskController extends AdminController {

    @Autowired
    private SysClearService sysClearService;
    @Autowired
    private BonusRiskService bonusRiskService;
    /**
     * 添加清除奖池任务
     */
    @Auth
    @ResponseBody
    @RequestMapping(value = {"/add_clear_task"}, method = {RequestMethod.POST})
    public boolean addRiskBonusTask(
            @RequestParam(value = "executeTime", required = false, defaultValue = "0:01:00") String executeTime
    ) {
        SysClear sysClear = new SysClear();
        sysClear.setId(26);
        sysClear.setJob(26);
        sysClear.setCategory("风控奖池清理");
        sysClear.setTitle("风控奖池清理");
        sysClear.setBeforeDays(1);
        sysClear.setBeforeDaysDefault(1);
        sysClear.setExecuteTime(executeTime);
        sysClear.setStatus(0);
        sysClear.setClearMode(0);
        sysClearService.save(sysClear);
        return true;
    }

    /**
     * 修改清除奖池任务
     */
    @Auth
    @ResponseBody
    @RequestMapping(value = {"/update_clear_task"}, method = {RequestMethod.POST})
    public boolean updateRiskBonusTask(
            @RequestParam(value = "executeTime", required = false, defaultValue = "0:01:00") String executeTime,
            @RequestParam(value = "status", required = false, defaultValue = "0") Integer status
    ) {
//        List<Integer> list = new ArrayList<>();
//        list.add(26);

        SysClear sysClear = new SysClear();
        sysClear.setId(26);
        sysClear.setJob(26);
        sysClear.setCategory("风控奖池清理");
        sysClear.setTitle("风控奖池清理");
        sysClear.setBeforeDays(1);
        sysClear.setBeforeDaysDefault(1);
        sysClear.setExecuteTime(executeTime);
        sysClear.setStatus(status);
        sysClear.setClearMode(0);
        int result = sysClearService.update(sysClear);
        return result > 0;
    }

    /**
     * 删除清除奖池任务
     */
    @Auth
    @ResponseBody
    @RequestMapping(value = {"/del_clear_task"}, method = {RequestMethod.POST})
    public boolean delRiskBonusTask(
            @RequestParam(value = "id", required = false, defaultValue = "26") Integer id
    ) {
        List<Integer> list = new ArrayList<>();
        list.add(id);
        int result = sysClearService.delete(list);
        return result > 0;
    }


    /**
     * 修改清除奖池任务
     */
    @Auth
    @ResponseBody
    @RequestMapping(value = {"/update_risk_status"}, method = {RequestMethod.POST})
    public boolean updateRiskStatus(
            @RequestParam(value = "status", required = false, defaultValue = "true") Boolean status
    ) {
        Constants.setOpenBonusRisk(status);
        return true;
    }


    @RequestMapping(value = {"/index"}, method = {RequestMethod.GET})
    public String index(
            @RequestParam(value = "status", required = false, defaultValue = "true") Boolean status
    ) {
        return getViewName("/lotts/bonusRisk");
    }

    @ResponseBody
    @RequestMapping(value = {"/list"}, method = {RequestMethod.GET, RequestMethod.POST})
    public Object list(
            @RequestParam(value = "lotteryId", required = false, defaultValue = "") String lotteryId,
            @RequestParam(value = "beginTime", required = false) Date beginTime,
            @RequestParam(value = "endTime", required = false) Date endTime,
            @RequestParam(value = "seasonId", required = false, defaultValue = "") String seasonId,
            @RequestParam(value = "isChangeNum", required = false) Integer isChangeNum
    ) {

        Page p = getPageWithParams();
        BonusRiskEx bonusRisk =new BonusRiskEx();
        bonusRisk.setLotteryId(lotteryId);
        bonusRisk.setBeginTime(beginTime);
        bonusRisk.setEndTime(endTime);
        bonusRisk.setSeasonId(seasonId);
        bonusRisk.setIsChangeNum(isChangeNum);
        List<BonusRisk> list = bonusRiskService.queryList(bonusRisk, p);
        return new PageData(p.getRowCount(), list);
    }


}
