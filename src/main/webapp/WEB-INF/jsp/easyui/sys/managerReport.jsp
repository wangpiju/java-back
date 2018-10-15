<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
function createData(){
	var type =$('#createDataType').val();
	var createDate =$('input[name="createDate"]').val();
	delTip('<c:url value="/admin/managerReport/createData?type="/>'+type+"&createDate="+createDate,function(rel){
		$.messager.alert('成功', rel.content, 'success');
	},"确定生成该日期的数据吗?"); 
}
</script>
</head>
<body>
	<div id="tb">
	    <label>生成当前日期的报表数据：</label>
		<form method="post" >
			<table >
				<tr>
					<td class="input-title">类型</td>
					<td><select name="type" id="createDataType">
							<option value="0">个人盈亏</option>
							<option value="1">团队盈亏</option>
							<option value="2">投注佣金</option>
							<option value="3">亏损佣金</option>
							<option value="4">运营统计</option>
							<option value="5">日工资</option>
							<option value="6">契约分红</option>
							<option value="7">私返数据</option>
							<option value="8">充值统计</option>
					</select></td>
				</tr>
				<tr>
					<td class="input-title">日期</td>
					<td><input type="text" class="easyui-datebox beginTime" size="20" name="createDate" id="createDate"/></td>
				</tr>
				<tr><td colspan="2"><a href="#" plain="true" id="create" class="easyui-linkbutton" icon="icon-add" onclick="createData()">生成</a></td></tr>
			</table>
		</form>
	</div>
</body>
</html>