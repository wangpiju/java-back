<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <script type="text/javascript">

        $(function() {

            setWebDefaultTime_Z();

            if('${begin}') {

                $('.beginTime').datebox("setValue", '${begin}');

            }

            if('${end}') {

                $('.endTime').datebox("setValue", '${end}');

            }

            var options = {

                columns : [ [ {

                    field : 'account',

                    title : '账户',
                    formatter : function(value, row) {
                        var	txt ="";
                        if(value!=null){
                            txt= "<span  style=\"color:blue;\" >" + value + "</span>";
                        }
                        return txt;
                    }

                }/*, {

                    field : 'parentAccount',

                    title : '上级'

                }*/, {

                    field : 'lotteryName',

                    title : '彩种'

                }, {

                    field : 'reportDate',

                    title : '计算日期'

                }, {

                    field : 'distributionAmount',

                    title : '派发金额'

                }, {

                    field : 'actualSalesVolume',

                    title : '团队销量（元）'

                }, {

                    field : 'actualActiveNumber',

                    title : '活跃人数'

                }, {

                    field : 'programName',

                    title : '方案名称'

                }, {

                    field : 'salesVolume',

                    title : '方案团队销量（元）'

                }, {

                    field : 'proportion',

                    title : '方案日工资比例（%）'

                }, {

                    field : 'activeNumber',

                    title : '方案活跃人数'

                }/*, {

                    field : 'cycle',

                    title : '方案计算周期'

                }*/, {

                    field : 'status',

                    title : '状态',
                    formatter : function(value, row) {
                        if (value == 1) {
                            var	txt ="";
                            if(value!=null){
                                txt= "<span  style=\"color:blue;\" >已派发</span>";
                            }
                            return txt;
                        }else if (value == 0) {
                            var	txt ="";
                            if(value!=null){
                                txt= "<span  style=\"color:red;\" >待处理</span>";
                            }
                            return txt;
                        } else if (value == 2) {
                            return '不予派发';
                        } else {
                            return value;
                        }
                    }

                }, {

                    field : 'createTime',

                    title : '创建时间',
                    formatter : function(value, row) {
                        var	txt ="";
                        if(value!=null){
                            txt= "<span  style=\"color:black;\" >"+ timestampToTime(value) +"</span>";
                        }
                        return txt;
                    }

                }, {

                    field : 'modifyTime',

                    title : '修改时间',
                    formatter : function(value, row) {
                        var	txt ="";
                        if(value!=null){
                            txt= "<span  style=\"color:black;\" >"+ timestampToTime(value) +"</span>";
                        }
                        return txt;
                    }

                }, {

                    field : 'operator',

                    title : '操作员'

                }, {

                    field : 'remarks',

                    title : '备注'

                },{

                    field : 'other',

                    title : '操作',

                    formatter : function(value, row) {

                        var win ="'#win'";

                        var url = "'edit'";

                        var dat = "'edit?id=" + row.id +"'";

                        var txt = '';

                        if(row.status != 1 && row.status != 2 ) {
                            txt = '<sjc:auth url="/admin/userAgents/dailyLotteryMg/edit"><a href="#" onClick="showWin(' + win + ',' + url + ',' + dat + ')">编辑</a></sjc:auth>&nbsp;&nbsp;';
                        }

                        return txt;

                    }

                }] ],
                queryParams : getQueryParams()
            };

            createGrid('#grid',options);
            createWin('#win');


            $("#search").click(function(){
                $("#grid").datagrid("options").queryParams = getQueryParams();
                reloadGrid("#grid");
            });


        });

        function getQueryParams() {
            var p={};
            $.each($("#queryForm").serializeArray(),function(){
                p[this.name]=this.value;
            });
            return p;
        }

    </script>

</head>

<body>

<div id="grid"></div>
<div id="tb">
    <form id="queryForm" action="list" method="post">
        <table>
            <tr>
                <td>账户：</td>
                <td><input type="text" size="10" name="q_account" /></td>
                <td>方案名称：</td>
                <td><input type="text" size="10" name="q_programName" /></td>
                <td>状态：</td>
                <td>
                    <select name="q_status">
                        <option value="">全部</option>
                        <option value="0">待处理</option>
                        <option value="1">已派发</option>
                        <option value="2">不予派发</option>
                    </select>
                </td>

                <td>计算日期：</td>
                <td><input type="text" class="easyui-datebox beginTime" size="16" name="q_begin" />~<input type="text" class="easyui-datebox endTime" size="16" name="q_end" /></td>

                <td>修改时间：</td>
                <td><input type="text" class="easyui-datetimebox" size="16" name="q_startTimeStr" />~<input type="text" class="easyui-datetimebox" size="16" name="q_endTimeStr" /></td>

                <td><a href="#" plain="true" id="search" class="easyui-linkbutton" icon="icon-search">查询</a></td>
            </tr>
        </table>
    </form>
    <div id="win">

        <form method="post" style="margin: 20px;" method="post">

            <input type="hidden" name="id" />
            <input type="hidden" name="programId" />
            <input type="hidden" name="distributionAmount" />

            <table class="formtable">

                <tr>

                    <td class="input-title">账户</td>

                    <td><input type="text" name="account" /></td>

                </tr>

                <tr>

                    <td class="input-title">日期</td>

                    <td><input type="text" name="reportDate" /></td>

                </tr>

                <tr>

                    <td class="input-title">状态</td>

                    <td><select name="status">
                        <option value="0">待处理</option>
                        <option value="1">派发</option>
                        <option value="2">不予派发</option>
                    </select></td>

                </tr>

                <tr>

                    <td class="input-title">备注</td>

                    <td><input type="text" name="remarks" /></td>

                </tr>

            </table>

            <div style="text-align: center; padding: 5px;">

                <a href="#" class="btn-save" icon="icon-save" onClick="saveData(this, function(rel){ closeWin('#win','#grid')})">保存</a>

                <a href="#" class="btn-cancel" icon="icon-cancel" onClick="closeWin('#win')">取消</a>

            </div>

        </form>
    </div>
</body>

</html>