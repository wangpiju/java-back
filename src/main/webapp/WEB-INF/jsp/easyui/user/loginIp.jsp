<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
var ipBlacks = ${ipBlacks};
$(function() {
	var options = {
		singleSelect:true,
		url:'',
		columns : [ [ {
			field : 'userMark',
			title : '用户标识',
			formatter:function(value,row){
				if(row.account){
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
				} else {
					return '';
				}
			}
		}, {
			field : 'account',
			title : '会员',
			formatter:function(value,row){
				return '<a href="#" onclick="findAccount(\''+value+'\');">'+value+'</a>';
			}
		},{
			field : 'parentAccount',
			title : '上级'
		},{
			field : 'loginTime',
			title : '登陆时间',
			formatter:function(value,row){
				if(value){
					return new Date(value).format("yyyy-MM-dd hh:mmss");
				}
			}
		}, {
			field : 'ip',
			title : 'IP',
			formatter:function(value,row){
				var show = value;
				for(var i=0;i<ipBlacks.length;i++){
					var ag = ipBlacks[i];
					if(ag.ip == value){
						show = "<span style='color:red;font-weight:bold;'>"+value+"<span>";
						break;
					}
				}
				return '<a href="#" onclick="findIp(\''+value+'\');">'+show+'</a>';
			}
		}, {
			field : 'ipInfo',
			title : '区域'
		}, {
			field : 'userAgent',
			title : '浏览器'
		}, {
			field : 'other',
			title : '操作',
			formatter : function(value, row) {
				var acc = "{statusType:0,account:'"+row.account+"',loginStatus:0,betStatus:0,betInStatus:0,depositStatus:0}";
				var txt ='&nbsp;&nbsp;&nbsp;&nbsp;<sjc:auth url="/admin/user/status"><a href="#" onClick="showWin(\'#statusWin\',\'<c:url value="/admin/user/status"/>\','+acc+')">冻结</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
				txt +='<sjc:auth url="/admin/userLoginIp/logout"><a href="#" onClick="userOut(\''+row.account+'\')">踢出平台</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
				return txt;
			}
		}] ]
	};
	createGrid('#grid',options);
	createWin("#statusWin");
	$("#search").click(function(){
		$(grid).datagrid("options")['url'] = 'list';
		var p={};
		$.each($("#form").serializeArray(),function(){  
            p[this.name]=this.value;  
        });
		reloadGrid("#grid",p);
	});
});

function findIp(ip){
	$("#ip").val(ip);
	$("#account").val('');
	$("#search").click();
}

function findAccount(account){
	$("#ip").val('');
	$("#account").val(account);
	$("#search").click();
}
function userOut(account){
	var url = 'logout?account='+account;
	ajaxData(url,function(rel){reloadGrid("#grid")});
}
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<form id="form" action="list" method="post">
		<div>
			IP：<input type="text" id="ip" size="8" name="ip" />
			会员：<input type="text" id="account" size="8" name="account" />
			区域：<input type="text" id="ipInfo" size="12" name="ipInfo" />
			<a href="#" plain="true" id="search" class="easyui-linkbutton" icon="icon-search">查询</a>
		</div>
		</form>
	</div>
	<div id="statusWin">
		<form method="post" style="margin: 20px;" id="statusForm" action="status">
			<table class="formtable">
				<tr>
					<td class="input-title">账户</td>
					<td><input type="text" size="5" readonly name="account" /></td>
				</tr>
				<tr>
					<td class="input-title">冻结类型</td>
					<td><select name="statusType">
						<option value="0">仅自己</option>
						<option value="1">仅团队</option>
						<option value="2">全部</option>
					</select></td>
				</tr>
				<tr>
					<td class="input-title">登陆冻结</td>
					<td><select name="loginStatus">
						<option value="0">解冻</option>
						<option value="1">冻结</option>
					</select></td>
				</tr>
				<tr>
					<td class="input-title">投注冻结</td>
					<td><select name="betStatus">
						<option value="0">解冻</option>
						<option value="1">冻结</option>
					</select></td>
				</tr>
				<tr>
					<td class="input-title">彩中彩冻结</td>
					<td><select name="betInStatus">
						<option value="0">解冻</option>
						<option value="1">冻结</option>
					</select></td>
				</tr>
				<tr>
					<td class="input-title">充提冻结</td>
					<td><select name="depositStatus">
						<option value="0">解冻</option>
						<option value="1">冻结</option>
					</select></td>
				</tr>
				<tr>
					<td class="input-title">备注</td>
					<td><input type="text" name="remark" /></td>
				</tr>
			</table>
			<div style="text-align: center; padding: 5px;">
				<a href="#" class="btn-save" icon="icon-save" onClick="saveData(this, function(rel){ closeWin('#statusWin');reloadGrid('#grid')})">保存</a>
				<a href="#" class="btn-cancel" icon="icon-cancel" onClick="closeWin('#statusWin')">取消</a>
			</div>
		</form>
	</div>
</body>
</html>