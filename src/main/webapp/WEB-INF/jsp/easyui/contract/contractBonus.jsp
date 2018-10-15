<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	$(function() {
		var options = {
			columns : [ [ {
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
				title : '用户名'
			},{
				field : 'parentAccount',
				title : '契约上级'
			},{
				field : 'rootAccount',
				title : '所属总代理'
			},{
				field : 'startDate',
				title : '开始日期'
			},{
				field : 'endDate',
				title : '结束日期'
			},{
				field : 'cumulativeSales',
				title : '累计销售量'
			},{
				field : 'dividend',
				title : '分红比',
				formatter : function(value, row) {
					return '<span>'+ value +'</span>';
				}
			},{
				field : 'cumulativeProfit',
				title : '累计盈亏'
			},{
				field : 'dividendAmount',
				title : '应发分红'
			},{
				field : 'status',
				title : '状态',
                formatter : function(value, row) {
					if(value==0){
						var txt='<span >'+ '尚未发放' +'</span>';
					}else if(value==1){
						var txt='<span >'+ '已发分红' +'</span>';
					}else if(value==2){
						var txt='<span >'+ '不需分红' +'</span>';
					}else if(value==3){
						var txt='<span >'+ '逾期未发放' +'</span>';
					}else if(value==4){
						var txt='<span >'+ '強制发放完毕' +'</span>';
					}else if(value==5){
						var txt='<span >'+ '系统已发放' +'</span>';
					}else if(value==6){
						var txt='<span >'+ '系统已拒发' +'</span>';
					}
					return txt;
				}
			},{
				field : 'other',
				title : '操作',
				formatter : function(value, row) {
					if(row.status==3){
						var a = row.id + ",'" + row.account + "','" + row.parentAccount + "',"+row.dividendAmount;
						var txt = '<sjc:auth url="/admin/contractRule/payout"><a href="#" onclick="payout(' + a + ')">强制执行</a></sjc:auth>';
						return txt;
					}
					if((row.account==row.rootAccount|| !row.parentAccount)&&row.status==0){
						var a = row.id + ",'" + row.account + "','" + row.parentAccount + "',"+row.dividendAmount;
						var txt = '<sjc:auth url="/admin/contractRule/payoutDirectly"><a href="#" onclick="payoutDirectly(' + a + ')">系统发</a></sjc:auth>&nbsp;&nbsp;';
						 txt += '<sjc:auth url="/admin/contractRule/refuseDirectly"><a href="#" onclick="refuseDirectly(' + a + ')">拒发</a></sjc:auth>';
						return txt;
					}
				}
			}] ]
		};
		createGrid('#grid',options);
		//createWin("#win");
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
	//强制派发
	function payout(id,account,parentAccount,dividendAmount){
		var url ='<c:url value="/admin/contractBonus/payout?id="/>'+id+"&account="+account+"&parentAccount="+parentAccount+"&dividendAmount="+dividendAmount;
		$.messager.confirm('提示信息', '是否强制派发分红？', function(data) {
			if (data) {
				ajaxData(url,function(rel){
					$.messager.alert('成功', rel.content, 'success');
					reloadGrid("#grid");
				});
			}
		});
	}
	//发放直属的分红
	function payoutDirectly(id,account,parentAccount,dividendAmount){
		var url ='<c:url value="/admin/contractBonus/payoutDirectly?id="/>'+id+"&account="+account+"&parentAccount="+parentAccount+"&dividendAmount="+dividendAmount;
		$.messager.confirm('提示信息', '是否发放直属分红？', function(data) {
			if (data) {
				ajaxData(url,function(rel){
					$.messager.alert('成功', rel.content, 'success');
					reloadGrid("#grid");
				});
			}
		});
	}
	//拒发直属的分红
	function refuseDirectly(id,account,parentAccount,dividendAmount){
		var url ='<c:url value="/admin/contractBonus/refuseDirectly?id="/>'+id;
		$.messager.confirm('提示信息', '是否拒发直属的分红？', function(data) {
			if (data) {
				ajaxData(url,function(rel){
					$.messager.alert('成功', rel.content, 'success');
					reloadGrid("#grid");
				});
			}
		});
	}
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
	   <div>
	     <form id="form" action="list" method="post">		
                                
	                       用户名： <input type="text" size="10" name="account" id="contractAccount"/>
	                       所属总代理： <input type="text" size="10" name="rootAccount" id="contractRootAccount"/>
			    日期 ：<input type="text" class="easyui-datebox" size="10"  name="startDate" id="contractStartDate"/>
			   状态：<select name="status" id="contractStatus">
			            <option value="">全部</option>
					    <option value="0">尚未发放</option>
					    <option value="1">已发分红</option>
					    <option value="2">不需分红</option>
					    <option value="3">逾期未发放</option>
					    <option value="4">強制发放完毕</option>
					    <option value="5">系统已发放</option>
					    <option value="6">系统已拒发</option>
                    </select>
			 <a href="#" plain="true" id="search" class="easyui-linkbutton" icon="icon-search">查询</a>
			 </form>
		</div>
	</div>
</body>
</html>