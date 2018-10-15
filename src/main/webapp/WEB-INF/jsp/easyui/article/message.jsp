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
				title : '标题',
				formatter : function(value, row) {
					return encodeHtml(value);
				}
			},{
				field : 'sender',
				title : '发送者'
			},{
				field : 'sendContent',
				title : '发送内容',
				formatter : function(value, row) {
					return encodeHtml(value);
				}
			},{
				field : 'sendTime',
				title : '发送时间'
			},{
				field : 'sendStatus',
				title : '发送状态',
				formatter : function(value, row) {
					if (value == 0) {
						return '已发送';
					} else if (value == 1) {
						return '已取消';
					} else if (value == 2) {
						return '已回复';
					} else if (value == 3) {
						return '已删除';
					} else {
						return value;
					}
				}
			},{
				field : 'rever',
				title : '接收者'
			},{
				field : 'revContent',
				title : '回复内容',
				formatter : function(value, row) {
					return encodeHtml(value);
				}
			},{
				field : 'revTime',
				title : '回复时间'
			},{
				field : 'revStatus',
				title : '回复状态',
				formatter : function(value, row) {
					if (value == 0) {
						return '未读';
					} else if (value == 1) {
						return '已读';
					} else if (value == 2) {
						return '已回复';
					} else if (value == 3) {
						return '已删除';
					} else {
						return value;
					}
				}
			},{
				field : 'sendType',
				title : '发送类型',
				formatter : function(value, row) {
					if (value == 0) {
						return '系统';
					} else if (value == 1) {
						return '用户';
					} else {
						return value;
					}
				}
			},{
				field : 'other',
				title : '操作',
				formatter : function(value, row) {
					var win ="'#win'";
					var url = "'edit'";
					var dat = "'edit?id=" + row.id +"'";
					var txt = '<sjc:auth url="/admin/article/message/cancel"><a href="#" onClick="delTip(\'cancel?id=' + row.id +'\',function(rel){reloadGrid(\'#grid\')},\'您确认要取消吗?\')">取消</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
					txt += '<sjc:auth url="/admin/article/message/delete"><a href="#" onClick="del(\'delete?id=' + row.id +'\',function(rel){reloadGrid(\'#grid\')})">删除</a></sjc:auth>';
					return txt;
				}
			}] ]
		};
		createGrid('#grid',options);
		createWin('#win');
		
		$("#search").click(function(){
			var p={};
			$.each($("#searchForm").serializeArray(),function(){  
	            p[this.name]=this.value;  
	        });
			$("#grid").datagrid("options").queryParams = p;
			reloadGrid("#grid");
		});
	});
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<form id="searchForm" action="list" method="post">
			<table>
		       <tr>
		          <td>标题：</td>
		          <td><input type="text" size="10" name="title" /></td>
		          <td>发送者：</td>
		          <td><input type="text" size="10" name="sender" /></td>
		          <td>接收者：</td>
		          <td><input type="text" size="10" name="rever" /></td>
		          <td> <a href="#" plain="true" id="search" class="easyui-linkbutton" icon="icon-search">查询</a></td>
		          <td> <sjc:auth url="/admin/article/message/add"><a href="#" plain="true" icon="icon-add" class="easyui-linkbutton" onClick="showWin('#win','add')">添加</a></sjc:auth></td>
		          <td> <sjc:auth url="/admin/article/message/delete"><a href="#" plain="true" icon="icon-remove" class="easyui-linkbutton" onClick="delAll('delete','#grid')">删除</a></sjc:auth></td>
		       </tr>
		   </table>
		</form>
	</div>
	<div id="win">
		<form method="post" style="margin: 20px;">
			<table class="formtable">
				<tr>
					<td class="input-title">标题</td>
					<td><input type="text" name="title" /></td>
				</tr>
				<tr>
					<td class="input-title">发送内容</td>
					<td><textarea rows="5" cols="25" name="sendContent"></textarea> </td>
				</tr>
				<tr>
					<td class="input-title">发送方式</td>
					<td>
						<input type="radio" name="type" value="0" />仅用户
						<input type="radio" name="type" value="1" />用户列表
						<input type="radio" name="type" value="2" />用户团队
					</td>
				</tr>
				<tr>
					<td class="input-title">接收者</td>
					<td><input type="text" name="rever" /></td>
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