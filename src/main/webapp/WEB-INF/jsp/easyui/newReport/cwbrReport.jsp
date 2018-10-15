<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>

<html xmlns="http://www.w3.org/1999/xhtml">

<head>

    <script type="text/javascript">

        var countFields = [];

        $(function() {

            var options = {

                url:'cwbrReport',

                queryParams : getQueryParams(),

                columns : [ [ {

                    field : 'account',

                    title : '账户',

                    formatter : function(value, row) {
                        var	txt ="";
                        if(value!=null){
                            txt= "<span  style=\"color:blue;\" >"+value+"</span>";
                        }
                        return txt;
                    }

                }, {

                    field : 'parentAccount',

                    title : '上级',

                }, {

                    field : 'amount',

                    title : '余额'

                }, {

                    field : 'accountBalanceZ',

                    title : '本次可提现帐变余额'

                }, {

                    field : 'actualBalanceZ',

                    title : '本次可提现实际余额',

                    formatter : function(value, row) {
                        var	txt ="";
                        if(value!=null){
                            txt= "<span  style=\"color:red;\" >"+value+"</span>";
                        }
                        return txt;
                    }

                }, {

                    field : 'lastRemainAmount',

                    title : '上次提现结余'

                }, {

                    field : 'lastCreateTime',

                    title : '上次成功提现的申请时间'

                }, {

                    field : 'lastRechargeTime',

                    title : '上一次充值成功时间'

                }, {

                    field : 'noWinRunAmount',

                    title : '未中奖流水'

                }, {

                    field : 'winRunAmount',

                    title : '中奖流水'

                }, {

                    field : 'subordinateRebate',

                    title : '下级投注返点'

                }, {

                    field : 'sysWithdrawalPoint',

                    title : '系统撤单返点'

                }, {

                    field : 'cancelRunAward',

                    title : '历史开奖撤销派奖流水'

                }, {

                    field : 'dailyWage',

                    title : '日工资'

                }, {

                    field : 'cycleDividend',

                    title : '周期分红'

                }, {

                    field : 'activityDispatch',

                    title : '活动派发'

                }, {

                    field : 'adminDispatch',

                    title : '管理员派发'

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
                    <td> <a href="#" plain="true" id="search" class="easyui-linkbutton" icon="icon-search">查询</a></td>
                    <td> 功能上线时间：2018-07-16 02:30:00</td>

                </tr>

            </table>

        </form>

    </div>

</div>

</body>

</html>