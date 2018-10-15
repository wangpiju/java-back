<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
var countFields = ['rechargeAmount', 'betAmount'];
	$(function() {
     	 setWebDefaultTime();
		var options = {
			url:'listForExtCode',
			queryParams : getQueryParams(),
			columns : [ [{
				field : 'account',
				title : '用户名'
			}, {
				field : 'createTime',
				title : '开户时间',
				formatter : function(value, row) {
					if(value!=null&&value !=''){
						return new Date(value).format("yyyy-MM-dd hh:mm:ss");
					}else{
						return '';
					}
					
				}
			},  {
				field : 'address',
				title : '开户IP地区'
			}, {
				field : 'num',
				title : '是否绑卡',
				formatter : function(value, row){
					if(value>0){
						return '<span>'+'是'+'</span>';
					}else if(value==0){
						return '<span>'+'否'+'</span>';
					}else{
						return '<span>'+' '+'</span>';
					}
				}
			}, {
				field : 'rechargeAmount',
				title : '充值金额',
				formatter : function(value, row){
					if(value==null){
						return '<span >'+'0'+'</span>';
					}else{
						return '<span >'+value+'</span>';
					}
				}
			},{
				field : 'betAmount',
				title : '投注金额',
				formatter : function(value, row){
					if(value==null){
						return '<span >'+'0'+'</span>';
					}else{
						return '<span >'+value+'</span>';
					}
				}
			},{
				field : 'loginStatus',
				title : '状态',
				formatter : function(value, row){
					if(value>0){
						return '<span >'+'冻结'+'</span>';
					}else if(value==0){
						return '<span >'+'正常'+'</span>';
					}else{
						return '<span >'+' '+'</span>';
					}
				}
			}] ],
			onLoadSuccess : function (pageData) {
				doCountField(grid);
				$("#pageDataRechargeAmount").text(pageData.obj.rechargeAmount);
				$("#pageDataBetAmount").text(pageData.obj.betAmount);
			}
		};
		createGrid('#grid',options);
		$("#search").click(function(){
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
			<form id="form" action="listForExtCode" method="post">		
		   <table>
		       <tr>
			      <td>投注时间：</td>
			      <td><input type="text" class="easyui-datetimebox" size="16" name="beginCreateTime"/>~<input type="text" class="easyui-datetimebox" size="16" name="endCreateTime"/></td>
			      <td> <input type="hidden" name="code" value="${code }"/></td>
			      <td> <a href="#" plain="true" id="search" class="easyui-linkbutton" icon="icon-search">查询</a></td>
		       </tr>
		       <tr>
			       	<td colspan="2">充值金额总计：<span id="pageDataRechargeAmount">0</span></td>
			       	<td colspan="2">投注金额总计：<span id="pageDataBetAmount">0</span></td>
			   </tr>
		   </table>		  		
		</form>
	</div>		
	</div>
</body>
</html>