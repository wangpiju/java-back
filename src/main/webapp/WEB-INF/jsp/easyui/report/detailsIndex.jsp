<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	$(function() {
		var options = {
				url:'viewDetails',
				singleSelect:true,
				queryParams:{account:'${account}',test:'${test}',begin:'${begin}',end:'${end}'},
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
			},/*  {
				field : 'betAmount',
				title : '投注总额'
			}, */{
				field : 'actualSaleAmount',
				title : '实际投注总额'
			}, {
				field : 'rebateAmount',
				title : '返点总额'
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
						return '<span style="color:red;">'+ value +'%</span>';
				}
			}, {
				field : 'activityAndSend',
				title : '活动'
			},  {
				field : 'wages',
				title : '日工资'
			},{
				field : 'count',
				title : '总盈亏'
			},  {
				field : 'rechargeAmount',
				title : '充值'
			},{
				field : 'drawingAmount',
				title : '提款'
			},{
				field : 'profitRatio',
				title : '净利率',
					formatter:function(value,row){
							return '<span >'+ value +'%</span>';
					}
			},{
				field : 'other',
				title : '团队详情',
				formatter : function(value, row) {
					var txt ='';
					if('${account}'!=row.account){
						txt='<a onClick="opens(this,\'团队详情\')"  href="#" data-href="<c:url value="/admin/profitReport/detailsIndex?account="/>'+ row.account +'&test='+row.test+'&begin='+row.begin+'&end='+row.end+'">查看</a>';
					}
				    return txt;
				}
			}] ]
		};
		grid = createGrid('#grid',options);
		$("#search").click(function(){
			var p={};
			$.each($("#form").serializeArray(),function(){  
	            p[this.name]=this.value;  
	        });
			$("#grid").datagrid("options").queryParams = p;
			reloadGrid("#grid");
		});
	});
	 function opens(a,title){
			addTab(title+' - '+$(a).text(),$(a).attr("data-href"));
		} 
	 
	 function reback(test,begin,end){
		 
		    var url ='<c:url value="/admin/profitReport/profitUser?account="/>'+parentAccount;
			
			ajaxData(url,function(datas) {
				parentAccount=datas.content.parentAccount;
				var url ='<c:url value="/admin/profitReport/detailsIndex?account="/>'+parentAccount+"&test="+test+"&begin="+begin+"&end="+end;
				
				window.location.href = url;
			});
	 }
	 
	 var parentAccount = '${account}';
</script>
</head>
<body>
    <div><a href="javascript:;" class="btn searchTeamBtn" onclick="reback('${test}','${begin}','${end}')">返回上一页</a></div>
	<div id="grid"></div>
</body>
</html>