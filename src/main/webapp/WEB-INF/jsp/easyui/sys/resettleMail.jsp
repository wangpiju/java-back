<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	$(function() {
		var options = {
			columns : [ [ 
			{
				field : 'title',
				title : '配置标题'
			},{
				field : 'type',
				title : '类型',
				formatter : function(value, row) {
					if (value == 0) {
						return "重新派奖";
					} else if (value == 1) {
						return "投注";
					} else if (value == 2) {
						return "充值未到账";
					} else if (value == 3) {
						return "提现未到账";
					}
				}
			},{
				field : 'sendAddress',
				title : '发送邮箱'
			},{
				field : 'address',
				title : '接收邮箱'
			},{
				hidden:true,
				field : 'host',
				title : 'SMTP服务器'
			},{
				hidden:true,
				field : 'user',
				title : '用户名'
			},{
				hidden:true,
				field : 'password',
				title : '密码'
			},{
				field : 'lotteryId',
				title : '彩种ID'
			},{
				field : 'status',
				title : '状态',
				formatter : function(value, row) {
					if (value == 0) {
						return "启用";
					} else if (value == 1) {
						return "禁用";
					}
				}
			},{
				hidden:true,
				field : 'remark',
				title : '备注'
			},{
				field : 'other',
				title : '操作',
				formatter : function(value, row) {
					var win ="'#win'";
					var url = "'edit'";
					var dat = "'edit?id=" + row.id +"'";
					var txt = '<sjc:auth url="/admin/sys/resettleMail/edit"><a href="#" onClick="showWin('+ win +',' +url+ ','+ dat +')">编辑</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
					txt += '<sjc:auth url="/admin/sys/resettleMail/delete"><a href="#" onClick="del(\'delete?id=' + row.id +'\',function(rel){reloadGrid(\'#grid\')})">删除</a></sjc:auth>';
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
			<sjc:auth url="/admin/sys/resettleMail/add"><a href="#" plain="true" icon="icon-add" class="easyui-linkbutton" onClick="showWin('#win','add')">添加</a></sjc:auth>
			<sjc:auth url="/admin/sys/resettleMail/delete"><a href="#" plain="true" icon="icon-remove" class="easyui-linkbutton" onClick="delAll('delete','#grid')">删除</a></sjc:auth>
		</div>
	</div>
	<div id="win">
		<form method="post" style="margin: 20px;">
			<input type="hidden" name="id" />
			<table class="formtable">
				<tr>
					<td class="input-title">配置标题</td>
					<td><input type="text" name="title" /></td>
				</tr>
				<tr>
					<td class="input-title">类型</td>
					<td>
						<select name="type">
							<option value="0">重新派奖</option>
							<option value="1">投注</option>
							<option value="2">充值未到账</option>
							<option value="3">提现未到账</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="input-title">发送邮箱</td>
					<td><input type="text" name="sendAddress" /></td>
				</tr>
				<tr>
					<td class="input-title">接收邮箱</td>
					<td><input type="text" name="address" /></td>
				</tr>
				<tr>
					<td class="input-title">SMTP服务器</td>
					<td><input type="text"  name="host"/>(例如:smtp.163.com)</td>
				</tr>
				<tr>
					<td class="input-title">用户名</td>
					<td><input type="text" name="user" /></td>
				</tr>
				<tr>
					<td class="input-title">密码</td>
					<td><input type="password" name="password" /></td>
				</tr>
				<td class="input-title">彩种ID</td>
					<td><select name="lotteryId">
						<c:forEach items="${lottery}" var="a">
						<option value="${a.id }">${a.title }</option>
						</c:forEach>
					</select></td>
				<tr>
					<td class="input-title">状态</td>
					<td>
						<select name="status">
							<option value="0">启用</option>
							<option value="1">禁用</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="input-title">备注</td>
					<td><textarea cols="50" rows="4" name="remark"></textarea></td>
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