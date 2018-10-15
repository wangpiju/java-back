<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
var bankKey=${bankKeyJson};
	$(function() {
		var options = {
			url:'',
			singleSelect:true,
			columns : [ [ {
				field : 'createDate',
				title : '日期'
			}, {
				field : 'receiveName',
				title : '充值接口',
				formatter:function(value,row){
					if(value) {
						var n = bankKey[value];
						if(n){
							return n;
						} else {
							return value;
						}
					} else {
						return '';
					}
				}
			}, {
				field : 'receiveCard',
				title : '收款银行卡号'
			}, {
				field : 'amount',
				title : '充值总额'
			}, {
				field : 'poundage',
				title : '手续费'
			}, {
				field : 'realAmount',
				title : '实际上分'
			}, {
				field : 'num',
				title : '充值次数'
			}] ]
		};
		createGrid('#grid',options);
		createWin('#win');
		setWebDefaultTime();
	});
	function finds(){
		var p = {
				begin: $('#begin').datebox('getValue'),
				end: $('#end').datebox('getValue'),
				receiveName: $('#receiveName').val(),
				receiveCard: $('#receiveCard').val()
		}
		$('#grid').datagrid("options")['url'] = 'list';
		reloadGrid('#grid',p);
	}
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<div>
			<form id="form">
				日期：<input type="text" id="begin" class="easyui-datetimebox beginTime" size="20"/>~
					  <input type="text" id="end" class="easyui-datetimebox endTime" size="20"/>
			
				充值接口：<select id="receiveName">
					<option value="">不限</option>
					<option value="现金充值">现金充值</option>
					<option value="银行充值">银行充值</option>
	          		<c:forEach items="${bankKey }" var="a">
					<option value="${a.key }">${a.value }</option>
					</c:forEach>
		        </select>
		        
		        	收款银行卡号：<input id="receiveCard" size="30" />
			</form>
			<sjc:auth url="/admin/finance/rechargeReport/list"><a href="#" plain="true" class="easyui-linkbutton" icon="icon-search" onClick="finds()">查询</a></sjc:auth>
		</div>
	</div>
</body>
</html>