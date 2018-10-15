<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
var betInRuleJson  = ${betInRuleJson };
	$(function() {
		var options = {
			columns : [ [ 
			{
				field : 'startTime',
				title : '起始时间'
			},{
				field : 'endTime',
				title : '终止时间'
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
				field : 'probability',
				title : '概率'
			},{
				field : 'other',
				title : '操作',
				formatter : function(value, row) {
					var win ="'#win'";
					var url = "'edit'";
					var dat = "'edit?id=" + row.id +"'";
					var txt = '<sjc:auth url="/admin/lotts/betInTime/edit"><a href="#" onClick="showWin('+ win +',' +url+ ','+ dat +',showProbability)">编辑</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
					txt += '<sjc:auth url="/admin/lotts/betInTime/delete"><a href="#" onClick="del(\'delete?id=' + row.id +'\',function(rel){reloadGrid(\'#grid\')})">删除</a></sjc:auth>';
					return txt;
				}
			}] ]
		};
		createGrid('#grid',options);
		createWin('#win');
	});
	
	function showProbability(data){
		if (data.betInTime) {
			$("#id").val(data.betInTime.id);
			$("#startTime").val(data.betInTime.startTime);
			$("#endTime").val(data.betInTime.endTime);
		}
		if (data.probabilityList) {
			for (var i = 0; i < data.probabilityList.length; i++) {
				var bim = data.probabilityList[i];
				$("#price_" + bim.ruleId).val(bim.probability);
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
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<div>
			<sjc:auth url="/admin/lotts/betInTime/add"><a href="#" plain="true" icon="icon-add" class="easyui-linkbutton" onClick="showWin('#win','add')">添加</a></sjc:auth>
			<sjc:auth url="/admin/lotts/betInTime/delete"><a href="#" plain="true" icon="icon-remove" class="easyui-linkbutton" onClick="delAll('delete','#grid')">删除</a></sjc:auth>
		</div>
	</div>
	<div id="win">
		<form method="post" style="margin: 20px;">
			<input type="hidden" name="id" id="id" />
			<table class="formtable">
				<tr>
					<td class="input-title">起始时间</td>
					<td><input type="text" name="startTime" id="startTime" /></td>
				</tr>
				<tr>
					<td class="input-title">终止时间</td>
					<td><input type="text" name="endTime" id="endTime" /></td>
				</tr>
				<c:forEach items="${betInRuleList }" var="a">
				<tr>
					<td class="input-title">概率（${a.name }）</td>
					<td>
						<input type="text" id="price_${a.id }" name="rule${a.id }" onkeyup="countProbability();" /><br />
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