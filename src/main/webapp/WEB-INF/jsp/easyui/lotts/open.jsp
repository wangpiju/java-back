<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	$(function() {
		var options = {
			singleSelect:true,
			queryParams:{lotteryId:'${lotteryId}'},
			url:'openList',
			columns : [ [ {
				field : 'seasonId',
				title : '网址'
			}, {
				field : 'n1',
				title : 'n1'
			}, {
				field : 'n2',
				title : 'n2'
			}, {
				field : 'n3',
				title : 'n3'
			}, {
				field : 'n4',
				title : 'n4'
			}, {
				field : 'n5',
				title : 'n5'
			}, {
				field : 'n6',
				title : 'n6'
			}, {
				field : 'n7',
				title : 'n7'
			}, {
				field : 'n8',
				title : 'n8'
			}, {
				field : 'n9',
				title : 'n9'
			}, {
				field : 'n10',
				title : 'n10'
			}, {
				field : 'openTime',
				title : '开奖时间'
			},{
				field : 'addTime',
				title : '创建时间'
			} ] ]
		};
		createGrid('#grid',options);
	});
</script>
</head>
<body>
	<div id="grid"></div>
</body>
</html>