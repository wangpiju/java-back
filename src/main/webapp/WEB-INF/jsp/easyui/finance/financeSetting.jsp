<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
var financeWithdrawJson = ${financeWithdrawJson};
	$(function() {
		var options = {
			columns : [[{
				field : 'depositMaxCount',
				title : '提现每天最多次数'
			},{
				field : 'depositMinMoney',
				title : '提现最低限额'
			},{
				field : 'depositMaxMoney',
				title : '提现最高限额'
			},{
				field : 'depositSplitMaxMoney',
				title : '提现分隔金额'
			},{
				field : 'depositMinBindCardHours',
				title : '提现需要绑卡后小时限制'
			},{
				field : 'rechargeLowerMaxMoney',
				title : '下级充值最高限额'
			},{
				field : 'rechargeLowerNotAudit',
				title : '下级充值免审核额度'
			},{
				field : 'rechargeLowerHours',
				title : '新用户注册被上级充值小时限制'
			},{
				field : 'testUserRechargeStatus',
				title : '测试用户充值设置',
				formatter : function(value, row) {
					if (value == 0) {
						return '关闭';
					} else if (value == 1) {
						return '开启';
					} else {
						return value;
					}
				}
			},{
				field : 'testUserDepositStatus',
				title : '测试用户提现设置',
				formatter : function(value, row) {
					if (value == 0) {
						return '关闭';
					} else if (value == 1) {
						return '开启';
					} else {
						return value;
					}
				}
			},{
				field : 'depositAuto',
				title : '自动出款状态',
				formatter : function(value, row) {
					if (value == 0) {
						return '关闭';
					} else if (value == 1) {
						return '开启';
					} else {
						return value;
					}
				}
			},{
				field : 'other',
				title : '操作',
				formatter : function(value, row) {
					var win ="'#win'";
					var url = "'edit'";
					var dat = "'edit?id=" + row.id +"'";
					var txt = '<sjc:auth url="/admin/finance/financeSetting/edit"><a href="#" onClick="showWin('+ win +',' +url+ ','+ dat +')">编辑</a></sjc:auth>';
					return txt;
				}
			}] ]
		};
		createGrid('#grid',options);
		createWin('#win');
		
		$("#form").form();
	});
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
	</div>
	<div id="win">
		<form method="post" style="margin: 20px;" id="form">
			<input type="hidden" name="id" />
			<input type="hidden" name="depositAutoAmount" value="0"/>
			<table class="formtable">
				<tr>
					<td class="input-title">提现每天最多次数</td>
					<td><input type="text" name="depositMaxCount" /></td>
				</tr>
				<tr>
					<td class="input-title">提现最低限额</td>
					<td><input type="text" name="depositMinMoney" /></td>
				</tr>
				<tr>
					<td class="input-title">提现最高限额</td>
					<td><input type="text" name="depositMaxMoney" /></td>
				</tr>
				<tr>
					<td class="input-title">提现分隔金额</td>
					<td><input type="text" name="depositSplitMaxMoney" /></td>
				</tr>
				<tr>
					<td class="input-title">提现需要绑卡后小时限制</td>
					<td><input type="text" name="depositMinBindCardHours" /></td>
				</tr>
				<tr>
					<td class="input-title">下级充值最高限额</td>
					<td><input type="text" name="rechargeLowerMaxMoney" /></td>
				</tr>
				<tr>
					<td class="input-title">下级充值免审核额度</td>
					<td><input type="text" name="rechargeLowerNotAudit" /></td>
				</tr>
				<tr>
					<td class="input-title">新用户注册被上级充值小时限制</td>
					<td><input type="text" name="rechargeLowerHours" /></td>
				</tr>
				<tr>
					<td class="input-title">测试用户充值设置</td>
					<td>
						<select name="testUserRechargeStatus">
							<option value="0">关闭</option>
							<option value="1">开启</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="input-title">测试用户提现设置</td>
					<td>
						<select name="testUserDepositStatus">
							<option value="0">关闭</option>
							<option value="1">开启</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="input-title">自动出款状态</td>
					<td>
						<select name="depositAuto">
							<option value="0">关闭</option>
							<option value="1">开启</option>
						</select>
					</td>
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