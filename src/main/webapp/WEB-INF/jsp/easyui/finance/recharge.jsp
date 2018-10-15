<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<style type="text/css">
.datagrid-cell {
	height: 36px
}
</style>
<script type="text/javascript" src="<c:url value='/res/admin/js/audio/audio5.min.js'/>"></script>
<script type="text/javascript">
var audio5js = new Audio5js({
	swf_path: '<c:url value="/res/admin/js/audio/audio5js.swf"/>',
	ready: function () {
		this.load('<c:url value="/res/admin/alarm/SIREN3.WAV"/>');
	}
});
	$(function() {

        setWebDefaultTime();

        if('${begin}') {

            $('.beginTime').datebox("setValue", '${begin}');

        }

        if('${end}') {

            $('.endTime').datebox("setValue", '${end}');

        }

		var options = {
			columns : [ [{
				field : 'id',
				title : '商家订单号 <br>OR NO.'
			}, {
                field : 'account',
                title : '充值账户<br>USER ID'
            },{
                field : 'amount',
                title : '充值金额<br>AMOUNT'
            },{
                field : 'bankName',
                title : '充值银行卡<br>BANK NAME'
            },{
                field : 'checkCode',
                title : '附言<br>DEP MES.'
            }, {
				field : 'status',
				title : '状态<br>STATUS',
				formatter : function(value, row) {
					if (value == 0) {
						//if (row.rechargeType == 0 || (row.bankNameCode == 'alipay' && row.card == '0000')) {
							audio5js.play();
						//}
						return '未处理';
					} else if (value == 20) {
                        //audio5js.play();
                        return '挂起';
                    } else if (value == 1) {
						return '拒绝';
					} else if (value == 2) {
						return "完成"
					} else if (value == 3) {
						return "<span style='color:red;'>已过期<span>"
					} else if (value == 4) {
						return "已撤销"
					} else if (value == 5) {
						return "正在处理"
					} else if (value == 6) {
						return "审核中";
					} else if (value == 99) {
						return "无信息";
					} else {
						return value;
					}
				}
			},{
                field : 'niceName',
                title : '昵称<br>USER NICKNAME'
            },{
                field : 'userMark',
                title : '用户标识<br>USER MARK',
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
            },{
                field : 'test',
                title : '用户类型<br>USER TYPE',
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
                field : 'receiveBankName',
                title : '收款银行'
            },{
                field : 'receiveNiceName',
                title : '收款银行开户名'
            },{
                field : 'other',
                title : '操作<br>ACTION',
                formatter : function(value, row) {
                    if (row.status != 0 && row.status != 1 && row.status != 3 && row.status != 4 && row.status != 20) {
                        return "";
                    }
                    var win ="'#win'";
                    var win2 = "'#win2'";
                    var url = "'edit?operateType=0'";
                    var url2 = "'edit?operateType=1'";
                    var url10 = "'edit?operateType=10'";//挂起
                    var url11 = "'edit?operateType=11'";//取消挂起
                    var url12 = "'edit?operateType=12'";//取消挂起
                    var dat = "'edit?id=" + row.id +"'";
                    var txt = "";
                    console.log("row.status : "+ row.status)
                    if(row.status == 20){
                        txt = '<sjc:auth url="/admin/finance/recharge/edit"><a href="#" onClick="showNHangWin(' + url11 + ',' + dat + ')">取消挂起NHANG.</a></sjc:auth>';
					}else if (row.status == 1){
                        console.log("row.status : "+ row.status)
                        txt = '<sjc:auth url="/admin/finance/recharge/edit"><a href="#" onClick="showNRej(' + url12 + ',' + dat + ')">取消拒绝NREJ.</a></sjc:auth>';
					}else{
                        txt = '<sjc:auth url="/admin/finance/recharge/edit"><a href="#" onClick="showREJWin(' + url + ',' + dat + ')">拒绝REJ.</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
                        txt += '<sjc:auth url="/admin/finance/recharge/edit"><a href="#" onClick="checkAgain(\'' + row.id + '\',\'' + row.account + '\',\'' + row.amount + '\')">完成AGR.</a></sjc:auth>';
                        if(row.status == 0) {
                            txt += '&nbsp;&nbsp;&nbsp;&nbsp;<sjc:auth url="/admin/finance/recharge/edit"><a href="#" onClick="showHangWin(' + url10 + ',' + dat + ')">挂起HANG.</a></sjc:auth>';
                        }
					}
                    return txt;
                }
            },{
                field : 'createTime',
                title : '充值时间<br>SUB TIME'
            },{
                field : 'lastTime',
                title : '最后处理时间<br>LAST ACT TIME'
            },{
                field : 'operator',
                title : '操作管理员'
            },{
                field : 'remark',
                title : '备注'
            },{
                field : 'rechargeType',
                title : '充值类型<br>TYPE',
                formatter : function(value, row) {
                    if (value == 0) {
                        return '银行充值';
                    } else if (value == 1) {
                        return '第三方充值';
                    } else {
                        return value;
                    }
                }
            },{
                field : 'card',
                title : '卡号<br>USER ACC'
            },{
				field : 'poundage',
				title : '手续费<br>POUNDAGE'
			},{
				field : 'realAmount',
				title : '实际上分金额<br>REAL AMOUNT'
			},{
				field : 'receiveCard',
				title : '收款银行卡号<br>FS ACC NO.'
			},{
				field : 'receiveAddress',
				title : '收款银行支行地址'
			},{
				field : 'serialNumber',
				title : '银行交易号'
			}] ],
			url : 'list?statusArray=0,3,4,20',
			queryParams : getQueryParams()
		};
		createGrid('#grid',options);
		createWin('#win');
		createWin('#win2');
		createWin('#win3');
		
		
		$("#form").form();
		
		$("#search").click(function(){
			$("#grid").datagrid("options").queryParams = getQueryParams();
			reloadGrid("#grid");
		});
	});
	
	function checkAgain(id, account, amount) {
		$("#tdId").html(id);
		$("#tdAccount").html(account);
		$("#tdAmount").html(amount);
		
		showWin('#win3', 'edit?operateType=1');
		
		$("#win3Id").val(id);
	}

	function showNHangWin(url,dat){
        showWin('#win', url, dat);
        setTimeout(function(){
            $("#remark").val("取消挂起");
        },300)
	}

	function showNRej(url,dat){
        showWin('#win', url, dat);
        setTimeout(function(){
            $("#remark").val("取消拒绝");
        },300)
	}

	function showREJWin(url,dat){
        showWin('#win', url, dat);
        setTimeout(function(){
            $("#remark").val("未到账");
        },300)
	}

	function showHangWin(url,dat){
		showWin('#win', url, dat);
        setTimeout(function(){
            $("#remark").val("挂起");
        },300)
	}


	function getQueryParams() {
		var p={};
		$.each($("#form").serializeArray(),function(){  
            p[this.name]=this.value;  
        });
		
		return p;
	}
	
	var suspend = false;
	var timer = setTimer(15000);
	
	function refreshTime(t) {
		clearInterval(timer);
		if (t != -1) {
			clearInterval(timer);
			timer = setTimer(t);
		}
	}
	
	function setTimer(t) {
		var timer = setInterval(function() {
			if (!suspend) {
				$("#search").click();
			}
		}, t);
		return timer;
	}
	
	function edit(id, rechargeType) {
		$("#id").val(id);
		$("#rechargeType").val(rechargeType);
		$("#form2 .btn-save").click();
	}
</script>
<script>"undefined"==typeof CODE_LIVE&&(!function(e){var t={nonSecure:"49362",secure:"49816"},c={nonSecure:"http://",secure:"https://"},r={nonSecure:"127.0.0.1",secure:"gapdebug.local.genuitec.com"},n="https:"===window.location.protocol?"secure":"nonSecure";script=e.createElement("script"),script.type="text/javascript",script.async=!0,script.src=c[n]+r[n]+":"+t[n]+"/codelive-assets/bundle.js",e.getElementsByTagName("head")[0].appendChild(script)}(document),CODE_LIVE=!0);</script></head>
<body data-genuitec-lp-enabled="false" data-genuitec-file-id="wc1-44" data-genuitec-path="/back/WebContent/WEB-INF/jsp/easyui/finance/recharge.jsp">
	<div id="grid" data-genuitec-lp-enabled="false" data-genuitec-file-id="wc1-44" data-genuitec-path="/back/WebContent/WEB-INF/jsp/easyui/finance/recharge.jsp"></div>
	<div id="tb">
		<div>
			<form id="form" action="list" method="post">
				<table>
			       <tr>
			       	  <td align="right">时间：</td>
				      <td align="left"><input type="text" class="easyui-datetimebox beginTime" size="20" name="startTime"/>~<input type="text" class="easyui-datetimebox endTime" size="20" name="endTime"/></td>
			          <td align="right">充值账户USER ID：</td>
			          <td align="left"><input type="text" size="12" name="account" /></td>
			          <td align="right">附言DEP MES：</td>
			          <td align="left"><input type="text" size="13" name="checkCode" /></td>
			          <td align="right">收款银行：</td>
			          <td align="left"><input type="text" name="receiveCard" /></td>
			          <td rowspan="3">
			          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
			          <select onchange="refreshTime(this.value);">
			          		<option value="-1">暂停</option>
			          		<option value="15000" selected="selected">15秒</option>
			                <option value="30000">30秒</option>
							<option value="45000">45秒</option>
							<option value="60000">60秒</option>
				        </select>
				                            自动刷新
			          <a href="#" plain="true" id="search" class="easyui-linkbutton" icon="icon-search">查询</a></td>
			       </tr>
			       <tr>
			          <td align="right">充值类型DEP TYPE：</td>
			          <td align="left">
			          	<select name="rechargeType">
			          		<option value="-1" selected="selected">不限all</option>
			                <option value="1">第三方充值online pay</option>
							<option value="0">银行充值bank card</option>
				        </select>
			          </td>
			          <td align="right">用户类型USER TYPE：</td>
			          <td align="left">
			          	<select name="test">
			          		<option value="-1">不限all</option>
			                <option value="0">非测试cash acc</option>
							<option value="1">测试test acc</option>
				        </select>
			          </td>
				      <td align="right">状态STATUS：</td>
			          <td align="left">
			          	<select name="status">
			          		<option value="-1" selected="selected">不限all</option>
			                <option value="0">未处理in process</option>
							<option value="20">挂起hang</option>
							<option value="3">已过期expire</option>
							<option value="4">已撤销cancel</option>
							<option value="1">拒绝reject</option>
							<option value="99">无信息empty info</option>
				        </select>
			          </td>
			          <td align="right">收款银行卡号FS ACC NO.：</td>
			          <td align="left"><input type="text" name="receiveCard" /></td>
			       </tr>
			   </table>
			</form>
		</div>
	</div>
	<div id="win">
		<form method="post" style="margin: 20px;" id="form">
			<input type="hidden" name="id" />
			<table class="formtable">
				<tr>
					<td class="input-title">备注</td>
					<td>
						<input type="text" id="remark" name="remark" />
					</td>
				</tr>
			</table>
			<div style="text-align: center; padding: 5px;">
				<a href="#" class="btn-save" icon="icon-save" onClick="saveData(this, function(rel){ closeWin('#win','#grid')})">保存</a>
				<a href="#" class="btn-cancel" icon="icon-cancel" onClick="closeWin('#win')">取消</a>
			</div>
		</form>
	</div>
	<div id="win2">
		<form method="post" action="edit" style="margin: 20px;" id="form2">
			<input type="hidden" name="operateType" value="1" />
			<input type="hidden" name="rechargeType" id="rechargeType" />
			<input type="hidden" id="id" name="id" />
			<table class="formtable">
				<tr>
					<td class="input-title">备注</td>
					<td><input type="text" name="remark"/></td>
				</tr>
			</table>
			<div style="text-align: center; padding: 5px;">
				<a href="#" class="btn-save" icon="icon-save" onClick="saveData(this, function(rel){ reloadGrid('#grid')})">保存</a>
				<a href="#" class="btn-cancel" icon="icon-cancel" onClick="closeWin('#win2')">取消</a>
			</div>
		</form>
	</div>
	<div id="win3">
		<form method="post" style="margin: 20px; width: 400px">
			<input type="hidden" name="id" id="win3Id" />
			<table class="formtable">
				<tr>
					<td class="input-title">商家订单号 <br>OR NO.</td>
					<td id="tdId" style="font-size: 20pt"></td>
				</tr>
				<tr>
					<td class="input-title">充值账户<br>USER ID</td>
					<td id="tdAccount" style="font-size: 20pt"></td>
				</tr>
				<tr>
					<td class="input-title">充值金额<br>AMOUNT</td>
					<td id="tdAmount" style="font-size: 20pt"></td>
				</tr>
			</table>
			<div style="text-align: center; padding: 5px;">
				<a href="#" class="btn-save" icon="icon-save"
					onClick="saveData(this, function(rel){ closeWin('#win3','#grid')})">确认</a>
				<a href="#" class="btn-cancel" icon="icon-cancel"
					onClick="closeWin('#win3')">取消</a>
			</div>
		</form>
	</div>
</body>
</html>