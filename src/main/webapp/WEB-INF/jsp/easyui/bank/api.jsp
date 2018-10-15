<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
var bankLevel=${bankLevelJson};
var bankKey=${bankKeyJson};
	$(function() {
		var options = {
			columns : [ [ {
				field : 'title',
				title : '名称'
			}, {
				field : 'orderId',
				title : '排序（数值越大越靠前）'
			}, {
				field : 'classKey',
				title : '接口类型',
				formatter:function(value,row){
					var n = bankKey[value];
					if(n){
						return n;
					} else {
						return '<span style="color:red">未知类型 - '+ value +'</span>';
					}
				}
			}, {
				field : 'poundage',
				title : '手续费率',
				formatter:function(value,row){
					if(value) {
						return value+"%";
					}
				}
			}, {
				field : 'email',
				title : '邮箱'
			}, {
				field : 'levelId',
				title : '等级',
				formatter:function(value,row){
					var levelIds = value.split(',');
					var s = '';
					for (var j = 0;j < levelIds.length;j++) {
						for(var i=0;i<bankLevel.length;i++){
							var bl = bankLevel[i];
							if(bl.id == levelIds[j]){
								s += ',' + bl.title+' ['+bl.minAmount+']';
							}
						}
					}
					return s.substring(1);
				}
			}, {
				field : 'rechargeAmount',
				title : '累计额度'
			}, {
				field : 'rechargeNum',
				title : '充值次数'
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
				field : 'minAmount',
				title : '最低充值金额'
			}, {
				field : 'maxAmount',
				title : '最高充值金额'
			}, {
				field : 'shopUrl',
				title : '商城地址'
			}, {
				field : 'isCredit',
				title : '是否直连',
				formatter:function(value,row){
					if(value == 1)
						return '是';
					else
						return '否';
				}
			}, {
				field : 'isSupportMobile',
				title : '显示方式',
				formatter:function(value,row){
					if(value == 1)
						return '全部显示';
					else if (value == 0) {
						return "仅网页";
					} else if (value == 2) {
						return "仅手机";
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
					var txt = '<sjc:auth url="/admin/bankApi/edit"><a href="#" onClick="showWin('+ win +',' +url+ ','+ dat +',function(d){showLevelId(d);})">编辑</a></sjc:auth>&nbsp;&nbsp;';
					txt += '<sjc:auth url="/admin/bankApi/delete"><a href="#" onClick="del(\'delete?id=' + row.id +'\',function(rel){reloadGrid(\'#grid\')})">删除</a></sjc:auth>&nbsp;';
					return txt;
				}
			}] ]
		};
		createGrid('#grid',options);
		createWin('#win');
		createWin('#win2', {title : "银行转账设置"});
		
		$("#form").form();
		
		$("#search").click(function(){
			var p = getFormData('form');
			p['classKeyArray'] = $('#classKeyArray').combobox('getValues').join(",");
			$("#grid").datagrid("options").queryParams = p;
			reloadGrid("#grid");
		});
	});
	
function showLevelId(d) {
	$('#levelId').combobox('setValues',d.levelId.split(','));
}

function selectIcoCode() {
	var icoCode = $('#icoCode').val();
	if (icoCode) {
		$("#image1")[0].src = "<c:url value='/res/admin/images/ico/'/>" + icoCode;
	} else {
		$("#image1")[0].src = "";
	}
}

var sysConfigBankArticle = "${sysConfigBankArticle}";
var sysConfigBankRemark = "${sysConfigBankRemark}";
function showWinBank() {
	if (!sysConfigBankArticle || !sysConfigBankRemark) {
		$.messager.alert('错误', '请先添加相关的系统参数后再设置', 'error');
		return;
	}
	$("#win2").window('open');
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
			       	  <td>状态：</td>
						<td><select name="status">
								<option value="">不限</option>
								<option value="0">正常</option>
								<option value="1">禁用</option>
						</select></td>
						<td>接口类型：</td>
			          	<td>
			          	<select id="classKeyArray" multiple="multiple" class="easyui-combobox">
			          		<c:forEach items="${bankKey }" var="bankKey">
							<option value="${bankKey.key }">${bankKey.value }</option>
							</c:forEach>
				        </select>
			          </td>
			          <td><a href="#" plain="true" id="search" class="easyui-linkbutton" icon="icon-search">查询</a></td>
			       </tr>
			   </table>
			</form>
		</div>
		<div>
			<sjc:auth url="/admin/bankApi/add"><a href="#" plain="true" icon="icon-add" class="easyui-linkbutton" onClick="showWin('#win','add')">添加</a></sjc:auth>
			<sjc:auth url="/admin/bankApi/delete"><a href="#" plain="true" icon="icon-remove" class="easyui-linkbutton" onClick="delAll('delete','#grid')">删除</a></sjc:auth>
			<sjc:auth url="/admin/bankApi/editBank"><a href="#" plain="true" icon="icon-add" class="easyui-linkbutton" onClick="showWinBank()">银行转账设置</a></sjc:auth>
		</div>
	</div>
	<div id="win">
		<form method="post" style="margin: 20px;" enctype="multipart/form-data">
			<input type="hidden" name="id" />
			<table class="formtable">
				<tr>
					<td class="input-title">名称</td>
					<td><input type="text" name="title" /></td>
				</tr>
				<tr>
					<td class="input-title">排序（数值越大越靠前）</td>
					<td><input type="text" name="orderId" /></td>
				</tr>
				<tr>
					<td class="input-title">手续费率</td>
					<td><input type="text" name="poundage" />%</td>
				</tr>
				<tr>
					<td class="input-title">邮箱</td>
					<td><input type="text" name="email" /></td>
				</tr>
				<tr>
					<td class="input-title">商户号</td>
					<td><input type="text" name="merchantCode" /></td>
				</tr>
				<tr>
					<td class="input-title">密钥</td>
					<td><input type="text" name="sign" /></td>
				</tr>
				<tr>
					<td class="input-title">公钥</td>
					<td><input type="text" name="publicKey" /></td>
				</tr>
				<tr>
					<td class="input-title">等级</td>
					<td><select name="levelId" multiple="multiple" class="easyui-combobox" id="levelId">
						<c:forEach items="${bankLevel }" var="a">
						<option value="${a.id }">${a.title }-${a.minAmount }元-${a.minCount }次</option>
						</c:forEach>
					</select>
					</td>
				</tr>
				<tr>
					<td class="input-title">特定会员</td>
					<td><textarea rows="5" cols="23" name="specialAccount" ></textarea></td>
				</tr>
				<tr>
					<td class="input-title">代理线路</td>
					<td><textarea rows="5" cols="23" name="proxyLine" ></textarea></td>
				</tr>
				<tr>
					<td class="input-title">接口类型</td>
					<td><select name="classKey">
						<c:forEach items="${bankKey }" var="a">
						<option value="${a.key }">${a.value }</option>
						</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td class="input-title">最低充值金额</td>
					<td><input type="text" name="minAmount" /></td>
				</tr>
				<tr>
					<td class="input-title">最高充值金额</td>
					<td><input type="text" name="maxAmount" /></td>
				</tr>
				<tr>
					<td class="input-title">二维码</td>
					<td><input type="file" name="file" /></td>
				</tr>
				<tr>
					<td class="input-title">图标</td>
					<td>
						<select id="icoCode" name="icoCode" onchange="selectIcoCode();">
							<option value="">无图标</option>
							<option value="1.png">快捷支付图标</option>
							<option value="2.png">支付宝图标</option>
							<option value="3.png">微信图标</option>
						</select>
						<img id="image1" src="">
					</td>
				</tr>
				<tr>
					<td class="input-title">商城地址</td>
					<td><input type="text" name="shopUrl" /></td>
				</tr>
				<tr>
					<td class="input-title">是否直连</td>
					<td>
						<select name="isCredit">
							<option value="1">是</option>
							<option value="0">否</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="input-title">显示方式</td>
					<td>
						<select name="isSupportMobile">
							<option value="1">全部显示</option>
							<option value="0">仅网页</option>
							<option value="2">仅手机</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="input-title">帮助文章</td>
					<td>
						<select name="articleId">
							<c:forEach items="${articleList }" var="article">
								<option value="${article.id }">${article.title }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td class="input-title">备注</td>
					<td><input type="text" name="remark" /></td>
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
				<a href="#" class="btn-save" icon="icon-save" onClick="saveData(this, function(rel){ closeWin('#win','#grid')})">保存</a>
				<a href="#" class="btn-cancel" icon="icon-cancel" onClick="closeWin('#win')">取消</a>
			</div>
		</form>
	</div>
	
	<div id="win2">
		<form action="editBank" method="post" style="margin: 20px;">
			<table class="formtable">
				<tr>
					<td class="input-title">帮助文章</td>
					<td>
						<select name="bankArticleId">
							<c:forEach items="${articleList }" var="article">
								<option value="${article.id }" ${sysConfigBankArticle.val == article.id ? 'selected' : '' }>${article.title }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td class="input-title">备注</td>
					<td><input type="text" name="bankRemark" value="${sysConfigBankRemark.val }" /></td>
				</tr>
			</table>
			<div style="text-align: center; padding: 5px;">
				<a href="#" class="btn-save" icon="icon-save" onClick="saveData(this, function(rel){ closeWin('#win2','#grid')})">保存</a>
				<a href="#" class="btn-cancel" icon="icon-cancel" onClick="closeWin('#win2')">取消</a>
			</div>
		</form>
	</div>
</body>
</html>