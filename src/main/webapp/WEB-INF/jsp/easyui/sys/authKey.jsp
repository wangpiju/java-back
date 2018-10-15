<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript" src="<c:url value='/res/admin/js/jquery.qrcode.min.js'/>"></script>
<script type="text/javascript">
	function createQRCode(url) {
		$("#qrCode").remove();
		$("#qrWapper").html('<div id="qrCode"></div>');
		$('#qrCode').qrcode({
			text: url,
			foreground: '#000',
			width: 200,
			height: 200
		});
	}
	function doCreate(url){
		ajaxData(url,function(rel) {
			createQRCode( rel.content);
		});
	}
	$(function(){
		createQRCode('${qrCode }');
	});
</script>
</head>
<body>
	<div style="width:300px; height:500px; margin:200px auto;">
		<div>${account } 的二维码  <sjc:auth url="/admin/manager/createKey"><a href="#" plain="true" class="easyui-linkbutton" icon="icon-add" onClick="doCreate('${url}?account=${account }')">重新生成</a></sjc:auth></div>
		<div id="qrWapper"><div id="qrCode"></div></div>
	</div>
</body>
</html>