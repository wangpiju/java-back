<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
var countFields = ['amount'];
	$(function() {
		var options = {
			columns : [ [{
				field : 'id',
				title : '商家订单号'
			}, {
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
						return "审核中";
					} else {
						return value;
					}
				}
			},{
				field : 'amount',
				title : '充值金额'
			},{
				field : 'poundage',
				title : '手续费'
			},{
				field : 'realAmount',
				title : '实际上分金额'
			},{
				field : 'rechargeType',
				title : '充值类型',
				formatter : function(value, row) {
					if (value == 0) {
						return '银行充值';
					} else if (value == 1) {
						return '第三方充值';
					} else if (value == 2) {
						return '现金充值';
					} else {
						return value;
					}
				}
			},{
				field : 'card',
				title : '卡号'
			},{
				field : 'niceName',
				title : '昵称'
			},{
				field : 'checkCode',
				title : '附言'
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
				title : '充值账户'
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
				field : 'bankName',
				title : '充值银行卡'
			},{
				field : 'createTime',
				title : '充值时间'
			},{
				field : 'lastTime',
				title : '最后处理时间'
			},{
				field : 'operator',
				title : '操作管理员'
			},{
				field : 'receiveBankName',
				title : '收款银行'
			},{
				field : 'receiveCard',
				title : '收款银行卡号'
			},{
				field : 'receiveAddress',
				title : '收款银行支行地址'
			},{
				field : 'receiveNiceName',
				title : '收款银行开户名'
			},{
				field : 'remark',
				title : '备注'
			},{
				field : 'serialNumber',
				title : '银行交易号'
			},{
				field : 'other',
				title : '操作',
				formatter : function(value, row) {
					if (row.status != 0 && row.status != 3) {
						return "";
					}
					var win ="'#win'";
					var win2 = "'#win2'";
					var url = "'edit?operateType=0'";
					var url2 = "'edit?operateType=1'";
					var dat = "'edit?id=" + row.id +"'";
					var txt = '<sjc:auth url="/admin/finance/recharge/edit"><a href="#" onClick="showWin('+ win +',' +url+ ','+ dat +')">拒绝</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
					txt += '<sjc:auth url="/admin/finance/recharge/edit"><a href="#" onClick="showWin('+ win2 +',' +url2+ ','+ dat +')">完成</a></sjc:auth>';
					return txt;
				}
			}] ],
			url : 'list?statusArray=1,2,5,6',
			queryParams : getQueryParams(),
			onLoadSuccess:function (pageData) {
// 				gridOnLoadSuccess(grid, pageData);
				$("#pageDataSum").text(pageData.obj.amountSum);
				$("#poundageSum").text(pageData.obj.poundageSum);
				$("#realAmountSum").text(pageData.obj.amountSum - pageData.obj.poundageSum);
			}
		};
		createGrid('#grid',options);
		createWin('#win');
		createWin('#win2');
		
		
		$("#form").form();
		
		$("#search").click(function(){
			$("#grid").datagrid("options").queryParams = getQueryParams();
			reloadGrid("#grid");
		});
		
		excelAddEvent(options, ["充值记录"], "充值记录.xls");
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
			          <td>充值账户：</td>
			          <td><input type="text" size="10" name="account" /></td>
			          <td>附言 ：</td>
			          <td><input type="text" size="10" name="checkCode" /></td>
			          <td>充值类型：</td>
			          <td>
			          	<select name="rechargeType">
			          		<option value="-1">不限</option>
			                <option value="1">第三方充值</option>
							<option value="0">银行充值</option>
							<option value="2">现金充值</option>
				        </select>
			          </td>
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
							<option value="2" selected="selected">完成</option>
							<option value="6">审核中</option>
				        </select>
			          </td>
				      <td>是否操作员：</td>
			          <td>
			          	<select name="operatorType">
			          		<option value="0" selected="selected">不限</option>
							<option value="1">是</option>
							<option value="2">否</option>
				        </select>
			          </td>
			          <td>收款银行：</td>
			          <td><input type="text" name="receiveBankName" /></td>
			          <td>收款银行卡号：</td>
			          <td><input type="text" name="receiveCard" /></td>
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
			       	<td colspan="6">当前查询条件下的充值金额总计：<span id="pageDataSum">0</span>
			       		&nbsp;&nbsp;&nbsp;&nbsp;手续费：<span id="poundageSum">0</span>
			       		&nbsp;&nbsp;&nbsp;&nbsp;实际上分：<span id="realAmountSum">0</span>
			       	</td>
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