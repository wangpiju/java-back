<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
var countFields = ['amount','win','winLose'];
	$(function() {
//		private String lotteryId;		//彩票ID	
//		private Date date;				//日期
//		private BigDecimal amount;		//投注额度
//		private BigDecimal win;			//中奖奖金
//		private BigDecimal winLose;		//盈亏
//		private BigDecimal sysAllWin;	//平台累计
//		private Integer betNum;			//投注数
//		private Integer userNum;		//用户数
		var options = {
			url:'seasonList',
			columns : [ [ {
				field : 'lotteryId',
				title : '彩种'
			}, {
				field : 'seasonId',
				title : '期号'
			}, {
				field : 'amount',
				title : '销售量'
			}, {
				field : 'win',
				title : '中奖'
			}, {
				field : 'winLose',
				title : '盈亏值'
			}, {
				field : 'betNum',
				title : '下单量'
			}, {
				field : 'userNum',
				title : '投注人数'
			}] ]
		};
		createGrid('#grid',options);
	});
	function finds(){
		var p = {
				date: $('#date').datebox('getValue'),
				lotteryId: $('#lotteryId').val(),
				test : $("#test").val()
		}
		reloadGrid('#grid',p);
	}
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<div>
			彩种：<select id="lotteryId">
				<c:forEach items="${list }" var="a">
					<option value="${a.id }">${a.title }</option>
				</c:forEach>
			</select>
			日期：<input id="date" class="easyui-datebox" size="8" />
			测试：<select id="test">
				<option value="0">否</option>
				<option value="1">是</option>
			</select>
			<a href="#" plain="true" class="easyui-linkbutton" icon="icon-search" onClick="finds()">查询</a>
		</div>
	</div>
</body>
</html>