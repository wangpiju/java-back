<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
$(function() {
	createWin("#win");
	$("#formSubmit").click(function(){
		var url = $("#form").attr("url");
		$("#form").attr("action",url);
		$("#form").submit();
	});
});
</script>
</head>
<body>
<div  class="easyui-panel" fit="true" border="none;">
	<div class="search-page">
		<div>
			会员：${account }
			<sjc:auth url="/admin/user/quotaAdd">
			<a href="#" plain="true" class="easyui-linkbutton" icon="icon-add" onClick="showWin('#win','quotaAdd',{account:'${account }'})">添加</a>
			</sjc:auth>
		</div>
	</div>
	<table class="my-table" style="width:500px;">
		<thead>
			<tr>
				<th width="100">返点</th>
				<th width="80">数量</th>
				<th width="80">操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list }" var="a">
			<tr>
				<td><fmt:formatNumber value='${a.rebateRatio}' pattern='#.##' />%</td>
				<td>${a.num}</td>
				<td> <sjc:auth url="/admin/user/quota"><a href="#" onClick="showWin('#win','quota',{account:'${account }', rebateRatio:${a.rebateRatio}})">修改</a></sjc:auth>&nbsp;
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<div id="win">
		<form method="post" style="margin: 20px;" id="form">
			<input type="hidden" name="account" value="${account }" />
			<table class="formtable">
				<tr>
					<td class="input-title">返点</td>
					<td><input type="text" size="3" name="rebateRatio" />%</td>
				</tr>
				<tr>
					<td class="input-title">数量</td>
					<td><input type="text" name="num" /></td>
				</tr>
			</table>
			<div style="text-align: center; padding: 5px;">
				<a href="#" class="btn-save" icon="icon-save" id="formSubmit">保存</a>
				<a href="#" class="btn-cancel" icon="icon-cancel" onClick="closeWin('#win')">取消</a>
			</div>
		</form>
	</div>
</div>
</body>
</html>