<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
$(function(){
	KindEditor.create('#editor', {
		uploadJson : '<c:url value="/admin/file/update"/>',
		afterChange : function() {
			this.sync();
		},
		afterBlur : function() {
			this.sync();
		}
	});
	$("#imgDiv").PreviewImage();
});
function doForm(a){
	if ($(a).linkbutton('options').disabled == true) return;
	$(a).linkbutton("disable");
	$("#form").submit();
		//$(a).linkbutton("enable");
}
	
//添加奖金
function addBonus(){
	var n = $("#bonus div").length;
	var div = "<div>";
	div+='充值：<input type="text" class="amount" name="bonusList['+ n +'].amount" value="${a.amount }" />以上送 ';
	div+='<input type="text" class="bonus" name="bonusList['+ n +'].bonus" value="${a.bonus }" /> ';
	div+='<a href="#" class="easyui-linkbutton" icon="icon-edit" onClick="deleteBonus(this)">删除</a>';
	div+="</div>";
	$("#bonus").append(div);
	$(".easyui-linkbutton").linkbutton();
}
	
//删除奖金
function deleteBonus(a) {
	$(a).parent("div").remove();
	$("#bonus div").each(function(i,n){
		$(this).find(".amount").attr("name","bonusList["+i+"].amount");
		$(this).find(".bonus").attr("name","bonusList["+i+"].bonus");
	});
}
</script>
</head>
<body>
<div class="easyui-panel" fit="true" border="none;">
	<form method="post" id="form" action="edit" enctype="multipart/form-data">
		<input type="hidden" name="id" value="${m.id}" />
		<table class="form-table">
			<tr>
				<td class="input-title">标题</td>
				<td><input type="text" name="title" value="${m.title }" /></td>
			</tr>
			<tr>
				<td class="input-title">图标</td>
				<td><div id="imgDiv"><input type="file" name="file" /><img src="<c:url value='${m.icon}'/>"/></div></td>
			</tr>
			<tr>
				<td class="input-title">状态</td>
				<td><select name="status">
					<option value="0">正常</option>
					<option value="1" <c:if test="${m.status==1 }"> selected</c:if>>停止</option>
				</select></td>
			</tr>
			<tr>
				<td class="input-title">帐变备注</td>
				<td><input type="text" name="changeRemark" value="${m.changeRemark}" /></td>
			</tr>
			<tr>
				<td class="input-title">参加时间</td>
				<td><input type="text" class="easyui-datetimebox" name="beginTime" value="${m.beginTime }" />~
					<input type="text" class="easyui-datetimebox" name="endTime" value="${m.endTime }" />
				</td>
			</tr>
			<tr>
				<td class="input-title">有效时间</td>
				<td><input type="text" class="easyui-datetimebox" name="beginPrizeTime" value="${m.beginPrizeTime }" />~
					<input type="text" class="easyui-datetimebox" name="endPrizeTime" value="${m.endPrizeTime }" />
				</td>
			</tr>
			<tr>
				<td class="input-title">活动对象</td>
				<td><select name="activityUser">
					<option value="0">不限</option>
					<option value="1" <c:if test="${m.activityUser==1 }"> selected</c:if>>用户</option>
					<option value="2" <c:if test="${m.activityUser==2 }"> selected</c:if>>代理</option>
				</select></td>
			</tr>
			<tr>
				<td class="input-title">领奖类型</td>
				<td><select name="prizeType">
					<option value="0">手工(向客服申请)</option>
					<option value="1" <c:if test="${m.prizeType==1 }"> selected</c:if>>半自动(用户申请，后台处理)</option>
					<option value="2" <c:if test="${m.prizeType==2 }"> selected</c:if>>全自动（(用户申请)</option>
<%-- 					<option value="3" <c:if test="${m.prizeType==3 }"> selected</c:if>>程序派发(全部自动)</option> --%>
				</select></td>
			</tr>
			<tr>
				<td class="input-title">领奖限制</td>
				<td><select name="amountType">
					<option value="0">每天一次</option>
					<option value="1">全部一次</option>
				</select></td>
			</tr>
			<tr>
				<td class="input-title">领奖范围</td>
				<td><select name="useRange">
					<option value="0">不限</option>
					<option value="1" <c:if test="${m.useRange==1 }"> selected</c:if>>网页</option>
					<option value="2" <c:if test="${m.useRange==2 }"> selected</c:if>>客户端</option>
					<option value="3" <c:if test="${m.useRange==3 }"> selected</c:if>>手机端</option>
				</select>
				<!-- 参加 领奖-->
				<input type="hidden" name="needAttend" value="1" />
				<input type="hidden" name="needPrize" value="1" />
				</td>
			</tr>
			<tr>
				<td class="input-title">可见范围</td>
				<td><select name="visibleRange">
					<option value="2">不限</option>
			 		<option value="0" <c:if test="${m.visibleRange==0 }"> selected</c:if>>用户</option>
					<option value="1" <c:if test="${m.visibleRange==1 }"> selected</c:if>>代理</option> 
				</select></td>
			</tr>
<!-- 			<tr> -->
<!-- 				<td class="input-title">参加</td> -->
<!-- 				<td><select name="needAttend"> -->
<!-- 					<option value="0">否</option> -->
<%-- 					<option value="1" <c:if test="${m.needAttend==1 }"> selected</c:if>>是</option> --%>
<!-- 				</select></td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td class="input-title">领奖</td> -->
<!-- 				<td><select name="needPrize"> -->
<!-- 					<option value="0">否</option> -->
<%-- 					<option value="1" <c:if test="${m.needPrize==1 }"> selected</c:if>>是</option> --%>
<!-- 				</select></td> -->
<!-- 			</tr> -->
			<!-- 这些在充值中用不到
			<tr>
				<td class="input-title">奖金类型</td>
				<td><select name="amountType">
					<option value="0">固定</option>
					<option value="1" <c:if test="${m.amountType==1 }"> selected</c:if>>比例</option>
				</select></td>
			</tr>
			<tr>
				<td class="input-title">奖金</td>
				<td><input type="text" name="amount" value="${m.amount }" /></td>
			</tr>
			<tr>
				<td class="input-title">奖金上限</td>
				<td><input type="text" name="maxAmount" value="${m.maxAmount }" /></td>
			</tr> -->
			<tr>
				<td class="input-title">排序</td>
				<td><input type="text" name="orderId" value="${m.orderId}" /></td>
			</tr>
			<tr>
				<td class="input-title">奖金段</td>
				<td><a href="#" class="easyui-linkbutton" icon="icon-edit" onClick="addBonus()">添加</a></td>
			</tr>
			<tr>
				<td class="input-title"></td>
				<td id="bonus">
					<c:forEach items="${m.bonusList }" var="a" varStatus="st">
					<div>
						充值：<input type="text" class="amount" name="bonusList[${st.index }].amount" value="${a.amount }" />以上送
						<input type="text" class="bonus" name="bonusList[${st.index }].bonus" value="${a.bonus }" />
						<a href="#" class="easyui-linkbutton" icon="icon-edit" onClick="deleteBonus(this)">删除</a>
					</div>
					</c:forEach>
				</td>
			</tr>
			<tr>
				<td class="input-title">活动内容</td>
				<td><textarea cols="50" rows="10" name="remark" id="editor" style="width: 800px; height: 400px; visibility: hidden;">${m.remark }</textarea></td>
			</tr>
		</table>
		<div style="text-align: center; padding: 5px;">
			<a href="#" class="easyui-linkbutton" icon="icon-save" onClick="doForm(this)">保存</a>
		</div>
	</form>
	</div>
</body>
</html>