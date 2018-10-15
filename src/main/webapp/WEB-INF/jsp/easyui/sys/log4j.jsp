<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	$(function() {
		var options = {
			url:'',
			columns : [ [ {
				field : 'lever',
				title : '等级'
			}, {
				field : 'serverIp',
				title : 'IP'
			}, {
				field : 'clazz',
				title : '类'
			}, {
				field : 'method',
				title : '方法'
			}, {
				field : 'createDate',
				title : '时间'
			}, {
				field : 'message',
				title : '日志',
				formatter:function(value,row){
					var t = value.replace(/</g,"&lt;");
					t = t.replace(/>/g,"&gt;");
					return t;
				}
			}] ]
		};
		createGrid('#grid',options);
		
		$("#search").click(function(){
			$(grid).datagrid("options")['url'] = 'list';
			$("#grid").datagrid("options").queryParams = getQueryParams();
			reloadGrid("#grid");
		});
	});
	

	
	function getQueryParams() {
		var p={};
		$.each($("#form").serializeArray(),function(){  
            p[this.name]=this.value;  
        });
		return p;
	}
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<div>
			<form id="form">
			等级：<input name="lever" type="text" size="4" />
			类：<input name="clazz" type="text" />
			方法：<input name="method" type="text" size="4" />
			内容：<input name="message" type="text" />
			时间：<input name="begin" class="easyui-datetimebox" size="20" />~<input name="end" class="easyui-datetimebox" size="20" />
			<a href="#" plain="true" id="search" class="easyui-linkbutton" icon="icon-search">查询</a>
			</form>
		</div>
	</div>
</body>
</html>