<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
var names = ${json};
	$(function() {
		var options = {
			singleSelect:true,
			columns : [ [ {
				field : 'account',
				title : '用户'
			},{
				field : 'activityId',
				title : '所属活动',
				formatter:function(value,row){
					for(var n in names){
						var m = names[n];
						if(m.id == value){
							return m.title;
						}
					}
					return value;
				}
			},{
				field : 'createTime',
				title : '参加时间'
			},{
				field : 'validTime',
				title : '起效时间'
			},{
				field : 'operator',
				title : '操作员'
			},{
				field : 'status',
				title : '状态',
				formatter:function(value,row){
					if(0 == value)
						//0进行中  1申请中  2正在处理 3已领取
						return '进行中';
					else if(1 == value)
						return '申请中';
					else if(2 == value)
						return '处理中';
					else if(3 == value)
						return '已领取';
					else if(4 == value)
						return '已拒绝';
					else
						return value;
				}
			},{
				field : 'other',
				title : '操作',
				formatter : function(value, row) {
					var txt ='&nbsp;&nbsp;';
					var status = row.status;
					if(status == 1){
						txt +='<a href="#" onClick="setStatus(\''+ row.id +'\')">处理</a>&nbsp;&nbsp;';
					} else if(status ==2){
						txt +='<a href="#" onClick="setSuccess(\''+ row.id +'\')">同意申请</a>&nbsp;&nbsp;';
						txt +='<a href="#" onClick="setFail(\''+ row.id +'\')">拒绝申请</a>&nbsp;&nbsp;';
					}
					return txt;
				}
			}] ]
		};
		createGrid('#grid',options);
	});
	function setStatus(id){
		ajaxData('status?id='+id,function(rel){
			reloadGrid("#grid");
		});
	}
	function setSuccess(id){
		ajaxData('success?id='+id,function(rel){
			reloadGrid("#grid");
		});
	}
	function setFail(id){
		ajaxData('fail?id='+id,function(rel){
			reloadGrid("#grid");
		});
	}
	
	function finds(){
		var p = {
			activityId:$("#activityId").val(),
			status:$("#status").val()	
		}
		reloadGrid("#grid",p);
	}
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<div>
			活动<select id="activityId">
				<option value="">不限</option>
				<c:forEach items="${list }" var="a">
				<option value="${a.id }" <c:if test="${a.id==activityId }"> selected</c:if>>${a.title }</option>
				</c:forEach>
			</select>
			活动状态<select id="status">
				<option value="">不限</option>
				<option value="0">进行中</option>
				<option value="1">申请中</option>
				<option value="2">已领取</option>
				<option value="3">已过期</option>
			</select>
			<a href="#" plain="true" icon="icon-search" class="easyui-linkbutton" onClick="finds()">查询</a>
		</div>
	</div>
</body>
</html>