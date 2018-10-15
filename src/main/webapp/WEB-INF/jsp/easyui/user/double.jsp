<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
$(function() {
	var options = {
		url:'',
		columns : [ [ {
			field : 'account',
			title : '账户'
		}, {
			field : 'status',
			title : '状态',
			formatter:function(value,row) {
				if(value == 0) {
					return '仅自己';
				} else if(value == 1) {
					return '整团队';
				} else {
					return '<span style="color:red;">停用</span>';
				}
			}
		}, {
			field : 'other',
			title : '操作',
			formatter : function(value, row) {
				var win ="'#win'";
				var url = "'edit'";
				var dat = "'edit?id=" + row.id +"'";
				var txt = '<sjc:auth url="/admin/userDoubleLogin/edit"><a href="#" onClick="showWin('+ win +',' +url+ ','+ dat +',function(d){showLevelId(d);})">编辑</a></sjc:auth>&nbsp;&nbsp;';
				txt += '<sjc:auth url="/admin/userDoubleLogin/delete"><a href="#" onClick="del(\'delete?id=' + row.id +'\',function(rel){reloadGrid(\'#grid\')})">删除</a></sjc:auth>&nbsp;';
				return txt;
			}
		}] ]
	};
	createGrid('#grid',options);
	createWin('#win');
	$("#search").click(function(){
		$(grid).datagrid("options")['url'] = 'list';
		var p={};
		$.each($("#form").serializeArray(),function(){  
            p[this.name]=this.value;  
        });
		reloadGrid("#grid",p);
	});
});

</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		
		<form id="form" action="list" method="post">
		<div>
			会员：<input type="text" size="6" name="account" />
			状态：<select name="status">
				<option value="">不限</option>
				<option value="0">仅自己</option>
				<option value="1">整团队</option>
				<option value="2">停用</option>
			</select>
			<a href="#" plain="true" id="search" class="easyui-linkbutton" icon="icon-search">查询</a>&nbsp;&nbsp;
			<sjc:auth url="/admin/userDoubleLogin/add"><a href="#" plain="true" icon="icon-add" class="easyui-linkbutton" onClick="showWin('#win','add',{status:0})">添加</a></sjc:auth>
		</div>
		</form>
	</div>
	
	<div id="win">
		<form method="post" style="margin: 20px;">
			<input type="hidden" name="id" />
			<table class="formtable">
				<tr>
					<td class="input-title">用户名</td>
					<td><input type="text" name="account" /></td>
				</tr>
				<tr>
					<td class="input-title">状态</td>
					<td><select name="status">
						<option value="0">仅自己</option>
						<option value="1">整团队</option>
						<option value="2">停用</option>
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