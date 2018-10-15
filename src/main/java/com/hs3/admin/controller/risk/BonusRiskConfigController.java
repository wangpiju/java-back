package com.hs3.admin.controller.risk;

import com.alibaba.fastjson.JSONObject;
import com.hs.comm.service.lotts.BonusRiskService;
import com.hs3.admin.controller.AdminController;
import com.hs3.commons.Whether;
import com.hs3.db.Page;
import com.hs3.entity.lotts.BonusRiskClean;
import com.hs3.entity.lotts.BonusRiskConfig;
import com.hs3.entity.users.Manager;
import com.hs3.models.Jsoner;
import com.hs3.models.PageData;
import com.hs3.service.risk.BonusRiskCleanService;
import com.hs3.service.risk.BonusRiskConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * program: java-back
 * des:
 * author: Terra
 * create: 2018-06-22 21:37
 **/
@Controller
@Scope("prototype")
@RequestMapping({"/admin/risk/bonusConfig"})
public class BonusRiskConfigController extends AdminController {

    @Autowired
    private BonusRiskConfigService bonusRiskConfigService;
    @Autowired
    private BonusRiskService bonusRiskService;
    @Autowired
    private BonusRiskCleanService bonusRiskCleanService;

    @RequestMapping(value = {"/index"}, method = {RequestMethod.GET})
    public String index(
            @RequestParam(value = "status", required = false, defaultValue = "true") Boolean status
    ) {
        return getViewName("/lotts/bonusRiskConfig");
    }

    /**
     * 添加风控奖池配置
     */
    @ResponseBody
    @RequestMapping(value = {"/add"}, method = {RequestMethod.POST})
    public Object save(Integer id, String lotteryId, BigDecimal dayFlowWater, BigDecimal revenueRate, BigDecimal loseRate, BigDecimal initBonusPool, Integer collectCount) {
        BonusRiskConfig riskConfig = new BonusRiskConfig();
        riskConfig.setId(id);
        riskConfig.setLotteryId(lotteryId);
        riskConfig.setDayFlowWater(dayFlowWater);
        riskConfig.setRevenueRate(revenueRate);
        riskConfig.setLoseRate(loseRate);
        riskConfig.setStatus(Whether.yes.getStatus());
        riskConfig.setCreateTime(new Date());
        riskConfig.setUpdateTime(riskConfig.getCreateTime());
        riskConfig.setInitBonusPool(initBonusPool);
        riskConfig.setCollectCount(collectCount);
        bonusRiskConfigService.save(riskConfig);
        return Jsoner.success();
    }

    /**
     * 修改风控奖池配置
     */
    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = RequestMethod.POST)
    public Object edit(Integer id, String lotteryId, BigDecimal dayFlowWater, BigDecimal revenueRate, BigDecimal loseRate, BigDecimal initBonusPool, Integer collectCount) {
        BonusRiskConfig riskConfig = new BonusRiskConfig();
        riskConfig.setId(id);
        riskConfig.setLotteryId(lotteryId);
        riskConfig.setDayFlowWater(dayFlowWater);
        riskConfig.setRevenueRate(revenueRate);
        riskConfig.setLoseRate(loseRate);
        riskConfig.setStatus(Whether.yes.getStatus());
        riskConfig.setUpdateTime(new Date());
        riskConfig.setInitBonusPool(initBonusPool);
        riskConfig.setCollectCount(collectCount);
        bonusRiskConfigService.save(riskConfig);
        return Jsoner.success();
    }


    @ResponseBody
    @RequestMapping(value = {"/edit"}, method = RequestMethod.GET)
    public Object edit(Integer id) {
        BonusRiskConfig config = bonusRiskConfigService.get(id);
        return config;
    }

    @ResponseBody
    @RequestMapping(value = {"/list"}, method = {RequestMethod.GET, RequestMethod.POST})
    public Object list() {
        Map<String, String> lottCons = new HashMap<>();
        lottCons.put("dfk3", "大順快3");
        lottCons.put("ffpk10", "大順pk10");
        lottCons.put("sj1fc", "宏发时时彩");
        Page p = getPageWithParams();
        List<BonusRiskConfig> list = bonusRiskConfigService.queryList(p);
        if (list != null && list.size() > 0) {
            list.forEach(l -> {
                l.setLotteryName(lottCons.get(l.getLotteryId()));
            });
        }
        return new PageData(p.getRowCount(), list);
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = {RequestMethod.GET, RequestMethod.POST})
    public Object delete(Integer id) {
        bonusRiskConfigService.delete(id);
        return Jsoner.success();
    }

    /**
     * 修改风控奖池配置
     */
    @ResponseBody
    @RequestMapping(value = {"/cleanBonus"}, method = RequestMethod.GET)
    public Object cleanBonus(String lotteryId) {
        JSONObject oj = new JSONObject();
        oj.put("lotteryId", lotteryId);
        oj.put("currentBonusPool", 0);
        Map<String, Long> allPool = bonusRiskService.getAllBonusPool();
        if (allPool.size() > 0) {
            Long pool = allPool.get(lotteryId);
            if (pool != null) {
                oj.put("currentBonusPool", new BigDecimal(pool).divide(new BigDecimal(10000), 4));
            }
        }
        return oj;
    }

    /**
     * 修改风控奖池配置
     */
    @ResponseBody
    @RequestMapping(value = {"/cleanBonus"}, method = RequestMethod.POST)
    public Object cleanBonus(String lotteryId, BigDecimal cleanAmount) {
        Manager manager = getLogin();

        BonusRiskClean brc = new BonusRiskClean();
        brc.setBeforeBonusPool(new BigDecimal(0));
        brc.setCleanAmount(cleanAmount);
        brc.setOperateUser(manager.getAccount());
        brc.setCreateTime(new Date());
        brc.setLotteryId(lotteryId);
        Map<String, Long> allPool = bonusRiskService.getAllBonusPool();
        if (allPool.size() > 0) {
            Long pool = allPool.get(lotteryId);
            if (pool != null) {
                brc.setBeforeBonusPool(new BigDecimal(pool).divide(new BigDecimal(10000), 4));
                Long leftAmount = pool - cleanAmount.multiply(new BigDecimal(10000)).longValue();
                bonusRiskService.setBonusPool(lotteryId, leftAmount);
            }
        }
        bonusRiskCleanService.save(brc);
        return Jsoner.success();
    }


}
