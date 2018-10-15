<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
var countFields = ['userRegisteredNum','userActiveNum','userActivityAmount','gameValidAmount','gameBetNum',
                   'gameRebate','gameHigherRebate','gameProfit','game3DAmount','rechaegeFirstNum','rechargeFirstAmount',
                   'rechargeAccountNum','rechargeNum','rechargePayAmount','rechargeBankAmount','depositAccountNum','depositNum','depositAmount'];
	$(function() {
		var options = {
			columns : [ [ {
				field : 'reportDate',
				title : '统计时间'
			}, {
				field : 'userRegisteredNum',
				title : '注册人数'
			}, {
				field : 'userActiveNum',
				title : '活跃人数'
			}, {
				field : 'userActivityAmount',
				title : '活动费用'
			}, {
				field : 'gameValidAmount',
				title : '投注额（有效）'
			}, {
				field : 'gameBetNum',
				title : '下单量'
			}, {
				field : 'gameRebate',
				title : '投注返点'
			}, {
				field : 'gameHigherRebate',
				title : '上级点差'
			}, {
				field : 'gameProfit',
				title : '盈亏'
			}, {
				field : 'game3DAmount',
				title : '3D投注额'
			}, {
				field : 'rechaegeFirstNum',
				title : '首存人数'
			}, {
				field : 'rechargeFirstAmount',
				title : '总首存'
			}, {
				field : 'rechargeAccountNum',
				title : '充值人数'
			}, {
				field : 'rechargeNum',
				title : '充值笔数'
			}, {
				field : 'rechargePayAmount',
				title : '第三方充值'
			}, {
				field : 'rechargeBankAmount',
				title : '银行卡充值'
			}, {
				field : 'depositAccountNum',
				title : '提款人数'
			}, {
				field : 'depositNum',
				title : '提款笔数'
			}, {
				field : 'depositAmount',
				title : '提款金额'
			}, {
				field : 'allUserAmount',
				title : '用户余额'
			}, {
				field : 'allOperationAmount',
				title : '平台余额'
			}] ]
		};
		grid = createGrid('#grid',options);
		$("#search").click(function(){
			var p={};
			$.each($("#form").serializeArray(),function(){  
	            p[this.name]=this.value;  
	        });
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
	     <form id="form" action="listOperationReport" method="post">		
			  时间：    <input type="text" class="easyui-datebox" size="10" name="startTime"/>00:00:00~<input type="text" class="easyui-datebox" size="10" name="endTime"/>23:59:59
			 <a href="#" plain="true" id="search" class="easyui-linkbutton" icon="icon-search">查询</a>
			 </form>
		</div>
	</div>
</body>
</html>