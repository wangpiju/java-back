<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
$(function() {
	var options = {
		pagination:false,
		url:'list',
		columns : [ [ {
			field : 'id',
			title : '编号'
		},{
			field : 'name',
			title : '名字'
		},{
			field : 'status',
			title : '状态',
			formatter:function(value,row) {
				if(value == 0) {
					return '<span style="color:green;">正常</span>';
				} else {
					return '<span style="color:red;">禁用</span>';
				}
			}
		},{
			field : 'other',
			title : '操作',
			formatter : function(value, row) {
				var win ="'#win'";
				var url = "'edit'";
				var dat = "'edit?id=" + row.id +"'";
				var txt = '<sjc:auth url="/admin/privateRatioRule/edit"><a href="#" onClick="showWin('+ win +',' +url+ ','+ dat +')">修改</a></sjc:auth>&nbsp;&nbsp;';
				txt += '<sjc:auth url="/admin/privateRatioRule/delete"><a href="#" onClick="del(\'delete?id=' + row.id +'\',function(rel){reloadGrid(\'#grid\')})">删除</a></sjc:auth>&nbsp;&nbsp;';
				txt += '<sjc:auth url="/admin/privateRatioRuleDetails/index"><a href="#" onClick="showDetails(\'' + row.name +'\',\'${url}?id='+ row.id +'\')">查看详情</a></sjc:auth>&nbsp;&nbsp;';
				return txt;
			}
		}] ]
	};
	createGrid('#grid',options);
	createWin("#win");
});

function showDetails(title,url){
	addTab(title + " - 详情",url);
}

</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<div>
			<sjc:auth url="/admin/privateRatioRule/add"><a href="#" plain="true" icon="icon-add" class="easyui-linkbutton" onClick="showWin('#win','add')">添加</a></sjc:auth>
			<sjc:auth url="/admin/privateRatioRule/delete"><a href="#" plain="true" icon="icon-remove" class="easyui-linkbutton" onClick="delAll('delete','#grid')">删除</a></sjc:auth>
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
					<td class="input-title">状态</td>
					<td><select name="status">
					    <option value="0">正常</option>
					    <option value="1">禁用</option>
                    </select></td>
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