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
				field : 'category',
				title : '系统名称'
			},{
				field : 'title',
				title : '任务'
			},{
				field : 'beforeDays',
				title : '清理几天前数据'
			},{
				field : 'beforeDaysDefault',
				title : '清理几天前数据默认值'
			},{
				field : 'executeTime',
				title : '执行时间'
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
				field : 'clearMode',
				title : '清理方式',
				formatter : function(value, row) {
					if (value == 0) {
						return "删除";
					} else if (value == 1) {
						return "冻结";
					} else if (value == 2) {
						return "备份后删除";
					}
				}
			},{
				field : 'deleteMinAmount',
				title : '清理最小金额'
			},{
				field : 'deleteMaxAmount',
				title : '清理最大金额'
			},{
				field : 'freezeMixAmount',
				title : '冻结最小金额'
			},{
				field : 'freezeMaxAmount',
				title : '冻结最大金额'
			},{
				field : 'extends1',
				title : '扩展1'
			},{
				field : 'extends2',
				title : '扩展2'
			},{
				field : 'other',
				title : '操作',
				formatter : function(value, row) {
					var win ="'#win'";
					var url = "'edit'";
					var dat = "'edit?id=" + row.id +"'";
					var txt = '<sjc:auth url="/admin/sys/sysClear/edit"><a href="#" onClick="showWin('+ win +',' +url+ ','+ dat +')">编辑</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
					txt += '<sjc:auth url="/admin/sys/sysClear/delete"><a href="#" onClick="del(\'delete?id=' + row.id +'\',function(rel){reloadGrid(\'#grid\')})">删除</a></sjc:auth>';
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
			<sjc:auth url="/admin/sys/sysClear/add"><a href="#" plain="true" icon="icon-add" class="easyui-linkbutton" onClick="showWin('#win','add')">添加</a></sjc:auth>
			<sjc:auth url="/admin/sys/sysClear/delete"><a href="#" plain="true" icon="icon-remove" class="easyui-linkbutton" onClick="delAll('delete','#grid')">删除</a></sjc:auth>
		</div>
	</div>
	<div id="win">
		<form method="post" style="margin: 20px;">
			<input type="hidden" name="id" />
			<table class="formtable">
				<tr>
					<td class="input-title">系统名称</td>
					<td><input type="text" name="category" /></td>
				</tr>
				<tr>
					<td class="input-title">任务</td>
					<td>
						<select name="job">
							<c:forEach items="${jobs }" var="entry">
								<option value="${entry.key }">${entry.value }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td class="input-title">清理几天前数据</td>
					<td><input type="text" name="beforeDays" /></td>
				</tr>
				<tr>
					<td class="input-title">清理几天前数据默认值</td>
					<td><input type="text" name="beforeDaysDefault" /></td>
				</tr>
				<tr>
					<td class="input-title">执行时间(HH:mm:ss)</td>
					<td><input type="text" maxlength="9" name="executeTime"/></td>
				</tr>
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
					<td class="input-title">清理方式</td>
					<td>
						<select name="clearMode">
							<option value="0">删除</option>
							<!--  <option value="1">冻结</option> -->
							<option value="2">备份后删除</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="input-title">清理最小金额</td>
					<td><input type="text" name="deleteMinAmount" /></td>
				</tr>
				<tr>
					<td class="input-title">清理最大金额</td>
					<td><input type="text" name="deleteMaxAmount" /></td>
				</tr>
				<tr>
					<td class="input-title">冻结最小金额</td>
					<td><input type="text" name="freezeMixAmount" /></td>
				</tr>
				<tr>
					<td class="input-title">冻结最大金额</td>
					<td><input type="text" name="freezeMaxAmount" /></td>
				</tr>
				<tr>
					<td class="input-title">扩展1</td>
					<td><input type="text" name="extends1" /></td>
				</tr>
				<tr>
					<td class="input-title">扩展2</td>
					<td><input type="text" name="extends2" /></td>
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