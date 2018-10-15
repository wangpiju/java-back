<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
var roles = ${json};
	$(function() {
		var options = {
			columns : [ [ {
				field : 'account',
				title : '账户'
			}, {
				field : 'niceName',
				title : '昵称'
			}, {
				field : 'role',
				title : '角色',
				formatter:function(value,row){
					for(var n in roles){
						var role = roles[n];
						if(role.id == value)
							return role.name;
					}
					return '未知角色:'+ value;
				}
			}, {
				field : 'mac',
				title : 'MAC地址'
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
					var txt = '<sjc:auth url="/admin/manager/edit"><a href="#" onClick="showWin('+ win +',' +url+ ','+ dat +')">编辑</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
					txt += '<sjc:auth url="/admin/manager/delete"><a href="#" onClick="del(\'delete?id=' + row.id +'\',function(rel){reloadGrid(\'#grid\')})">删除</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
					txt += '<sjc:auth url="/admin/userToken/index"><a onClick="opens(this)" href="#" data-href="<c:url value="/admin/userToken/index?account="/>'+ row.account +'">令牌管理</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;'
					txt += '<sjc:auth url="/admin/manager/authKey"><a href="#" onClick="opens(this)" href="#" data-href="<c:url value="/admin/manager/authKey?account="/>'+ row.account +'">GOOGLE令牌</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
					return txt;
				}
			}] ]
		};
		createGrid('#grid',options);
		createWin('#win');
	});
	 function opens(a){
		addTab($(a).text(),$(a).attr("data-href"));
	} 
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<div>
			<sjc:auth url="/admin/manager/add"><a href="#" plain="true" icon="icon-add" class="easyui-linkbutton" onClick="showWin('#win','add',{role:1,status:0})">添加</a></sjc:auth>
			<sjc:auth url="/admin/manager/delete"><a href="#" plain="true" icon="icon-remove" class="easyui-linkbutton" onClick="delAll('delete','#grid')">删除</a></sjc:auth>
		</div>
	</div>
	<div id="win">
		<form method="post" style="margin: 20px;">
			<input type="hidden" name="id" />
			<input type="hidden" name="status" />
			<table class="formtable">
				<tr>
					<td class="input-title">账户</td>
					<td><input type="text" name="account" /></td>
				</tr>
				<tr>
					<td class="input-title">密码</td>
					<td><input type="text" name="password" /></td>
				</tr>
				<tr>
					<td class="input-title">昵称</td>
					<td><input type="text" name="niceName" /></td>
				</tr>
				<tr>
					<td class="input-title">MAC地址</td>
					<td><input type="text" name="mac" /></td>
				</tr>
				<tr>
					<td class="input-title">状态</td>
					<td><select name="status">
						<option value="0">正常</option>
						<option value="1">禁用</option>
					</select></td>
				</tr>
				<tr>
					<td class="input-title">角色</td>
					<td><select name="role">
						<c:forEach items="${roles }" var="a">
						<option value="${a.id }">${a.name }</option>
						</c:forEach>
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