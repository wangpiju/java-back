<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
$(function() {
	$("#win").find("a.btn-save,a.btn-cancel").linkbutton();
	$("#changeAmount,#poundage").change(function(){
		$("#realAmount").html("");

		var id = $("#accountChangeTypeId").val();
		if(id == 21) {
			var amount = $("#changeAmount").val() || 0;
			var poundage = $("#poundage").val() || 0;
			$("#realAmount").html( amount - poundage);
		}
	});
	$("#accountChangeTypeId").change(function(){
		var id = $("#accountChangeTypeId").val();
		$("#poundage,#receiveCard").val("");
		$("#realAmount").html("");
		if(id == 21) {
			$("#poundage,#receiveCard").attr("disabled",false);
		} else {
			$("#poundage,#receiveCard").attr("disabled",true);
		}
	});
});
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="win" title="" style="width: 255px; height: auto;">
		<form method="post" style="margin: 20px;" id="form" url="add">
			<table class="formtable" style="width:400px;">
				<tr>
					<td class="input-title" style="width:100px;">帐变用户</td>
					<td  style="width:130px;"><input type="text" name="changeUser" /></td>
				</tr>
				<tr>
					<td class="input-title">帐变类型</td>
					<td>
						<select name="accountChangeTypeId" id="accountChangeTypeId">
							<c:forEach items="${accountChangeTypeList }" var="a" varStatus="st">
								<c:if test="${a.id > 18 && a.id != 29 && a.id != 25 && a.id != 26 && a.id != 40 && a.id != 50 && a.id != 51 && a.id != 52 && a.id != 88 && a.id != 89 && a.id != 22 && a.id != 38}">
									<option value="${a.id }">${st.index - 7 }-${a.name }</option>
								</c:if>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td class="input-title">帐变金额</td>
					<td><input type="text" name="changeAmount" id="changeAmount" /></td>
				</tr>
				<tr>
					<td class="input-title">手续费</td>
					<td><input type="text" name="poundage" id="poundage" disabled /></td>
					<td>&nbsp;实际上分：<span id="realAmount" style="color:red;font-weight:bold;"></span></td>
				</tr>
				<tr>
					<td class="input-title">收款银行卡号</td>
					<td><input type="text" name="receiveCard" id="receiveCard" disabled/></td>
				</tr>
				<tr>
					<td class="input-title">备注</td>
					<td><input type="text" name="remark" /></td>
				</tr>
			</table>
			<div style="text-align: center; padding: 5px;">
				<sjc:auth url="/admin/finance/financeChange/add"><a href="#" class="btn-save" icon="icon-save" onClick="saveData(this, function(rel){ $.messager.alert('提示', rel.content, 'info');document.getElementById('form').reset();})">保存</a></sjc:auth>
			</div>
		</form>
	</div>
</body>
</html>