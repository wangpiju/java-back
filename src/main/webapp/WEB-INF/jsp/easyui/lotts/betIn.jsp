<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	$(function() {
		var options = {
			columns : [ [ 
			{
				field : 'account',
				title : '账号'
			},{
				field : 'test',
				title : '是否测试用户',
				formatter : function(value, row) {
					if (value == 0) {
						return "否";
					} else if (value == 1) {
						return "是";
					} else {
						return value;
					}
				}
			},{
				field : 'betId',
				title : '订单编号'
			},{
				field : 'amount',
				title : '游戏金额'
			},{
				field : 'multiples',
				title : '倍数'
			},{
				field : 'win',
				title : '获得金额'
			},{
				field : 'createTime',
				title : '创建时间'
			}] ],
			url : "list?betId=" + "${betId }"
		};
		createGrid('#grid',options);
		createWin('#win');
	});
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
	</div>
	<div id="win">
		<form method="post" style="margin: 20px;">
			<input type="hidden" name="id" />
			<table class="formtable">
				<tr>
					<td class="input-title">account</td>
					<td><input type="text" name="account" /></td>
				</tr>
				<tr>
					<td class="input-title">test</td>
					<td><input type="text" name="test" /></td>
				</tr>
				<tr>
					<td class="input-title">betId</td>
					<td><input type="text" name="betId" /></td>
				</tr>
				<tr>
					<td class="input-title">amount</td>
					<td><input type="text" name="amount" /></td>
				</tr>
				<tr>
					<td class="input-title">multiples</td>
					<td><input type="text" name="multiples" /></td>
				</tr>
				<tr>
					<td class="input-title">win</td>
					<td><input type="text" name="win" /></td>
				</tr>
				<tr>
					<td class="input-title">createTime</td>
					<td><input type="text" name="createTime" /></td>
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