<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	$(function() {
		var options = {
			columns : [ [ {
				field : 'ruleNum',
				title : '契约分红规则'
			},{
				field : 'dayNum',
				title : '契约监控时间（天）'
			},{
				field : 'bonusCycle',
				title : '分红周期',
				formatter : function(value, row) {
					var txt ='';
					if(value==0){
						txt ='<span>半月</span>';
					}else{
						txt ='<span>一月</span>';
					}
					return txt;
				}
			},{
				field : 'other',
				title : '操作',
				formatter : function(value, row) {
					var win ="'#win'";
					var url = "'edit'";
					var dat = "'edit?id=" + row.id +"'";
					var txt = '<sjc:auth url="/admin/contractConfig/edit"><a href="#" onClick="showWin('+ win +',' +url+ ','+ dat +')">编辑</a></sjc:auth>&nbsp;&nbsp;';
					/*  txt +='<sjc:auth url="/admin/contractConfig/delete"><a href="#" onClick="del(\'delete?id=' + row.id +'\',function(rel){reloadGrid(\'#grid\')})">删除</a></sjc:auth>&nbsp;'; */
					return txt;
				}
			}] ]
		};
		createGrid('#grid',options);
		createWin("#win");
	});
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<div>
		   <span>契约分红参数配置</span></br>
		   <span>①多少条规则；</span></br>
		   <span>②契约分红有效时间（天）----逾期发放进入不良记录列表；</span></br>
		   <span>③分红周期参数（2种:0表示半月；1表示一月）：</span></br>
		   <span>（1）半月为一个周期：每月1日0:00:00至15日23:59:59/ 每月16日0:00:00至月底日的23:59:59；</span></br>
		   <span>（2）一月为一个周期：每月1日0:00:00至月底日的23:59:59；</span></br>
		</div>
	</div>
	<div id="win">
		<form method="post" style="margin: 20px;">
			<input type="hidden" name="id"/>
			<table class="formtable">
				<tr>
					<td class="input-title">契约分红规则</td>
					<td><input type="text" name="ruleNum"/></td>
				</tr>
				<tr>
					<td class="input-title">契约监控时间（天）</td>
					<td><input type="text" name="dayNum" /></td>
				</tr>
				<tr>
					<td class="input-title">分红周期</td>
					<td><select name="bonusCycle" id="contractStatus">
					    <option value="0">半月</option>
					    <option value="1">一月</option>
                    </select></td>
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