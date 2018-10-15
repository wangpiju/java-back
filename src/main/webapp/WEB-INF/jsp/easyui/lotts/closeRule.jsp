<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
$(function() {
	var options = {
		singleSelect:true,
		toolbar:'#tb',
		queryParams:{lotteryId:'${lott.id}'},
		columns : [ [ {
			field : 'startTime',
			title : '开始时间'
		}, {
			field : 'endTime',
			title : '结束时间'
		}, {
			field : 'status',
			title : '状态',
			formatter:function(value,row){
				if(value==0)
					return '正常';
				else
					return '<span style="color:red;">禁用</span>';
			}
		},{
			field : 'other',
			title : '操作',
			formatter : function(value, row) {
				var win ="'#win'";
				var url = "'edit'";
				var dat = "'edit?id=" + row.id +"'";
				var txt = '&nbsp;&nbsp;&nbsp;&nbsp;<sjc:auth url="/admin/lotteryCloseRule/edit"><a href="#" onClick="showWin('+ win +',' +url+ ','+ dat +')">编辑</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
				txt += '<sjc:auth url="/admin/lotteryCloseRule/delete"><a href="#" onClick="del(\'delete?id=' + row.id +'\',function(rel){reloadGrid(\'#grid\')})">删除</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
				return txt;
			}
		} ] ]
	};
	createGrid('#grid',options);
	createWin('#win',{width:400});
});
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<sjc:auth url="/admin/lotteryCloseRule/add"><a href="#" class="easyui-linkbutton" plain="true" icon="icon-add" onClick="showWin('#win','add',{status:0,lotteryId:'${lott.id}'})">添加</a></sjc:auth>
	</div>
	<div id="win">
		<form method="post" style="margin: 20px;">
			<input name="id" type="hidden" />
			<input name="lotteryId" type="hidden" value="${lott.id }" />
			<table class="formtable">
				<tr>
					<td class="input-title">彩票</td>
					<td>${lott.title }</td>
				</tr>
				<tr>
					<td class="input-title">开始时间</td>
					<td><input type="text" class='easyui-datetimebox' name="startTime" /></td>
				</tr>
				<tr>
					<td class="input-title">结束时间</td>
					<td><input type="text" class='easyui-datetimebox' name="endTime" /></td>
				</tr>
				<tr>
					<td class="input-title">状态</td>
					<td><select class="easyui-combobox" name="status">
						<option value="0">正常</option>
						<option value="1">禁用</option>
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