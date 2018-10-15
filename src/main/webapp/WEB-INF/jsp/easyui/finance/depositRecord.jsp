<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<script type="text/javascript">
        var countFields = ['amount'];
        $(function() {
            var options = {
                columns : [ [ {
                    field : 'status',
                    title : '状态',
                    formatter : function(value, row) {
                        if (value == 0) {
                            return '未处理';
                        } else if (value == 1) {
                            return "<span style='color:red;'>拒绝</span>";
                        } else if (value == 2) {
                            return "<span style='color:green;'>完成</span>"
                        } else if (value == 3) {
                            return "已过期"
                        } else if (value == 4) {
                            return "已撤销"
                        } else if (value == 5) {
                            return "正在处理"
                        } else if (value == 6) {
                            return "审核中"
                        } else if (value == 7) {
                            return "审核通过"
                        } else if (value == 8) {
                            return "审核不通过"
                        } else if (value == 99) {
                            return "挂起"
                        } else {
                            return value;
                        }
                    }
                },{
                    field : 'amount',
                    title : '提现金额'
                },{
                    field : 'userMark',
                    title : '用户标识',
                    formatter:function(value,row){
                        if(row.account){
                            if(!value || value == 0)
                                return '正常';
                            else if(value == 1)
                                return '<span style="color:red;">嫌疑</span>';
                            else if(value == 2)
                                return '<span style="color:green;">VIP</span>';
                            else if(value == 3)
                                return '<span style="color:green;">黑名单</span>';
                            else if(value == 4)
                                return '<span style="color:green;">招商经理</span>';
                            else if(value == 5)
                                return '<span style="color:green;">特权代理</span>';
                            else if(value == 6)
                                return '<span style="color:green;">金牌代理</span>';
                            else if(value == 7)
                                return '<span style="color:green;">外部主管</span>';
                            else
                                return value;
                        } else {
                            return '';
                        }
                    }
                }, {
                    field : 'account',
                    title : '提现账户'
                },{
                    field : 'test',
                    title : '用户类型',
                    formatter : function(value, row) {
                        if (value == 0) {
                            return '非测试';
                        } else if (value == 1) {
                            return '测试';
                        } else {
                            return value;
                        }
                    }
                },{
                    field : 'createTime',
                    title : '提现时间',
                    formatter : function(value, row) {
                        var	txt ="";
                        if(value!=null){
                            txt= "<span  style=\"color:black;\" >"+ timestampToTime(value) +"</span>";
                        }
                        return txt;
                    }
                },{
                    field : 'lastTime',
                    title : '最后处理时间',
                    formatter : function(value, row) {
                        var	txt ="";
                        if(value!=null){
                            txt= "<span  style=\"color:black;\" >"+ timestampToTime(value) +"</span>";
                        }
                        return txt;
                    }
                },{
                    field : 'lastOperator',
                    title : '上个操作人员'
                },{
                    field : 'operator',
                    title : '现在操作的人员'
                },{
                    field : 'bankName',
                    title : '提现银行'
                },{
                    field : 'card',
                    title : '提现银行卡号'
                },{
                    field : 'address',
                    title : '提现银行支行地址'
                },{
                    field : 'niceName',
                    title : '提现开户名'
                },{
                    field : 'remark',
                    title : '备注'
                },{
                    field : 'serialNumber',
                    title : '交易号'
                },{
                    field : 'other',
                    title : '操作',
                    formatter : function(value, row) {
                        if (row.status != 0 && row.status != 5 && row.status != 6 && row.status != 7) {
                            return "";
                        }
                        var win1 ="'#win'";
                        var win2 = "'#win2'";
                        var dat = "'edit?id=" + row.id +"'";
                        var txt = "";
                        if (row.status == 0) {//未处理
                            txt += '<sjc:auth url="/admin/finance/deposit/edit"><a href="#" onClick="showWin('+ win1 + ',\'edit?operateType=3\',' + dat +')">审核</a></sjc:auth>';
                        } else if (row.status == 5) {//正在处理
                            txt += '<sjc:auth url="/admin/finance/deposit/edit"><a href="#" onClick="showWin('+ win1 + ',\'edit?operateType=0\','+ dat + ')">拒绝</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
                            txt += '<sjc:auth url="/admin/finance/deposit/edit"><a href="#" onClick="showWin('+ win2 + ',\'edit?operateType=1\','+ dat + ')">完成</a></sjc:auth>';
                        } else if (row.status == 6) {//审核中
                            txt += '<sjc:auth url="/admin/finance/deposit/edit"><a href="#" onClick="showWin('+ win1 + ',\'edit?operateType=4\','+ dat + ')">拒绝</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
                            txt += '<sjc:auth url="/admin/finance/deposit/edit"><a href="#" onClick="showWin('+ win1 + ',\'edit?operateType=5\','+ dat + ')">通过</a></sjc:auth>';
                        } else if (row.status == 7) {//审核通过
                            txt += '<sjc:auth url="/admin/finance/deposit/edit"><a href="#" onClick="showWin('+ win1 + ',\'edit?operateType=0\','+ dat + ')">拒绝</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
                            txt += '<sjc:auth url="/admin/finance/deposit/edit"><a href="#" onClick="showWin('+ win1 + ',\'edit?operateType=2\','+ dat + ')">处理</a></sjc:auth>';
                        }
                        return txt;
                    }
                }] ],
                url : 'list?statusArray=1,2,3,4,8',
                queryParams : getQueryParams()
            };
            createGrid('#grid',options);
            createWin('#win');
            createWin('#win2');


            $("#form").form();

            $("#search").click(function(){
                $("#grid").datagrid("options").queryParams = getQueryParams();
                reloadGrid("#grid");
            });

            excelAddEvent(options, ["提款记录"], "提款记录.xls");
        });


        function getQueryParams() {
            var p={};
            $.each($("#form").serializeArray(),function(){
                p[this.name]=this.value;
            });

            return p;
        }

        var suspend = false;
        var timer = setTimer(15000);

        function refreshTime(t) {
            clearInterval(timer);
            if (t != -1) {
                clearInterval(timer);
                timer = setTimer(t);
            }
        }

        function setTimer(t) {
            var timer = setInterval(function() {
                if (!suspend) {
                    $("#search").click();
                }
            }, t);
            return timer;
        }
	</script>
</head>
<body>
<div id="grid"></div>
<div id="tb">
	<div>
		<form id="form" action="list" method="post">
			<table>
				<tr>
					<td>时间：</td>
					<td><input type="text" class="easyui-datetimebox beginTime" size="20" name="startTime"/>~<input type="text" class="easyui-datetimebox endTime" size="20" name="endTime"/></td>
					<td>提现账户：</td>
					<td><input type="text" size="10" name="account" /></td>
					<td>用户类型：</td>
					<td>
						<select name="test">
							<option value="-1">不限</option>
							<option value="0">非测试</option>
							<option value="1">测试</option>
						</select>
					</td>
					<td>状态：</td>
					<td>
						<select name="status">
							<option value="-1">不限</option>
							<option value="1">拒绝</option>
							<option value="2">完成</option>
							<option value="8">审核不通过</option>
						</select>
					</td>
					<td>
						<select onchange="refreshTime(this.value);">
							<option value="-1">暂停</option>
							<option value="15000" selected="selected">15秒</option>
							<option value="30000">30秒</option>
							<option value="45000">45秒</option>
							<option value="60000">60秒</option>
						</select>
						自动刷新
					</td>
					<td> <a href="#" plain="true" id="search" class="easyui-linkbutton" icon="icon-search">查询</a></td>
					<td><button id="excelExportButton">导出数据</button></td>
				</tr>
				<tr>
					<td colspan="2">当前查询条件下的提现金额总计：<span id="pageDataSum">0</span></td>
				</tr>
			</table>
		</form>
	</div>
</div>
<div id="win">
	<form method="post" style="margin: 20px;" id="form">
		<input type="hidden" name="id" />
		<table class="formtable">
			<tr>
				<td class="input-title">备注</td>
				<td><input type="text" name="remark" /></td>
			</tr>
		</table>
		<div style="text-align: center; padding: 5px;">
			<a href="#" class="btn-save" icon="icon-save" onClick="saveData(this, function(rel){ closeWin('#win','#grid')})">保存</a>
			<a href="#" class="btn-cancel" icon="icon-cancel" onClick="closeWin('#win')">取消</a>
		</div>
	</form>
</div>
<div id="win2">
	<form method="post" style="margin: 20px;" id="form2">
		<input type="hidden" name="id" />
		<table class="formtable">
			<tr>
				<td class="input-title">交易号</td>
				<td><input type="text" name="serialNumber" /></td>
			</tr>
			<tr>
				<td class="input-title">备注</td>
				<td><input type="text" name="remark" /></td>
			</tr>
		</table>
		<div style="text-align: center; padding: 5px;">
			<a href="#" class="btn-save" icon="icon-save" onClick="saveData(this, function(rel){ closeWin('#win2','#grid')})">保存</a>
			<a href="#" class="btn-cancel" icon="icon-cancel" onClick="closeWin('#win2')">取消</a>
		</div>
	</form>
</div>
</body>
</html>