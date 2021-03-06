<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	$(function() {
		var options = {
			idField:'ip',
			columns : [ [ {
				field : 'ip',
				title : 'IP'
			}] ]
		};
		createGrid('#grid',options);
		createWin('#win');
	});
	function finds(){
		var p = { ip: $('#ip').val() }
		reloadGrid('#grid',p);
	}
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<div>
			IP：<input id="ip" type="text" />
			<a href="#" plain="true" class="easyui-linkbutton" icon="icon-search" onClick="finds()">查询</a>
			<br />
			<sjc:auth url="/admin/ipWhite/add"><a href="#" plain="true" class="easyui-linkbutton" icon="icon-add" onClick="showWin('#win','add',{})">添加</a></sjc:auth>
			<sjc:auth url="/admin/ipWhite/delete"><a href="#" plain="true" class="easyui-linkbutton" icon="icon-remove" onClick="delAll('delete','#grid')">删除</a></sjc:auth>
		</div>
	</div>
	
	<div id="win">
		<form method="post" style="margin: 20px;">
			<input type="hidden" name="id" />
			<input type="hidden" name="status" />
			<table class="formtable">
				<tr>
					<td class="input-title">IP</td>
					<td><input type="text" name="ip" /></td>
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