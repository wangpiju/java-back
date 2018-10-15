<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
var withdrawApiJson=${withdrawApiJson};
	$(function() {
		var options = {
			columns : [ [ 
			{
				field : 'classKey',
				title : '接口类型'
			},{
				field : 'title',
				title : '名称'
			},{
				field : 'merchantCode',
				title : '商户号'
			},{
				field : 'email',
				title : '邮箱'
			},{
				field : 'apiUrl',
				title : '接口地址'
			},{
				field : 'shopUrl',
				title : '商城地址'
			},{
				field : 'status',
				title : '状态',
				formatter : function(value, row) {
					if (value == 0) {
						return '正常';
					} else if (value == 1) {
						return '禁用';
					} else {
						return value;
					}
				}
			},{
				field : 'autoOperator',
				title : '自动出款操作人'
			},{
				field : 'minAmount',
				title : '最小额度（包含）'
			},{
				field : 'maxAmount',
				title : '最大额度（不包含）'
			},{
				field : 'other',
				title : '操作',
				formatter : function(value, row) {
					var win ="'#win'";
					var url = "'edit'";
					var dat = "'edit?id=" + row.id +"'";
					var txt = '<a href="#" onClick="showWin('+ win +',' +url+ ','+ dat +')">编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;';
					txt += '<a href="#" onClick="del(\'delete?id=' + row.id +'\',function(rel){reloadGrid(\'#grid\')})">删除</a>';
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
			<a href="#" plain="true" icon="icon-add" class="easyui-linkbutton" onClick="showWin('#win','add')">添加</a>
			<a href="#" plain="true" icon="icon-remove" class="easyui-linkbutton" onClick="delAll('delete','#grid')">删除</a>
		</div>
	</div>
	<div id="win">
		<form method="post" style="margin: 20px;">
			<input type="hidden" name="id" />
			<table class="formtable">
				<tr>
					<td class="input-title">接口类型</td>
					<td>
						<select name="classKey">
							<c:forEach items="${withdrawApiMap }" var="a">
								<option value="${a.key }">${a.key }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td class="input-title">名称</td>
					<td><input type="text" name="title" /></td>
				</tr>
				<tr>
					<td class="input-title">商户号</td>
					<td><input type="text" name="merchantCode" /></td>
				</tr>
				<tr>
					<td class="input-title">邮箱</td>
					<td><input type="text" name="email" /></td>
				</tr>
				<tr>
					<td class="input-title">秘钥</td>
					<td><input type="text" name="sign" /></td>
				</tr>
				<tr>
					<td class="input-title">公钥</td>
					<td><input type="text" name="publicKey" /></td>
				</tr>
				<tr>
					<td class="input-title">接口地址</td>
					<td><input type="text" name="apiUrl" /></td>
				</tr>
				<tr>
					<td class="input-title">商城地址</td>
					<td><input type="text" name="shopUrl" /></td>
				</tr>
				<tr>
					<td class="input-title">状态</td>
					<td>
						<select name="status">
							<option value="0">正常</option>
							<option value="1">禁用</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="input-title">自动出款操作人</td>
					<td><input type="text" name="autoOperator" /></td>
				</tr>
				<tr>
					<td class="input-title">最小额度（包含）</td>
					<td><input type="text" name="minAmount" /></td>
				</tr>
				<tr>
					<td class="input-title">最大额度（不包含）</td>
					<td><input type="text" name="maxAmount" /></td>
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