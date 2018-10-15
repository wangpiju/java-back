<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	$(function() {
		var options = {
			columns : [ [ 
			{
				field : 'requestUri',
				title : '请求路径'
			},{
				field : 'duringTime',
				title : '耗时'
			},{
				field : 'account',
				title : '用户'
			},{
				field : 'createTime',
				title : '创建时间'
			},{
				field : 'k1',
				title : '关键字1'
			},{
				field : 'k2',
				title : '关键字2'
			},{
				field : 'k3',
				title : '关键字3'
			},{
				field : 'k4',
				title : '关键字4'
			},{
				field : 'k5',
				title : '关键字5'
			},{
				field : 'kext',
				title : '关键字扩展'
			},{
				field : 'c1',
				title : '内容1'
			},{
				field : 'c2',
				title : '内容2'
			},{
				field : 'c3',
				title : '内容3'
			},{
				field : 'c4',
				title : '内容4'
			},{
				field : 'c5',
				title : '内容5'
			},{
				field : 'cext',
				title : '内容扩展'
			},{
				field : 'maxMemory',
				title : '最大内存'
			},{
				field : 'totalMemory',
				title : '已分配内存'
			},{
				field : 'freeMemory',
				title : '已分配内存中的剩余空间'
			},{
				field : 'remoteAddr',
				title : 'ip'
			},{
				field : 'userAgent',
				title : '用户头'
			},{
				field : 'method',
				title : '方法'
			},{
				field : 'params',
				title : '参数'
			},{
				field : 'exception',
				title : '异常'
			},{
				field : 'extends1',
				title : '扩展1'
			},{
				field : 'extends2',
				title : '扩展2'
			},{
				field : 'extends3',
				title : '扩展3'
			}] ],
			url : '',
			queryParams : getQueryParams()
		};
		createGrid('#grid',options);
		createWin('#win');
		
		$("#form").form();
		
		$("#search").click(function(){
			$(grid).datagrid("options")['url'] = 'listByCond';
			$("#grid").datagrid("options").queryParams = getQueryParams();
			reloadGrid("#grid");
		});
	});
	
	function getQueryParams() {
		var p={};
		$.each($("#form").serializeArray(),function(){  
            p[this.name]=this.value;  
        });
		
		return p;
	}
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<div>
			<form id="form" action="listByCond" method="post">
				<table>
			       <tr>
			       	  <td>耗时>=：</td>
				      <td><input type="text" size="10" name="duringTime"/></td>
			          <td>用户：</td>
			          <td><input type="text" size="10" name="account" /></td>
			          <td>时间：</td>
				      <td><input type="text" class="easyui-datetimebox beginTime" size="20" name="startTime"/>~<input type="text" class="easyui-datetimebox endTime" size="20" name="finishTime"/></td>
			          <td>请求路径：</td>
			          <td><input type="text" size="10" name="requestUri" /></td>
			          <td>关键字1：</td>
			          <td><input type="text" size="10" name="k1" /></td>
			          <td>关键字2：</td>
			          <td><input type="text" size="10" name="k2" /></td>
			          <td>关键字3：</td>
			          <td><input type="text" size="10" name="k3" /></td>
			          <td>关键字4：</td>
			          <td><input type="text" size="10" name="k4" /></td>
			          <td>关键字5：</td>
			          <td><input type="text" size="10" name="k5" /></td>
			          <td> <a href="#" plain="true" id="search" class="easyui-linkbutton" icon="icon-search">查询</a></td>
			       </tr>
			   </table>
			</form>
		</div>
	</div>
</body>
</html>