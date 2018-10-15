<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
var bankKey=${bankKeyJson};
	$(function() {
		var options = {
			columns : [ [ 
			{
				field : 'title',
				title : '名称'
			},{
				field : 'merchantCode',
				title : '商户号'
			},{
				field : 'classKey',
				title : '接口类型',
				formatter:function(value,row){
					var n = bankKey[value];
					if(n){
						return n;
					} else {
						return '<span style="color:red">未知类型 - '+ value +'</span>';
					}
				}
			},{
				field : 'email',
				title : '邮箱'
			},{
				field : 'specialAccount',
				title : '特定会员'
			},{
				field : 'proxyLine',
				title : '代理线路'
			},{
				field : 'status',
				title : '状态',
				formatter:function(value,row){
					if(value == 0)
						return '正常';
					else
						return '禁用';
				}
			},{
				field : 'other',
				title : '操作',
				formatter : function(value, row) {
					var win ="'#win'";
					var url = "'edit'";
					var dat = "'edit?id=" + row.id +"'";
					var txt = '<a href="#" onClick="showWin('+ win +',' +url+ ','+ dat +')">编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;';
					return txt;
				}
			}] ]
		};
		createGrid('#grid',options);
		createWin('#win');
		
		$("#form").form();
		
		$("#search").click(function(){
			var p = getFormData('form');
			p['classKeyArray'] = $('#classKeyArray').combobox('getValues').join(",");
			$("#grid").datagrid("options").queryParams = p;
			reloadGrid("#grid");
		});
	});
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<div>
			<form id="form" action="list" method="post">
				<table>
			       <tr>
			       	  <td>状态：</td>
						<td><select name="status">
								<option value="">不限</option>
								<option value="0">正常</option>
								<option value="1">禁用</option>
						</select></td>
						<td>接口类型：</td>
			          	<td>
			          	<select id="classKeyArray" multiple="multiple" class="easyui-combobox">
			          		<c:forEach items="${bankKey }" var="bankKey">
							<option value="${bankKey.key }">${bankKey.value }</option>
							</c:forEach>
				        </select>
			          </td>
			          <td><a href="#" plain="true" id="search" class="easyui-linkbutton" icon="icon-search">查询</a></td>
			       </tr>
			   </table>
			</form>
		</div>
	</div>
	<div id="win">
		<form method="post" style="margin: 20px;">
			<input type="hidden" name="id" />
			<table class="formtable">
				<tr>
					<td class="input-title">名称</td>
					<td><input type="text" name="title" disabled="disabled" /></td>
				</tr>
				<tr>
					<td class="input-title">商户号</td>
					<td><input type="text" name="merchantCode" disabled="disabled" /></td>
				</tr>
				<tr>
					<td class="input-title">接口类型</td>
					<td>
						<select name="classKey" disabled="disabled" >
							<c:forEach items="${bankKey }" var="a">
								<option value="${a.key }">${a.value }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td class="input-title">特定会员</td>
					<td><textarea rows="5" cols="23" name="specialAccount" ></textarea></td>
				</tr>
				<tr>
					<td class="input-title">代理线路</td>
					<td><textarea rows="5" cols="23" name="proxyLine" ></textarea></td>
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
			</table>
			<div style="text-align: center; padding: 5px;">
				<a href="#" class="btn-save" icon="icon-save" onClick="saveData(this, function(rel){ closeWin('#win','#grid')})">保存</a>
				<a href="#" class="btn-cancel" icon="icon-cancel" onClick="closeWin('#win')">取消</a>
			</div>
		</form>
	</div>
</body>
</html>