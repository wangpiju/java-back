<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	$(function() {
		var options = {
			columns : [ [ 
			{
				field : 'name',
				title : '名称'
			},{
				field : 'status',
				title : '状态',
			formatter : function(value, row) {
					if (value == 0) {
						return "开启";
					} else if (value == 1) {
						return "关闭";
					} else {
						return value;
					}
				}
			},{
				field : 'userMark',
				title : '对话分流配置',
			formatter : function(value, row) {
					if (value == 0) {
						return "正常";
					} else if (value == 1) {
						return "嫌疑";
					} else if (value == 2) {
						return "VIP";
					} else if (value == 3) {
						return "黑名单";
					} else {
						return value;
					}
				}
			},{
				field : 'link',
				title : '链接'
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
		//createGrid('#grid',options);
		createWin('#win');
	});
	
	$(function() {$("#win2").find("a.btn-save,a.btn-cancel").linkbutton()});
	
	function saveAll() {
		var haveOpen = 0;
		var haveOpenAndMark = 0;
		
		var ids = "";
		var statuss = "";
		var userMarks = "";
		$("#win2 select[id^='status_']").each(function() {
			var id         = this.id.replace('status_', '');
			var status     = this.value;
			var userMark   = $('input:radio[name=userMark_' + id + ']:checked').val();
			
			ids += "," + id;
			statuss += "," + status;
			userMarks += "," + userMark;
			
			if (status == 0) {
				haveOpen++;
				if (userMark) {// 为开启状态且设置对话分流
					haveOpenAndMark++;
				}
			}
		});
		
		// 不允许将所有对话工具同时设定为关闭
		if (haveOpen == 0) {
			$.messager.alert('错误', '不允许将所有对话工具同时设定为关闭', 'error');
			return false;
		}
		// 对话工具为1个时，“是否开启对话分流”和“对话分流设置”不生效
		if (haveOpen == 1) {
		//	$.messager.alert('警告', '当开启对话工具为1个时，“对话分流设置”不生效', 'warning');
		}
		// 当开启对话工具>=2时，必须设定“对话分流设置”
		if (haveOpen >= 2 && haveOpenAndMark != haveOpen) {
			$.messager.alert('错误', '当开启对话工具大于等于2个时，必须设定“对话分流设置”', 'error');
			return false;
		}
		
		ids = ids.substring(1);
		statuss = statuss.substring(1);
		userMarks = userMarks.substring(1);
		
		ajaxData('editAll?ids=' + ids + "&statuss=" + statuss + "&userMarks=" + userMarks, function() {
			window.location.reload(true);
		});
	}
</script>

<style type="">
#win2 .formtable td,th {
	border:solid; border-width:0px 1px 1px 0px; height: 35px
}
#win2 .formtable{border:solid; border-width:1px 0px 0px 1px;}
</style>

</head>
<body>
	<div id="grid"></div>
	
	<div id="tb">
		<div>
			<a href="#" plain="true" icon="icon-add" class="easyui-linkbutton" onClick="showWin('#win','add')">添加</a>
		</div>
	</div>
	
	<div id="win2" title="" style="width: 1200px; height: auto; font-size: 14px">
		<form method="post" style="margin: 20px;" id="form" url="add">
			<table class="formtable" style="text-align: center;" border="1" cellspacing="0" cellpadding="0">
				<tr>
					<th width="5%">序号</th>
					<th width="15%">名称</th>
					<th width="10%">状态</th>
					<th width="30%">对话分流配置</th>
					<th width="30%">链接</th>
					<th width="10%">操作</th>
				</tr>
				<c:forEach items="${sysServiceList }" var="sysService" varStatus="st">
					<tr>
						<td>${st.index + 1 }</td>
						<td>${sysService.name }</td>
						<td>
							<select id="status_${sysService.id }" name="status_${sysService.id }">
								<option value="0" ${sysService.status == 0 ? 'selected' : ''  } >开启</option>
								<option value="1" ${sysService.status == 1 ? 'selected' : ''  } >关闭</option>
							</select>
						</td>
						<td>
							<input type="radio" name="userMark_${sysService.id }" value="0" ${sysService.userMark == 0 ? 'checked' : ''  }>正常</input>
							<input type="radio" name="userMark_${sysService.id }" value="1" ${sysService.userMark == 1 ? 'checked' : ''  }>嫌疑</input>
							<input type="radio" name="userMark_${sysService.id }" value="2" ${sysService.userMark == 2 ? 'checked' : ''  }>VIP</input>
							<input type="radio" name="userMark_${sysService.id }" value="3" ${sysService.userMark == 3 ? 'checked' : ''  }>黑名单</input>
						</td>
						<td style="text-align: left;">${sysService.link }</td>
						<td>
							<a href="#" onClick="showWin('#win', 'edit', 'edit?id=${sysService.id}')">编辑</a>
							<a href="#" onClick="del('delete?id=${sysService.id}', function(){window.location.reload(true);})">删除</a>
						</td>
					</tr>
				</c:forEach>
			</table>
			<div style="text-align: center; padding: 5px;">
				<sjc:auth url="/admin/sys/sysService/saveAll"><a href="#" class="btn-save" icon="icon-save" onClick="saveAll();">保存</a></sjc:auth>
			</div>
		</form>
	</div>
	
	<div id="win">
		<form method="post" style="margin: 20px;">
			<input type="hidden" name="id" />
			<table class="formtable">
				<tr>
					<td class="input-title">名称</td>
					<td><input type="text" name="name" /></td>
				</tr>
				<tr>
					<td class="input-title">状态</td>
					<td>
						<select name="status">
							<option value="0">开启</option>
							<option value="1">关闭</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="input-title">对话分流配置</td>
					<td>
						<input type="radio" name="userMark" value="0">正常</input>
						<input type="radio" name="userMark" value="1">嫌疑</input>
						<input type="radio" name="userMark" value="2">VIP</input>
						<input type="radio" name="userMark" value="3">黑名单</input>
					</td>
				</tr>
				<tr>
					<td class="input-title">链接</td>
					<td><input type="text" name="link" /></td>
				</tr>
			</table>
			<div style="text-align: center; padding: 5px;">
				<a href="#" class="btn-save" icon="icon-save" onClick="saveData(this, function(rel){ closeWin('#win');window.location.reload(true);})">保存</a>
				<a href="#" class="btn-cancel" icon="icon-cancel" onClick="closeWin('#win')">取消</a>
			</div>
		</form>
	</div>
</body>
</html>