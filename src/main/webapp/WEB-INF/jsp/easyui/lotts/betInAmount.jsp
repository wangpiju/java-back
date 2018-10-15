<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
var betInPriceJson = ${betInPriceJson };
var betInRuleJson  = ${betInRuleJson };
	$(function() {
		var options = {
			columns : [ [ 
			{
				field : 'name',
				title : '名称'
			},{
				field : 'amount',
				title : '金额止'
			},{
				field : 'probability',
				title : '概率'
			},{
				field : 'priceId',
				title : '数值区间',
				formatter:function(value,row) {
					for(var i=0;i<betInPriceJson.length;i++){
						var ag = betInPriceJson[i];
						if(ag.id == value){
							return ag.start + '-' + ag.end;
						}
					}
				}
			},{
				field : 'ruleId',
				title : '规则',
				formatter:function(value,row) {
					for(var i=0;i<betInRuleJson.length;i++){
						var ag = betInRuleJson[i];
						if(ag.id == value){
							return ag.name;
						}
					}
				}
			},{
				field : 'other',
				title : '操作',
				formatter : function(value, row) {
					var win ="'#win'";
					var url = "'edit'";
					var dat = "'edit?id=" + row.id +"'";
					var txt = '<sjc:auth url="/admin/lotts/betInAmount/edit"><a href="#" onClick="showWin('+ win +',' +url+ ','+ dat +',showProbability)">编辑</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
					txt += '<sjc:auth url="/admin/lotts/betInAmount/delete"><a href="#" onClick="delTip(\'delete?id=' + row.id +'\',function(rel){reloadGrid(\'#grid\')},\'将删除该规则该金额下所有的区间，您确认要删除吗?\')">删除</a></sjc:auth>';
					return txt;
				}
			}] ]
		};
		createGrid('#grid',options);
		createWin('#win');
		
		$("#form").form();
		
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
	
function showProbability(data){
	if (data.betInAmount) {
		$("#id").val(data.betInAmount.id);
		$("#name").val(data.betInAmount.name);
		$("#ruleId").val(data.betInAmount.ruleId);
		$("#amount").val(data.betInAmount.amount);
	}
	if (data.probabilityList) {
		for (var i = 0; i < data.probabilityList.length; i++) {
			var bim = data.probabilityList[i];
			$("#price_" + bim.priceId).val(bim.probability);
		}
		countProbability();
	}
}	
	
function countProbability() {
	var count = 0;
	$("input[id^='price_']").each(function(){
		count = Math.add(count, this.value == null ? 0 : this.value);
	});
	$("#count").html(count);
}
</script>
<script type="text/javascript">
function computeProbability() {
	var odds = $("#odds").val();
	if (odds) {
		count(odds);
	}
}

var N = 19;
var ERROR = 0.00000001;

var bonus = [ 0.05, 0.15, 0.25, 0.35, 0.45, 0.55, 0.65, 0.75, 0.85, 0.95, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5, 7.5, 8.5, 9.5 ];
var alpha = [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ];

var pl;

function count(odds) {
	if (compute(odds)) {
		var d = 0;
		for (var i = 0; i < N; i++) {
			$("#price_" + (i+1)).val(Math.mul(pl[i], 100).toFixed(2));
		}
	} else {
		console.log("error!");
	}
	countProbability();
}

function excuteL2(lower, upper, odds) {
	pl = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

	if (lower == upper) {
		if (Math.abs(odds - bonus[lower]) > ERROR)
			return false;
		pl[lower] = 1;
		return true;
	}

	var good = true;
	var a1 = 0, b1 = 0, a2 = 0, b2 = 0;
	for (var j = lower; j <= upper; j++) {
		a1 += bonus[j] * bonus[j] / -2 / alpha[j];
		b1 += bonus[j] / -2 / alpha[j];
		a2 += bonus[j] / -2 / alpha[j];
		b2 += 1.0 / -2 / alpha[j];
	}

	var a = (b1 - odds * b2) / (a2 * b1 - a1 * b2);
	var b = (a1 - odds * a2) / (b2 * a1 - b1 * a2);

	for (var j = lower; j <= upper; j++) {
		pl[j] = (bonus[j] * a + b) / -2 / alpha[j];
		if (pl[j] < 0)
			good = false;
		else if (Math.abs(pl[j]) < ERROR)
			pl[j] = 0;
	}

	return good;
}

function compute(odds) {
	if (odds < bonus[0] || odds > bonus[N - 1])
		return false;
	
	if (odds < 1.5) {
		for (var j = N - 1; j >= 0; j--) {
			if (excuteL2(0, j, odds))
				return true;
		}
	} else {
		for (var j = 0; j < N; j++) {
			if (excuteL2(j, N - 1, odds))
				return true;
		}
	}
	return false;
}
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<div>
			<form id="form" action="list" method="post">
				<table>
			       <tr>
				      <td>规则：</td>
			          <td>
			          	<select name="ruleId">
			          		<option value="">不限</option>
			               	<c:forEach items="${betInRuleList }" var="betInRule">
			               		<option value="${betInRule.id }">${betInRule.name }</option>
			               	</c:forEach>
				        </select>
			          </td>
			          <td> <a href="#" plain="true" id="search" class="easyui-linkbutton" icon="icon-search">查询</a></td>
			          <td> <sjc:auth url="/admin/lotts/betInAmount/add"><a href="#" plain="true" icon="icon-add" class="easyui-linkbutton" onClick="showWin('#win','add')">添加</a></sjc:auth></td>
			          <td> <sjc:auth url="/admin/lotts/betInAmount/delete"><a href="#" plain="true" icon="icon-remove" class="easyui-linkbutton" onClick="delAll('delete','#grid')">删除</a></sjc:auth></td>
			       </tr>
			   </table>
			</form>
		</div>
	</div>
	<div id="win">
		<form method="post" style="margin: 20px; height: 500px">
			<input type="hidden" name="id" id="id" />
			<table class="formtable">
				<tr>
					<td class="input-title">名称</td>
					<td><input type="text" name="name" id="name" /></td>
				</tr>
				<tr>
					<td class="input-title">规则</td>
					<td>
						<select name="ruleId" id="ruleId">
							<c:forEach items="${betInRuleList }" var="a">
								<option value="${a.id }">${a.name }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td class="input-title">金额止</td>
					<td><input type="text" name="amount" id="amount" /></td>
				</tr>
				<tr>
					<td class="input-title">倍数期望值P</td>
					<td><input type="text" id="odds" /><input type="button" onclick="computeProbability();" value="计算"></td>
				</tr>
				<c:forEach items="${betInPriceList }" var="a" varStatus="s">
				<tr>
					<td class="input-title">概率(${a.start }-${a.end })</td>
					<td>
						<input type="text" id="price_${a.id }" name="probabilitys" onkeyup="countProbability();" /><br />
					</td>
				</tr>
				</c:forEach>
				<tr>
					<td class="input-title">概率汇总</td>
					<td id="count">0.00</td>
				</tr>
			</table>
			<div style="text-align: center; padding: 5px;">
				<a href="#" class="btn-save" icon="icon-save" onClick="saveData(this, function(rel){ closeWin('#win','#grid')})">保存</a>
				<a href="#" class="btn-cancel" icon="icon-cancel" onClick="closeWin('#win')">取消</a>
			</div>
		</form>
	</div>
</body>
</html>