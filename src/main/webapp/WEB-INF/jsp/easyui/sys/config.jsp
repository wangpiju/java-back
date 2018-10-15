<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	$(function() {
		var options = {
			columns : [ [ {
				field : 'id',
				title : '键'
			}, {
				field : 'val',
				title : '值'
			}, {
				field : 'remark',
				title : '描述'
			},{
				field : 'other',
				title : '操作',
				formatter : function(value, row) {
					var win ="'#win'";
					var url = "'edit'";
					var dat = "'edit?id=" + row.id +"'";
					var txt = '<sjc:auth url="/admin/sysConfig/edit"><a href="#" onClick="showWin('+ win +',' +url+ ','+ dat +')">编辑</a></sjc:auth>&nbsp;&nbsp;';
					txt += '<sjc:auth url="/admin/sysConfig/delete"><a href="#" onClick="del(\'delete?id=' + row.id +'\',function(rel){reloadGrid(\'#grid\')})">删除</a></sjc:auth>&nbsp;';
					return txt;
				}
			}] ]
		};
		createGrid('#grid',options);
		createWin('#win');
	});
// 	function finds(){
// 		var p = {
// 				begin: $('#begin').datebox('getValue'),
// 				end: $('#end').datebox('getValue'),
// 				lever: $('#lever').val(),
// 				clazz: $('#clazz').val(),
// 				method:$('#method').val(),
// 				message:$('#message').val()
// 		}
// 		reloadGrid('#grid',p);
// 	}
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<div>
<!-- 			等级：<input id="lever" type="text" size="4" /> -->
<!-- 			类：<input id="clazz" type="text" /> -->
<!-- 			方法：<input id="method" type="text" size="4" /> -->
<!-- 			内容：<input id="message" type="text" /> -->
<!-- 			时间：<input id="begin" class="easyui-datebox" size="8" />~<input id="end" class="easyui-datebox" size="8" /> -->
<!-- 			<a href="#" plain="true" class="easyui-linkbutton" icon="icon-search" onClick="finds()">查询</a> -->
			
<!-- 			<br /> -->
			<sjc:auth url="/admin/sysConfig/add"><a href="#" plain="true" class="easyui-linkbutton" icon="icon-add" onClick="showWin('#win','add')">添加</a></sjc:auth>
			<sjc:auth url="/admin/sysConfig/delete"><a href="#" plain="true" class="easyui-linkbutton" icon="icon-remove" onClick="delAll('delete','#grid')">删除</a></sjc:auth>
		</div>
	</div>
	<div id="win">
		<form method="post" style="margin: 20px;">
			<table class="formtable">
				<tr>
					<td class="input-title">键</td>
					<td><input type="text" name="id" /></td>
				</tr>
				<tr>
					<td class="input-title">值</td>
					<td><input type="text" name="val" /></td>
				</tr>
				<tr>
					<td class="input-title">描述</td>
					<td><input type="text" name="remark" /></td>
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