<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
$(function() {
	$("#formSubmit").click(function(){
		$("#form").submit();
	});
});
</script>
</head>
<body>
	<form id="form" action="password" method="post">
		<table  class="form-table">
			<tr>
				<td class="input-title">旧密码：</td>
				<td><input type="password" name="old" /></td>
			</tr>
			<tr>
				<td class="input-title">新密码：</td>
				<td><input type="password" name="password1" /></td>
			</tr>
			<tr>
				<td class="input-title">确认密码：</td>
				<td><input type="password" name="password2" /></td>
			</tr>
		</table>
		<div style="text-align: center; padding: 5px;">
		<a href="#"  class="easyui-linkbutton" id="formSubmit" icon="icon-save">保存</a></div>
	</form>
</body>
</html>