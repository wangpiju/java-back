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
	<style type="text/css">
		#bg{ display: none;  position: absolute;  top: 0%;  left: 0%;  width: 100%;  height: 100%;  background-color: black;  z-index:1001;  -moz-opacity: 0.7;  opacity:.70;  filter: alpha(opacity=70);}
		#show{display: none;  position: absolute;  top: 45%;  left: 45%;  width: 200px;  height: 50px;  padding: 8px;  border: 8px solid #E8E9F7;  background-color: white;  z-index:1002;  overflow: auto;}
	</style>
	<link href="<c:url value='/res/admin/js/reportRoles/app.18919bffdf6854ca2430028c0edd405a.css'/>" rel="stylesheet">
	<title>综合报表</title>
	<script type="text/javascript">

		//-------------初始化-------------------
		var readyFlagDateFlag = 0;
        var readyFlagMonThis = 0;
        var readyFlagMonLast = 0;


        function showdiv() {
            document.getElementById("bg").style.display = "block";
            document.getElementById("show").style.display = "block";
        }
        function hidediv() {
            document.getElementById("bg").style.display = 'none';
            document.getElementById("show").style.display = 'none';
        }

		$(document).ready(function () {
		    console.log(1);
            showdiv();
			var dateFlag = 0;
			var  dateFlag_id = 'dateFlag_day';
			dateFlag_onclick(dateFlag_id, dateFlag, 'ready');

		});
        function rfc(){
            //console.log("red");
            if(readyFlagDateFlag == 1 && readyFlagMonThis == 1 && readyFlagMonLast == 1){
                //setTimeout("hidediv()",1000);
                hidediv();
			}
		}


        function setMonData(dateFlag_value) {

            var code_v;
            var message_v;

            $.ajax({
                type: "GET",
                async: true,
                url: document.location.origin + "/newReport/cpsNReport/getCpsReportByDateFlag",
                dataType: "json",
                data: {dateFlag:dateFlag_value},
                success: function(datas){

                    if(dateFlag_value == 2){
                        readyFlagMonThis = 1;
                        rfc();
                    }
                    if(dateFlag_value == 3){
                        readyFlagMonLast = 1;
                        rfc();
                    }

                    var json = eval(datas); //数组
                    $.each(json, function (index) {
                        if(index == 'code'){
                            code_v = json[index];
                        }
                        if(code_v == 0){
                            if(index == 'data'){
                                var message = json[index].message;
                                message_v = message;
                            }
                        }else if(index == 'data'){
                            setReportData(json[index], dateFlag_value);
                        }
                    });
                }

            });

            if(code_v != null){
                if(code_v == 0) {
                    $.messager.alert(message_v);
                }
            }

        }


        function finds_Z(){
            showdiv();
            finds();
		}

		function finds() {
            var startDateStr_V = document.getElementsByName('startTime')[0].value;
            var endDateStr_V = document.getElementsByName('endTime')[0].value;

            if(startDateStr_V == null || startDateStr_V == '' || endDateStr_V == null || endDateStr_V == ''){
                hidediv();
                $.messager.alert('错误', '[开始日期]或[结束日期]不能为空', 'error');
                return;
			}

			if (startDateStr_V > endDateStr_V) {
                hidediv();
				$.messager.alert('错误', '[开始日期]不能大于[结束日期]', 'error');
				return;
			}


            var code_v;
            var message_v;

            $.ajax({
                type: "GET",
                async: true,
                url: document.location.origin + "/newReport/cpsNReport/getCpsReportByDate",
                dataType: "json",
                data: {startDateStr:startDateStr_V, endDateStr:endDateStr_V},
                success: function(datas){
                    hidediv();
                    var json = eval(datas); //数组
                    $.each(json, function (index) {
                        if(index == 'code'){
                            code_v = json[index];
                        }
                        if(code_v == 0){
                            if(index == 'data'){
                                var message = json[index].message;
                                message_v = message;
                            }
                        }else if(index == 'data'){
                            setReportData(json[index], 11);
                        }
                    });
                }

            });

            if(code_v != null){
                if(code_v == 0) {
                    $.messager.alert(message_v);
                }
            }

		}


        function dateFlag_onclick_Z(dateFlag_id, dateFlag_value) {
            showdiv();
            dateFlag_onclick(dateFlag_id, dateFlag_value, 'onclik');
        }

		function dateFlag_onclick(dateFlag_id, dateFlag_value, typeStr) {

			var arr = ['dateFlag_day', 'dateFlag_lday', 'dateFlag_mday', 'dateFlag_lmday'];
			for (var i = 0; i < arr.length; i++) {
				document.getElementById(arr[i]).setAttribute("class", "");
			}
			document.getElementById(dateFlag_id).setAttribute("class", "curr");

            var code_v;
            var message_v;

            $.ajax({
                type: "GET",
                async: true,
                url: document.location.origin + "/newReport/cpsNReport/getCpsReportByDateFlag",
                dataType: "json",
                data: {dateFlag:dateFlag_value},
                success: function(datas){

                    if(typeStr == 'ready'){
                        readyFlagDateFlag = 1;
                        rfc();
                        setMonData(2);
                        setMonData(3);
                    }
                    if(typeStr == 'onclik'){
                        hidediv();
                    }

                    var json = eval(datas); //数组
                    $.each(json, function (index) {
                        if(index == 'code'){
                            code_v = json[index];
                        }
                        if(code_v == 0){
                            if(index == 'data'){
                                var message = json[index].message;
                                message_v = message;
                            }
                        }else if(index == 'data'){
                            setReportData(json[index], 11);
                        }
                    });

                }

            });

            if(code_v != null){
                if(code_v == 0) {
                    $.messager.alert(message_v);
                }
            }

            if(dateFlag_value == 0){
                //取会员余额
				setUserAllAmount();
                //取当前在线人数
				setOnlineUserNum();
			}

		}

		function setReportData(jsonData, type){
            var rechargeBankAmount = jsonData.rechargeBankAmount;//银行充值金额
            var rechargeBankNum = jsonData.rechargeBankNum;//银行充值人数---
            var rechargeBankOrNum = jsonData.rechargeBankOrNum;//充值笔数
            var rechargeOnlineAmount = jsonData.rechargeOnlineAmount;//在线充值金额
            var rechargeOnlineNum = jsonData.rechargeOnlineNum;//在线充值人数---
            var rechargeOnlineOrNum = jsonData.rechargeOnlineOrNum;//充值笔数
            var rechargeHandAmount = jsonData.rechargeHandAmount;//充值手续费金额
            var rechargeHandNum = jsonData.rechargeHandNum;//充值手续费人数---
            var rechargeHandOrNum = jsonData.rechargeHandOrNum;//充值笔数
            var rechargeCashAmount = jsonData.rechargeCashAmount;//现金充值金额
            var rechargeCashNum = jsonData.rechargeCashNum;//现金充值人数---
            var rechargeCashOrNum = jsonData.rechargeCashOrNum;//充值笔数
            var withdrawAmount = -(jsonData.withdrawAmount);//提现金额
            var withdrawNum = jsonData.withdrawNum;//提现人数---
            var withdrawOrNum = jsonData.withdrawOrNum;//提现笔数
            var rebateAmount = jsonData.rebateAmount;//返点金额
            var rebateNum = jsonData.rebateNum;//返点人数---
            var distributeActivityAmount = jsonData.distributeActivityAmount;//活动派发金额
            var distributeActivityNum = jsonData.distributeActivityNum;//活动派发人数---
            var distributeClaimAmount = jsonData.distributeClaimAmount;//理赔充值金额
            var distributeClaimNum = jsonData.distributeClaimNum;//理赔充值人数---
            var distributeDailyAmount = jsonData.distributeDailyAmount;//日工资金额
            var distributeDailyNum = jsonData.distributeDailyNum;//日工资人数---
            var distributeDividendAmount = jsonData.distributeDividendAmount;//周期分红金额
            var distributeDividendNum = jsonData.distributeDividendNum;//周期分红人数---
            var distributeAdminAmount = jsonData.distributeAdminAmount;//管理员派发金额
            var distributeAdminNum = jsonData.distributeAdminNum;//管理员派发人数---
            var deductionAdministraAmount = jsonData.deductionAdministraAmount;//行政提出金额
            var deductionAdministraNum = jsonData.deductionAdministraNum;//行政提出人数---
            var deductionAdminAmount = jsonData.deductionAdminAmount;//管理员扣减金额
            var deductionAdminNum = jsonData.deductionAdminNum;//管理员扣减人数---
            var regNum = jsonData.regNum;//注册人数
            var firstChargeNum = jsonData.firstChargeNum;//首充人数
            var betNum = jsonData.betNum;//投注单量
            var betAmount = jsonData.betAmount;//投注金额
            var betPerNum = jsonData.betPerNum;//投注人数---
            var winAmount = jsonData.winAmount;//中奖金额
            var winPerNum = jsonData.winPerNum;//中奖人数---
            var withdrawalPerAmount = jsonData.withdrawalPerAmount;//个人撤单金额
            var withdrawalPerNum = jsonData.withdrawalPerNum;//个人撤单人数---
            var withdrawalSysAmount = jsonData.withdrawalSysAmount;//系统撤单金额
            var withdrawalSysNum = jsonData.withdrawalSysNum;//系统撤单人数---

			//------------------------------------------------------------------------------------

			var rechargeAmountAll = rechargeBankAmount + rechargeOnlineAmount + rechargeHandAmount + rechargeCashAmount;//充值金额
			var rechargePerAll = jsonData.rechargeAllNum;//充值人数
			var rechargeOrNumAll = rechargeBankOrNum + rechargeOnlineOrNum + rechargeHandOrNum + rechargeCashOrNum;//充值笔数

			var platformDistributionAmountAll = distributeActivityAmount + distributeClaimAmount + distributeDailyAmount + distributeDividendAmount + distributeAdminAmount;//平台派发金额
			var platformDistributionPerAll = jsonData.distributeAllNum;//平台派发人数

			var platformDeductionAmountAll = deductionAdministraAmount + deductionAdminAmount;//平台扣减金额
            var platformDeductionPerAll = jsonData.deductionAllNum;//平台扣减人数

			var withdrawalBetAmountAll = withdrawalPerAmount + withdrawalSysAmount;//撤单金额
			var withdrawalBetPerAll = jsonData.withdrawalAllNum;//撤单人数

			//alert('betAmount：'+betAmount);
            //alert('rebateAmount：'+rebateAmount);
            //alert('winAmount：'+winAmount);
            //alert('betAmount - rebateAmount - winAmount：'+ (betAmount - rebateAmount - winAmount));
			var profitAndLoss = betAmount - rebateAmount - winAmount;//损益=投注金额-返点-中奖金额；
			var grossRate = (profitAndLoss/betAmount)*100;//毛利率=损益/投注金额*100%；
			var profit = profitAndLoss - platformDistributionAmountAll + platformDeductionAmountAll;//盈利=损益-平台派发+平台扣减；
			var earningsRatio = (profit/betAmount)*100;//盈率=盈利/投注金额*100%；

            //document.getElementById('rechargeAmount').innerHTML = OOOOO + '/' + OOOOO + '人';//
            if(type == 11){
                document.getElementById('profit').innerHTML = profit.toFixed(2);//盈利
				if(profit < 0) document.getElementById('profit').setAttribute("class", "negative");
				else document.getElementById('profit').setAttribute("class", "light");
                document.getElementById('earningsRatio').innerHTML = earningsRatio.toFixed(2) + '%';//盈率
                if(earningsRatio < 0) document.getElementById('earningsRatio').setAttribute("class", "negative");
                else document.getElementById('earningsRatio').setAttribute("class", "light");
                document.getElementById('grossRate').innerHTML = grossRate.toFixed(2) + '%';//毛率
                if(grossRate < 0) document.getElementById('grossRate').setAttribute("class", "negative");
                else document.getElementById('grossRate').setAttribute("class", "light");
                document.getElementById('betAmount').innerHTML = betAmount.toFixed(2) + '/' + betPerNum + '人';//投注金额
                document.getElementById('winningAmount').innerHTML = winAmount.toFixed(2) + '/' + winPerNum + '人';//中奖金额
                document.getElementById('rechargeAmount').innerHTML = rechargeAmountAll.toFixed(2) + '/' + rechargePerAll + '人';//充值金额
                document.getElementById('bankRechargeAmount').innerHTML = rechargeBankAmount.toFixed(2) + '/' + rechargeBankNum + '人';//银行充值
                document.getElementById('onlineRechargeAmount').innerHTML = rechargeOnlineAmount.toFixed(2) + '/' + rechargeOnlineNum + '人';//在线充值
                document.getElementById('rechargeFee').innerHTML = rechargeHandAmount.toFixed(2) + '/' + rechargeHandNum + '人';//充值手续费
                document.getElementById('cashRecharge').innerHTML = rechargeCashAmount.toFixed(2) + '/' + rechargeCashNum + '人';//现金充值
                document.getElementById('withdrawalAmount').innerHTML = withdrawAmount.toFixed(2) + '/' + withdrawNum + '人';//提现金额
                document.getElementById('rebateAmount').innerHTML = rebateAmount.toFixed(2) + '/' + rebateNum + '人';//返点金额
                document.getElementById('platformDistribution').innerHTML = platformDistributionAmountAll.toFixed(2) + '/' + platformDistributionPerAll + '人';//平台派发
                document.getElementById('distributeActivity').innerHTML = distributeActivityAmount.toFixed(2) + '/' + distributeActivityNum + '人';//活动派发
                document.getElementById('distributeClaim').innerHTML = distributeClaimAmount.toFixed(2) + '/' + distributeClaimNum + '人';//理赔充值
                document.getElementById('distributeDaily').innerHTML = distributeDailyAmount.toFixed(2) + '/' + distributeDailyNum + '人';//日工资
                document.getElementById('distributeDividend').innerHTML = distributeDividendAmount.toFixed(2) + '/' + distributeDividendNum + '人';//周期分红
                document.getElementById('distributeAdmin').innerHTML = distributeAdminAmount.toFixed(2) + '/' + distributeAdminNum + '人';//管理员派发
                document.getElementById('rechargeHandOrNum').innerHTML = rechargeOrNumAll + '/' + rechargePerAll + '人';//充值笔数
                document.getElementById('withdrawOrNum').innerHTML = withdrawOrNum + '/' + withdrawNum + '人';//提现笔数
                document.getElementById('platformDeduction').innerHTML = platformDeductionAmountAll.toFixed(2) + '/' + platformDeductionPerAll + '人';//平台扣减
                document.getElementById('deductionAdministra').innerHTML = deductionAdministraAmount.toFixed(2) + '/' + deductionAdministraNum + '人';//行政提出
                document.getElementById('deductionAdmin').innerHTML = deductionAdminAmount.toFixed(2) + '/' + deductionAdminNum + '人';//管理员扣减
                document.getElementById('regNum').innerHTML = regNum + '人';//注册人数
                document.getElementById('firstChargeNum').innerHTML = firstChargeNum + '人';//首充人数
                document.getElementById('betNum').innerHTML = betNum + '/' + betPerNum + '人';//投注单量
                document.getElementById('withdrawal').innerHTML = withdrawalBetAmountAll.toFixed(2) + '/' + withdrawalBetPerAll + '人';//撤单金额
                document.getElementById('withdrawalPer').innerHTML = withdrawalPerAmount.toFixed(2) + '/' + withdrawalPerNum + '人';//个人撤单
                document.getElementById('withdrawalSys').innerHTML = withdrawalSysAmount.toFixed(2) + '/' + withdrawalSysNum + '人';//系统撤单
			}else if(type == 2){
                document.getElementById('profitThisMonth').innerHTML = profit.toFixed(2);//本月盈利
                if(profit < 0) document.getElementById('profitThisMonth').setAttribute("class", "negative");
                document.getElementById('earningsRatioThisMonth').innerHTML = earningsRatio.toFixed(2) + '%';//本月盈率
                if(earningsRatio < 0) document.getElementById('earningsRatioThisMonth').setAttribute("class", "negative");
                document.getElementById('profitAndLossThisMonth').innerHTML = profitAndLoss.toFixed(2);//本月损益
                if(profitAndLoss < 0) document.getElementById('profitAndLossThisMonth').setAttribute("class", "negative");
                document.getElementById('grossRateThisMonth').innerHTML = grossRate.toFixed(2) + '%';//本月毛率
                if(grossRate < 0) document.getElementById('grossRateThisMonth').setAttribute("class", "negative");
			}else if(type == 3){
                document.getElementById('profitLastMonth').innerHTML = profit.toFixed(2);//上月盈利
                if(profit < 0) document.getElementById('profitLastMonth').setAttribute("class", "negative");
                document.getElementById('earningsRatioLastMonth').innerHTML = earningsRatio.toFixed(2) + '%';//上月盈率
                if(earningsRatio < 0) document.getElementById('earningsRatioLastMonth').setAttribute("class", "negative");
                document.getElementById('profitAndLossLastMonth').innerHTML = profitAndLoss.toFixed(2);//上月损益
                if(profitAndLoss < 0) document.getElementById('profitAndLossLastMonth').setAttribute("class", "negative");
                document.getElementById('grossRateLastMonth').innerHTML = grossRate.toFixed(2) + '%';//上月毛率
                if(grossRate < 0) document.getElementById('grossRateLastMonth').setAttribute("class", "negative");
            }
		}

		//设置会员余额
		function setUserAllAmount() {

            var code_v;
            var message_v;

            $.ajax({
                type: "GET",
                async: true,
                url: document.location.origin + "/newReport/cpsNReport/getAmountAllUser",
                dataType: "json",
                data: {},
                success: function(datas){
                    var json = eval(datas); //数组
                    $.each(json, function (index) {
                        if(index == 'code'){
                            code_v = json[index];
                        }
                        if(code_v == 0){
                            if(index == 'data'){
                                var message = json[index].message;
                                message_v = message;
                            }
                        }else if(index == 'data'){
                            var allAmount = json[index].allAmount;
                            document.getElementById('userAmount').innerHTML = allAmount;//用户余额
                        }
                    });
                }

            });

            if(code_v != null){
                if(code_v == 0) {
                    $.messager.alert(message_v);
                }
            }

        }


        function setOnlineUserNum(){

            var code_v;
            var message_v;

            $.ajax({
                type: "GET",
                async: true,
                url: document.location.origin + "/newReport/cpsNReport/getOnlineUserNum",
                dataType: "json",
                data: {},
                success: function(datas){
                    var json = eval(datas); //数组
                    $.each(json, function (index) {
                        if(index == 'code'){
                            code_v = json[index];
                        }
                        if(code_v == 0){
                            if(index == 'data'){
                                var message = json[index].message;
                                message_v = message;
                            }
                        }else if(index == 'data'){
                            var onlineUserNum = json[index].onlineUserNum;
                            document.getElementById('onlineUserData').innerHTML = onlineUserNum;//在线人数
                        }
                    });
                }

            });

            if(code_v != null){
                if(code_v == 0) {
                    $.messager.alert(message_v);
                }
            }

		}


	</script>
</head>
<body>
<div id="app" class="nav_sm_con">
	<div class="content fix">
		<div class="mainContent">
			<div data-v-55d6c893="">
				<div data-v-55d6c893="" class="tableFilter">
					<div data-v-465b8d5c="" data-v-55d6c893="" class="tableFilterDay">
						<a data-v-465b8d5c="" id="dateFlag_day" class="curr" onclick="dateFlag_onclick_Z(this.id,0)">今天</a>
						<a data-v-465b8d5c="" id="dateFlag_lday" onclick="dateFlag_onclick_Z(this.id,1)">昨天</a>
						<a data-v-465b8d5c="" id="dateFlag_mday" onclick="dateFlag_onclick_Z(this.id,2)">本月</a>
						<a data-v-465b8d5c="" id="dateFlag_lmday" onclick="dateFlag_onclick_Z(this.id,3)">上月</a>
					</div>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<div data-v-9059e430="" data-v-55d6c893="" class="tableFilterTime">
						<em data-v-9059e430="">统计日期</em>
						<!--<i data-v-9059e430="" class="iconfont"></i>-->
						<input data-v-9059e430="" id="LAY_demorange_s" class="easyui-datebox" size="11" name="startTime" >
						<!--<em data-v-9059e430="">结束时间</em>-->
						<!--<i data-v-9059e430="" class="iconfont"></i>-->
						<input data-v-9059e430="" id="LAY_demorange_e" class="easyui-datebox" size="11" name="endTime" >
					</div>
					<div data-v-55d6c893="" class="tableButton">
						<a data-v-55d6c893="" class="dark" onclick="finds_Z()"><i data-v-55d6c893="" class="iconfont"></i>查询</a> &nbsp;&nbsp;[注：除“今天”外的按钮获取的是定时任务产生的历史数据]
					</div>
				</div>
				<div data-v-55d6c893="" class="reportTitle fix">
					<div data-v-55d6c893="" class="title">
						<div data-v-55d6c893=""><h6 data-v-55d6c893="">盈利</h6>
									<p data-v-55d6c893="" class="light" id="profit"></p>
						</div>
					</div>
					<div data-v-55d6c893="" class="title">
						<div data-v-55d6c893=""><h6 data-v-55d6c893="">盈率</h6>
									<p data-v-55d6c893="" class="light" id="earningsRatio"></p>
						</div>
					</div>
					<div data-v-55d6c893="" class="title">
						<div data-v-55d6c893=""><h6 data-v-55d6c893="">毛率</h6>
							<p data-v-55d6c893="" class="light" id="grossRate"></p>
						</div>
					</div>
					<div data-v-55d6c893="" class="title">
						<div data-v-55d6c893=""><h6 data-v-55d6c893="">投注金额</h6>
							<p data-v-55d6c893="" class="light" id="betAmount"></p></div>
					</div>
					<div data-v-55d6c893="" class="title">
						<div data-v-55d6c893=""><h6 data-v-55d6c893="">中奖金额</h6>
							<p data-v-55d6c893="" class="light" id="winningAmount"></p></div>
					</div>
				</div>
				<div data-v-55d6c893="" class="report fix">
					<div data-v-55d6c893="" class="reportCol reportCol1">
						<div data-v-55d6c893="" class="detail">
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">充值金额</em>
									<i data-v-55d6c893="" class="light" id="rechargeAmount"></i>
								</div>
								<ul data-v-55d6c893="" class="detailRow">
									<li data-v-55d6c893="">
										<span data-v-55d6c893="">银行充值</span>
										<a data-v-55d6c893=""
										   class="bottomline light" id="bankRechargeAmount"></a>
									</li>
									<li data-v-55d6c893="">
										<span data-v-55d6c893="">在线充值</span>
										<a data-v-55d6c893=""
										   class="bottomline light" id="onlineRechargeAmount"></a>
									</li>
									<li data-v-55d6c893="">
										<span data-v-55d6c893="">充值手续费</span>
										<a data-v-55d6c893="" class="bottomline light" id="rechargeFee"></a>
									</li>
									<li data-v-55d6c893="">
										<span data-v-55d6c893="">现金充值</span>
										<a data-v-55d6c893="" class="bottomline light" id="cashRecharge"></a>
									</li>
								</ul>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">提现金额</em>
									<i data-v-55d6c893="" class="light" id="withdrawalAmount"></i>
								</div>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">返点金额</em>
									<i data-v-55d6c893="" class="light" id="rebateAmount"></i>
								</div>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">平台派发</em>
									<i data-v-55d6c893="" class="light" id="platformDistribution"></i>
								</div>
								<ul data-v-55d6c893="" class="detailRow">
									<li data-v-55d6c893="">
										<span data-v-55d6c893="">活动派发</span>
										<a data-v-55d6c893=""
										   class="bottomline light" id="distributeActivity"></a>
									</li>
									<li data-v-55d6c893="">
										<span data-v-55d6c893="">理赔充值</span>
										<a data-v-55d6c893=""
										   class="bottomline light" id="distributeClaim"></a>
									</li>
									<li data-v-55d6c893="">
										<span data-v-55d6c893="">日工资</span>
										<a data-v-55d6c893="" class="bottomline light" id="distributeDaily"></a>
									</li>
									<li data-v-55d6c893="">
										<span data-v-55d6c893="">周期分红</span>
										<a data-v-55d6c893="" class="bottomline light" id="distributeDividend"></a>
									</li>
									<li data-v-55d6c893="">
										<span data-v-55d6c893="">管理员派发</span>
										<a data-v-55d6c893="" class="bottomline light" id="distributeAdmin"></a>
									</li>
								</ul>
							</div>
						</div>
					</div>
					<div data-v-55d6c893="" class="reportCol reportCol2">
						<div data-v-55d6c893="" class="detail">
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">充值笔数</em>
									<i data-v-55d6c893="" id="rechargeHandOrNum"></i>
								</div>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">提现笔数</em>
									<i data-v-55d6c893="" id="withdrawOrNum"></i>
								</div>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">平台扣减</em>
									<i data-v-55d6c893="" class="light" id="platformDeduction"></i>
								</div>
								<ul data-v-55d6c893="" class="detailRow">
									<li data-v-55d6c893=""><span data-v-55d6c893="">行政提出</span>
										<ins data-v-55d6c893="" class="light" id="deductionAdministra"></ins>
									</li>
									<li data-v-55d6c893=""><span data-v-55d6c893="">管理员扣减</span>
										<ins data-v-55d6c893="" class="light" id="deductionAdmin"></ins>
									</li>
								</ul>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">注册人数</em>
									<i data-v-55d6c893="" id="regNum"></i>
								</div>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">首充人数</em>
									<i data-v-55d6c893="" id="firstChargeNum"></i></div>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">在线人数</em>
									<i data-v-55d6c893="" id="onlineUserData"></i>
								</div>
							</div>
						</div>
					</div>
					<div data-v-55d6c893="" class="reportCol reportCol3">
						<div data-v-55d6c893="" class="detail">
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">投注单量</em>
									<i data-v-55d6c893="" id="betNum"></i>
								</div>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">撤单金额</em>
									<i data-v-55d6c893="" class="light" id="withdrawal"></i>
								</div>
								<ul data-v-55d6c893="" class="detailRow">
									<li data-v-55d6c893=""><span data-v-55d6c893="">个人撤单</span>
										<ins data-v-55d6c893="" class="light" id="withdrawalPer"></ins>
									</li>
									<li data-v-55d6c893=""><span data-v-55d6c893="">系统撤单</span>
										<ins data-v-55d6c893="" class="light" id="withdrawalSys"></ins>
									</li>
								</ul>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">会员余额</em>
									<i data-v-55d6c893="" class="light" id="userAmount"></i>
								</div>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">本月盈利</em>
											<i data-v-55d6c893="" class="light" id="profitThisMonth"></i>
								</div>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">本月盈率</em>
											<i data-v-55d6c893="" class="light" id="earningsRatioThisMonth"></i>
								</div>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">本月损益</em>
											<i data-v-55d6c893="" class="light" id="profitAndLossThisMonth"></i>
								</div>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">本月毛率</em>
											<i data-v-55d6c893="" class="red" id="grossRateThisMonth"></i>
								</div>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">上月盈利</em>
											<i data-v-55d6c893="" class="light" id="profitLastMonth"></i>
								</div>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">上月盈率</em>
											<i data-v-55d6c893="" class="light" id="earningsRatioLastMonth"></i>
								</div>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">上月损益</em>
											<i data-v-55d6c893="" class="light" id="profitAndLossLastMonth"></i>
								</div>
							</div>
							<div data-v-55d6c893="" class="titleRow">
								<div data-v-55d6c893="">
									<em data-v-55d6c893="">上月毛率</em>
											<i data-v-55d6c893="" class="light" id="grossRateLastMonth"></i>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div>
		&nbsp;&nbsp;&nbsp;&nbsp;<br/>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*温馨提示：&nbsp;&nbsp;损益=投注金额-返点-中奖金额；&nbsp;&nbsp;毛利率=损益/投注金额*100%；&nbsp;&nbsp;盈利=损益-平台派发+平台扣减；&nbsp;&nbsp;盈率=盈利/投注金额*100%；
	</div>
	<div id="bg"></div>
	<div id="show">&nbsp;&nbsp;&nbsp;请等待 ......................</div>
</div>
</body>
</html>