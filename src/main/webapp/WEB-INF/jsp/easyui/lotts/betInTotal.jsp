<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
var countFields = ['gameAmount', 'winAmount'];
	$(function() {
		setWebDefaultTime();
		var options = {
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
				title : '账号'
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
				field : 'betId',
				title : '订单编号'
			},{
				field : 'lotteryName',
				title : '开启彩种'
			},{
				field : 'playName',
				title : '开启玩法'
			},{
				field : 'startAmount',
				title : '启动金额'
			},{
				field : 'startTime',
				title : '开启时间'
			},{
				field : 'gameCount',
				title : '游戏次数'
			},{
				field : 'gameAmount',
				title : '游戏金额'
			},{
				field : 'winAmount',
				title : '中奖金额'
			},{
				field : 'other',
				title : '操作',
				formatter : function(value, row) {
					if (!row.betId) {
						return "";
					}
					var win ="'#win'";
					var url = "'edit'";
					var dat = "'edit?id=" + row.id +"'";
					var txt = '<sjc:auth url="/admin/lotts/betIn/index"><a href="#" onClick="addTab(\'详情\',\'<c:url value="/admin/lotts/betIn/index?betId="/>' + row.betId +'\')">查看记录</a></sjc:auth>';
					return txt;
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
	});
	
	function getQueryParams() {
		var p={};
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
		<div>
			<form id="form" action="list" method="post">
				<table>
			       <tr>
			       	  <td>时间：</td>
				      <td><input type="text" class="easyui-datetimebox beginTime" size="20" name="beginTime"/>~<input type="text" class="easyui-datetimebox endTime" size="20" name="endTime"/></td>
			          <td>开启彩种</td>
			          <td>
			          	<select name="lotteryName">
			          		<option value="">不限</option>
			          		<c:forEach items="${lotteryList }" var="lottery">
			          			<option value="${lottery.title }">${lottery.title }</option>
			          		</c:forEach>
			          	</select>
			          </td>
			          <td>订单编号：</td>
			          <td><input type="text" size="10" name="betId" /></td>
			          <td>账号：</td>
			          <td><input type="text" size="10" name="account" /></td>
			          <td><input name="isIncludeChildFlag" type="checkbox" value="1"/>包含下级</td>
			          <td>用户类型：</td>
			          <td>
			          	<select name="test">
			          		<option value="">不限</option>
			                <option value="0">非测试</option>
							<option value="1">测试</option>
				        </select>
			          </td>
			          <td> <a href="#" plain="true" id="search" class="easyui-linkbutton" icon="icon-search">查询</a></td>
			          <td> <sjc:auth url="/admin/lotts/betInTotal/delete"><a href="#" plain="true" icon="icon-remove" class="easyui-linkbutton" onClick="delAll('delete','#grid')">删除</a></sjc:auth></td>
			       </tr>
			   </table>
			</form>
		</div>
	</div>
	<div id="win">
		
	</div>
</body>
</html>