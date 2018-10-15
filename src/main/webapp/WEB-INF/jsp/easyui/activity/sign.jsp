<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<style type="">
	.days{width:50px;}
	.betAmount{width:100px}
	.giveAmount{width:100px}
	.dayTitle{margin-right:10px};
</style>
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
// 		$(a).linkbutton("enable");
	}
	
	//添加奖金
	function addBonus(){
		var n = $("#bonus div").length;
		var div = "<div>";
		div+='第<input type="text" class="days" name="daysList['+ n +'].days" value="${a.maxAmount }" /><span class="dayTitle">天</span> ';
		div+='投注量：<input type="text" class="betAmount" name="daysList['+ n +'].betAmount" value="${a.betAmount }" /> ';
		div+='奖励：<input type="text" class="giveAmount" name="daysList['+ n +'].giveAmount" value="${a.giveAmount }" /> ';
// 		div+='图标路径：<input type="file" class="icoUrl" name="icoNames" /><img src="<c:url value="${a.icoUrl}"/> ';
// 		div+='<input type="hidden" class="icoUrl" name="daysList[${st.index }].icoUrl" /> ';
		div+='<a href="#" class="easyui-linkbutton" icon="icon-edit" onClick="deleteBonus(this)">删除</a>';
		div+="</div>";
		$("#bonus").append(div);
		$(".easyui-linkbutton").linkbutton();
	}
	
	//删除
	function deleteBonus(a) {
		$(a).parent().remove();
		$("#bonus div").each(function(i,n){
			$(this).find(".days").attr("name","daysList["+i+"].days");
			$(this).find(".betAmount").attr("name","daysList["+i+"].betAmount");
			$(this).find(".giveAmount").attr("name","daysList["+i+"].giveAmount");
			$(this).find(".icoUrl").attr("name","daysList["+i+"].icoUrl");
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
				<td class="input-title">活动时间</td>
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
					<%-- <option value="1" <c:if test="${m.activityUser==1 }"> selected</c:if>>用户</option>
					<option value="2" <c:if test="${m.activityUser==2 }"> selected</c:if>>代理</option> --%>
				</select></td>
			</tr>
			<tr>
				<td class="input-title">领奖类型</td>
				<td><select name="prizeType">
					<%-- <option value="0">手工</option>
					<option value="1" <c:if test="${m.prizeType==1 }"> selected</c:if>>半自动</option>
					<option value="2" <c:if test="${m.prizeType==2 }"> selected</c:if>>全自动</option> --%>
					<option value="3" <c:if test="${m.prizeType==3 }"> selected</c:if>>程序派发</option>
				</select></td>
			</tr>
			<tr>
				<td class="input-title">可见范围</td>
				<td><select name="visibleRange">
					<option value="2">不限</option>
			 		<option value="0" <c:if test="${m.visibleRange==0 }"> selected</c:if>>用户</option>
					<option value="1" <c:if test="${m.visibleRange==1 }"> selected</c:if>>代理</option> 
				</select></td>
			</tr>
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
					<c:forEach items="${m.daysList }" var="a" varStatus="st">
					<div>
						第<input type="text" class="days" name="daysList[${st.index }].days" value="${a.days }" /><span class="dayTitle">天</span>
						投注量：<input type="text" class="betAmount" name="daysList[${st.index }].betAmount" value="${a.betAmount }" />
						奖励：<input type="text" class="giveAmount" name="daysList[${st.index }].giveAmount" value="${a.giveAmount }" />
<%-- 						图标路径：<input type="file" class="icoUrl" name="icoNames" /><img src="<c:url value='${a.icoUrl}'/>"/> --%>
<%-- 						<input type="hidden" class="icoUrl" name="daysList[${st.index }].icoUrl" /> --%>
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