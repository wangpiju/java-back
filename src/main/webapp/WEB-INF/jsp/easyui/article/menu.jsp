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
			},{
				field : 'position',
				title : '位置',
				formatter : function(value, row) {
					if (value==0) {
						return '底部';
					} else {
						return '顶部';
					}
				}
			},{
				field : 'status',
				title : '状态',
				formatter : function(value, row) {
					if (value==0) {
						return '正常';
					} else {
						return '禁用';
					}
				}
			},{
				field : 'orderId',
				title : '排序'
			},{
				field : 'url',
				title : '链接地址'
			},{
				field : 'other',
				title : '操作',
				formatter : function(value, row) {
					var win ="'#win'";
					var url = "'edit'";
					var dat = "'edit?id=" + row.id +"'";
					var txt = '<sjc:auth url="/admin/article/menu/edit"><a href="#" onClick="showWin('+ win +',' +url+ ','+ dat +')">编辑</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
					txt += '<sjc:auth url="/admin/article/menu/delete"><a href="#" onClick="del(\'delete?id=' + row.id +'\',function(rel){reloadGrid(\'#grid\')})">删除</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
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
		          <td>位置：</td>
		          <td>
		          	<select name="position">
		          		<option value="-1">不限</option>
		                <option value="0">底部</option>
						<option value="1">顶部</option>
			        </select>
		          </td>
		          <td> <a href="#" plain="true" id="search" class="easyui-linkbutton" icon="icon-search">查询</a></td>
		          <td> <sjc:auth url="/admin/article/menu/add"><a href="#" plain="true" icon="icon-add" class="easyui-linkbutton" onClick="showWin('#win','add')">添加</a></sjc:auth></td>
		          <td> <sjc:auth url="/admin/article/menu/delete"><a href="#" plain="true" icon="icon-remove" class="easyui-linkbutton" onClick="delAll('delete','#grid')">删除</a></sjc:auth></td>
		       </tr>
		   </table>
		</form>
	</div>
	<div id="win">
		<form method="post" style="margin: 20px;" id="form">
			<input type="hidden" name="id" />
			<table class="formtable">
				<tr>
					<td class="input-title">标题</td>
					<td><input type="text" name="title" /></td>
				</tr>
				<tr>
					<td class="input-title">位置</td>
					<td>
						<select name="position">
							<option value="0" selected="selected">底部</option>
							<option value="1">顶部</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="input-title">状态</td>
					<td>
						<select name="status">
							<option value="0" selected="selected">正常</option>
							<option value="1">禁用</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="input-title">排序</td>
					<td><input type="text" name="orderId" /></td>
				</tr>
				<tr>
					<td class="input-title">链接地址</td>
					<td><input type="text" name="url" /></td>
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