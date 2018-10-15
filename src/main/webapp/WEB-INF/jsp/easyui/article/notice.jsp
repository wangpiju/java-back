<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	$(function() {
		var options = {
			columns : [ [ {
				field : 'title',
				title : '标题'
			},{
				field : 'createTime',
				title : '创建时间'
			},{
				field : 'status',
				title : '状态',
				formatter : function(value, row) {
					if (value==0) {
						return '正常';
					} else {
						return '禁用';
					}
				}
			},{
				field : 'orderId',
				title : '排序'
			},{
				field : 'author',
				title : '作者'
			},{
				field : 'switching',
				title : '弹框',
				formatter : function(value, row) {
					if (value==1) {
						var txt = '<span>启动</span>&nbsp;&nbsp;&nbsp'+'<sjc:auth url="/admin/article/notice/updateOpenOrClose"><a href="#" onClick="showDialogs('+ row.id+',1,0)">关闭</a></sjc:auth>';
						return txt;
					} else {
						var txt = '<sjc:auth url="/admin/article/notice/updateOpenOrClose"><a href="#" onClick="showDialogs('+ row.id+',0,1)">启动</a></sjc:auth>&nbsp;&nbsp;&nbsp;'+'<span>关闭</span>';
						return txt;
					}
				}
			},{
				field : 'other',
				title : '操作',
				formatter : function(value, row) {
					var win ="'#win'";
					var url = "'edit'";
					var dat = "'edit?id=" + row.id +"'";
					var txt = '<sjc:auth url="/admin/article/notice/edit"><a href="#" onClick="showWin('+ win +',' +url+ ','+ dat +')">编辑</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
					txt += '<sjc:auth url="/admin/article/notice/delete"><a href="#" onClick="del(\'delete?id=' + row.id +'\',function(rel){reloadGrid(\'#grid\')})">删除</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
					return txt;
				}
			}] ]
		};
		createGrid('#grid',options);
		createWin('#win', {
			width : '800px;',
			height : '600px;',
			onOpen : function() {
			KindEditor.create('#editor', {
				uploadJson : '<c:url value="/admin/file/update"/>',
				afterChange : function() {
					this.sync();
				},
				afterBlur : function() {
					this.sync();
				}
			});
			KindEditor.html('#editor', '');
			},
			onBeforeClose : function(event, ui) {
				KindEditor.remove('#editor');
			}
		});
		
		var formOptions = {
			onLoadSuccess : function(data) {
				KindEditor.html('#editor', data ? data.content : '');
			}
		};
		$("#form").form(formOptions);
		
		$("#search").click(function(){
			var p={};
			$.each($("#searchForm").serializeArray(),function(){  
	            p[this.name]=this.value;  
	        });
			$("#grid").datagrid("options").queryParams = p;
			reloadGrid("#grid");
		});
	});
	function showDialogs(id,oldValue,newValue){
		if(newValue==1){
	      //打开弹框
	      var url ='<c:url value="/admin/article/notice/ajaxGetSwitch?switching="/>'+newValue;
	      ajaxData(url,function(rel){
	    	  updateOpenOrClose(id,newValue);
	  	   });
		}else{
		  //关闭弹框
			updateOpenOrClose(id,newValue);
		}
	}
	function updateOpenOrClose(id,newValue){
		 var url ='<c:url value="/admin/article/notice/updateOpenOrClose?id="/>'+id+"&switching="+newValue;
	      ajaxData(url,function(rel){
	    	  if(newValue==0){
					$.messager.alert('提示', '关闭成功！', 'error');
					reloadGrid("#grid");
				}else{
					$.messager.alert('提示', '启动成功！', 'error');
					reloadGrid("#grid");
				}
	  	   });
	}
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<div>
			<form id="searchForm" action="list" method="post">
				<table>
			       <tr>
			          <td>标题：</td>
			          <td><input type="text" size="10" name="title" /></td>
			          <td> <a href="#" plain="true" id="search" class="easyui-linkbutton" icon="icon-search">查询</a></td>
			          <td> <sjc:auth url="/admin/article/notice/add"><a href="#" plain="true" icon="icon-add" class="easyui-linkbutton" onClick="showWin('#win','add')">添加</a></sjc:auth></td>
			          <td> <sjc:auth url="/admin/article/notice/delete"><a href="#" plain="true" icon="icon-remove" class="easyui-linkbutton" onClick="delAll('delete','#grid')">删除</a></sjc:auth></td>
			       </tr>
			   </table>
			</form>
		</div>
	</div>
	<div id="win">
		<form method="post" style="margin: 20px;" id="form">
			<input type="hidden" name="id" />
			<table class="formtable">
				<tr>
					<td class="input-title">标题</td>
					<td><input type="text" name="title" style="width:800px;"/></td>
				</tr>
				<tr>
					<td class="input-title">内容</td>
					<td><textarea cols="50" rows="10" name="content" id="editor" style="width: 800px; height: 400px; visibility: hidden;"></textarea></td>
				</tr>
				<tr>
					<td class="input-title">状态</td>
					<td>
						<select name="status">
							<option value="0" selected="selected">正常</option>
							<option value="1">禁用</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="input-title">排序</td>
					<td><input type="text" name="orderId" /></td>
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