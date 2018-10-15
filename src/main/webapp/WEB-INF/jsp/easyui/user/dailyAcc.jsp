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
				title : 'account'
			},{
				field : 'rate',
				title : 'rate'
			},{
				field : 'validAccountCount',
				title : 'validAccountCount'
			},{
				field : 'lossStatus',
				title : 'lossStatus'
			},{
				field : 'limitAmount',
				title : 'limitAmount'
			},{
				field : 'createTime',
				title : 'createTime'
			},{
				field : 'changeTime',
				title : 'changeTime'
			},{
				field : 'status',
				title : 'status'
			},{
				field : 'other',
				title : '操作',
				formatter : function(value, row) {
					var win ="'#win'";
					var url = "'edit'";
					var dat = "'edit?id=" + row.id +"'";
					var txt = '<a href="#" onClick="showWin('+ win +',' +url+ ','+ dat +')">编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;';
					txt += '<a href="#" onClick="del(\'delete?id=' + row.id +'\',function(rel){reloadGrid(\'#grid\')})">删除</a>';
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
	<div id="tb">
		<div>
			<a href="#" plain="true" icon="icon-add" class="easyui-linkbutton" onClick="showWin('#win','add')">添加</a>
			<a href="#" plain="true" icon="icon-remove" class="easyui-linkbutton" onClick="delAll('delete','#grid')">删除</a>
		</div>
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
					<td class="input-title">rate</td>
					<td><input type="text" name="rate" /></td>
				</tr>
				<tr>
					<td class="input-title">validAccountCount</td>
					<td><input type="text" name="validAccountCount" /></td>
				</tr>
				<tr>
					<td class="input-title">lossStatus</td>
					<td><input type="text" name="lossStatus" /></td>
				</tr>
				<tr>
					<td class="input-title">limitAmount</td>
					<td><input type="text" name="limitAmount" /></td>
				</tr>
				<tr>
					<td class="input-title">createTime</td>
					<td><input type="text" name="createTime" /></td>
				</tr>
				<tr>
					<td class="input-title">changeTime</td>
					<td><input type="text" name="changeTime" /></td>
				</tr>
				<tr>
					<td class="input-title">status</td>
					<td><input type="text" name="status" /></td>
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