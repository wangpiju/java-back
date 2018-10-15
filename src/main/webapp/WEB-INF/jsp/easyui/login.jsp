<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sjc" uri="http://www.sjc168.com" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>后台管理系统</title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/res/admin/easyui/themes/default/easyui.css'/>"
		  id="swicth-style"/>
	<link rel="stylesheet" type="text/css" href="<c:url value='/res/admin/js/keyboard/css/keyboard-basic.min.css'/>"/>
	<script type="text/javascript">
		try {
			window.nodeRequire = require;
			delete window.require;
			delete window.exports;
			delete window.module;
		} catch (e) {
		}
	</script>
	<script type="text/javascript" src="<c:url value='/res/admin/easyui/jquery-1.8.0.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/res/admin/easyui/jquery.easyui.min.js'/>"></script>
	<!-- MD5插件 -->
	<script type="text/javascript" src="<c:url value='/res/admin/js/jquery.md5.js'/>"></script>
	<!-- 键盘插件 -->
	<script type="text/javascript" src="<c:url value='/res/admin/js/keyboard/js/jquery.keyboard.min.js'/>"></script>
	<script type="text/javascript"
			src="<c:url value='/res/admin/js/keyboard/js/jquery.keyboard.extension-all.min.js'/>"></script>
	<script type="text/javascript">
		$(function () {
			$('#verfiy').click(function () {
				var src = '<c:url value="/code.jpg?_="/>' + new Date().getTime();
				$(this).attr('src', src);
			});
			$('#tokenValue').click(function () {
				var url = '<c:url value="/admin/getToken?_="/>' + new Date().getTime();
				$.ajax({
					url: url,
					type: 'GET',
					dataType: 'json',
					success: function (rel) {
						if (rel.status == 200) {
							$('#tokenValue').text(rel.content);
						} else {
							$.messager.alert('错误', rel.content, 'error');
						}
					}
				});
			});
			$('#loginform').submit(function () {
				var password = $.md5($("#userPassword").val()) + $("#code").val();
				$("#userPassword").val($.md5(password));
				return true;
			});
			try {
				var res = $('#body_token').attr('data-token');
				if (res) {
					var ipcRenderer = window.nodeRequire('electron').ipcRenderer;
					var s = ipcRenderer.sendSync('getToken', res);
					var mac = ipcRenderer.sendSync('getMac');
					$('#token').val(s);
					$('#mac').text(mac);
				}
			} catch (e) {
			}
			var browser = {
				versions: function () {
					var u = window.navigator.userAgent;
					return {//移动终端浏览器版本信息
						mobile: !!u.match(/AppleWebKit.*Mobile.*/) || !!u.match(/IEMobile/), //是否为移动终端
						ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
						android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1, //android终端或者uc浏览器
						iPhone: u.indexOf('iPhone') > -1 || u.indexOf('Mac') > -1, //是否为iPhone
						iPad: u.indexOf('iPad') > -1 //是否iPad
					};
				}()
			};
			var mobile = browser.versions.mobile ||//是否为移动终端
				browser.versions.ios ||//是否为ios终端
				browser.versions.android ||//是否为android终端
				browser.versions.iPhone ||//是否为iPhone
				browser.versions.iPad;//是否为iPad
			//手机端禁用软键盘
//    			if(!mobile) {
//    		   		$('#account,#userPassword,#code').keyboard();
//    		   		$(document).on("keydown","input",function(){
//    		   			return false;
//    		   		});
//    			}
		});
	</script>
</head>
<body style="background-color: #444" id="body_token" data-token="${token}">
<div class="easyui-window"
	 data-options="width:450,collapsible:false,minimizable:false,maximizable:false,closable:false"
	 title="Sign In">
	<div style="padding: 20px;">
		<form id="loginform" action="<c:url value='/admin/login'/>"
			  method="post">
			<input id="token" name="token" type="hidden"/>
			<table style="width: 100%;">
				<tr>
					<td>IP：</td>
					<td>${ip }</td>
				</tr>
				<tr>
					<td>ID：</td>
					<td id="mac"></td>
				</tr>
				<tr>
					<td>Account：</td>
					<td><input style="width: 175px;" id="account" name="account" type="text" value="${account }"/></td>
				</tr>
				<tr>
					<td>Password：</td>
					<td><input style="width: 175px;" id="userPassword" name="password" type="password"/></td>
				</tr>
				<tr>
					<td>Confirm：</td>
					<td><input id="code" name="code" type="text" style="width: 70px;"/>
						<c:if test="${type==0 }">
							<img
									id="verfiy"
									style="width: 100px;  margin-right: 20px;"
									src="<c:url value='/code.jpg'/>"/>
						</c:if>
						<c:if test="${type==1 }">
							<span id="tokenValue" style="cursor: pointer;">${tokenKey}</span>
						</c:if>
						<c:if test="${type==2 }">
							<span>动态密码</span>
						</c:if>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><span style="color:red;">${msg}</span></td>
				</tr>
			</table>
		</form>
		<div style="text-align: center; padding: 5px;">
			<a href="javascript:void(0)" class="easyui-linkbutton"
			   onclick="$('#loginform').submit();">Login</a>
		</div>
	</div>
</div>
</body>
</html>
