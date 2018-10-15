<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
var grid;
//var seasonRules = ${json};
	$(function() {
		/* $(".beginTime").datebox("setValue",new Date().addHour(-4,'yyyy-MM-dd 04:00:00'));
   	   	$(".endTime").datebox("setValue",new Date().addDay(1).addHour(-4,'yyyy-MM-dd 04:00:00')); */
   	    setWebDefaultTime();
		var options = {
				url:'listForTrace',
				//singleSelect:true,
				queryParams : getQueryParams(),
			columns : [ [ {
				field : 'id',
				title : '序号'
			}, {
				field : 'createTime',
				title : '追号时间'
			}, {
				field : 'userMark',
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
				title : '用户'
			}, {
				field : 'lotteryName',
				title : '彩种/玩法'
			}, {
				field : 'startSeason',
				title : '起始期号'
			}, {
				field : 'finishTraceNumAndTraceNum',
				title : '已追/总期数',
			    formatter : function(value, row) {
			    	return row.finishTraceNum + '/'+row.traceNum;
			    }
			},{
				field : 'finishTraceAmountAndTraceAmount',
				title : '已投/总金额',
			    formatter : function(value, row) {
			    	return row.finishTraceAmount + '/'+row.traceAmount;
			    } 
			}, {
				field : 'isWinStop',
				title : '追中即停',
				 formatter : function(value, row) {
					 switch(value){
					 case 0: return '<span >否</span>';
					 case 1:return '<span >是</span>';
					 }
				} 
			},{
				field : 'status',
				title : '状态',
				 formatter : function(value, row) {
					 switch(value){
					 case 0: return '<span style="color:red;">进行中</span>';
					 case 1:return '<span style="color:green;">已完成</span>';
					 }
				} 
			},{
				field : 'other',
				title : '操作',
				formatter : function(value, row) {
					var txt ='<a onClick="opens(this,\'追号\')"  href="#" data-href="<c:url value="/admin/report/traceDetailsIndex?id="/>'+ row.id +'">详情</a>'
					return txt;
				}
			}] ]
		};
		grid = createGrid('#grid',options);
		$("#search").click(function(){
		/* 	var p={};
			$.each($("#form").serializeArray(),function(){  
	            p[this.name]=this.value;  
	        });
			reloadGrid("#grid",p); */
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
 function opens(a,title){
	addTab(title+' - '+$(a).text(),$(a).attr("data-href"));
} 
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<div>
			<form id="form" action="listForTrace" method="post">		
		   <table>
		       <tr>
		          <td>用户名：</td>
		          <td> <input type="text" size="10" name="account" /></td>
		          <td><input name="include" type="checkbox" value="1"/>包含下级</td>		         
				  <td>用户类型：</td>
				  <td><select name="test" style="width: 100px;" >
						<option value="2">不限</option>
						<option value="0">非测试</option>
						<option value="1">测试</option>
					 </select>
			      </td>		
			      <td>追号模式：</td>
		          <td ><select  style="width: 100px;"  name="isWinStop">
		                <option value="2">不限</option>
						<option value="0">追中不停</option>
						<option value="1">追中即停</option>
			          </select>
		          </td>	      
			      <td>追号时间：</td>
			      <td><input type="text" class="easyui-datetimebox beginTime" size="20" name="startTime"/>~<input type="text" class="easyui-datetimebox endTime" size="20" name="endTime"/></td>
			     
		       </tr>
		       <tr>	          
		          <td>追号状态：</td>
		          <td colspan="2"><select name="status" style="width: 100px;" >
		                <option value="2">不限</option>
						<option value="0">进行中</option>
						<option value="1">已完成</option>	
			          </select>
		          </td>
		          <td>彩种：</td>
		          <td><select id="lotteryId" name="lotteryId"  style="width: 100px;" >
				        <option value="">不限</option>
						<c:forEach items="${lotteryList}" var="item">
						<option value="${item.id}">${item.title}</option>
						</c:forEach>
				       </select>
		          </td>
		           <td>起始期数：</td>
			      <td><input type="text" size="10" name="startSeason" /></td>
				   
				  <td>已获金额：</td>
				  <td><input type="text" size="10" name="lowerWinAmount" />~<input type="text" size="10" name="highWinAmount" /></td>
				  
			      <td> <a href="#" plain="true" id="search" class="easyui-linkbutton" icon="icon-search">查询</a></td>
		       </tr>
		   </table>		  		
		</form>
	</div>		
	</div>
</body>
</html>