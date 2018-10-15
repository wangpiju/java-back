<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">

function format(str,args) {
	for(var i in args){
		var reg=new RegExp ("({["+i+"]})","g");
		str = str.replace(reg, args[i]);
	}
	return str;
}
	
function valid(){
	var nums = $("#nums").val();
	var groupId = $("#nums>option:selected").attr("data-id");
	$("td").css({color:'#000'});
	if(nums!=''){
		var ns = nums.split(",");
		var nList = [];
		for(var n in ns){
			nList.push(parseInt(ns[n]));
		}
		
		if(groupId!='ssc'){
			$.messager.alert('错误', "目前仅支持时时彩封锁", 'error');
			return;
		}
		
// 		if(groupId=='11x5' && nList.length!=5){
// 			$.messager.alert('错误', "11选5 开奖号码为5个，请填写完整", 'error');
// 			return;
// 		}
		
// 		if(groupId=='ssc' && nList.length!=5){
// 			$.messager.alert('错误', "时时彩开奖号码为5个，请填写完整", 'error');
// 			return;
// 		}
		
// 		if(groupId=='pk10' && nList.length!=10){
// 			$.messager.alert('错误', "北京赛车开奖号码为10个，请填写完整", 'error');
// 			return;
// 		}
		
// 		if(groupId=='3d' && nList.length!=3){
// 			$.messager.alert('错误', "排三、3D开奖号码为3个，请填写完整", 'error');
// 			return;
// 		}
		
		var keys = [];
		keys.push(format("{0}----",nList));
		keys.push(format("-{1}---",nList));
		keys.push(format("--{2}--",nList));
		keys.push(format("---{3}-",nList));
		keys.push(format("----{4}",nList));
		
		keys.push(format("{0}{1}---",nList));
		keys.push(format("{0}-{2}--",nList));
		keys.push(format("{0}--{3}-",nList));
		keys.push(format("{0}---{4}",nList));
		
		keys.push(format("-{1}{2}--",nList));
		keys.push(format("-{1}-{3}-",nList));
		keys.push(format("-{1}--{4}",nList));
		
		keys.push(format("--{2}{3}-",nList));
		keys.push(format("--{2}-{4}",nList));
		
		keys.push(format("---{3}{4}",nList));
		

		keys.push(format("{0}{1}{2}--",nList));
		keys.push(format("{0}{1}-{3}-",nList));
		keys.push(format("{0}{1}--{4}",nList));
		keys.push(format("{0}-{2}{3}-",nList));
		keys.push(format("{0}-{2}-{4}",nList));
		keys.push(format("{0}--{3}{4}",nList));
		
		keys.push(format("-{1}{2}{3}-",nList));
		keys.push(format("-{1}{2}-{4}",nList));
		keys.push(format("-{1}-{3}{4}",nList));
		
		keys.push(format("--{2}{3}{4}",nList));
		
		keys.push(format("{0}{1}{2}{3}-",nList));
		keys.push(format("{0}{1}{2}-{4}",nList));
		keys.push(format("{0}{1}-{3}{4}",nList));
		keys.push(format("{0}-{2}{3}{4}",nList));
		keys.push(format("-{1}{2}{3}{4}",nList));
		

		keys.push(format("{0}{1}{2}{3}{4}",nList));
		
		var win = 0;
		for(var k in keys){
			var key = keys[k];
			var n1 = $("td[data-num='"+key+"']").css({color:'#f00'}).next().css({color:'#f00'}).text();
			if(n1!=''){
				win = win.add(parseFloat(n1));
			}
		}
		$("#open").text("预计奖金："+n);
	}
}
function finds(){
	var lotteryId = $("#lotteryId").val();
	var seasonId = $("#seasonId").val();
	var p = '?lotteryId='+lotteryId+"&seasonId="+seasonId;
	ajaxData('<c:url value="/admin/lotts/loseWin/list"/>'+p,function(data){
		if(data.status!=200) return;
		var d = data.content;
		var betA = 0;
		if(d.BET_AMOUNT){
			betA = d.BET_AMOUNT;
			delete(d['BET_AMOUNT']);
		}
		
		var table = '';
		var keys =[];
		for(var k in d){
			keys.push(k);
		}
		keys.sort();
		$("#betAmount").html(betA+",全部可中号码："+keys.length);
		var index = 0;
		for(var k in d){
			var v = d[k];
			if(index == 0){
				table+="<tr>";
			}
			table+="<td class='input-title' data-num='"+k+"'>"+k+"</td><td>"+parseFloat(v)+"</td>";

			if(index==9){
				table+="</tr>";
				index=0;
			} else {
				index++;
			}
		}
		$("#table").html(table);
	});
}
</script>
</head>
<body>
	<div class="easyui-panel" fit="true" border="none;">
		<div class="search-page">
			<div>
				彩种：<select id="lotteryId">
					<c:forEach items="${list }" var="a">
					<option value="${a.id }" data-id="${a.groupId}">${a.title }</option>
					</c:forEach>
				</select>
				期号：<input type="text" size="10" id="seasonId" />  
				<a href="#" plain="true" class="easyui-linkbutton" icon="icon-search" onClick="finds()">查询</a>
			</div>
			<div>
			期号：<input type="text" size="10" id="nums" /> 
				<a href="#" plain="true" class="easyui-linkbutton" icon="icon-search" onClick="valid()">验证</a>
				<span id="open"></span>
			</div>
			<div>投注额度：<span id="betAmount">0</span></div>
		</div>
		<table class="form-table">
			<tbody id="table"></tbody>
		</table>
	</div>
</body>
</html>