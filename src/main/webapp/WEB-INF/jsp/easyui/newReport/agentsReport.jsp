<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>

<html xmlns="http://www.w3.org/1999/xhtml">

<head>

    <script type="text/javascript">

        var countFields = ['regCount','betPerCount','firstChargeCount','teamAmount','betAmount','winningAmount','activityAmount','teamRebateAmount','rechargeAmount','withdrawAmount','profit'];

        $(function() {

            setWebDefaultTime_Z();

            if('${begin}') {

                $('.beginTime').datebox("setValue", '${begin}');

            }

            if('${end}') {

                $('.endTime').datebox("setValue", '${end}');

            }

            var options = {

                url:'agentsReport',

                queryParams : getQueryParams(),

                columns : [ [ {

                    field : 'account',

                    title : '代理账户',

                    formatter : function(value, row) {
                        var	txt ="";
                        if(value!=null){
                            txt= "<span  style=\"color:blue;\" >"+value+"</span>";
                        }
                        return txt;
                    }

                }, {

                    field : 'regCount',

                    title : '注册人数',

                }, {

                    field : 'betPerCount',

                    title : '投注人数'

                }, {

                    field : 'firstChargeCount',

                    title : '首充人数'

                }, {

                    field : 'teamRechargeCount',

                    title : '充值人数'

                }, {

                    field : 'lowerCount',

                    title : '下级人数'

                }, {

                    field : 'teamCount',

                    title : '团队人数'

                }, {

                    field : 'teamAmount',

                    title : '团队余额'

                }, {

                    field : 'betAmount',

                    title : '投注金额'

                }, {

                    field : 'winningAmount',

                    title : '中奖金额'

                }, {

                    field : 'activityAmount',

                    title : '活动礼金'

                }, {

                    field : 'dailyAmount',

                    title : '日工资'

                }, {

                    field : 'dividendAmount',

                    title : '周期分红'

                }, {

                    field : 'rebateAmountL',

                    title : '团队返点'

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

                    field : 'withdrawAmount',

                    title : '提现金额'

                }, {

                    field : 'profit',

                    title : '团队盈利',

                    formatter : function(value, row) {
                        var	txt ="";
                        if(value!=null){
                            if(value >= 0){
                                txt = "<span  style=\"color:red;\" >" + value + "</span>";
                            }else {
                                txt = "<span  style=\"color:green;\" >" + value + "</span>";
                            }
                        }
                        return txt;
                    }

                }, {

                    field : 'rebateAmount',

                    title : '代理返点'

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

        <form id="form" action="agentsReport" method="post">

            <table>

                <tr>

                    <td>用户名：</td>

                    <td> <input type="text" size="10" name="account" value="" /></td>

                    <td>查询时间：</td>

                    <td><input type="text" class="easyui-datebox beginTime" size="16" name="startDateStr" />~<input type="text" class="easyui-datebox endTime" size="16" name="endDateStr" /></td>

                    <td>排序：</td>
                    <td>
                        <select id="sorting" name="sorting" style="width: 150px;" >
                            <option value="0">首充人数递减</option>
                            <option value="1">充值人数递减</option>
                            <option value="2">投注人数递减</option>
                            <option value="3">注册人数递减</option>
                            <option value="4">下级人数递减</option>
                            <option value="5">活动礼金递减</option>
                            <option value="6">投注金额递减</option>
                            <option value="7">中奖金额递减</option>
                            <option value="8">充值金额递减</option>
                            <option value="9">提现金额递减</option>
                            <option value="10">团队盈利递减</option>
                            <option value="11">团队返点递减</option>
                            <option value="12">代理返点递减</option>
                            <option value="13">团队余额递减</option>
                        </select>
                    </td>

                    <td> <a href="#" plain="true" id="search" class="easyui-linkbutton" icon="icon-search">查询</a></td>

                </tr>

            </table>

        </form>

    </div>

</div>

</body>

</html>