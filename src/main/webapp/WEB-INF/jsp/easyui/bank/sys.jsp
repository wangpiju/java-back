<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
var bankName=${bankNameJson};
var bankLevel=${bankLevelJson};
	$(function() {
		var options = {
			columns : [ [ {
				field : 'nameId',
				title : '银行名称',
				formatter:function(value,row){
					for(var i=0;i<bankName.length;i++){
						var bn = bankName[i];
						if(bn.id == value){
							return bn.title+' ['+bn.code+']';
						}
					}
					return '<span style="color:red">未知银行 - '+ value +'</span>';
				}
			}, {
				field : 'card',
				title : '卡号'
			}, {
				field : 'niceName',
				title : '开户姓名'
			}, {
				field : 'address',
				title : '支行地址'
			}, {
				field : 'levelId',
				title : '等级',
				formatter:function(value,row){
					for(var i=0;i<bankLevel.length;i++){
						var bl = bankLevel[i];
						if(bl.id == value){
							return bl.title+' ['+bl.minAmount+']';
						}
					}
					return '<span style="color:red">未知等级 - '+ value +'</span>';
				}
			}, {
				field : 'rechargeAmount',
				title : '累计额度'
			}, {
				field : 'rechargeNum',
				title : '充值次数'
			}, {
				field : 'crossStatus',
				title : '收款方式',
				formatter:function(value,row){
					if(value == 0)
						return '同行';
					else
						return '<span style="color:red">跨行</span>';
				}
			}, {
				field : 'status',
				title : '状态',
				formatter:function(value,row){
					if(value == 0)
						return '正常';
					else
						return '禁用';
				}
			}, {
				field : 'createTime',
				title : '创建时间'
			}, {
				field : 'remark',
				title : '备注'
			},{
				field : 'other',
				title : '操作',
				formatter : function(value, row) {
					var win ="'#win'";
					var url = "'edit'";
					var dat = "'edit?id=" + row.id +"'";
					var txt = '<sjc:auth url="/admin/bankSys/edit"><a href="#" onClick="showWin('+ win +',' +url+ ','+ dat +')">编辑</a></sjc:auth>&nbsp;&nbsp;';
					txt += '<sjc:auth url="/admin/bankSys/delete"><a href="#" onClick="del(\'delete?id=' + row.id +'\',function(rel){reloadGrid(\'#grid\')})">删除</a></sjc:auth>&nbsp;';
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
	<div id="tb">
		<div>
			<sjc:auth url="/admin/bankSys/add"><a href="#" plain="true" icon="icon-add" class="easyui-linkbutton" onClick="showWin('#win','add')">添加</a></sjc:auth>
			<sjc:auth url="/admin/bankSys/delete"><a href="#" plain="true" icon="icon-remove" class="easyui-linkbutton" onClick="delAll('delete','#grid')">删除</a></sjc:auth>
		</div>
	</div>
	<div id="win">
		<form method="post" style="margin: 20px;">
			<input type="hidden" name="id" />
			<table class="formtable">
				<tr>
					<td class="input-title">银行名称</td>
					<td><select name="nameId">
						<c:forEach items="${bankName }" var="a">
						<option value="${a.id }">${a.title }</option>
						</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td class="input-title">银行卡号</td>
					<td><input type="text" name="card" /></td>
				</tr>
				<tr>
					<td class="input-title">开户姓名</td>
					<td><input type="text" name="niceName" /></td>
				</tr>
				<tr>
					<td class="input-title">支行地址</td>
					<td><input type="text" name="address" /></td>
				</tr>
				<tr>
					<td class="input-title">卡等级</td>
					<td><select name="levelId">
						<c:forEach items="${bankLevel }" var="a">
						<option value="${a.id }">${a.title } - ${a.minAmount }</option>
						</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td class="input-title">收款方式</td>
					<td><select name="crossStatus">
						<option value="0">同行</option>
						<option value="1">跨行</option>
					</select></td>
				</tr>
				<tr>
					<td class="input-title">状态</td>
					<td><select name="status">
						<option value="0">正常</option>
						<option value="1">禁用</option>
					</select></td>
				</tr>
				<tr>
					<td class="input-title">备注</td>
					<td><input type="text" name="remark" /></td>
				</tr>
				<tr>
					<td class="input-title">秘钥</td>
					<td><input type="text" name="sign" /></td>
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