<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
var countFields = ['alls', 'player', 'daili', 'alls2', 'player2', 'daili2'];
	$(function() {
		
		var options = {
				url:'listZongDaiState',
				columns : [ [ {
					field : 'account',
					title : '总代'
				}, {
					field : 'alls',
					title : '直接开户人数',
	
				}, {
					field : 'player',
					title : '会员'
				}, {
					field : 'daili',
					title : '代理'
				}, {
					field : 'alls2',
					title : '链接开户人数'
				}, {
					field : 'player2',
					title : '会员'
				},{
					field : 'daili2',
					title : '代理',
					
				}] ]
		};
		createGrid('#grid',options);
	});
 function opens(a,title){
	addTab(title+' - '+$(a).text(),$(a).attr("data-href"));
} 
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">	
	</div>
</body>
</html>