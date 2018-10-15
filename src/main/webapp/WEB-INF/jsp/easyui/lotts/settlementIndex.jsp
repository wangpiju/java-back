<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
/* var allLottery = ${json}; */ 
 
var countFields = ['amount'];
var grid;

	$(function() {
		/* $(".beginTime").datebox("setValue",new Date().addHour(-4,'yyyy-MM-dd 04:00:00'));
   	   	$(".endTime").datebox("setValue",new Date().addDay(1).addHour(-4,'yyyy-MM-dd 04:00:00')); */
   	 setWebDefaultTime();
   	if('${begin}') {
		$('.beginTime').datebox("setValue", '${begin}');
   	}
   	if('${end}') {
		$('.endTime').datebox("setValue", '${end}');
   	}
		var options = {
				url:'listForSettlement',
				//singleSelect:true,
				queryParams : getQueryParams(),
			columns : [ [ {
				field : 'betId',
				title : '订单类型'
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
				title : '彩种'
			}, {
				field : 'seasonId',
				title : '期号'
			}, {
				field : 'playName',
				title : '玩法'
			},{
				field : 'class',
				title : '类别',
				 formatter : function(value, row) {
					if (row.amount>=0) {
						return '<span style="color:green;">收入</span>';
					} else {
						return '<span style="color:red;">支出</span>';
					}
				} 
			}, {
				field : 'createTime',
				title : '时间',
			}, {
				field : 'amount',
				title : '金额'
			}, {
				field : 'balance',
				title : '用户余额'
			},  {
				field : 'changeType',
				title : '账变类型'
			}/* , {
				field : 'other',
				title : '操作',
				formatter : function(value, row) {
					var txt ='<a onClick="opens(this,\''+ row.title +'\')"  href="#" data-href="<c:url value="/admin/player/index?lotteryId="/>'+ row.id +'">查看</a>&nbsp;&nbsp;&nbsp;&nbsp;';
					return txt;
				}
			}  */] ]
		};
		grid = createGrid('#grid',options);
		$("#search").click(function(){
			/* var p={};
			p['accountChangeTypes'] = $('#accountChangeTypes').combobox('getValues').join(",");
			$.each($("#form").serializeArray(),function(){  
	            p[this.name]=this.value;  
	        });
			reloadGrid("#grid",p); */
			$("#grid").datagrid("options").queryParams = getQueryParams();
			reloadGrid("#grid");
		});
	});
 function opens(a,title){
	addTab(title+' - '+$(a).text(),$(a).attr("data-href"));
} 
 function getQueryParams() {
	 var p={};
		p['accountChangeTypes'] = $('#accountChangeTypes').combobox('getValues').join(",");
		$.each($("#form").serializeArray(),function(){  
         p[this.name]=this.value;  
     });
		return p;
	}
    function mychange(s){
    	var param ="name="+s.options[s.selectedIndex].value;
    	$.ajax({
    		   type: "POST",
    		   url: 'getPlayName',
    		   data: param,
    		   success: function(response){
    			 var a =response;
    		     alert( "测试: " +a);
    		   }
    		});
    }
 

</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<div>
			<form id="form" action="listForSettlement" method="post">		
		   <table>
		       <tr>
		          <td>用户名：</td>
		          <td> <input type="text" size="10" name="account" value="${account }" /></td>
		          <td><input name="include" type="checkbox" value="1"/>包含下级</td>
		          <td>账变类型：</td>
		          <td><%-- <select name="accountChangeTypeId">
				        <option value="0">不限</option>
						<c:forEach items="${accountChangeTypeJson}" var="item">
						<option value="${item.id}">${item.name}</option>
						</c:forEach>
				       </select> --%>
				       
				       <select multiple="multiple" class="easyui-combobox" id="accountChangeTypes">
							<c:forEach items="${accountChangeTypeJson}" var="item">
							<option value="${item.id}">${item.name}</option>
							</c:forEach>
			        </select>
				  </td>
				  <td>用户类型：</td>
				  <td><select name="test" style="width:95px">
						<option value="2">不限</option>
						<option value="0">非测试</option>
						<option value="1">测试</option>
					 </select>
			      </td>
		           <td>金额：</td>
				  <td><input type="text" size="19" name="lowerAmount" />~<input type="text" size="19" name="highAmount" /></td>
			      <td>订单编号：</td>
		          <td><input type="text" size="10" name="betId" /></td>
			      <td></td>
		       </tr>
		       <tr>	          
		          <td>彩种：</td>
		          <td colspan="2"><select id="lotteryId" name="lotteryId" style="width:120px" >
				        <option value="">不限</option>
						<c:forEach items="${lotteryList}" var="item">
						<option value="${item.id}">${item.title}</option>
						</c:forEach>
				       </select>
		          </td>
		          <td>彩种组：</td>
		          <td><select id="groupName" name="groupName" style="width:100px" >
		                 <option value="">不限</option>
						<c:forEach items="${groups }" var="g">
							<option value="${g }">${g }</option>
						</c:forEach>
				      </select>
				  </td>
				   <td>期数：</td>
			      <td><input type="text" size="10" name="seasonId" /></td>
			        <td>时间：</td>
				    <td><input type="text" class="easyui-datetimebox beginTime" size="20" name="startTime"/>~<input type="text" class="easyui-datetimebox endTime" size="20" name="endTime"/></td>
				  <td>排序：</td>
				  <td>	<select name="sortClass" style="width:100px">
							<option value="0">时间倒序</option>
							<option value="1">时间正序</option>
							<option value="2">金额倒序</option>
							<option value="3">金额正序</option>
			            </select>
			      </td>
			      <td> <a href="#" plain="true" id="search" class="easyui-linkbutton" icon="icon-search">查询</a></td>
		       </tr>
		   </table>		  		
		</form>
	</div>		
	</div>
</body>
</html>