<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
var countFields = ['betAmount', 'rebateAmount', 'actualSaleAmount', 'winAmount', 'marginDollar', 'wages','activityAndSend','rechargeAmount','drawingAmount','count'];
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
			}, /* {
				field : 'betAmount',
				title : '投注总额'
			}, */{
				field : 'actualSaleAmount',
				title : '实际投注总额'
			}, {
				field : 'rebateAmount',
				title : '返点总额'
			},{
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
				field : 'activityAndSend',
				title : '活动'
			},  {
				field : 'wages',
				title : '日工资'
			},{
				field : 'rechargeAmount',
				title : '充值'
			},{
				field : 'drawingAmount',
				title : '提款'
			},{
				field : 'count',
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
					if(row.status==2){
						var txt ='<sjc:auth url="/admin/profitReport/detailsIndex"><a onClick="opens(this,\'团队详情\')"  href="#" data-href="<c:url value="/admin/profitReport/detailsIndex?account="/>'+ row.account +'&test='+row.test+'&begin='+row.begin+'&end='+row.end+'">查看</a></sjc:auth>'
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
		 $('.beginTime').datebox("setValue", webProfitDefaultBiginTime);
		 $('.endTime').datebox("setValue", webProfitDefaultEndTime);
		$('#profitHistoryAndNow').change(function(){ 
			var p=$(this).children('option:selected').val();//这就是selected的值 
			   $('.combo-text').val("");
			   /* $('#profitConditionEndTime').val(""); */
			   $('#profitAccount').val("");
			   if(p==1){	
				   $('.beginTime').datebox("setValue", webProfitDefaultBiginTime);
					$('.endTime').datebox("setValue", webProfitDefaultEndTime);
			   }else if(p==2){
				   $('.beginTime').datebox("setValue", webProfitDefaultBiginTime);
					$('.endTime').datebox("setValue", webProfitDefaultEndTime);
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
                                设定时间：<select name="status" id="profitHistoryAndNow">
					    <option value="1">盈亏详情</option>
					    <option value="2">盈亏统计</option>
                    </select>
              <label  id="profitConditionAccount">
	                                用户名： <input type="text" size="10" name="account" id="profitAccount"/>
	          </label>
			           时间：    
		        <input type="text" class="easyui-datebox beginTime" size="10"  name="begin" id="profitConditionStartTime"/><span>(00:00:00)</span>
		           ~
		        <input type="text" class="easyui-datebox endTime" size="10"  name="end" id="profitConditionEndTime"/><span>(23:59:59)</span>
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