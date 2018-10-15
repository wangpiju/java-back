<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	$(function() {
		var options = {
			columns : [[{
				field : 'depositAuto',
				title : '自动出款状态',
				formatter : function(value, row) {
					if (value == 0) {
						return '关闭';
					} else if (value == 1) {
						return '开启';
					} else {
						return value;
					}
				}
			},{
				field : 'other',
				title : '操作',
				formatter : function(value, row) {
					var win ="'#win'";
					var url = "'editStatus'";
					var dat = "'edit?id=" + row.id +"'";
					var txt = '<sjc:auth url="/admin/finance/financeSetting/editStatus"><a href="#" onClick="showWin('+ win +',' +url+ ','+ dat +')">编辑</a></sjc:auth>';
					return txt;
				}
			}] ]
		};
		createGrid('#grid',options);
		createWin('#win');
		
		$("#form").form();
	});
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
	</div>
	<div id="win">
		<form method="post" style="margin: 20px; width: 300px" id="form">
			<input type="hidden" name="id" />
			<table class="formtable">
				<tr>
					<td class="input-title">自动出款状态</td>
					<td>
						<select name="depositAuto">
							<option value="0">关闭</option>
							<option value="1">开启</option>
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