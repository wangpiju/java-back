<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	$(function() {
		var options = {
			columns : [ [ 
			{
				field : 'account',
				title : '账号'
			},{
				field : 'killAmount',
				title : '追杀金额'
			},{
				field : 'killCount',
				title : '追杀次数'
			},{
				field : 'bothStatus',
				title : '是否同时满足',
				formatter : function(value, row) {
					if (value == 0) {
						return "是";
					} else if (value == 1) {
						return "否";
					} else {
						return value;
					}
				}
			},{
				field : 'killPriceMin',
				title : '追杀最小倍数'
			},{
				field : 'killPriceMax',
				title : '追杀最大倍数'
			},{
				field : 'hadKillAmount',
				title : '已追杀金额'
			},{
				field : 'hadKillCount',
				title : '已追杀次数'
			},{
				field : 'status',
				title : '状态',
				formatter : function(value, row) {
					if (value == 0) {
						return "未启动";
					} else if (value == 1) {
						return "进行中";
					} else if (value == 2) {
						return "完成";
					} else if (value == 3) {
						return "已停止";
					} else {
						return value;
					}
				}
			},{
				field : 'other',
				title : '操作',
				formatter : function(value, row) {
					var win ="'#win'";
					var url = "'edit'";
					var dat = "'edit?id=" + row.id +"'";
					var txt = '<sjc:auth url="/admin/lotts/betInRuleKill/edit"><a href="#" onClick="showWin('+ win +',' +url+ ','+ dat +')">编辑</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
					txt += '<sjc:auth url="/admin/lotts/betInRuleKill/delete"><a href="#" onClick="del(\'delete?id=' + row.id +'\',function(rel){reloadGrid(\'#grid\')})">删除</a></sjc:auth>';
					return txt;
				}
			}] ],
			url : 'list?type=0'
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
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<div>
			<form id="form" action="list" method="post">
				<table>
			       <tr>
			          <td>账号：</td>
			          <td><input type="text" size="10" name="account" /></td>
				      <td>状态：</td>
			          <td>
			          	<select name="status">
			          		<option value="">不限</option>
			                <option value="0">未启动</option>
							<option value="1">进行中</option>
							<option value="2">完成</option>
							<option value="3">已停止</option>
				        </select>
			          </td>
			          <td> <a href="#" plain="true" id="search" class="easyui-linkbutton" icon="icon-search">查询</a></td>
			          <td> <sjc:auth url="/admin/lotts/betInRuleKill/add"><a href="#" plain="true" icon="icon-add" class="easyui-linkbutton" onClick="showWin('#win','add?type=0')">添加</a></sjc:auth></td>
			          <td> <sjc:auth url="/admin/lotts/betInRuleKill/delete"><a href="#" plain="true" icon="icon-remove" class="easyui-linkbutton" onClick="delAll('delete','#grid')">删除</a></sjc:auth></td>
			       </tr>
			   </table>
			</form>
		</div>
	</div>
	<div id="win">
		<form method="post" style="margin: 20px;">
			<input type="hidden" name="id" />
			<input type="hidden" name="type" value="0" />
			<table class="formtable">
				<tr>
					<td class="input-title">账号</td>
					<td><input type="text" name="account" /></td>
				</tr>
				<tr>
					<td class="input-title">追杀金额</td>
					<td><input type="text" name="killAmount" /></td>
				</tr>
				<tr>
					<td class="input-title">追杀次数</td>
					<td><input type="text" name="killCount" /></td>
				</tr>
				<tr>
					<td class="input-title">是否同时满足</td>
					<td>
						<select name="bothStatus">
							<option value="0">是</option>
							<option value="1">否</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="input-title">追杀最小倍数</td>
					<td><input type="text" name="killPriceMin" /></td>
				</tr>
				<tr>
					<td class="input-title">追杀最大倍数</td>
					<td><input type="text" name="killPriceMax" /></td>
				</tr>
				<tr>
					<td class="input-title">已追杀金额</td>
					<td><input type="text" name="hadKillAmount" /></td>
				</tr>
				<tr>
					<td class="input-title">已追杀次数</td>
					<td><input type="text" name="hadKillCount" /></td>
				</tr>
				<tr>
					<td class="input-title">状态</td>
					<td>
						<select name="status">
							<option value="0">未启动</option>
							<option value="1">进行中</option>
							<option value="2">完成</option>
							<option value="3">已停止</option>
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