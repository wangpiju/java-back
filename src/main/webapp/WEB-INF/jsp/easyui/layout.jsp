<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css"
	href="<c:url value='/res/admin/easyui/themes/default/easyui.css'/>"
	id="swicth-style" />
<link rel="stylesheet" type="text/css"
	href="<c:url value='/res/admin/easyui/themes/icon.css'/>" />
<link rel="stylesheet" type="text/css"
	href="<c:url value='/res/admin/css/style.css'/>" />
<script type="text/javascript" 
	src="<c:url value='/res/admin/easyui/jquery-1.8.0.min.js'/>"></script>
<script type="text/javascript"
	src="<c:url value='/res/admin/easyui/jquery.easyui.min.js'/>"></script>
<script type="text/javascript"
	src="<c:url value='/res/admin/easyui/locale/easyui-lang-zh_CN.js'/>"></script>
<script type="text/javascript"
	src="<c:url value='/res/admin/editor/kindeditor-all.js'/>"></script>
<script type="text/javascript"
	src="<c:url value='/res/admin/js/PreviewImage.js'/>"></script>
<script type="text/javascript"
	src="<c:url value='/res/admin/js/date.extends.js'/>"></script>
<script type="text/javascript"
	src="<c:url value='/res/admin/js/math.extends.js'/>"></script>
<script type="text/javascript"
	src="<c:url value='/res/admin/js/common.js'/>"></script>
<script type="text/javascript"
	src="<c:url value='/res/admin/js/skin.js'/>"></script>
<script type="text/javascript">
// common.js用到
var homeURL = "<c:url value='/admin'/>";
</script>
<sitemesh:write property='head' />
</head>
<body>
	<sitemesh:write property='body' />
</body>
</html>