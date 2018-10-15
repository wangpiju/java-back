<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
var bankNames = ${json};
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
				title : '用户'
			}, {
				field : 'parentAccount',
				title : '上级用户'
			}, {
				field : 'bankNameId',
				title : '所属银行',
				formatter:function(value,row){
					for(var n in bankNames){
						var bank = bankNames[n];
						if(bank.id == value){
							return bank.title;
						}
					}
				}
			}, {
				field : 'niceName',
				title : '开户姓名'
			}, {
				field : 'card',
				title : '银行卡号'
			}, {
				field : 'address',
				title : '开户地址'
			}, {
				field : 'createTime',
				title : '绑定时间'
			}, {
				field : 'status',
				title : '状态',
				formatter:function(value,row){
					if(value==0)
						return '<span style="color:green;">正常</span>';
					else if(value == 1)
						return '<span style="color:red;">冻结</span>';
					else if(value == 2)
						return '<span style="color:red;">已解绑</span>';
					else
						return value;
				}
			},{
				field : 'other',
				title : '操作',
				formatter : function(value, row) {
					var txt ='&nbsp;&nbsp;&nbsp;&nbsp;';
					if(row.status == 0){
						txt+='<sjc:auth url="/admin/bankUserAll/status"><a href="#" onClick="setStatus('+ row.id +',1)">冻结</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
						txt+='<sjc:auth url="/admin/bankUserAll/status"><a href="#" onClick="setStatus('+ row.id +',2)">解绑</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
					} else if(row.status == 1){
						txt+='<sjc:auth url="/admin/bankUserAll/status"><a href="#" onClick="setStatus('+ row.id +',0)">解冻</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
					} else if(row.status == 2){
						txt+='<sjc:auth url="/admin/bankUserAll/status"><a href="#" onClick="setStatus('+ row.id +',0)">绑定</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
					}
					txt +='<sjc:auth url="/admin/userLoginIp/logout"><a href="#" onClick="userOut(\''+row.account+'\')">踢出平台</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
					return txt;
				}
			}] ]
		};
		createGrid('#grid',options);
	});
function setStatus(id,status){
	var url = 'status?id='+ id+'&status='+status;
	ajaxData(url,function(rel){
		reloadGrid("#grid");
	});
}
function userOut(account){
	var url = 'logout?account='+account;
	ajaxData(url,function(rel){
		$.messager.alert('提示', rel.content, 'info');
	});
}
function finds(){

	$(grid).datagrid("options")['url'] = 'list';
	
	var p =  {
		account:$("#account").val(),
		niceName:$("#niceName").val(),
		bankCard:$("#bankCard").val(),
		begin:$('#begin').datebox('getValue'),
		end:$('#end').datebox('getValue')
	};
	reloadGrid("#grid",p);
}
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<div>
			会员：<input type="text" id="account" size="6" />
			开户名：<input type="text" id="niceName" size="6" />
			银行卡号：<input type="text" id="bankCard" size="22" />
			时间：<input type="text" size="8" class="easyui-datebox" id="begin" />~<input size="8" type="text" class="easyui-datebox" id="end" />
			
			<a href="#" plain="true" icon="icon-search" class="easyui-linkbutton" onClick="finds()">查询</a>
		</div>
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