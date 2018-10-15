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
				field : 'start',
				title : '数值起始'
			},{
				field : 'end',
				title : '数值终结'
			},{
				field : 'surplusNum',
				title : '存货'
			},{
				field : 'warnNum',
				title : '警戒线'
			},{
				field : 'totalAmount',
				title : '累计额度'
			},{
				field : 'addNum',
				title : '补充'
			},{
				field : 'other',
				title : '操作',
				formatter : function(value, row) {
					var win ="'#win'";
					var url = "'edit'";
					var dat = "'edit?id=" + row.id +"'";
					var txt = '<sjc:auth url="/admin/lotts/betInPrice/edit"><a href="#" onClick="showWin('+ win +',' +url+ ','+ dat +')">编辑</a></sjc:auth>';
					return txt;
				}
			}] ]
		};
		createGrid('#grid',options);
		createWin('#win');
	});
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="win">
		<form method="post" style="margin: 20px;">
			<input type="hidden" name="id" />
			<table class="formtable">
				<tr>
					<td class="input-title">数值起始</td>
					<td><input type="text" name="start" readonly="readonly" /></td>
				</tr>
				<tr>
					<td class="input-title">数值终结</td>
					<td><input type="text" name="end" readonly="readonly" /></td>
				</tr>
				<tr>
					<td class="input-title">存货</td>
					<td><input type="text" name="surplusNum" /></td>
				</tr>
				<tr>
					<td class="input-title">警戒线</td>
					<td><input type="text" name="warnNum" /></td>
				</tr>
				<tr>
					<td class="input-title">累计额度</td>
					<td><input type="text" name="totalAmount" /></td>
				</tr>
				<tr>
					<td class="input-title">补充</td>
					<td><input type="text" name="addNum" /></td>
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