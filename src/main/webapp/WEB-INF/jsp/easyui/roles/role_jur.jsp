<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript"
	src="<c:url value='/res/admin/js/roles/role.js'/>"></script>
<script type="text/javascript">
var roles = ${json};
$(function() {
	var options = {
		queryParams:{roleId:'${role.id}'},
		columns : [ [ {
			field : 'firstName',
			title : '一级菜单'
		},{
			field : 'secondName',
			title : '二级菜单'
		},{
			field : 'remark',
			title : '描述',
				formatter: function (value,row) {
					var ckbadmin='';
					if (row.path=='/admin')
						ckbadmin='id=\"chbadmin\" onclick=\"selectAll()\"';
						if (row.role_jur_id!=null)
                    		return "<input type=\"checkbox\" "+ckbadmin+"  class=\"pl\" checked=\"checked\"  value=\"" + row.id + "\" >"+value;
                    	else
                    		return "<input type=\"checkbox\"  "+ckbadmin+"  class=\"pl\"  value=\"" + row.id + "\" >"+value;
               
				}
	},{
		field : 'path',
		title : '访问路径'
		}] ]
	};
	createGridEx('#grid',options);
});
function selectAll(){
	if ($('#chbadmin').is(':checked')){
		$('.pl').each(function(){
			$(this).prop("checked",true) 
		});
	}
	else{
		$('.pl').each(function(){
			$(this).prop("checked",false) 
		});
	}
	
}
function sleep(n) { //n表示的毫秒数
    var start = new Date().getTime();
    while (true) if (new Date().getTime() - start > n) break;
}  
function saveAll(url,grid){
	var ids=[];
	$('.pl:checked').each(function(){
		ids.push(this.value);
	});
	var a = ids.join();
	
	if (ids.length > 0) {
		var u = url;
		if(url.indexOf('?')>0){
			u+= '&id=' + a;
		} else{
			u += '?id=' + a;
		}
		ajaxData(u, function(func){});
		sleep(1000);
		reloadGrid(grid);
	} else {
		$.messager.alert('警告', '请先选择权限。', 'warning');
	}
}
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		当前角色：${role.name }
			<a href="#" plain="true" icon="icon-save" class="easyui-linkbutton" onClick="saveAll('save?roleId=${role.id}','#grid')">保存所选</a>
	</div>
</body>
</html>