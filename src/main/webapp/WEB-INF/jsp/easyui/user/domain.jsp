<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
$(function() {
	var options = {
		queryParams:{account:'${account}'},
		columns : [ [ {
			field : 'url',
			title : '域名'
		},{
			field : 'other',
			title : '操作',
			formatter : function(value, row) {
				var win ="'#win'";
				var url = "'edit'";
				var dat = "'edit?id=" + row.id +"'";
				var txt ='<a href="#" onClick="del(\'delete?id=' + row.id +'\',function(rel){reloadGrid(\'#grid\')})">删除</a>&nbsp;';
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
			queryParams:{account:'${account}'},
			url:'listNot',
			toolbar:'#detailsTb',
			columns : [ [ {
				field : 'url',
				title : '域名'
			}] ]
		};
		createGrid('#detailsGrid',options2);
});
function addUserDomain(a){
	if ($(a).linkbutton('options').disabled == true) return;
	$(a).linkbutton("disable");
	var ids = getSelectedArr("#detailsGrid","id");
	if(ids.length == 0) {
		return;
	}
	var url = 'add?account=${account}&id='+ids.join(",");
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
		<div>
			会员：${account }
			<a href="#" plain="true" icon="icon-add" class="easyui-linkbutton" onClick="showWin('#win','add')">添加</a>
			<a href="#" plain="true" icon="icon-remove" class="easyui-linkbutton" onClick="delAll('delete?account=${account}','#grid')">删除</a>
		</div>
	</div>
	<div id="win">
		<div id="detailsGrid"></div>
		<div id="detailsTb">
			<div><a href="#" plain="true" icon="icon-add" class="easyui-linkbutton" onClick="addUserDomain(this)">确定</a></div>
		</div>
	</div>
</body>
</html>