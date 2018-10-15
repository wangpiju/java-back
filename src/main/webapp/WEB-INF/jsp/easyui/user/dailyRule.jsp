<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	$(function() {
		var options = {
			columns : [ [ 
			{
				field : 'name',
				title : '名称'
			},{
				field : 'rate',
				title : '日薪比例',
				formatter : function(value, row) {
					return value + "%";
				}
			},{
				field : 'minRate',
				title : '最低日薪比例',
				formatter : function(value, row) {
					return value + "%";
				}
			},{
				field : 'maxRate',
				title : '最高日薪比例',
				formatter : function(value, row) {
					return value + "%";
				}
			},{
				field : 'limitAmount',
				title : '日薪封顶额度'
			},{
				field : 'validAccountCount',
				title : '有效人数要求',
				formatter : function(value, row) {
					return 0 == value ? "是" : "否";
				}
			},{
				field : 'betAmount',
				title : '最低投注额度'
			},{
				field : 'lossStatus',
				title : '是否开启亏损限制',
				formatter : function(value, row) {
					return 0 == value ? "是" : "否";
				}
			},{
				field : 'level',
				title : '针对层级用户',
				formatter : function(value, row) {
					return value + "级";
				}
			},{
				field : 'status',
				title : '状态',
				formatter : function(value, row) {
					return 0 == value ? "正常" : "禁用";
				}
			},{
				field : 'other',
				title : '操作',
				formatter : function(value, row) {
					var win ="'#win'";
					var url = "'edit'";
					var dat = "'edit?id=" + row.id +"'";
					var txt = '<a href="#" onClick="showWin('+ win +',' +url+ ','+ dat +')">编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;';
					txt += '<a href="#" onClick="delTip(\'delete?id=' + row.id +'\',function(rel){reloadGrid(\'#grid\')},\'删除规则，将删除该规则下所有用户的日薪信息，点击确定继续删除\')">删除</a>';
					return txt;
				}
			}] ]
		};
		createGrid('#grid',options);
		createWin('#win');
	});
	
	function checkDo(ths) {
		if ($("#win form").attr('url') == 'add') {
			saveData(ths, function(rel){ closeWin('#win','#grid')})
		} else {
			$.messager.confirm('提示信息', '修改规则，将删除该规则下所有用户的日薪信息，点击确定继续删除', function(data) {
				saveData(ths, function(rel){ closeWin('#win','#grid')})
			});
		}
	}
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<div>
			<a href="#" plain="true" icon="icon-add" class="easyui-linkbutton" onClick="showWin('#win','add')">新增规则</a>
		</div>
	</div>
	<div id="win">
		<form method="post" style="margin: 20px;">
			<input type="hidden" name="id" />
			<table class="formtable">
				<tr>
					<td class="input-title">名称</td>
					<td><input type="text" name="name" /></td>
				</tr>
				<tr>
					<td class="input-title">日薪比例</td>
					<td><input type="text" name="rate" size="10" />%</td>
				</tr>
				<tr>
					<td class="input-title">最低日薪比例</td>
					<td><input type="text" name="minRate" size="10" />%</td>
				</tr>
				<tr>
					<td class="input-title">最高日薪比例</td>
					<td><input type="text" name="maxRate" size="10" />%</td>
				</tr>
				<tr>
					<td class="input-title">日薪封顶额度</td>
					<td><input type="text" name="limitAmount" /></td>
				</tr>
				<tr>
					<td class="input-title">有效人数要求</td>
					<td>
						<select name="validAccountCount">
							<option value="0">是</option>
							<option value="1">否</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="input-title">最低投注额度</td>
					<td><input type="text" name="betAmount" /></td>
				</tr>
				<tr>
					<td class="input-title">是否开启亏损限制</td>
					<td>
						<select name="lossStatus">
							<option value="0">是</option>
							<option value="1">否</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="input-title">针对层级用户</td>
					<td>
						<select name="level">
							<c:forEach begin="1" end="15" step="1" var="item">
								<option value="${item }">${item }级</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td class="input-title">状态</td>
					<td>
						<select name="status">
							<option value="0">正常</option>
							<option value="1">禁用</option>
						</select>
					</td>
				</tr>
			</table>
			<div style="text-align: center; padding: 5px;">
				<a href="#" class="btn-save" icon="icon-save" onClick="checkDo(this);">保存</a>
				<a href="#" class="btn-cancel" icon="icon-cancel" onClick="closeWin('#win')">取消</a>
			</div>
		</form>
	</div>
</body>
</html>