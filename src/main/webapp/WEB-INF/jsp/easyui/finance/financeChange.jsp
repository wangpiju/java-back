<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
var countFields = ['changeAmount'];
var accountChangeType = ${json};
	$(function() {
		setWebDefaultTime();
		var options = {
			columns : [[{
				field : 'changeUser',
				title : '帐变用户'
			},{
				field : 'test',
				title : '用户类型',
				formatter : function(value, row) {
					if (value == 0) {
						return '非测试';
					} else if (value == 1) {
						return '测试';
					} else {
						return value;
					}
				}
			},{
				field : 'financeId',
				title : '帐变编号'
			},{
				field : 'accountChangeTypeId',
				title : '帐变类型',
				formatter:function(value,row) {
					for(var i=0;i<accountChangeType.length;i++){
						var ag = accountChangeType[i];
						if(ag.id == value){
							return ag.name;
						}
					}
				}
			},{
				field : 'changeTime',
				title : '帐变时间'
			},{
				field : 'changeAmount',
				title : '帐变金额'
			},{
				field : 'balance',
				title : '用户余额'
			},{
				field : 'status',
				title : '状态',
				formatter : function(value, row) {
					if (value == 0) {
						return '未处理';
					} else if (value == 1) {
						return '拒绝';
					} else if (value == 2) {
						return "完成"
					} else if (value == 3) {
						return "已过期"
					} else if (value == 4) {
						return "已撤销"
					} else if (value == 5) {
						return "正在处理"
					} else if (value == 6) {
						return "审核中"
					} else if (value == 7) {
						return "审核通过"
					} else if (value == 8) {
						return "审核不通过"
					} else {
						return value;
					}
				}
			},{
				field : 'remark',
				title : '备注'
			},{
				field : 'operator',
				title : '操作管理员',
				formatter:function(value,row) {
					return "<span style='color:red;font-weight: bold'>" + (value || "") + "<span>";
				}
			}] ],
			queryParams : getQueryParams()
		};
		createGrid('#grid',options);
		createWin('#win');
		
		$("#form").form();
		
		$("#search").click(function(){
			$("#grid").datagrid("options").queryParams = getQueryParams();
			reloadGrid("#grid");
		});
		
		$("#searchBet").click(function(){
			var users = getSelectedArr("#grid",'changeUser');
			var times = getSelectedArr("#grid",'changeTime');
			
			var u = '',t1 = '',t2 = '';
			if(users.length == 1) {
				u = users[0];
				t1 = times[0];
			} else if(users.length == 2 &&  users[0] == users[1]) {
				u = users[0];
				t1 = times[0];
				t2 = times[1];
			} else {
				$.messager.alert('错误', '选中2行时,两行的用户名要一致', 'error');
				return false;
			}
			
			
			var url = '<c:url value="/admin/report/betIndex"/>?account='+u+"&t1="+t1+"&t2="+t2;
			addTab('投注记录',url);
		});
		
		$("#searchAmount").click(function(){
			var users = getSelectedArr("#grid",'changeUser');
			var times = getSelectedArr("#grid",'changeTime');
			
			var u = '',t1 = '',t2 = '';
			if(users.length == 1) {
				u = users[0];
				t1 = times[0];
			} else if(users.length == 2 &&  users[0] == users[1]) {
				u = users[0];
				t1 = times[0];
				t2 = times[1];
			} else {
				$.messager.alert('错误', '选中2行时,两行的用户名要一致', 'error');
				return false;
			}
			
			var url = '<c:url value="/admin/report/settlementIndex"/>?account='+u+"&t1="+t1+"&t2="+t2;
			addTab('游戏账变',url);
		});
	});
	
	function getQueryParams() {
		var p={};
		p['accountChangeTypes'] = $('#accountChangeTypes').combobox('getValues').join(",");
		$.each($("#form").serializeArray(),function(){  
            p[this.name]=this.value;  
        });
		
		return p;
	}
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<form id="form" action="list" method="post">
			<table>
		       <tr>
		       	  <td>时间：</td>
			      <td><input type="text" class="easyui-datetimebox beginTime" size="20" name="startTime"/>~<input type="text" class="easyui-datetimebox endTime" size="20" name="endTime"/></td>
		          <td>帐变用户：</td>
		          <td><input type="text" size="10" name="changeUser" /></td>
		          <td><input name="isIncludeChildFlag" type="checkbox" value="1"/>包含下级</td>
		          <td>账变类型：</td>
		          <td>
		          	<select multiple="multiple" class="easyui-combobox" id="accountChangeTypes">
						<c:forEach items="${accountChangeTypeList }" var="a">
							<option value="${a.id }">${a.name }</option>
						</c:forEach>
			        </select>
		          </td>
		          <td>用户类型：</td>
		          <td>
		          	<select name="test">
		          		<option value="-1">不限</option>
		                <option value="0">非测试</option>
						<option value="1">测试</option>
			        </select>
		          </td>
		          <td>帐变编号：</td>
		          <td><input type="text" size="10" name="financeId" /></td>
			      <td>状态：</td>
		          <td>
		          	<select name="status">
		          		<option value="-1">不限</option>
		                <option value="0">未处理</option>
						<option value="1">拒绝</option>
						<option value="2">完成</option>
						<option value="3">已过期</option>
						<option value="4">已撤销</option>
			        </select>
		          </td>
		          <td><a href="#" plain="true" id="search" class="easyui-linkbutton" icon="icon-search">查询</a></td>
		       </tr>
		   </table>
		</form>
		<a href="#" plain="true" id="searchBet" class="easyui-linkbutton" icon="icon-search">查投注</a>
		<a href="#" plain="true" id="searchAmount" class="easyui-linkbutton" icon="icon-search">查帐变</a>
	</div>
	<div id="win">
		<form method="post" style="margin: 20px;" id="form">
			<table class="formtable">
				<tr>
					<td class="input-title">帐变用户</td>
					<td><input type="text" name="changeUser" /></td>
				</tr>
				<tr>
					<td class="input-title">帐变类型</td>
					<td>
						<select name="accountChangeTypeId">
							<c:forEach items="${accountChangeTypeList }" var="a">
								<option value="${a.id }">${a.name }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td class="input-title">帐变金额</td>
					<td><input type="text" name="changeAmount" /></td>
				</tr>
				<tr>
					<td class="input-title">备注</td>
					<td><input type="text" name="remark" /></td>
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