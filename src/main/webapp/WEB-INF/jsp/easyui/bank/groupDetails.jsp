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
			queryParams:{groupId:'${id}'},
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
				title : '同行转账',
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
					var txt = '<sjc:auth url="/admin/bankGroupDetails/delete"><a href="#" onClick="del(\'delete?groupId=${id}&id=' + row.id +'\',function(rel){reloadGrid(\'#grid\')})">删除</a></sjc:auth>&nbsp;';
					return txt;
				}
			}] ]
		};
		createGrid('#grid',options);
		createWin('#win',{width:650,height:400,onOpen:function(){
			reloadGrid('#detailsGrid');
		}});
		
		var options2 = {
				singleSelect: false,
				queryParams:{groupId:'${id}'},
				url:'listNot',
				toolbar:'#detailsTb',
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
					title : '同行转账',
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
				}] ]
			};
			createGrid('#detailsGrid',options2);
	});
function addDetails(a){
	if ($(a).linkbutton('options').disabled == true) return;
	$(a).linkbutton("disable");
	var ids = getSelectedArr("#detailsGrid","id");
	if(ids.length == 0) {
		return;
	}
	var url = 'add?groupId=${id}&id='+ids.join(",");
	ajaxData(url,function(rel){
		closeWin("#win","#grid");
		$(a).linkbutton("enable");
	});
}
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<div>卡库名称：${details.title }
			<sjc:auth url="/admin/bankGroupDetails/add"><a href="#" plain="true" icon="icon-add" class="easyui-linkbutton" onClick="showWin('#win');">添加</a></sjc:auth>
			<sjc:auth url="/admin/bankGroupDetails/delete"><a href="#" plain="true" icon="icon-remove" class="easyui-linkbutton" onClick="delAll('delete?groupId=${id}','#grid')">删除</a></sjc:auth>
		</div>
	</div>
	<div id="win">
		<div id="detailsGrid"></div>
		<div id="detailsTb">
			<div><a href="#" plain="true" icon="icon-add" class="easyui-linkbutton" onClick="addDetails(this)">确定</a></div>
		</div>
	</div>
</body>
</html>