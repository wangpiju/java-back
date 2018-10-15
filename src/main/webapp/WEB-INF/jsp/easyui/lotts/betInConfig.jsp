<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	$(function() {
		var options = {
			columns : [ [ 
			{
				field : 'status',
				title : '开关配置',
				formatter : function(value, row) {
					if (value == 0) {
						return "开启";
					} else if (value == 1) {
						return "关闭";
					} else {
						return value;
					}
				}
			},{
				field : 'amountMin',
				title : '游戏最小额度'
			},{
				field : 'amountMax',
				title : '游戏最大额度'
			},{
				field : 'priceDefaultMin',
				title : '默认最小倍数'
			},{
				field : 'priceDefaultMax',
				title : '默认最大倍数'
			},{
				field : 'totalAmount',
				title : '累计额度'
			},{
				field : 'gameCountMax',
				title : '游戏最多次数'
			},{
				field : 'gameSecondMax',
				title : '游戏倒计时秒数'
			},{
				field : 'ruleFirstCount',
				title : '首玩次数'
			},{
				field : 'other',
				title : '操作',
				formatter : function(value, row) {
					var win ="'#win'";
					var url = "'edit'";
					var dat = "'edit?id=" + row.id +"'";
					var txt = '<sjc:auth url="/admin/lotts/betInConfig/edit"><a href="#" onClick="showWin('+ win +',' +url+ ','+ dat +')">编辑</a></sjc:auth>';
					return txt;
				}
			}] ]
		};
		createGrid('#grid',options);
		createWin('#win');
	});
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="win">
		<form method="post" style="margin: 20px;">
			<input type="hidden" name="id" />
			<table class="formtable">
				<tr>
					<td class="input-title">开关配置</td>
					<td>
						<select name="status">
							<option value="0">开启</option>
							<option value="1">关闭</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="input-title">游戏最小额度</td>
					<td><input type="text" name="amountMin" /></td>
				</tr>
				<tr>
					<td class="input-title">游戏最大额度</td>
					<td><input type="text" name="amountMax" /></td>
				</tr>
				<tr>
					<td class="input-title">默认最小倍数</td>
					<td><input type="text" name="priceDefaultMin" /></td>
				</tr>
				<tr>
					<td class="input-title">默认最大倍数</td>
					<td><input type="text" name="priceDefaultMax" /></td>
				</tr>
				<tr>
					<td class="input-title">累计额度</td>
					<td><input type="text" name="totalAmount" /></td>
				</tr>
				<tr>
					<td class="input-title">游戏最多次数</td>
					<td><input type="text" name="gameCountMax" /></td>
				</tr>
				<tr>
					<td class="input-title">游戏倒计时秒数</td>
					<td><input type="text" name="gameSecondMax" /></td>
				</tr>
				<tr>
					<td class="input-title">首玩次数</td>
					<td><input type="text" name="ruleFirstCount" /></td>
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