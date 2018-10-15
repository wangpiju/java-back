<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
var countFields = ['betAmount',  'winAmount', 'marginDollar', 'totalAmount'];
var webProfitDefaultBiginTime ='${webProfitDefaultBiginTime}';
var webProfitDefaultEndTime='${webProfitDefaultEndTime}';
	$(function() {
		var options = {
			columns : [ [ {
				field : 'account',
				title : '用户'
			}, {
				field : 'createDate',
				title : '日期',
				formatter:function(value,row){
					if(value==null){
						var txt='<span >'+ '----' +'</span>';
					}else{
						var txt='<span >'+ value +'</span>';
					}
					return txt;
			}
			}, {
				field : 'betAmount',
				title : '投注总额'
			}, {
				field : 'winAmount',
				title : '中奖总额'
			}, {
				field : 'marginDollar',
				title : '毛利额',
				formatter:function(value,row){
					 if(!value){
					    	return " ";
					    }else{
					        return '<span style="color:red;">'+ value +'</span>';
					    }
				}
			}, {
				field : 'marginRatio',
				title : '毛利率',
				formatter:function(value,row){
					  if(!value){
					    	return " ";
					    }else{
						return '<span style="color:red;">'+ value +'%</span>';
					    }
				}
			}, {
				field : 'totalAmount',
				title : '总盈亏'
			}, {
				field : 'profitRatio',
				title : '净利率',
					formatter:function(value,row){
						    if(!value){
						    	return " ";
						    }else{
						    	return '<span >'+ value +'%</span>';
						    }
					}
			},{
				field : 'other',
				title : '团队详情',
				formatter : function(value, row) {
					var fianlTxt="";
					if(row.status==3||row.account==null){
						
					}else{
						var txt ='<sjc:auth url="/admin/teamInReport/teamInDelIndex"><a onClick="opens(this,\'团队详情\')"  href="#" data-href="<c:url value="/admin/teamInReport/teamInDelIndex?account="/>'+ row.account +'&status='+row.status+'&test='+row.test+'&curDate='+row.curDate+'&startDate='+row.startDate+'&endDate='+row.endDate+'">查看</a></sjc:auth>'
						fianlTxt=txt;
					}
				    return fianlTxt;
				}
			}] ]
		};
		grid = createGrid('#grid',options);
		$("#search").click(function(){
			var p={};
			$.each($("#form").serializeArray(),function(){  
	            p[this.name]=this.value;  
	        });
			if($("#profitHistoryAndNow").val() == 1){
				if (p["account"] == "") {
					$.messager.alert("错误", "用户不能为空", "error");
					return null;
				}
			}
// 			$("#grid").datagrid("options").queryParams = p;
			reloadGrid("#grid",p);
		});
		
		$('#profitHistoryAndNow').change(function(){ 
			var p=$(this).children('option:selected').val();//这就是selected的值 
			   $('.combo-text').val("");
			   /* $('#profitConditionEndTime').val(""); */
			   $('#profitAccount').val("");
			   if(p==1){	
				   $('#profitConditionAccount').show();
				   $('#profitConditionDate').show();
				   $('.beginTime').datebox("setValue", webProfitDefaultBiginTime);
					$('.endTime').datebox("setValue", webProfitDefaultEndTime);
			   }else if(p==2){
				   $('#profitConditionDate').show();
				   $('#profitConditionAccount').show();
				   $('.beginTime').datebox("setValue", webProfitDefaultBiginTime);
					$('.endTime').datebox("setValue", webProfitDefaultEndTime);
			   }else{
				   $('#profitConditionDate').hide();
				   $('#profitConditionAccount').show();
			   }
			});
	});
	 function opens(a,title){
			addTab(title+' - '+$(a).text(),$(a).attr("data-href"));
		} 
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
	     <div>
	     <form id="form" action="list" method="post">		
                                设定时间：<select name="profitHistoryAndNow" id="profitHistoryAndNow">
					    <option value="0">今天统计</option>
					    <option value="1">历史统计</option>
					    <option value="2">历史详情</option>
                    </select>
              <label  id="profitConditionAccount">
	                                用户名： <input type="text" size="10" name="account" id="profitAccount"/>
	          </label>
	         <label style="display:none;" id="profitConditionDate">
			           时间：    
			        <input type="text" class="easyui-datebox beginTime" size="10"  name="startTime" id="profitConditionStartTime"/><span>(00:00:00)</span>
			           ~
			           <input type="text" class="easyui-datebox endTime" size="10"  name="endTime" id="profitConditionEndTime"/><span>(23:59:59)</span>
			 </label>
			   测试：<select name="test" id="test">
					    <option value="0">否</option>
					    <option value="1">是</option>
                    </select>
			 <a href="#" plain="true" id="search" class="easyui-linkbutton" icon="icon-search">查询</a>
			 </form>
		</div>
	</div>
</body>
</html>