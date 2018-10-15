<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	$(function() {
		var options = {
				singleSelect:true,
			columns : [ [ {
				field : 'lotteryId',
				title : '彩种'
			}, {
				field : 'ratio',
				title : '最大中投比'
			},{
				field : 'deviation',
				title : '合法误差'
			}, {
				field : 'status',
				title : '状态',
				formatter : function(value, row) {
					if (value==0) {
						return '<span style="color:green;">启用</span>';
					} else {
						return '<span style="color:red;">停用</span>';
					}
				}
			},{
				field : 'closeTime',
				title : '失效时间'
			}, {
				field : 'other',
				title : '操作',
				formatter : function(value, row) {
					var txt ='<sjc:auth url="/admin/lotts/lock/edit"><a onClick="showWin(\'#win\',\'edit\',\'edit?id='+ row.id+'\')"  href="#">编辑</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
					txt += '<sjc:auth url="/admin/lotts/lock/delete"><a href="#" onClick="del(\'delete?id=' + row.id +'\',function(rel){reloadGrid(\'#grid\')})">删除</a></sjc:auth>&nbsp;';
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
			<sjc:auth url="/admin/lotts/lock/add"><a href="#" plain="true" class="easyui-linkbutton" icon="icon-add" onClick="showWin('#win','add',{status:0})">添加</a></sjc:auth>
		</div>
	</div>
	<div id="win">
		<form method="post" style="margin: 20px;" id="form">
			<input type="hidden" name="id" />
			<table class="formtable">
				<tr>
					<td class="input-title">彩票</td>
					<td><input type="text" name="lotteryId" /></td>
				</tr>
				<tr>
					<td class="input-title">状态</td>
					<td><select name="status">
						<option value="0">启用</option>
						<option value="1">禁用</option>
					</select></td>
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
					<td class="input-title">有效时间</td>
					<td><input type="text" name="close" />(分钟)空白不限时</td>
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