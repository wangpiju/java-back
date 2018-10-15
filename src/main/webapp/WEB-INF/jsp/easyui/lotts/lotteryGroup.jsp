<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
$(function() {
	var options = {
		columns : [ [ {
			field : 'name',
			title : '名称'
		}, {
			field : 'icon',
			title : '图标名'
		}, {
			field : 'status',
			title : '状态',
			formatter:function(value,row){
				if(value==0)
					return '显示';
				else
					return '<span style="color:red;">隐藏</span>';
			}
		}, {
			field : 'orderId',
			title : '排序'
		},{
			field : 'other',
			title : '操作',
			formatter : function(value, row) {
				var win ="'#win'";
				var url = "'edit'";
				var dat = "'edit?id=" + row.id +"'";
				var txt = '<sjc:auth url="/admin/lotteryGroup/edit"><a href="#" onClick="showWin('+ win +',' +url+ ','+ dat +')">编辑</a></sjc:auth>&nbsp;&nbsp;';
				txt += '<sjc:auth url="/admin/lotteryGroup/delete"><a href="#" onClick="del(\'delete?id=' + row.id +'\',function(rel){reloadGrid(\'#grid\')})">删除</a></sjc:auth>&nbsp;';
				return txt;
			}
		}] ]
	};
	createGrid('#grid',options);
	createWin('#win');
// 	$("#imgDiv").PreviewImage();
});
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<div>
			<sjc:auth url="/admin/lotteryGroup/add"><a href="#" plain="true" icon="icon-add" class="easyui-linkbutton" onClick="showWin('#win','add',{orderId:0,status:0})">添加</a></sjc:auth>
			<sjc:auth url="/admin/lotteryGroup/delete"><a href="#" plain="true" icon="icon-remove" class="easyui-linkbutton" onClick="delAll('delete','#grid')">删除</a></sjc:auth>
		</div>
	</div>
	<div id="win">
		<form method="post" style="margin: 20px;">
			<input type="hidden" name="id" />
			<table class="formtable">
				<tr>
					<td class="input-title">名字</td>
					<td><input type="text" name="name" /></td>
				</tr>
				<tr>
					<td class="input-title">图标名</td>
					<td><input type="text" name="icon" /></td>
				</tr>
				<tr>
					<td class="input-title">状态</td>
					<td><select name="status">
						<option value="0">显示</option>
						<option value="1">隐藏</option>
					</select></td>
				</tr>
				<tr>
					<td class="input-title">排序</td>
					<td><input type="text" name="orderId" /></td>
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