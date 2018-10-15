package com.hs3.admin.controller.users.vo;

import java.math.BigDecimal;

public class UserRebateDetail {
    private String lotteryName;
    private String playName;
    private BigDecimal rebate;

    public String getLotteryName() {
        return this.lotteryName;
    }

    public void setLotteryName(String lotteryName) {
        this.lotteryName = lotteryName;
    }

    public String getPlayName() {
        return this.playName;
    }

    public void setPlayName(String playName) {
        this.playName = playName;
    }

    public BigDecimal getRebate() {
        return this.rebate;
    }

    public void setRebate(BigDecimal rebate) {
        this.rebate = rebate;
    }
}
