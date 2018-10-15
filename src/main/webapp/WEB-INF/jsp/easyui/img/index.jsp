<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
$(function() {
	var options = {
		columns : [ [ {
			field : 'title',
			title : '标题'
		}, {
			field : 'img',
			title : '图片'
		}, {
			field : 'link',
			title : '链接'
		}, {
			field : 'status',
			title : '状态',
			formatter:function(value,row){
				if(value==0)
					return '全部显示';
				else if(value ==1)
					return "仅网页";
				else if(value == 2)
					return "仅手机";
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
				var txt = '<sjc:auth url="/admin/img/edit"><a href="#" onClick="showWin('+ win +',' +url+ ','+ dat +')">编辑</a></sjc:auth>&nbsp;&nbsp;';
				txt += '<sjc:auth url="/admin/img/delete"><a href="#" onClick="del(\'delete?id=' + row.id +'\',function(rel){reloadGrid(\'#grid\')})">删除</a></sjc:auth>&nbsp;';
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
			<sjc:auth url="/admin/img/add"><a href="#" plain="true" icon="icon-add" class="easyui-linkbutton" onClick="showWin('#win','add',{orderId:0,status:0})">添加</a></sjc:auth>
			<sjc:auth url="/admin/img/delete"><a href="#" plain="true" icon="icon-remove" class="easyui-linkbutton" onClick="delAll('delete','#grid')">删除</a></sjc:auth>
		</div>
	</div>
	<div id="win">
		<form method="post" style="margin: 20px;" enctype="multipart/form-data">
			<input type="hidden" name="id" />
			<table class="formtable">
				<tr>
					<td class="input-title">标题</td>
					<td><input type="text" name="title" /></td>
				</tr>
				<tr>
					<td class="input-title">链接</td>
					<td><input type="text" name="link" /></td>
				</tr>
				<tr>
					<td class="input-title">图片</td>
					<td><input type="file" name="file" /></td>
				</tr>
				<tr>
					<td class="input-title">状态</td>
					<td><select name="status">
						<option value="0">全部显示</option>
						<option value="1">仅网页</option>
						<option value="2">仅手机</option>
						<option value="3">隐藏</option>
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