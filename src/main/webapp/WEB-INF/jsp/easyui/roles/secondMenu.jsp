<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	$(function() {
		var options = {
			columns : [ [ {
				field : 'firstName',
				title : '一级菜单'
			},{
				field : 'firstMenuId',
				title : '一级菜单Id',
				hidden:true
			},{
				field : 'secondName',
				title : '二级菜单'
			},{
				field : 'other',
				title : '操作',
				formatter : function(value, row) {
					var win ="'#win'";
					var url = "'edit'";
					var dat = "'edit?id=" + row.id +"'";
					var txt = '<sjc:auth url="/admin/secondMenu/edit"><a href="#" onClick="showWinEx('+ win +',' +url+ ','+ dat +')">编辑</a></sjc:auth>&nbsp;&nbsp;';
					txt += '<sjc:auth url="/admin/secondMenu/delete"><a href="#" onClick="del(\'delete?id=' + row.id +'\',function(rel){reloadGrid(\'#grid\')})">删除</a></sjc:auth>&nbsp;';
					return txt;
				}
			}] ]
		};
		createGrid('#grid',options);
		createWin('#win',{width:400});
	});
	function showWinEx(win, url,loadData) {
		$(win).window('open');
		$(win).find("form").form('clear');
		$(win).find("form").form('load',loadData);
		$(win).find("form").attr("url", url);
	}
	//-----------------------$('#cc').combobox('setValue', '001');
	jQuery(function(){ 
  // 一级菜单 
  var rootUrl=$('#firstMenu').attr('url');
   $('#firstMenu').combobox({
        valueField:'id', //值字段
        textField:'firstName', //显示的字段
        url:rootUrl+'/listByFirstMenu',
        panelHeight:'auto',
        editable:true,//不可编辑，只能选择
        value:'--请选择--',
        onChange:function(firstMenuId){
            if (firstMenuId==null)
           	return null;
           	$('#firstMenuId').val(firstMenuId);
           }
     });
  });
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<div>
			<sjc:auth url="/admin/secondMenu/add"><a href="#" plain="true" icon="icon-add" class="easyui-linkbutton" onClick="showWin('#win','add')">添加</a></sjc:auth>
			<sjc:auth url="/admin/secondMenu/delete"><a href="#" plain="true" icon="icon-remove" class="easyui-linkbutton" onClick="delAll('delete','#grid')">删除</a></sjc:auth>
		</div>
	</div>
	<div id="win">
		<form method="post" style="margin: 20px;">
			<input type="hidden" name="id" />
			<input type="hidden" id="firstMenuId" name="firstMenuId" />
			<table class="formtable">
				<tr>
					<td class="input-title">一级菜单</td>
					 <td>
                    <input type="text" id="firstMenu" name="firstName" url="<c:url value='/admin/firstMenu'/>" style="width: 128px"
                      class="easyui-validatebox" validType="selectValid['--请选择--']" />
            </td>
				</tr>
				<tr>
					<td class="input-title">二级菜单</td>
					 <td>
                    <input type="text" id="secondMenu" name="secondName" style="width: 128px"
                      class="easyui-validatebox" />
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