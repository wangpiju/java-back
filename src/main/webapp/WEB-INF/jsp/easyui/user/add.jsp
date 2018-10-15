<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<style type="text/css">
.noneMinRatio{
	float:left;
	padding:0;
	margin:0;
	margin-right:50px;
	margin-top:2px;
	height:17px;
}
.noneMinRatio span{
	border:1px solid #ccc;
	border-right:none;
	height:17px;
	width:40px;
	display:block;
	float:left;
	padding:0;
	margin:0;
	text-align:center;
	vertical-align: text-top;
	background:#f4f4f4;
	line-height:17px;
	font-weight:bold;
	color:green;
}
.noneMinRatio input{
	height:17px;
	width:30px;
	padding:0;
	margin:0;
	display:block;
	float:left;
	text-align:center;
	border:1px solid #ccc;
}
</style>
<script type="text/javascript">
var bonusGroup=${json};
var noneMinRatio,userMinRatio;
$(function() {
	$("#bonusGroupId").change(function(){
		var v = $(this).val();
		for(var i=0;i<bonusGroup.length;i++){
			var bg = bonusGroup[i];
			if(bg.id == v){
				var opt = "";
				for(var n = bg.rebateRatio;n>0;n = Math.sub(n,0.1)){
					opt+='<option value="'+ n +'">'+n+'%</option>';
				}
				$("#rebateRatio").html(opt).val(bg.rebateRatio);
				noneMinRatio = bg.noneMinRatio; //无需配额的账户
				userMinRatio = bg.userMinRatio;
				$("#rebateRatio").change();
				return;
			}
		}
	});
	$("#rebateRatio").change(function(){
		var v = $(this).val();
		var maxV = Math.sub(v,userMinRatio);
		if(maxV<noneMinRatio) {
			$("#noneMinRatio").html("");
			$("#noneMinRatioTR").hide();
		} else {
			var div = "";
			var l = 0;
			for(var i=Math.add(noneMinRatio,0.1);i<=maxV;i=Math.add(i,0.1)){
				div+='<div class="noneMinRatio"><span>'+i+'%</span>';
				div+='<input type="hidden" name="quota['+l+'].rebateRatio" value="'+i+'"/>';
				div+='<input type="text" name="quota['+l+'].num" value="0" /></div>';
				l++;
			}
			$("#noneMinRatio").html(div);
			$("#noneMinRatioTR").show();
		}
	});
	$("#bonusGroupId").change();
	$('#domain').combo({  
	    required:true,  
	    multiple:true  
	});
	
	$('#domain_list').appendTo($('#domain').combo('panel'));
	$('#domain_list input').click(function(){
		var txt = '';
		var s = '';
		var v = $('#domain_list input:checked').each(function(i,n){
			s += ","+ $(this).val();
			txt += "     "+$(this).next('span').text();
		});
		s=s.substring(1);
		$('#domain').combo('setText', txt);
		$("#input-domain").val(s);
	});
	$("#formSubmit").click(function(){
		$("#form").submit();
	});
});
</script>
</head>
<body>
	<form id="form" action="add" method="post">
		<table class="form-table">
			<tr>
				<td class="input-title" width="100">账户：</td>
				<td><input type="text" name="user.account" /></td>
			</tr>
			<tr>
				<td class="input-title">密码：</td>
				<td>aa123456</td>
			</tr>
			<tr>
				<td class="input-title">测试账户：</td>
				<td><select name="user.test">
					<option value="0">否</option>
					<option value="1">是</option>
				</select></td>
			</tr>
			<tr>
				<td class="input-title">奖金组：</td>
				<td><select name="user.bonusGroupId" id="bonusGroupId">
					<c:forEach items="${bonusGroup }" var="a"><option value="${a.id}">${a.title}</option></c:forEach>
				</select></td>
			</tr>
			<tr>
				<td class="input-title">返点：</td>
				<td><select name="user.rebateRatio" id="rebateRatio"></select></td>
			</tr>
			<tr id="noneMinRatioTR" style="display:none;">
				<td class="input-title">配额：</td>
				<td id="noneMinRatio"></td>
			</tr>
			<tr>
				<td class="input-title">域名分配：</td>
				<td>
					<input type="hidden" id="input-domain" name="domain" value=""/>
					<input id="domain" style="width:300px;"/>
					<div id="domain_list">
					<c:forEach items="${domains }" var="a">
					<input type="checkbox" value="${a.id }"/><span>${a.url }</span><br/>
					</c:forEach>
					</div>
				</td>
			</tr>
			<tr>
				<td class="input-title">银行卡包分配：</td>
				<td><select name="user.bankGroup">
					<c:forEach items="${bankGroups }" var="a">
					<option value="${a.title }">${a.title }</option>
					</c:forEach>
					</select>
				</td>
			</tr>
		</table>
		<div style="text-align: center; padding: 5px;">
		<a href="#"  class="easyui-linkbutton" id="formSubmit" icon="icon-save">保存</a></div>
		<div style="color:red;">${msg }</div>
	</form>
</body>
</html>