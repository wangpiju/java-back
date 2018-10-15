<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv="Expires" content="0">
	<style type="text/css">
		.nav_sm_con {
			width: calc(100% - 10px);
			height: calc(100vh - 10px);
			overflow-x: auto;
			overflow-y: auto;
		}
	</style>
	<link href="<c:url value='/res/admin/js/reportRoles/app.18919bffdf6854ca2430028c0edd405a.css'/>" rel="stylesheet">
	<title>综合报表</title>
	<script type="text/javascript">
		$(document).ready(function () {
			//alert(screen.width);
			//alert(screen.height);
			var dateFlag = ${parameterOb.dateFlag};
			var dateFlag_id;
			if (dateFlag == 0) dateFlag_id = 'dateFlag_day';
			if (dateFlag == 1) dateFlag_id = 'dateFlag_lday';
			if (dateFlag == 2) dateFlag_id = 'dateFlag_mday';
			if (dateFlag == 3) dateFlag_id = 'dateFlag_lmday';
			dateFlag_onclick(dateFlag_id, dateFlag);
		});

		function finds() {
			var startDateStr = document.getElementById('startDateStr');
			var endDateStr = document.getElementById('endDateStr');
			startDateStr.value = document.getElementsByName('startTime')[0].value;
			endDateStr.value = document.getElementsByName('endTime')[0].value;
			var startDateStr_V = startDateStr.value;
			var endDateStr_V = endDateStr.value;
			if (startDateStr_V > endDateStr_V) {
				$.messager.alert('错误', '[开始日期]不能大于[结束日期]', 'error');
				return;
			}
			var cpsReportForm = document.getElementById('cpsReportForm');
			cpsReportForm.submit();
		}

		function dateFlag_onclick(dateFlag_id, dateFlag_value) {
			document.getElementById('dateFlag').value = dateFlag_value;
			var arr = ['dateFlag_day', 'dateFlag_lday', 'dateFlag_mday', 'dateFlag_lmday'];
			for (var i = 0; i < arr.length; i++) {
				document.getElementById(arr[i]).setAttribute("class", "");
			}
			document.getElementById(dateFlag_id).setAttribute("class", "curr");
		}
	</script>
</head>
<body>
<form id="cpsReportForm" name="cpsReportForm" action="index" method="post">
	<input type="hidden" id="dateFlag" name="dateFlag" value="${parameterOb.dateFlag}"/>
	<input type="hidden" id="startDateStr" name="startDateStr" value="${parameterOb.startDateStr}"/>
	<input type="hidden" id="endDateStr" name="endDateStr" value="${parameterOb.endDateStr}"/>
</form>
<div id="app" class="nav_sm_con">
	<div class="content fix">
		<div class="mainContent">
			<div data-v-55d6c893="">
				<div data-v-55d6c893="" class="tableFilter">
					<div data-v-465b8d5c="" data-v-55d6c893="" class="tableFilterDay">
						<a data-v-465b8d5c="" id="dateFlag_day" class="curr"
						   onclick="dateFlag_onclick(this.id,0)">今天</a>
						<a data-v-465b8d5c="" id="dateFlag_lday" onclick="dateFlag_onclick(this.id,1)">昨天</a>
						<a data-v-465b8d5c="" id="dateFlag_mday" onclick="dateFlag_onclick(this.id,2)">本月</a>
						<a data-v-465b8d5c="" id="dateFlag_lmday" onclick="dateFlag_onclick(this.id,3)">上月</a>
					</div>
					<div data-v-9059e430="" data-v-55d6c893="" class="tableFilterTime">
						<em data-v-9059e430="">统计日期</em>
						<!--<i data-v-9059e430="" class="iconfont"></i>-->
						<input data-v-9059e430="" id="LAY_demorange_s" class="easyui-datebox" size="11" name="startTime"
							   value="${parameterOb.startDateStr}">
						<!--<em data-v-9059e430="">结束时间</em>-->
						<!--<i data-v-9059e430="" class="iconfont"></i>-->
						<input data-v-9059e430="" id="LAY_demorange_e" class="easyui-datebox" size="11" name="endTime"
							   value="${parameterOb.endDateStr}">
					</div>
					<div data-v-55d6c893="" class="tableButton">
						<a data-v-55d6c893="" class="dark" onclick="finds()"><i data-v-55d6c893=""
																				class="iconfont"></i>查询</a>
					</div>
				</div>
				<div data-v-55d6c893="" class="reportTitle fix">
					<div data-v-55d6c893="" class="title"><em data-v-55d6c893=""><i data-v-55d6c893="" class="iconfont"></i></em>
						<div data-v-55d6c893=""><h6 data-v-55d6c893="">盈利</h6>
							<c:choose>
								<c:when test="${cpsReport.profit >= 0.00}">
									<p data-v-55d6c893="" class="light">${cpsReport.profit}</p>
								</c:when>
								<c:otherwise>
									<p data-v-55d6c893="" class="negative">${cpsReport.profit}</p>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					<div data-v-55d6c893="" class="title"><em data-v-55d6c893=""><i data-v-55d6c893="" class="iconfont"></i></em>
						<div data-v-55d6c893=""><h6 data-v-55d6c893="">盈率</h6>
							<c:choose>
								<c:when test="${cpsReport.earningsRatio >= 0.00}">
									<p data-v-55d6c893="" class="light">${cpsReport.earningsRatio}%</p>
								</c:when>
								<c:otherwise>
									<p data-v-55d6c893="" class="negative">${cpsReport.earningsRatio}%</p>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					<div data-v-55d6c893="" class="title"><em data-v-55d6c893=""><i data-v-55d6c893="" class="iconfont"></i></em>
						<div data-v-55d6c893=""><h6 data-v-55d6c893="">投注金额</h6>
							<p data-v-55d6c893="">${cpsReport.betAmount}</p></div>
					</div>
					<div data-v-55d6c893="" class="title"><em data-v-55d6c893=""><i data-v-55d6c893="" class="iconfont"></i></em>
						<div data-v-55d6c893=""><h6 data-v-55d6c893="">中奖金额</h6>
							<p data-v-55d6c893="" class="negative">${cpsReport.winningAmount}</p></div>
					</div>
				</div>
				<div data-v-55d6c893="" class="report fix">
					<div data-v-55d6c893="" class="reportCol reportCol1">
						<div data-v-55d6c893="" class="detail">
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">充值金额</em>
									<i data-v-55d6c893="" class="light">${cpsReport.rechargeAmount}</i>
								</div>
								<ul data-v-55d6c893="" class="detailRow">
									<li data-v-55d6c893="">
										<span data-v-55d6c893="">银行充值</span>
										<a data-v-55d6c893=""
										   class="bottomline light">${cpsReport.bankRechargeAmount}</a>
									</li>
									<li data-v-55d6c893="">
										<span data-v-55d6c893="">在线充值</span>
										<a data-v-55d6c893=""
										   class="bottomline light">${cpsReport.onlineRechargeAmount}</a>
									</li>
									<li data-v-55d6c893="">
										<span data-v-55d6c893="">充值手续费</span>
										<a data-v-55d6c893="" class="bottomline light">${cpsReport.rechargeFee}</a>
									</li>
									<li data-v-55d6c893="">
										<span data-v-55d6c893="">现金充值</span>
										<a data-v-55d6c893="" class="bottomline light">${cpsReport.cashRecharge}</a>
									</li>
								</ul>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">提现金额</em>
									<i data-v-55d6c893="" class="negative">${cpsReport.withdrawalAmount}</i>
								</div>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">返点金额</em>
									<i data-v-55d6c893="" class="negative">${cpsReport.rebateAmount}</i>
								</div>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">活动礼金</em>
									<i data-v-55d6c893="" class="negative">${cpsReport.activityAmount}</i>
								</div>
							</div>
						</div>
					</div>
					<div data-v-55d6c893="" class="reportCol reportCol2">
						<div data-v-55d6c893="" class="detail">
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">充值笔数</em>
									<a data-v-55d6c893="" class="light">${cpsReport.rechargeAmountNum}</a>
								</div>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">提现笔数</em>
									<i data-v-55d6c893="" class="negative">${cpsReport.withdrawalAmountNum}</i>
								</div>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">管理员扣减</em>
									<i data-v-55d6c893="" class="light">${cpsReport.administratorDeduction}</i>
								</div>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">拒绝提款金额</em>
									<i data-v-55d6c893="" class="light">${cpsReport.refuseWithdrawalAmount}</i>
								</div>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">拒绝充值金额</em>
									<i data-v-55d6c893="" class="negative">${cpsReport.refuseRechargeAmount}</i>
								</div>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">注册人数</em>
									<i data-v-55d6c893="" class="light">${cpsReport.registrationData}</i>
								</div>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">首充人数</em>
									<i data-v-55d6c893="" class="light">${cpsReport.firstChargeData}</i></div>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">在线人数</em>
									<i data-v-55d6c893="" class="light">${cpsReport.onlineUserData}</i>
								</div>
							</div>
						</div>
					</div>
					<div data-v-55d6c893="" class="reportCol reportCol3">
						<div data-v-55d6c893="" class="detail">
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">投注单量</em>
									<i data-v-55d6c893="" class="light">${cpsReport.bettingAmount}</i>
								</div>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">撤单金额</em>
									<i data-v-55d6c893="">${cpsReport.withdrawalBetAmount}</i>
								</div>
								<ul data-v-55d6c893="" class="detailRow">
									<li data-v-55d6c893=""><span data-v-55d6c893="">个人撤单</span>
										<ins data-v-55d6c893="" class="light">${cpsReport.withdrawalBetUser}</ins>
									</li>
									<li data-v-55d6c893=""><span data-v-55d6c893="">系统撤单</span>
										<ins data-v-55d6c893="" class="light">${cpsReport.withdrawalBetSys}</ins>
									</li>
								</ul>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">会员余额</em>
									<i data-v-55d6c893="" class="light">${cpsReport.userAmount}</i>
								</div>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">本月盈利</em>
									<c:choose>
										<c:when test="${cpsReport.profitThisMonth >= 0.00 }">
											<i data-v-55d6c893="" class="light">${cpsReport.profitThisMonth}</i>
										</c:when>
										<c:otherwise>
											<i data-v-55d6c893="" class="negative">${cpsReport.profitThisMonth}</i>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">本月盈率</em>
									<c:choose>
										<c:when test="${cpsReport.earningsRatioThisMonth >= 0.00 }">
											<i data-v-55d6c893="" class="light">${cpsReport.earningsRatioThisMonth}%</i>
										</c:when>
										<c:otherwise>
											<i data-v-55d6c893="" class="negative">${cpsReport.earningsRatioThisMonth}%</i>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">本月损益</em>
									<c:choose>
										<c:when test="${cpsReport.profitAndLossThisMonth >= 0.00 }">
											<i data-v-55d6c893="" class="light">${cpsReport.profitAndLossThisMonth}</i>
										</c:when>
										<c:otherwise>
											<i data-v-55d6c893="" class="negative">${cpsReport.profitAndLossThisMonth}</i>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">本月毛率</em>
									<c:choose>
										<c:when test="${cpsReport.grossRateThisMonth >= 0.00 }">
											<i data-v-55d6c893="" class="red">${cpsReport.grossRateThisMonth}%</i>
										</c:when>
										<c:otherwise>
											<i data-v-55d6c893="" class="negative">${cpsReport.grossRateThisMonth}%</i>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">上月盈利</em>
									<c:choose>
										<c:when test="${cpsReport.profitLastMonth >= 0.00 }">
											<i data-v-55d6c893="" class="light">${cpsReport.profitLastMonth}</i>
										</c:when>
										<c:otherwise>
											<i data-v-55d6c893="" class="negative">${cpsReport.profitLastMonth}</i>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">上月盈率</em>
									<c:choose>
										<c:when test="${cpsReport.earningsRatioLastMonth >= 0.00 }">
											<i data-v-55d6c893="" class="light">${cpsReport.earningsRatioLastMonth}%</i>
										</c:when>
										<c:otherwise>
											<i data-v-55d6c893="" class="negative">${cpsReport.earningsRatioLastMonth}%</i>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">上月损益</em>
									<c:choose>
										<c:when test="${cpsReport.profitAndLossLastMonth >= 0.00 }">
											<i data-v-55d6c893="" class="light">${cpsReport.profitAndLossLastMonth}</i>
										</c:when>
										<c:otherwise>
											<i data-v-55d6c893="" class="negative">${cpsReport.profitAndLossLastMonth}</i>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">上月毛率</em>
									<c:choose>
										<c:when test="${cpsReport.grossRateLastMonth >= 0.00 }">
											<i data-v-55d6c893="" class="light">${cpsReport.grossRateLastMonth}%</i>
										</c:when>
										<c:otherwise>
											<i data-v-55d6c893="" class="negative">${cpsReport.grossRateLastMonth}%</i>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>
					</div>
				</div>
				<p data-v-55d6c893="" class="tips">*
					温馨提示：盈利=损益-活动礼金-系统分红-理赔充值-私返-消费佣金+管理员扣减；盈率＝盈利/投注金额*100%；损益=投注金额-返点-中奖金额；毛利率=损益/投注金额*100%。</p>
				<div data-v-55d6c893="" class="vlayer list " style="display: none;">
					<div data-v-55d6c893="" class="shadow"></div>
					<div data-v-55d6c893="" class="v-cont">
						<div data-v-55d6c893="" class="v-con">
							<div data-v-55d6c893="" class="v">
								<div data-v-55d6c893="" class="title">充值明细表<a data-v-55d6c893="">关闭</a></div>
								<table data-v-55d6c893="">
									<tr data-v-55d6c893="">
										<th data-v-55d6c893="">类型</th>
										<th data-v-55d6c893="">金额</th>
										<th data-v-55d6c893="">人数</th>
									</tr>
									<tr data-v-55d6c893="">
										<td data-v-55d6c893="" colspan="3">暂无数据</td>
									</tr>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>