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
			queryParams:{lotteryId:'${lott.id}'},
			columns : [ [ {
				field : 'saleTime',
				title : '第一期销售时间'
			}, {
				field : 'firstTime',
				title : '第一期开奖时间'
			}, {
				field : 'lastTime',
				title : '最后期开奖时间'
			}, {
				field : 'openCycle',
				title : '开奖间隔(秒)'
			}, {
				field : 'weeks',
				title : '开奖周期(星期)'
			}, {
				field : 'beforeClose',
				title : '提前封盘(秒)'
			}, {
				field : 'openAfter',
				title : '超时时间'
			}, {
				field : 'orderId',
				title : '排序'
			}, {
				field : 'beforeDay',
				title : '天数误差'
			}, {
				field : 'status',
				title : '状态',
				formatter:function(value,row){
					if(value==0)
						return '正常';
					else
						return '禁用';
				}
			},{
				field : 'other',
				title : '操作',
				formatter : function(value, row) {
					var win ="'#win'";
					var url = "'edit'";
					var dat = "'edit?id=" + row.id +"'";
					var txt = '&nbsp;&nbsp;&nbsp;&nbsp;<sjc:auth url="/admin/lotterySaleRule/edit"><a href="#" onClick="showWin('+ win +',' +url+ ','+ dat +')">编辑</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
					txt += '<sjc:auth url="/admin/lotterySaleRule/delete"><a href="#" onClick="del(\'delete?id=' + row.id +'\',function(rel){reloadGrid(\'#grid\')})">删除</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
					return txt;
				}
			} ] ]
		};
		createGrid('#grid',options);
		createWin('#win');
	});
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<sjc:auth url="/admin/lotterySaleRule/add"><a href="#" plain="true" class="easyui-linkbutton" icon="icon-add" onClick="showWin('#win','add',{status:0,lotteryId:'${lott.id}'})">添加</a></sjc:auth>
	</div>
	<div id="win">
		<form method="post" style="margin: 20px;">
			<input name="id" type="hidden" />
			<input name="lotteryId" type="hidden" />
			<table class="formtable">
				<tr>
					<td class="input-title">彩票</td>
					<td>${lott.title }</td>
				</tr>
				<tr>
					<td class="input-title">第一期销售时间</td>
					<td><input type="text" name="saleTime" /></td>
				</tr>
				<tr>
					<td class="input-title">第一期开奖时间</td>
					<td><input type="text" name="firstTime" /></td>
				</tr>
				<tr>
					<td class="input-title">最后期开奖时间</td>
					<td><input type="text" name="lastTime" /></td>
				</tr>
				<tr>
					<td class="input-title">排序</td>
					<td><input type="text" name="orderId" /></td>
				</tr>
				<tr>
					<td class="input-title">天数误差</td>
					<td><input type="text" name="beforeDay" /></td>
				</tr>
				<tr>
					<td class="input-title">开奖间隔(秒)</td>
					<td><input type="text" name="openCycle" /></td>
				</tr>
				<tr>
					<td class="input-title">开奖周期(星期)</td>
					<td><input type="text" name="weeks" /></td>
				</tr>
				<tr>
					<td class="input-title">提前封盘(秒)</td>
					<td><input type="text" name="beforeClose" /></td>
				</tr>
				<tr>
					<td class="input-title">抓号超时(秒)</td>
					<td><input type="text" name="openAfter" /></td>
				</tr>
				<tr>
					<td class="input-title">状态</td>
					<td><select name="status">
						<option value="0">正常</option>
						<option value="1">禁用</option>
					</select>
					</td>
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