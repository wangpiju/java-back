<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	$(function() {
		var options = {
			columns : [ [ {
				field : 'account',
				title : '用户'
			}, {
				field : 'test',
				title : '类型',
				formatter : function(value, row) {
					   if(value==0){
							return '<span >正常</span>';
						}else {
							return '<span>测试</span>';
						} 
					}
			}, {
				field : 'createDate',
				title : '日期'
			}, {
				field : 'betAmount',
				title : '投注总额'
			}, {
				field : 'rebateAmount',
				title : '自身返点总额'
			}, {
				field : 'juniorRebateAmount',
				title : '下级返点总额'
			},{
				field : 'actualSaleAmount',
				title : '实际投注总额'
			}, {
				field : 'winAmount',
				title : '中奖总额'
			}, {
				field : 'count',
				title : '总盈亏'
			}, {
				field : 'rechargeAmount',
				title : '充值总额'
			}, {
				field : 'drawingAmount',
				title : '提现总额'
			}, {
				field : 'tigerWinAmount',
				title : '老虎机中奖总额'
			}, {
				field : 'wages',
				title : '日工资'
			},{
				field : 'activityAndSend',
				title : '活动派发总额'
			}] ]
		};
		createGrid('#grid',options);
	});
	function finds(){
		var p = {
				startDate: $('#startDate').datebox('getValue'),
				endDate: $('#endDate').datebox('getValue'),
				account: $('#account').val()
		}
		reloadGrid('#grid',p);
	}
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<div>
			用户：<input type="text" size="10" id="account" name="account" />
			起始日期：<input id="startDate" class="easyui-datebox" size="8" />~<input id="endDate" class="easyui-datebox" size="8" />
			<a href="#" plain="true" class="easyui-linkbutton" icon="icon-search" onClick="finds()">查询</a>
		</div>
	</div>
</body>
</html>