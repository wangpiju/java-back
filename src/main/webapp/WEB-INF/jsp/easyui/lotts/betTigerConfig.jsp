<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	$(function() {
		var options = {
			columns : [ [ 
			{
				field : 'status',
				title : '状态',
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
				field : 'ratio',
				title : '最大中投比'
			},{
				field : 'deviation',
				title : '合法误差'
			},{
				field : 'winAmount',
				title : '中奖金额'
			},{
				field : 'betAmount',
				title : '投注金额'
			},{
				field : 'other',
				title : '操作',
				formatter : function(value, row) {
					var win ="'#win'";
					var url = "'edit'";
					var dat = "'edit?id=" + row.id +"'";
					var txt = '<a href="#" onClick="showWin('+ win +',' +url+ ','+ dat +')">编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;';
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
					<td class="input-title">状态</td>
					<td>
						<select name="status">
							<option value="0">开启</option>
							<option value="1">关闭</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="input-title">最大中投比</td>
					<td><input type="text" name="ratio" /></td>
				</tr>
				<tr>
					<td class="input-title">合法误差</td>
					<td><input type="text" name="deviation" /></td>
				</tr>
				<tr>
					<td class="input-title">中奖金额</td>
					<td><input type="text" name="winAmount" /></td>
				</tr>
				<tr>
					<td class="input-title">投注金额</td>
					<td><input type="text" name="betAmount" /></td>
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