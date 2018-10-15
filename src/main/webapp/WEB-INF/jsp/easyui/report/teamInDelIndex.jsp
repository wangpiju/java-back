<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	$(function() {
		var options = {
				url:'viewDetails',
				singleSelect:true,
				queryParams:{account:'${account}',status:'${status}',test:'${test}',curDate:'${curDate}',startDate:'${startDate}',endDate:'${endDate}'},
			columns : [ [ {
				field : 'account',
				title : '用户'
			}, {
				field : 'createDate',
				title : '日期'
			}, {
				field : 'betAmount',
				title : '投注总额'
			},  {
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
				field : 'totalAmount',
				title : '总盈亏'
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
					var fianlTxt="";
					if(row.status==3||row.account==null){
						
					}else{
						var txt ='<a onClick="opens(this,\'团队详情\')"  href="#" data-href="<c:url value="/admin/teamInReport/teamInDelIndex?account="/>'+ row.account +'&status='+row.status+'&test='+row.test+'&curDate='+row.curDate+'&startDate='+row.startDate+'&endDate='+row.endDate+'">查看</a>'
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
// 			$("#grid").datagrid("options").queryParams = p;
			reloadGrid("#grid",p);
		});
	});
	 function opens(a,title){
			addTab(title+' - '+$(a).text(),$(a).attr("data-href"));
		} 
</script>
</head>
<body>
	<div id="grid"></div>
</body>
</html>