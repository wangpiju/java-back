<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>

<html xmlns="http://www.w3.org/1999/xhtml">

<head>

    <script type="text/javascript">

        var countFields = ['amount','rechargeAmount','rechargeAmountNum','withdrawAmount','withdrawAmountNum','activityAmount','betAmount','winningAmount','rebateAmount','profitAndLoss','profit'];

        $(function() {

            setWebDefaultTime();

            if('${begin}') {

                $('.beginTime').datebox("setValue", '${begin}');

            }

            if('${end}') {

                $('.endTime').datebox("setValue", '${end}');

            }

            var options = {

                url:'membershipReport',

                queryParams : getQueryParams(),

                columns : [ [ {

                    field : 'account',

                    title : '会员账户',

                    formatter : function(value, row) {
                        var	txt ="";
                        if(value!=null){
                            txt= "<span  style=\"color:blue;\" >"+value+"</span>";
                        }
                        return txt;
                    }

                }, {

                    field : 'parentAccount',

                    title : '上级用户',

                }, {

                    field : 'amount',

                    title : '余额'

                }, {

                    field : 'rechargeAmount',

                    title : '充值金额',

                    formatter : function(value, row) {
                        var	txt ="";
                        if(value!=null){
                            txt= "<span  style=\"color:red;\" >"+value+"</span>";
                        }
                        return txt;
                    }

                }, {

                    field : 'rechargeAmountNum',

                    title : '充值次数'

                }, {

                    field : 'withdrawAmount',

                    title : '提现金额'

                }, {

                    field : 'withdrawAmountNum',

                    title : '提现次数'

                }, {

                    field : 'activityAmount',

                    title : '活动礼金'

                }, {

                    field : 'betAmount',

                    title : '投注金额'

                }, {

                    field : 'winningAmount',

                    title : '中奖金额'

                }, {

                    field : 'agentRebateAmount',

                    title : '返点金额'

                }, {

                    field : 'profitAndLoss',

                    title : '损益',

                    formatter : function(value, row) {

                        var betAmount = row.betAmount;//投注金额
                        var winningAmount = row.winningAmount;//中奖金额
                        var agentRebateAmount = row.agentRebateAmount;//返点金额

                        var profitAndLoss = -(betAmount - winningAmount - agentRebateAmount);

                        var	txt ="";
                        if(profitAndLoss!=null){
                            if(profitAndLoss >= 0){
                                txt = "<span  style=\"color:red;\" >" + profitAndLoss.toFixed(2) + "</span>";
                            }else {
                                txt = "<span  style=\"color:green;\" >" + profitAndLoss.toFixed(2) + "</span>";
                            }
                        }
                        return txt;
                    }

                }, {

                    field : 'grossRate',

                    title : '损率',

                    formatter : function(value, row) {

                        var betAmount = row.betAmount;//投注金额
                        var winningAmount = row.winningAmount;//中奖金额
                        var agentRebateAmount = row.agentRebateAmount;//返点金额

                        var profitAndLoss = -(betAmount - winningAmount - agentRebateAmount);//损益

                        var grossRate = 0;
                        if(betAmount > 0){
                            grossRate = profitAndLoss/betAmount;
                        }

                        var	txt ="";
                        if(grossRate!=null){
                            txt= (grossRate * 100).toFixed(2) + "%" ;
                            if(grossRate >= 0){
                                txt = "<span  style=\"color:red;\" >" + txt + "</span>";
                            }else {
                                txt = "<span  style=\"color:green;\" >" + txt + "</span>";
                            }
                        }
                        return txt;
                    }

                }, {

                    field : 'profit',

                    title : '盈利',

                    formatter : function(value, row) {

                        var betAmount = row.betAmount;//投注金额
                        var winningAmount = row.winningAmount;//中奖金额
                        var agentRebateAmount = row.agentRebateAmount;//返点金额
                        var activityAmount = row.activityAmount;//活动金额

                        var profitAndLoss = betAmount - winningAmount - agentRebateAmount;//损益

                        var profit = -(profitAndLoss - activityAmount);

                        var	txt ="";
                        if(profit!=null){
                            if(profit >= 0){
                                txt = "<span  style=\"color:red;\" >" + profit.toFixed(2) + "</span>";
                            }else {
                                txt = "<span  style=\"color:green;\" >" + profit.toFixed(2) + "</span>";
                            }
                        }
                        return txt;
                    }

                }, {

                    field : 'earningsRatio',

                    title : '盈率',

                    formatter : function(value, row) {

                        var betAmount = row.betAmount;//投注金额
                        var winningAmount = row.winningAmount;//中奖金额
                        var agentRebateAmount = row.agentRebateAmount;//返点金额
                        var activityAmount = row.activityAmount;//活动金额

                        var profitAndLoss = betAmount - winningAmount - agentRebateAmount;//损益

                        var profit = -(profitAndLoss - activityAmount);

                        var earningsRatio = 0;
                        if(betAmount > 0){
                            earningsRatio = profit/betAmount;
                        }

                        var	txt ="";
                        if(earningsRatio!=null){
                            txt= (earningsRatio * 100).toFixed(2) + "%" ;
                            if(earningsRatio >= 0){
                                txt = "<span  style=\"color:red;\" >" + txt + "</span>";
                            }else {
                                txt = "<span  style=\"color:green;\" >" + txt + "</span>";
                            }
                        }
                        return txt;
                    }

                }, {

                    field : 'regTime',

                    title : '注册时间'

                }] ],

                onLoadSuccess : function (pageData) {

                    doCountField(grid);

                }

            };

            createGrid('#grid',options);

            $("#search").click(function(){

                $("#grid").datagrid("options").queryParams = getQueryParams();

                reloadGrid("#grid");

            });

        });



        function getQueryParams() {

            var p={};

            $.each($("#form").serializeArray(),function(){

                p[this.name]=this.value;

            });



            return p;

        }


        //初始化
        $(document).ready(function(){



        });

    </script>

</head>

<body>

<div id="grid"></div>

<div id="tb">

    <div>

        <form id="form" action="membershipReport" method="post">

            <table>

                <tr>

                    <td>用户名：</td>

                    <td> <input type="text" size="10" name="account" value="" /></td>

                    <td>上级：</td>

                    <td> <input type="text" size="10" name="parentAccount" value="" /></td>

                    <!--<td>排序：</td>
                    <td>
                        <select id="sorting" name="sorting" style="width: 100px;" >
                            <option value="0">投注递减</option>
                            <option value="1">盈利递减</option>
                            <option value="2">盈利递增</option>
                            <option value="3">盈率递减</option>
                            <option value="4">盈率递增</option>
                            <option value="5">入款递减</option>
                            <option value="6">出款递减</option>
                            <option value="7">返点递减</option>
                            <option value="8">活动递减</option>
                        </select>
                    </td>-->

                    <td>查询时间：</td>

                    <td><input type="text" class="easyui-datetimebox beginTime" size="16" name="startDateStr" />~<input type="text" class="easyui-datetimebox endTime" size="16" name="endDateStr" /></td>

                    <td> <a href="#" plain="true" id="search" class="easyui-linkbutton" icon="icon-search">查询</a></td>

                </tr>

            </table>

        </form>

    </div>

</div>

</body>

</html>