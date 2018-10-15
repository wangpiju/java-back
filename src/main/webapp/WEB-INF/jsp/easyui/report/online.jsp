<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	$(function() {
		var options = {
			onLoadSuccess : function(d) { 
				var totalRowNum = d.total;
				$("#total").html(totalRowNum);

			},
			columns : [ [ {
				field : 'account',
				title : '在线用户名称'
			}, {
				field : 'userType',
				title : '在线用户类型',
				formatter : function(value, row) {
					if (value == 1) {
						return '代理';
					} else if (value == 0) {
						return '玩家';
					}
				}
			}, {
				field : 'ip',
				title : '在线用户IP'
			}, {
				field : 'ipInfo',
				title : '在线用户归属地'
			}, {
				field : 'loginTime',
				title : '登陆时间',
				formatter : function(value, row) {
					if (value > 1000)
						return new Date(value).format("yyyy-MM-dd hh:mm:ss");
				}
			} ] ]
		};
		grid = createGrid('#grid', options);
		$("#search").click(function() {
			var p = {};
			$.each($("#form").serializeArray(), function() {
				p[this.name] = this.value;
			});
// 			$("#grid").datagrid("options").queryParams = p;
			reloadGrid("#grid",p);
		});
	});
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<div>
			<form id="form" action="list" method="post">
				用户名： <input type="text" size="10" name="account" /> </select> 类型：<select
					name="userType">
					<option value="">不限</option>
					<option value="1">代理</option>
					<option value="0">玩家</option>
				</select> 
				IP: <input type="text" size="10" name="ip" /> 
				地区：<input type="text" size="10" name="info" />
				
				<span>在线人数共：</span><span id="total">0</span> <a href="#"
					plain="true" id="search" class="easyui-linkbutton"
					icon="icon-search">查询</a>
			</form>
		</div>
	</div>
</body>
</html>