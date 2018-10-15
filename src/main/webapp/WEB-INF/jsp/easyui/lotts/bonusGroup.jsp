<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	$(function() {
		var options = {
			singleSelect:true,
			columns : [ [ {
				field : 'title',
				title : '标题'
			}, {
				field : 'bonusRatio',
				title : '固定返奖率',
				formatter:function(value,row){
					return value+"%";
				}
			}, {
				field : 'rebateRatio',
				title : '返点',
				formatter:function(value,row){
					return value+"%";
				}
			}, {
				field : 'companyRatio',
				title : '公司留水',
				formatter:function(value,row){
					var n = 100;
					return n.sub(row.bonusRatio.add(row.rebateRatio))+"%";
				}
			}, {
				field : 'noneMinRatio',
				title : '无配额最小返点',
				formatter:function(value,row){
					return value+"%";
				}
			}, {
				field : 'userMinRatio',
				title : '最小点差',
				formatter:function(value,row){
					return value+"%";
				}
			},{
				field : 'playerMaxRatio',
				title : '会员最大返点',
				formatter:function(value,row){
					return value+"%";
				}
			}
// 			,{
// 				field : 'other',
// 				title : '操作',
// 				formatter : function(value, row) {
// 					var win ="'#win'";
// 					var url = "'edit'";
// 					var dat = "'edit?id=" + row.id +"'";
// 					var txt = '<a href="#" onClick="showWin('+ win +',' +url+ ','+ dat +')">编辑</a>&nbsp;&nbsp;';
// 					return txt;
// 				}
// 			}
			] ]
		};
		createGrid('#grid',options);
		createWin('#win');
	});
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<sjc:auth url="/admin/bonusGroup/add"><a href="#" plain="true" class="easyui-linkbutton" icon="icon-add" onClick="showWin('#win','add')">添加</a></sjc:auth>
	</div>
	<div id="win">
		<form method="post" style="margin: 20px;">
			<input name="id" type="hidden" />
			<table class="formtable">
				<tr>
					<td class="input-title">标题</td>
					<td><input type="text" name="title" /></td>
				</tr>
				<tr>
					<td class="input-title">固定返奖率</td>
					<td><input type="text" name="bonusRatio" />%</td>
				</tr>
				<tr>
					<td class="input-title">返点</td>
					<td><input type="text" name="rebateRatio" />%</td>
				</tr>
				<tr>
					<td class="input-title">无配额最小返点</td>
					<td><input type="text" name="noneMinRatio" />%</td>
				</tr>
				<tr>
					<td class="input-title">最小点差</td>
					<td><input type="text" name="userMinRatio" />%</td>
				</tr>
				<tr>
					<td class="input-title">会员最大返点</td>
					<td><input type="text" name="playerMaxRatio" />%</td>
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