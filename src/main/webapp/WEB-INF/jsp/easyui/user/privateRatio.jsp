<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	$(function() {
		var options = {
			singleSelect:true,
			url:'',
			columns : [ [{
				field : 'id',
				title : '编号'
			}, {
				field : 'createDate',
				title : '日期',
			}, {
				field : 'remark',
				title : '用户标识',
				formatter:function(value,row){
					if(row.account){
						if(!value || value == 0)
							return '正常';
						else if(value == 1)
							return '<span style="color:red;">嫌疑</span>';
						else if(value == 2)
							return '<span style="color:green;">VIP</span>';
						else if(value == 3)
							return '<span style="color:green;">黑名单</span>';
						else if(value == 4)
							return '<span style="color:green;">招商经理</span>';
						else if(value == 5)
							return '<span style="color:green;">特权代理</span>';
						else if(value == 6)
							return '<span style="color:green;">金牌代理</span>';
						else if(value == 7)
							return '<span style="color:green;">外部主管</span>';
						else
							return value;
					} else {
						return '';
					}
				}
			}, {
				field : 'account',
				title : '用户',
			}, {
				field : 'parentAccount',
				title : '上级用户',
			}, {
				field : 'ratio',
				title : '私返比例',
				formatter : function(value, row) {
					return value+"%";
				}
			}, {
				field : 'betAmount',
				title : '昨日投注金额'
			}, {
				field : 'amount',
				title : '私返金额'
			} ] ]
		};
		createGrid("#grid",options);
		$("#search").click(function(){
			$(grid).datagrid("options")['url'] = 'list';
			var p =getFormData("form");
			reloadGrid("#grid",p);
		});
	});
</script>
<style>
</style>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<form id="form">
		用户名:<input name="account" type="text" size="6"/> 
		私返比例:<input name="ratio" type="text" size="8"/>
		日期:<input type="text" name="begin" class="easyui-datebox"  size="8"/>至<input type="text" name="end" size="8" class="easyui-datebox"/>
		
		<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-search" id="search">查询</a>
		</form>
	</div>
	
</body>
</html>