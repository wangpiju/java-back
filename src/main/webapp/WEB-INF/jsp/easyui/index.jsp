<%@page contentType="text/html" pageEncoding="UTF-8" %><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><!DOCTYPE html><%@ taglib prefix="sjc" uri="http://www.sjc168.com" %><html><head>	<meta charset="UTF-8">	<title>OA管理系统</title>	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE9"/>	<link rel="stylesheet" type="text/css"		  href="<c:url value='/res/admin/easyui/themes/default/easyui.css'/>"		  id="swicth-style"/>	<link rel="stylesheet" type="text/css"		  href="<c:url value='/res/admin/css/style.css'/>"/>	<script type="text/javascript"			src="<c:url value='/res/admin/easyui/jquery-1.8.0.min.js'/>"></script>	<script type="text/javascript"			src="<c:url value='/res/admin/easyui/jquery.easyui.min.js'/>"></script>	<script type="text/javascript"			src="<c:url value='/res/admin/js/audio/audio5.min.js'/>"></script>	<!-- <script type="text/javascript" -->	<%-- 	src="<c:url value='/res/admin/js/play.js'/>"></script> --%>	<script type="text/javascript"			src="<c:url value='/res/admin/js/index.js'/>"></script>	<script type="text/javascript"			src="<c:url value='/res/admin/js/skin.js'/>"></script></head><body class="easyui-layout"><div region="north" border="true" class="cs-north">	<div class="cs-north-bg">		<div class="cs-north-logo">大順娛樂--管理系统</div>		<div class="logout">			${user.account } | <sjc:auth url="/admin/manager/password">				<a class="cs-navi-tab" href="${url}">修改密码</a> | </sjc:auth>				<a href="<c:url value='/admin/logout'/>">退出</a>		</div>		<%--<ul class="ui-skin-nav">--%>			<%--<li class="li-skinitem" title="gray">--%>				<%--<span class="gray" rel="gray"></span>--%>			<%--</li>--%>			<%--<li class="li-skinitem" title="default">--%>				<%--<span class="default" rel="default"></span>--%>			<%--</li>--%>			<%--<li class="li-skinitem" title="bootstrap">--%>				<%--<span class="bootstrap" rel="bootstrap"></span>--%>			<%--</li>--%>			<%--<li class="li-skinitem" title="black">--%>				<%--<span class="black" rel="black"></span>--%>			<%--</li>--%>			<%--<li class="li-skinitem" title="metro">--%>				<%--<span class="metro" rel="metro"></span>--%>			<%--</li>--%>		<%--</ul>--%>	</div></div><div region="west" border="true" split="true" title="功能菜单" class="cs-west">	<div class="easyui-accordion" fit="true" border="false">		<%@include file="/WEB-INF/jsp/easyui/left.jsp" %>	</div></div><div id="mainPanle" region="center" border="true" border="false">	<div id="tabs" class="easyui-tabs" fit="true" border="false">		<div title="主页">			<h1>欢迎使用 OA管理系统 v1.0</h1>		</div>	</div></div><div region="south" border="false" class="cs-south"></div><div id="mm" class="easyui-menu cs-tab-menu">	<div id="mm-tabupdate">刷新</div>	<div class="menu-sep"></div>	<div id="mm-tabclose">关闭</div>	<div id="mm-tabcloseother">关闭其他</div>	<div id="mm-tabcloseall">关闭全部</div></div></body></html>