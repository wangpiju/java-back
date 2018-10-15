<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript"
	src="<c:url value='/res/admin/js/audio/audio5.min.js'/>"></script>
<script type="text/javascript">
	var audio5js = new Audio5js({
		swf_path : '<c:url value="/res/admin/js/audio/audio5js.swf"/>',
		ready : function() {
			this.load('<c:url value="/res/admin/alarm/huiyuanzz.wav"/>');
		}
	});
	$(function() {
		setWebDefaultTime();
		var options = {
			columns : [ [
					{
						field : 'status',
						title : '状态',
						formatter : function(value, row) {
							if (value == 0) {
								audio5js.play();
								return '未处理';
							} else if (value == 1) {
								return '拒绝';
							} else if (value == 2) {
								return "完成"
							} else {
								return value;
							}
						}
					}, {
						field : 'amount',
						title : '充值金额'
					}, {
						field : 'test',
						title : '用户组别',
						formatter : function(value, row) {
							if (value == 0) {
								return '非测试';
							} else if (value == 1) {
								return '测试';
							} else {
								return value;
							}
						}
					}, {
						field : 'userMark',
						title : '用户标识',
						formatter:function(value,row){
							if(!value || value == 0)
								return '正常';
							else if(value == 1)
								return '<span style="color:red;">嫌疑</span>';
							else if(value == 2)
								return '<span style="color:green;">VIP</span>';
							else if(value == 3)
								return '<span style="color:green;">黑名单</span>';
							else if(value == 4)
								return '<span style="color:green;">招商经理</span>';
							else if(value == 5)
								return '<span style="color:green;">特权代理</span>';
							else if(value == 6)
								return '<span style="color:green;">金牌代理</span>';
							else if(value == 7)
								return '<span style="color:green;">外部主管</span>';
							else
								return value;
						}
					}, {
						field : 'sourceAccount',
						title : '充值用户'
					}, {
						field : 'targetAccount',
						title : '目标用户'
					}, {
						field : 'createTime',
						title : '充值时间'
					}, {
						field : 'lastTime',
						title : '最后处理时间'
					}, {
						field : 'operator',
						title : '操作管理员'
					}, {
						field : 'remark',
						title : '备注'
					}, {
						field : 'other',
						title : '操作',
						formatter : function(value, row) {
							if (row.status != 0) {
								return "";
							}
							var win = "'#win'";
							var url = "'edit?operateType=0'";
							var url2 = "'edit?operateType=1'";
							var dat = "'edit?id=" + row.id + "'";
							var txt = '<sjc:auth url="/admin/finance/rechargeLower/edit"><a href="#" onClick="showWin(' + win+ ',' + url + ',' + dat+ ')">拒绝</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
							txt += '<sjc:auth url="/admin/finance/rechargeLower/edit"><a href="#" onClick="showWin(' + win + ','+ url2 + ',' + dat + ')">完成</a></sjc:auth>';
							return txt;
						}
					} ] ],
			queryParams : getQueryParams()
		};
		createGrid('#grid', options);
		createWin('#win');

		$("#form").form();

		$("#search").click(function() {
			$("#grid").datagrid("options").queryParams = getQueryParams();
			reloadGrid("#grid");
		});
	});

	function getQueryParams() {
		var p = {};
		$.each($("#form").serializeArray(), function() {
			p[this.name] = this.value;
		});

		return p;
	}

	var suspend = false;
	var timer = setTimer(15000);

	function refreshTime(t) {
		clearInterval(timer);
		if (t != -1) {
			clearInterval(timer);
			timer = setTimer(t);
		}
	}

	function setTimer(t) {
		var timer = setInterval(function() {
			if (!suspend) {
				$("#search").click();
			}
		}, t);
		return timer;
	}
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<div>
			<form id="form" action="list" method="post">
				<table>
					<tr>
						<td>时间：</td>
						<td><input type="text" class="easyui-datetimebox beginTime"
							size="20" name="startTime" />~<input type="text"
							class="easyui-datetimebox endTime" size="20" name="endTime" /></td>
						<td>用户组别：</td>
						<td><select name="test">
								<option value="">不限</option>
								<option value="0">非测试</option>
								<option value="1">测试</option>
						</select></td>
						<td>充值用户：</td>
						<td><input type="text" size="10" name="sourceAccount" /></td>
						<td>目标用户：</td>
						<td><input type="text" size="10" name="targetAccount" /></td>
						<td>状态：</td>
						<td><select name="status">
								<option value="-1">不限</option>
								<option value="0">未处理</option>
								<option value="1">拒绝</option>
								<option value="2">完成</option>
						</select></td>
						<td><select onchange="refreshTime(this.value);">
								<option value="-1">暂停</option>
								<option value="15000" selected="selected">15秒</option>
								<option value="30000">30秒</option>
								<option value="45000">45秒</option>
								<option value="60000">60秒</option>
						</select> 自动刷新</td>
						<td><a href="#" plain="true" id="search"
							class="easyui-linkbutton" icon="icon-search">查询</a></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<div id="win">
		<form method="post" style="margin: 20px;" id="form">
			<input type="hidden" name="id" />
			<table class="formtable">
				<tr>
					<td class="input-title">备注</td>
					<td><input type="text" name="remark" /></td>
				</tr>
			</table>
			<div style="text-align: center; padding: 5px;">
				<a href="#" class="btn-save" icon="icon-save"
					onClick="saveData(this, function(rel){ closeWin('#win','#grid')})">保存</a>
				<a href="#" class="btn-cancel" icon="icon-cancel"
					onClick="closeWin('#win')">取消</a>
			</div>
		</form>
	</div>
</body>
</html>