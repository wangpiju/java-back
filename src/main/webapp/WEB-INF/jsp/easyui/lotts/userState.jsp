<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>
<table  class="form-table">
			<tr>
				<td class="input-title" width="120">用户总数：</td>
				<td>${userState.alls}</td>
			</tr>
			<tr>
				<td class="input-title">代理总数：</td>
				<td>${userState.daili}</td>
			</tr>
			<tr>
				<td class="input-title">会员总数：</td>
				<td>${userState.player}</td>
			</tr>
			<tr>
				<td class="input-title">注册后未登陆用户数：</td>
				<td>${userState.notLogin}</td>
			</tr>
			<tr>
				<td class="input-title">未绑卡用户数：</td>
				<td>${userState.notBind}</td>
			</tr>
			<tr>
				<td class="input-title">未充值用户数：</td>
				<td>${userState.notRecharge}</td>
			</tr>
			<tr>
				<td class="input-title">未投注用户数：</td>
				<td>${userState.notBet}</td>
			</tr>
		</table>

</body>
</html>