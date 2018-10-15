<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	$(function() {
		var options = {
			columns : [ [ {
				field : 'id',
				title : '编号'
			}, {
				field : 'name',
				title : '账变类型'
			}, {
				field : 'type',
				title : '类别',
				formatter:function(value,row){
					if(value == 0)
						return '<span>彩票账变</span>';
					else
						return '<span>充值账变</span>';
				}
			}, {
				field : 'remark',
				title : '备注'
			},{
				field : 'other',
				title : '操作',
				formatter : function(value, row) {
					var win ="'#win'";
					var url = "'edit'";
					var dat = "'edit?id=" + row.id +"'";
					var txt = '<sjc:auth url="/admin/accountChangeType/edit"><a href="#" onClick="showWin('+ win +',' +url+ ','+ dat +')">编辑</a></sjc:auth>&nbsp;&nbsp;';
					/* txt += '<a href="#" onClick="del(\'delete?id=' + row.id +'\',function(rel){reloadGrid(\'#grid\')})">删除</a>&nbsp;'; */
					return txt;
				}
			}] ]
		};
		createGrid('#grid',options);
		createWin('#win');
		createWin('#addWin');
	});
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<div>
			<sjc:auth url="/admin/accountChangeType/add"><a href="#" plain="true" icon="icon-add" class="easyui-linkbutton" onClick="showWin('#addWin','add')">添加</a></sjc:auth>
			<!-- <a href="#" plain="true" icon="icon-remove" class="easyui-linkbutton" onClick="delAll('delete','#grid')">删除</a> -->
		</div>
	</div>
	<div id="win">
		<form method="post" style="margin: 20px;">
			<input type="hidden" name="id" />
			<table class="formtable">
				<tr>
					<td class="input-title">编号</td>
					<td><input type="text" name="id" readonly/></td>
				</tr>
				<tr>
					<td class="input-title">账变类型</td>
					<td><input type="text" name="name" /></td>
				</tr>				
				<tr>
					<td class="input-title">类别</td>
					<td><select name="type">
						<option value="0">彩票账变</option>
						<option value="1">充值账变</option>
					</select></td>
				</tr>
				<tr>
					<td class="input-title">备注</td>
					<td><textarea  name="remark"></textarea></td>
				</tr>
			</table>
			  <div style="text-align: center; padding: 5px;">
				<a href="#" class="btn-save" icon="icon-save" onClick="saveData(this, function(rel){ closeWin('#win','#grid')})">保存</a>
				<a href="#" class="btn-cancel" icon="icon-cancel" onClick="closeWin('#win')">取消</a>
			 </div>
		</form>
	</div>
	<div id="addWin">
		<form method="post" style="margin: 20px;">
			<table class="formtable">
				<tr>
					<td class="input-title">编号</td>
					<td><input type="text" name="id" /></td>
				</tr>
				<tr>
					<td class="input-title">账变类型</td>
					<td><input type="text" name="name" /></td>
				</tr>				
				<tr>
					<td class="input-title">类别</td>
					<td><select name="type">
						<option value="0">彩票账变</option>
						<option value="1">充值账变</option>
					</select></td>
				</tr>
				<tr>
					<td class="input-title">备注</td>
					<td><textarea  name="remark"></textarea></td>
				</tr>
			</table>
			  <div style="text-align: center; padding: 5px;">
				<a href="#" class="btn-save" icon="icon-save" onClick="saveData(this, function(rel){ closeWin('#addWin','#grid')})">保存</a>
				<a href="#" class="btn-cancel" icon="icon-cancel" onClick="closeWin('#addWin')">取消</a>
			 </div>
		</form>
	</div>
</body>
</html>