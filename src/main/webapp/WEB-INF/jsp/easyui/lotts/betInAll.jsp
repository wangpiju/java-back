<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<style type="text/css">
.input-title {
text-align: center;
}
</style>
<script type="text/javascript">
	
</script>
</head>
<body>
	<form id="form" action="add" method="post">
		<table class="form-table">
			<tr>
				<td class="input-title" rowspan="2" colspan="2">数值区间</td>
				<td class="input-title" rowspan="3">存货</td>
				<td class="input-title" rowspan="3">警戒线</td>
				<td class="input-title" rowspan="2" colspan="2">补仓规则</td>
				<c:forEach items="${betInRuleList }" var="betInRule">
				<td class="input-title" colspan="${ruleAmountMap[betInRule.id].size() * 2 == 0 ? 2 : ruleAmountMap[betInRule.id].size() * 2 }">${betInRule.name }</td>
				</c:forEach>
			</tr>
			<tr>
				<c:forEach items="${betInRuleList }" var="betInRule">
					<c:if test="${empty ruleAmountMap[betInRule.id] }">
						<td class="input-title" colspan="2">---</td>
					</c:if>
					<c:forEach items="${ruleAmountMap[betInRule.id] }" var="betInAmount">
						<td class="input-title" colspan="2">${betInAmount.name }</td>
					</c:forEach>
				</c:forEach>
			</tr>
			<tr>
				<td class="input-title">数值起始</td>
				<td class="input-title">数值终结</td>
				<td class="input-title">累计额度</td>
				<td class="input-title">补充</td>
				<c:forEach items="${betInRuleList }" var="betInRule">
					<c:if test="${empty ruleAmountMap[betInRule.id] }">
						<td class="input-title" colspan="2">---</td>
					</c:if>
					<c:forEach items="${ruleAmountMap[betInRule.id] }" var="betInAmount">
						<td rowspan="20">金额止<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />${betInAmount.amount }</td>
						<td class="input-title">概率</td>
					</c:forEach>
				</c:forEach>
			</tr>
			<c:forEach items="${betInPriceList }" var="betInPrice">
			<tr>
				<td>${betInPrice.start }</td>
				<td>${betInPrice.end }</td>
				<td>${betInPrice.surplusNum }</td>
				<td>${betInPrice.warnNum }</td>
				<td>${betInPrice.totalAmount }</td>
				<td>${betInPrice.addNum }</td>
				<c:forEach items="${betInRuleList }" var="betInRule">
					<c:if test="${empty ruleAmountMap[betInRule.id] }">
						<td class="input-title" colspan="2">---</td>
					</c:if>
					<c:forEach items="${ruleAmountMap[betInRule.id] }" var="betInAmount">
						<c:set var="key" value="${betInRule.id }-${betInPrice.id }-${ betInAmount.amount }"></c:set>
						<td>${ruleAmountProbMap[key].probability }</td>
					</c:forEach>
				</c:forEach>
			</tr>
			</c:forEach>
			<tr>
				<td class="input-title" colspan="6">时间区间</td>
				<c:forEach items="${betInRuleList }" var="betInRule">
				<td class="input-title" colspan="${ruleAmountMap[betInRule.id].size() * 2 == 0 ? 2 : ruleAmountMap[betInRule.id].size() * 2 }">概率</td>
				</c:forEach>
			</tr>
			<c:forEach items="${betInTimeMap }" var="betInTime">
			<tr>
				<td colspan="6">${betInTime.key }</td>
				<c:forEach items="${betInRuleList }" var="betInRule">
				<c:set var="key" value="${betInTime.key }~${betInRule.id }"></c:set>
				<td colspan="${ruleAmountMap[betInRule.id].size() * 2 == 0 ? 2 : ruleAmountMap[betInRule.id].size() * 2 }">${betInTimeProbMap[key].probability == null ? "---" : betInTimeProbMap[key].probability }</td>
				</c:forEach>				
			</tr>
			</c:forEach>
			<!-- 
			<tr>
				<td colspan="6"><a href="#"  class="easyui-linkbutton" id="formSubmit" icon="icon-save">保存</a></td>
				<c:forEach items="${betInRuleList }" var="betInRule">
					<c:if test="${empty ruleAmountMap[betInRule.id] }">
						<td class="input-title" colspan="2">---</td>
					</c:if>
					<c:forEach items="${ruleAmountMap[betInRule.id] }" var="betInAmount">
						<td colspan="2"><a href="#"  class="easyui-linkbutton" id="formSubmit" icon="icon-save">保存</a></td>
					</c:forEach>
				</c:forEach>
			</tr>
			 -->
		</table>
		<div style="color:red;">${msg }</div>
	</form>
</body>
</html>