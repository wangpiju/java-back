<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<style>
	#contractRule div{margin-bottom:10px;}
</style>
<script type="text/javascript">
    var dArray =["一","二","三","四","五","六","七","八","九","十"];
	$(function() {
		var options = {
			columns : [ [ {
				field : 'account',
				title : '用户名'
			}, {
				field : 'parentAccount',
				title : '契约上级'
			},{
				field : 'contractTime',
				title : '契约时间'
			}, {
				field : 'contractStatus',
				title : '契约状态',
				formatter : function(value, row) {
					if(value==0){
						return '<span>'+ '确认契约中' +'</span>';
					}else if(value==1){
						return '<span>'+ '已经签约' +'</span>';
					}else if(value==2){
						return '<span>'+ '拒绝签约' +'</span>';
					}else if(value==3){
						return '<span>'+ '已激活' +'</span>';
					}else if(value==4){
						return '<span>'+ '已关闭' +'</span>';
					}else if(value==8){
						return '<span>'+ '尚未签约' +'</span>';
					}
				}
			},{
				field : 'other',
				title : '操作',
				formatter : function(value, row) {
					var win ="'#win'";
					var url = "'edit'";
					var dat = "'edit?account=" + row.account +"&contractStatus="+row.contractStatus +"'";
					var condition ="'account=" + row.account +"&contractStatus="+row.contractStatus +"'";
					var txt ='<sjc:auth url="/admin/contractRule/edit"><a href="#" onClick="editContract('+ win +',' +url+ ','+ dat +','+ function(d){test(d);} +')">编辑</a></sjc:auth>&nbsp;&nbsp;';
					txt += '<sjc:auth url="/admin/contractRule/delete"><a href="#" onClick="del(\'delete?account=' + row.account +'&contractStatus='+row.contractStatus+'\',function(rel){reloadGrid(\'#grid\')})">删除</a></sjc:auth>';
					return txt;
				}
			}] ]
		};
		createGrid('#grid',options);
		createWin("#win");
		createWin("#winShow");
		createWin("#winAdd");
		
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
	
	//添加
	function addContract(){
		$("#contractRules div").remove();
		showWin('#win','add');
	}
	
	//编辑
	function editContract(win,url,dat,fuc){
		$("#contractRules div").remove();
		showWin(win,url,dat,fuc);
	}
	
	//添加规则
	function addContractRule(){
		var n = $("#contractRules div").length;
		var a =$("#configCycle").val();
		if(n>=a){
			return;
		} 
		var div ='';
		if(n==0){
			 div +='<div>契约规则<span class="ruleNum">'+dArray[n]+'</span>：&nbsp;&nbsp;保底分红：';
			 div+='<input type="text" name="contractRuleList['+n+'].gtdBonuses" />%';
		}else{
			div+='<div>契约规则<span class="ruleNum">'+dArray[n]+'</span>：&nbsp;&nbsp;累积销量：';
			div+=' <input type="text" class="cumulativeSales" name="contractRuleList['+ n +'].cumulativeSales" />';
			div+=' &nbsp;&nbsp;投注人数：<input type="text" class="humenNum" name="contractRuleList['+ n +'].humenNum" />';
			div+=' &nbsp;&nbsp;分红：<input type="text" class="dividend" name="contractRuleList['+ n +'].dividend" />%';
			div+=' <a href="#" class="easyui-linkbutton" icon="icon-edit" onClick="deleteContracts(this)">删除</a>';
		}
		div+="</div>";
		$("#contractRules").append(div);
	}
	
	//删除规则
	function deleteContracts(a) {
		$(a).parent("div").remove();
		$("#contractRules div").each(function(i,n){
			if(i>0){
				$(this).find(".ruleNum").text(dArray[i]);
				$(this).find(".cumulativeSales").attr("name","contractRuleList["+i+"].cumulativeSales");
				$(this).find(".humenNum").attr("name","contractRuleList["+i+"].humenNum");
				$(this).find(".dividend").attr("name","contractRuleList["+i+"].dividend");
			}
		});
	}
	
	//编辑
	function test(b){
		//$("#contractRules div").remove();
		var o =eval(b.contractRuleList);
		
		for(var i=0;i<o.length;i++){
			var div='';
			if(i==0){
			    div +='<div>契约规则<span class="ruleNum">'+dArray[i]+'</span>：&nbsp;&nbsp;保底分红：';
				div+='<input type="text" name="contractRuleList['+i+'].gtdBonuses" value="'+o[i].gtdBonuses+'"/>%';
			}else{
				div+='<div>契约规则<span class="ruleNum">'+dArray[i]+'</span>：&nbsp;&nbsp;累积销量：';
				div+='<input type="text" class="cumulativeSales" name="contractRuleList['+ i +'].cumulativeSales"  value="'+o[i].cumulativeSales+'"/>';
				div+=' &nbsp;&nbsp;投注人数：<input type="text" class="humenNum" name="contractRuleList['+ i +'].humenNum" value="'+o[i].humenNum+'"/>';
				div+=' &nbsp;&nbsp;分红：<input type="text" class="dividend" name="contractRuleList['+ i +'].dividend" value="'+o[i].dividend+'" />%';
				div+='<a href="#" class="easyui-linkbutton" icon="icon-edit" onClick="deleteContracts(this)">删除</a>';
				div+="</div>";
			}
			$("#contractRules").append(div);
		}
	};
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<div>
			<sjc:auth url="/admin/contractRule/add"><a href="#" plain="true" icon="icon-add" class="easyui-linkbutton" onClick="addContract()">添加契约</a></sjc:auth>
			<input id="configCycle" type="hidden" value="${contractConfig.ruleNum }"/>
		</div>
		 <div>
	     <form id="form" action="list" method="post">		
	                       用户名： <input type="text" size="10" name="account" />
			 <a href="#" plain="true" id="search" class="easyui-linkbutton" icon="icon-search">查询</a>
			 </form>
		</div>
	</div>
	<div id="win">
		<form method="post" style="margin: 20px;">
			<label>用户名：</label>
			<input type="text" name="account" /> &nbsp;&nbsp;
			<label>契约上级：</label>
			<select name="type">
				 <option value="0">系统</option>
				 <option value="1">上级</option>
		    </select>
		    &nbsp;&nbsp;&nbsp;
			<a href="#" class="easyui-linkbutton" icon="icon-edit" onClick="addContractRule()">添加</a> 
			<div id="contractRules" style="width:850px;">
		    </div>
			<div style="text-align: center; padding: 5px;">
				<a href="#" class="btn-save" icon="icon-save" onClick="saveData(this, function(rel){ closeWin('#win','#grid')})">保存</a>
				<a href="#" class="btn-cancel" icon="icon-cancel" onClick="closeWin('#win')">取消</a>
			</div>
		</form>
	</div>
</body>
</html>