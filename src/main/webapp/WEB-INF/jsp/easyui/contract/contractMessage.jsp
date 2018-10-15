<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	$(function() {
		var options = {
			columns : [ [ {
				field : 'sender',
				title : '发送者'
			},{
				field : 'receiver',
				title : '接收者'
			},{
				field : 'content',
				title : '内容'
			},{
				field : 'contractStatus',
				title : '契约状态'
			},{
				field : 'messageStatus',
				title : '消息状态',
				formatter : function(value, row) {
					if(value==0){
					  return '<span>未读</span>';
					}else{
					  return '<span>已读</span>';
					}
				}
			},{
				field : 'createTime',
				title : '创建时间'
			},{
				field : 'other',
				title : '操作',
				formatter : function(value, row) {
				}
			}] ]
		};
		createGrid('#grid',options);
	});
	
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<!--  <div><a href="javascript:;" class="btn searchTeamBtn" onclick="test()">测试</a></div> -->
	</div>
</body>
</html>