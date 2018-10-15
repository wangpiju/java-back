<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
var bonusGroup=${json};
	$(function() {
		var options = {
			singleSelect:true,
			url:'',
			columns : [ [{
				field : 'userMark',
				title : '用户标识',
				formatter:function(value,row){
					if(row.account){
						if(!value || value == 0)
							return '正常';
						else if(value == 1)
							return '<span style="color:red;">嫌疑</span>';
						else if(value == 2)
							return '<span style="color:green;">VIP</span>';
						else if(value == 3)
							return '<span style="color:green;">黑名单</span>';
						else if(value == 4)
							return '<span style="color:green;">招商经理</span>';
						else if(value == 5)
							return '<span style="color:green;">特权代理</span>';
						else if(value == 6)
							return '<span style="color:green;">金牌代理</span>';
						else if(value == 7)
							return '<span style="color:green;">外部主管</span>';
						else
							return value;
					} else {
						return '';
					}
				}
			}, {
				field : 'account',
				title : '用户'
			}, {
				field : 'parnetAccount',
				title : '所属上级',
			}, {
				field : 'code',
				title : 'URL代码'
			}, {
				field : 'bonusGroupId',
				title : '奖金组',
				formatter:function(value,row){
					for(var i=0;i<bonusGroup.length;i++){
						var bg = bonusGroup[i];
						if(bg.id == value){
							return bg.title;
						}
					}
					return value+' - 未知奖金组';
				}
			}, {
				field : 'rebateRatio',
				title : '返点',
				formatter : function(value, row) {
					return value+"%";
				}
			}, {
				field : 'createTime',
				title : '创建时间',
				formatter : function(value, row) {
					return new Date(value).format("yyyy-MM-dd hh:mm:ss");
				}
			}, {
				field : 'lastRegist',
				title : '最后时间',
				formatter : function(value, row) {
					return new Date(value).format("yyyy-MM-dd hh:mm:ss");
				}
			}, {
				field : 'validTime',
				title : '有效时间',
				formatter:function(value,row){
					if(value==0)
						return '永久';
					else
						return value+'天';
				}
			}, {
				field : 'registNum',
				title : '注册人数'
			}, {
				field : 'rechargeNum',
				title : '充值人数'
			}, {
				field : 'extAddress',
				title : '地址'
			},/*  {
				field : 'qq',
				title : 'QQ'
			},  */{
				field : 'status',
				title : '状态',
				formatter : function(value, row) {
					if (value=="0")
						return "正常";
					else
						return '<span style="color:red;">禁用</span>';
				}
			}, {
				field : 'other',
				title : '操作',
				formatter : function(value, row) {
					var txt ='';
					if(row.status==0){
						txt += '<sjc:auth url="/admin/extCode/status"><a href="#" onClick="setStatus(1,'+row.id+')">禁用</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
					} else {
						txt += '<sjc:auth url="/admin/extCode/status"><a href="#" onClick="setStatus(0,'+row.id+')">启用</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
					}
					txt +='<sjc:auth url="/admin/extCode/extCodeAnalyzeIndex?code="><a onClick="opens(this,\'链接\')"  href="#" data-href="<c:url value="/admin/extCode/extCodeAnalyzeIndex?code="/>'+ row.code +'">分析</a></sjc:auth>';
					return txt;
				}
			} ] ]
		};
		createGrid("#grid",options);
		$("#search").click(function(){
			$(grid).datagrid("options")['url'] = 'list';
			var p = {
					account : $('#account').val(),
					code : $('#code').val(),
					beginCreateTime : $('#beginCreateTime').datebox('getValue'),
					endCreateTime : $('#endCreateTime').datebox('getValue'),
					bonusGroupId : $('#bonusGroupId').val(),
					minRebateRatio : $('#minRebateRatio').val(),
					maxRebateRatio : $('#maxRebateRatio').val(),
					lastTime : $('#lastTime').val()
			};
			reloadGrid("#grid",p);
		});
	});
	function setStatus(status,id){
		var url = 'status?status='+ status+'&id='+id;
		ajaxData(url,function(rel){
			reloadGrid("#grid");
		});
	}
	function opens(a,title){
		addTab(title+' - '+$(a).text(),$(a).attr("data-href"));
	}
</script>
<style>
</style>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		用户名:<input id="account" type="text" size="6"/> 
		链接代码:<input id="code" type="text" size="8"/>
		开设时间:<input type="text" id="beginCreateTime" class="easyui-datebox"  size="8"/>至<input type="text" id="endCreateTime" size="8" class="easyui-datebox"/>
		奖金组:<select id="bonusGroupId">
				<option value="">不限</option>
				<c:forEach items="${bonusGroup }" var="a">
				<option value="${a.id }">${a.title }</option>
				</c:forEach></select>
		返点:<input type="text" id="minRebateRatio" size="6"/>~<input type="text" id="maxRebateRatio" size="6"/>
		未活跃时间:<select id="lastTime">
		<option value="">不限</option>
		<option value="3">3天</option>
		<option value="7">7天</option>
		<option value="30">30天</option>
		<option value="60">60天</option>
		</select>
		<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-search" id="search">查询</a>
	</div>
	
</body>
</html>