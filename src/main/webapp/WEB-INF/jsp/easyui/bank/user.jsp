<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
var bankNames = ${json};
$(function() {
	var options = {
		queryParams:{account:'${account}'},
		columns : [ [ {
			field : 'account',
			title : '用户'
		}, {
			field : 'parentAccount',
			title : '上级用户'
		}, {
			field : 'bankNameId',
			title : '所属银行',
			formatter:function(value,row){
				for(var n in bankNames){
					var bank = bankNames[n];
					if(bank.id == value){
						return bank.title;
					}
				}
			}
		}, {
			field : 'niceName',
			title : '开户姓名'
		}, {
			field : 'card',
			title : '银行卡号'
		}, {
			field : 'address',
			title : '开户地址'
		}, {
			field : 'createTime',
			title : '绑定时间'
		}, {
			field : 'status',
			title : '状态',
			formatter:function(value,row){
				if(value==0)
					return '<span style="color:green;">正常</span>';
				else if(value == 1)
					return '<span style="color:red;">冻结</span>';
				else if(value == 2)
					return '<span style="color:red;">已解绑</span>';
				else
					return value;
			}
		},{
			field : 'other',
			title : '操作',
			formatter : function(value, row) {
				var txt = '&nbsp;&nbsp;&nbsp;&nbsp;';//'<a href="#" onClick="del(\'delete?id=' + row.id +'\',function(rel){reloadGrid(\'#grid\')})">删除</a>&nbsp;';
				if(row.status == 0){
					txt+='<sjc:auth url="/admin/bankUser/status"><a href="#" onClick="setStatus('+ row.id +',1)">冻结</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
					txt+='<sjc:auth url="/admin/bankUser/status"><a href="#" onClick="setStatus('+ row.id +',2)">解绑</a></sjc:auth>';
				} else if(row.status == 1){
					txt+='<sjc:auth url="/admin/bankUser/status"><a href="#" onClick="setStatus('+ row.id +',0)">解冻</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
				} else if(row.status == 2){
					txt+='<sjc:auth url="/admin/bankUser/status"><a href="#" onClick="setStatus('+ row.id +',0)">绑定</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
				}
				return txt;
			}
		}] ]
	};
	createGrid('#grid',options);
});
function setStatus(id,status){
	var url = 'status?id='+ id+'&status='+status;
	ajaxData(url,function(rel){
		reloadGrid("#grid");
	});
}
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<div>
			会员：${account } 
			<sjc:auth url="/admin/bankUser/delete"><a href="#" plain="true" icon="icon-remove" class="easyui-linkbutton" onClick="delAll('delete','#grid')">删除</a></sjc:auth>
		</div>
	</div>
</body>
</html>