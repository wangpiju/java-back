<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
var grid;
	$(function() {
		var options = {
			singleSelect:true,
 			queryParams:{lotteryId:'${lotteryId}'},
			columns : [ [ {
				field : 'lotteryId',
				title : '彩票标示'
			}, {
				field : 'seasonRule',
				title : '期号规则'
			}, {
				field : 'seasonDate',
				title : '期号时间'
			}, {
				field : 'firstSeason',
				title : '当天第一期期号'
			}, {
				field : 'autoCreateDay',
				title : '预留天数'
			},{
				field : 'other',
				title : '操作',
				formatter : function(value, row) {
					var win ="'#win'";
					var url = "'edit'";
					var dat = "'edit?id=" + row.id +"'";
					var txt = '&nbsp;&nbsp;&nbsp;&nbsp;<sjc:auth url="/admin/seasonForDate/edit"><a href="#" onClick="showWin('+ win +',' +url+ ','+ dat +')">编辑</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
					txt += '<sjc:auth url="/admin/seasonForDate/delete"><a href="#" onClick="del(\'delete?id=' + row.id +'\',function(rel){reloadGrid(\'#grid\')})">删除</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
					return txt;
				}
			} ] ]
		};
		createGrid('#grid',options);
		createWin('#win');
		function checkSave(){
			
		}
	});
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<sjc:auth url="/admin/seasonForDate/add"><a href="#" plain="true" class="easyui-linkbutton" icon="icon-add" onClick="showWin('#win','add',{lotteryId:'${lotteryId}'})">添加</a></sjc:auth>
	</div>
	<div id="win">
		<form method="post" style="margin: 20px;">
			<input name="id" type="hidden" />
			<table class="formtable">
				<tr>
					<td class="input-title">彩票标示</td>
					<td><input type="text" name="lotteryId"  value="${lotteryId}" readonly="readonly"/></td>
				</tr>
				<tr>
					<td class="input-title">期号规则</td>
					<td><select name="seasonRule" style="width:153px">
						<c:forEach items="${seasonRules}" var="a">
						<option value="${a.title }">${a.remark }</option>
						</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td class="input-title">期号时间</td>
					<td><input type="text" class='easyui-datebox'  name="seasonDate" /></td>
				</tr>
				<tr>
					<td class="input-title">当天第一期期号</td>
					<td><input type="text" name="firstSeason" /></td>
				</tr>
				<tr style="display:none">
					<td class="input-title">更新时间</td>
					<td><input type="text" class='easyui-datebox' name="lastTime" /></td>
				</tr>
				<tr>
					<td class="input-title">预留天数</td>
					<td><input type="text" name="autoCreateDay" /></td>
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