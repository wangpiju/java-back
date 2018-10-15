<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	$(function() {
		var options = {
			singleSelect:true,
			queryParams:{lotteryId:'${lott.id}'},
			columns : [ [ {
				field : 'url',
				title : '网址/算法'
			}, {
				field : 'urlBuilder',
				title : '网址规则'
			}, {
				field : 'regex',
				title : '正则表达式',
				formatter:function(value,row){
					var t = value.replace(/</g,"&lt;");
					t = t.replace(/>/g,"&gt;");
					return t;
				}
			}, {
				field : 'craType',
				title : '号源类型',
				formatter:function(value,row){
					if(value==0)
						return '爬虫';
					else if(value == 1)
						return '人工录号';
					else
						return '随机生成';
				}
			}, {
				field : 'weight',
				title : '权重'
			}, {
				field : 'status',
				title : '状态',
				formatter:function(value,row){
					if(value==0)
						return '<span style="color:green;">正常</span>';
					else
						return '<span style="color:red;">禁用</span>';
				}
			},{
				field : 'other',
				title : '操作',
				formatter : function(value, row) {
					var win ="'#win'";
					var url = "'edit'";
					var dat = "'edit?id=" + row.id +"'";
					var txt = '&nbsp;&nbsp;&nbsp;&nbsp;<sjc:auth url="/admin/crawler/edit"><a href="#" onClick="showWin('+ win +',' +url+ ','+ dat +')">编辑</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
					txt += '<sjc:auth url="/admin/crawler/delete"><a href="#" onClick="del(\'delete?id=' + row.id +'\',function(rel){reloadGrid(\'#grid\')})">删除</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
					return txt;
				}
			} ] ]
		};
		createGrid('#grid',options);
		createWin('#win',{width:700});
	});
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		${lott.title } <sjc:auth url="/admin/crawler/add"><a href="#" plain="true" class="easyui-linkbutton" icon="icon-add" onClick="showWin('#win','add',{status:0,lotteryId:'${lott.id}'})">添加</a></sjc:auth>
	</div>
	<div id="win">
		<form method="post" style="margin: 20px;">
			<input name="id" type="hidden" />
			<input name="lotteryId" type="hidden" />
			<table class="formtable">
				<tr>
					<td class="input-title">网址/算法</td>
					<td><input type="text" name="url" size="60" /></td>
				</tr>
				<tr>
					<td class="input-title">网址规则</td>
					<td><select name="urlBuilder">
							<option value="">无规则</option>
							<c:forEach items="${urlBuilders }" var="url">
							<option value="${url.title }">${url.remark }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td class="input-title">正则表达式</td>
					<td><input type="text" name="regex" size="60" /></td>
				</tr>
				<tr>
					<td class="input-title">权重</td>
					<td><input type="text" name="weight" /></td>
				</tr>
				<tr>
					<td class="input-title">类型</td>
					<td><select name="craType">
						<option value="0">爬虫</option>
						<option value="1">人工录号</option>
						<option value="2">随机生成</option>
					</select>
					</td>
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