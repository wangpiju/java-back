<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
$(function() {
	$("#win").find("a.btn-save,a.btn-cancel").linkbutton();
	
	createWin('#win2', {title:'确认信息', onClose : function(){
		$("#subButton").show();
	}});
	
	var message = '${message}';
	if(message) {
		$.messager.alert('提示', message, 'info');
	}
});

var checkMoney = function(obj) {
	var me = obj,v = me.value,index;
	me.value = v = v.replace(/^\.$/g, '');		
	index = v.indexOf('.');
	if (index > 0) {
		me.value = v = v.replace(/(.+\..*)(\.)/g, '$1');			
		if(v.substring(index + 1, v.length).length > 2) {				
			me.value= v  = v.substring(0, v.indexOf(".") + 3);
		}
	} else {
		me.value = v = v.replace(/^0/g, '');
	}		
	me.value = v = v.replace(/[^\d|^\.]/g, '');
	me.value = v = v.replace(/^00/g, '0');				
};

function selectBank(ths) {
	$("#issueBankName").val($(ths).find("option[value='"+ths.value+"']").html());
}

function selectClassKey(ths) {
	$("#bank optgroup").hide();
	var value = ths.value;
	if (value == 'xingxin') {
		$("#method").val("proxypay");
		$("#xingxinGroup").show();
	} else if (value == 'le') {
		$("#method").val("transfer");
		$("#leGroup").show();
	}
}

function subForm(ths) {
	$(ths).hide();
	
	var p={};
	$.each($("#form").serializeArray(),function(){  
    	p[this.name]=this.value;  
    });

	var classKey = p['classKey'];
	if (!classKey) {
		return error(ths, '请选择接口！');		
	}
	
	if (classKey == 'xingxin') {
		if (!p['merchantCode']) {
			return error(ths, '请填写商户号！');
		}
		if (!p['amount']) {
			return error(ths, '请填写金额！');
		}
		if (!p['bank']) {
			return error(ths, '请选择银行！');
		}
		if (!p['issueBankName']) {
			return error(ths, '请填写银行名称！');
		}
		if (!p['issueBankAddress']) {
			return error(ths, '请填写支行地址！');
		}
		if (!p['cardNum']) {
			return error(ths, '请填写卡号！');
		}
		if (!p['cardName']) {
			return error(ths, '请填写户名！');
		}
		if (!p['extends1']) {
			return error(ths, '请填写身份证！');
		}
		if (!p['extends2']) {
			return error(ths, '请填写手机号！');
		}
		if (!p['shopUrl']) {
			return error(ths, '请填写商城地址！');
		}
		if (!p['key']) {
			return error(ths, '请填写秘钥！');
		}
		if (!p['publicKey']) {
			return error(ths, '请填写公钥！');
		}
	} else if (classKey == 'le') {
		if (!p['merchantCode']) {
			return error(ths, '请填写商户号！');
		}
		if (!p['amount']) {
			return error(ths, '请填写金额！');
		}
		if (!p['bank']) {
			return error(ths, '请选择银行！');
		}
		if (!p['issueBankName']) {
			return error(ths, '请填写银行名称！');
		}
		if (!p['issueBankAddress']) {
			return error(ths, '请填写支行地址！');
		}
		if (!p['cardNum']) {
			return error(ths, '请填写卡号！');
		}
		if (!p['cardName']) {
			return error(ths, '请填写户名！');
		}
		if (!p['extends1']) {
			return error(ths, '请填写身份证！');
		}
		if (!p['extends2']) {
			return error(ths, '请填写手机号！');
		}
		if (!p['shopUrl']) {
			return error(ths, '请填写商城地址！');
		}
		if (!p['key']) {
			return error(ths, '请填写秘钥！');
		}
		if (!p['publicKey']) {
			return error(ths, '请填写公钥！');
		}
		
		// le
		if (!p['extends3']) {
			return error(ths, '请填写银行卡省份！');
		}
		if (!p['memo']) {
			return error(ths, '请填写银行卡城市！');
		}
	}
	
	$("#tdMerchantCode").html(p['merchantCode']);
	$("#tdAmount").html(p['amount']);
	$("#tdBankInfo").html(p['issueBankName']);
	$("#tdCardNum").html(p['cardNum']);
	$("#tdCardName").html(p['cardName']);
	showWin('#win2', 'proxypay');
}

function error(ths, msg) {
	$.messager.alert('提示', msg, 'info');
	$(ths).show();
	return false;
}
</script>
</head>
<body>
	<div id="win" title="" style="width: 500px; height: auto;">
		<form method="post" style="margin: 20px;" id="form">
			<table class="formtable">
				<tr>
					<td class="input-title">接口类型</td>
					<td>
						<select name="classKey" onchange="selectClassKey(this);">
							<option value="">请选择</option>
							<option value="xingxin">兴信</option>
							<option value="le">乐付</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="input-title">方法</td>
					<td><input type="text" name="method" id="method" readonly="readonly"/></td>
				</tr>
				<tr>
					<td class="input-title">商户号</td>
					<td><input type="text" name="merchantCode" /></td>
				</tr>
				<tr>
					<td class="input-title">金额</td>
					<td><input type="text" name="amount" onkeyup="checkMoney(this)"/></td>
				</tr>
				<tr>
					<td class="input-title">银行</td>
					<td>
						<select name="bank" onchange="selectBank(this);" id="bank">
							<optgroup label="兴信" id="xingxinGroup">
								<option value=""></option>
								<option value="ICBC">工商银行</option>
								<option value="ABC">农业银行</option>
								<option value="BOC">中国银行</option>
								<option value="CCB">建设银行</option>
								<option value="BCOM">交通银行</option>
								<option value="CMB">招商银行</option>
								<option value="GDB">广东发展银行</option>
								<option value="CITIC">中信银行</option>
								<option value="CMBC">民生银行</option>
								<option value="CEB">光大银行</option>
								<option value="PABC">平安银行</option>
								<option value="SPDB">上海浦东发展银行</option>
								<option value="PSBC">中国邮政储蓄银行</option>
								<option value="HXB">华夏银行</option>
								<option value="FIB">兴业银行</option>
							</optgroup>
							<optgroup label="乐付" id="leGroup">
								<option value=""></option>
								<option value="ICBC">工商银行</option>
								<option value="ABC">农业银行</option>
								<option value="BOC">中国银行</option>
								<option value="CCB">建设银行</option>
								<option value="BOCM">交通银行</option>
								<option value="CMB">招商银行</option>
								<option value="CGB">广发银行</option>
								<option value="CITIC">中信银行</option>
								<option value="PSBC">中国邮政储蓄银行</option>
								<option value="HXB">华夏银行</option>
								<option value="CIB">兴业银行</option>
							</optgroup>
						</select>
					</td>
				</tr>
				<tr>
					<td class="input-title">银行名称</td>
					<td><input type="text" name="issueBankName" id="issueBankName"/></td>
				</tr>
				<tr>
					<td class="input-title">银行卡省份</td>
					<td><input type="text" name="extends3" /></td>
				</tr>
				<tr>
					<td class="input-title">银行卡城市</td>
					<td><input type="text" name="memo" /></td>
				</tr>
				<tr>
					<td class="input-title">支行地址</td>
					<td><input type="text" name="issueBankAddress" /></td>
				</tr>
				<tr>
					<td class="input-title">卡号</td>
					<td><input type="text" name="cardNum" /></td>
				</tr>
				<tr>
					<td class="input-title">户名</td>
					<td><input type="text" name="cardName" /></td>
				</tr>
				<tr>
					<td class="input-title">身份证</td>
					<td><input type="text" name="extends1" /></td>
				</tr>
				<tr>
					<td class="input-title">手机号</td>
					<td><input type="text" name="extends2" /></td>
				</tr>
				<tr>
					<td class="input-title">商城地址</td>
					<td><input type="text" name="shopUrl" value="http://mall.yhhbo.com:16888" /></td>
				</tr>
				<tr>
					<td class="input-title">秘钥</td>
					<td><input type="text" name="key" /></td>
				</tr>
				<tr>
					<td class="input-title">公钥</td>
					<td><input type="text" name="publicKey" /></td>
				</tr>
			</table>
			<div style="margin-left: 120px;margin-top: 20px">
				<sjc:auth url="/admin/bankApi/proxypay"><a id="subButton" href="#" class="btn-save" icon="icon-save" onClick="subForm(this);">提交</a></sjc:auth>
			</div>
		</form>
	</div>
	<div id="win2">
		<form method="post" style="margin: 20px; width: 400px" id="form2" action="edit?operateType=1">
			<input type="hidden" name="id" id="win2Id"/>
			<table class="formtable">
				<tr>
					<td class="input-title">商户号:</td>
					<td id="tdMerchantCode" style="font-size: 20pt"></td>
				</tr>
				<tr>
					<td class="input-title">金额:</td>
					<td id="tdAmount" style="font-size: 20pt"></td>
				</tr>
				<tr>
					<td class="input-title">银行信息:</td>
					<td id="tdBankInfo" style="font-size: 20pt"></td>
				</tr>
				<tr>
					<td class="input-title">卡号:</td>
					<td id="tdCardNum" style="font-size: 20pt"></td>
				</tr>
				<tr>
					<td class="input-title">户名:</td>
					<td id="tdCardName" style="font-size: 20pt"></td>
				</tr>
			</table>
			<div style="text-align: center; padding: 5px;">
				<a id="win2Save" href="#" class="btn-save" icon="icon-save" onClick="$('#form').submit();">保存</a>
				<a href="#" class="btn-cancel" icon="icon-cancel" onClick="closeWin('#win2')">取消</a>
			</div>
		</form>
	</div>
</body>
</html>