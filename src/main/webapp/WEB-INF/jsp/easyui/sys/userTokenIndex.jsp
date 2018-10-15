<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	var grid;
	$(function() {

		var options = {
			url : 'list',
			singleSelect : true,
			rownumbers : false,
 			pagination : false,
// 			pageList:[100],
// 			pageSize : 100,
			queryParams : {
				account : '${account}'
			},
			columns : [ [
					{
						field : 'k',
						title : ' '
					},
					{
						field : '0',
						title : '0',

					},
					{
						field : '1',
						title : '1',

					},
					{
						field : '2',
						title : '2',

					},
					{
						field : '3',
						title : '3',

					},
					{
						field : '4',
						title : '4',

					},
					{
						field : '5',
						title : '5',

					},
					{
						field : '6',
						title : '6',

					},
					{
						field : '7',
						title : '7',

					},
					{
						field : '8',
						title : '8',

					},
					{
						field : '9',
						title : '9',

					} ] ]
		};
		grid = createGrid('#grid', options);
    	$("#resetData").click(function() {
    		 var url ='<c:url value="/admin/userToken/ajaxDeleteAndCreate?account="/>'+$("#account").val();
		      ajaxData(url,function(rel){
		    	  var p = {};
					$.each($("#form").serializeArray(), function() {
						p[this.name] = this.value;
					});
					reloadGrid("#grid", p);
		  	   });
		});
	
	});


</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
	<form id="form" action="list" method="post">	
	    <table>
	       <tr>
	          <td>当前用户：</td>
	          <td><input  type="text" name="account" id="account" value="${account}" readonly/></td>
	          <td><a href="#" plain="true" id="resetData" class="easyui-linkbutton" >重置</a></td>
	       </tr>
	    </table>
	</form>
	</div>
</body>
</html>