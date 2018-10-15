<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	var countFields = ['dailyAmount'];
	$(function() {
		var options = {
			columns : [ [ 
			{
				field : 'createTime',
				title : '日期',
				formatter:function(value,row){
					return value != null ? value.substring(0, 10) : '';
				}
			},{
				field : 'account',
				title : '用户名'
			},{
				field : 'parentAccount',
				title : '上级用户'
			},{
				field : 'userMark',
				title : '用户标识',
				formatter:function(value,row){
					if (!value) {
						return '';
					}
					var txt = "";
					if(!value || value == 0)
						txt+= '正常';
					else if(value == 1)
						txt+= '<span style="color:red;">嫌疑</span>';
					else if(value == 2)
						txt+= '<span style="color:green;">VIP</span>';
					else if(value == 3)
						txt+= '<span style="color:green;">黑名单</span>';
					else if(value == 4)
						txt+= '<span style="color:green;">招商经理</span>';
					else if(value == 5)
						txt+= '<span style="color:green;">特权代理</span>';
					else if(value == 6)
						txt+= '<span style="color:green;">金牌代理</span>';
					else if(value == 7)
						txt+= '<span style="color:green;">外部主管</span>';
					return txt;
				}
			},{
				field : 'ruleRate',
				title : '日薪比例（%）'
			},{
				field : 'betAmount',
				title : '昨日投注额'
			},{
				field : 'dailyAmount',
				title : '日薪金额'
			},{
				field : 'remark',
				title : '备注'
			}] ]
		};
		createGrid('#grid',options);
		$("#search").click(function(){
			$(grid).datagrid("options")['url'] = 'list';
			var p =getFormData("form");
			reloadGrid("#grid",p);
		});
	});
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<form id="form">
		用户名:<input name="account" type="text" size="6"/> 
		<input name="isIncludeChildFlag" type="checkbox" value="1"/>包含下级
		日期:<input type="text" name="begin" class="easyui-datebox"  size="8"/>至<input type="text" name="end" size="8" class="easyui-datebox"/>
		
		<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-search" id="search">查询</a>
		</form>
	</div>
</body>
</html>