<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	$(function() {
		var options = {
				singleSelect:true,
			columns : [ [ {
				field : 'groupName',
				title : '彩票组'
			}, {
				field : 'id',
				title : '标示'
			}, {
				field : 'title',
				title : '彩票名称',
				formatter:function(value,row){
					var rel = value;
					if(row.isHot==1){
						rel +='<span style="color:red;">[热]</span>';
					}
					if(row.isNew==1){
						rel +='<span style="color:blue;">[新]</span>';
					}
					if(row.isSelf==1){
						rel +='<span style="color:green;">[自]</span>';
					}
					return rel;
				}
			}, {
				field : 'seasonRule',
				title : '期号规则'
			}, {
				field : 'maxPlan',
				title : '最大追号数'
			}, {
				field : 'weight',
				title : '权重值'
			}, {
				field : 'status',
				title : '销售状态',
				formatter : function(value, row) {
					if (value==0) {
						return '<span style="color:green;">销售中</span>';
					} else {
						return '<span style="color:red;">已停售</span>';
					}
				}
			}, {
				field : 'betInStatus',
				title : '彩中彩状态',
				formatter : function(value, row) {
					if (value==0) {
						return '<span style="color:green;">启用</span>';
					} else {
						return '<span style="color:red;">禁用</span>';
					}
				}
			}, {
				field : 'mobileStatus',
				title : '手机端',
				formatter : function(value, row) {
					if (value==0) {
						return '<span style="color:green;">显示</span>';
					} else {
						return '<span style="color:red;">不显示</span>';
					}
				}
			}, {
				field : 'reSettleTime',
				title : '重新派奖超时',
			}, {
				field : 'orderId',
				title : '排序',
			}, {
				field : 'other',
				title : '操作',
				formatter : function(value, row) {
					var txt ='<sjc:auth url="/admin/lotts/edit"><a onClick="showWin(\'#win\',\'edit\',\'edit?id='+ row.id+'\')"  href="#">编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;</sjc:auth>';
					txt +='<sjc:auth url="/admin/lotts/delete"><a onClick="delns(\''+row.id+'\')"  href="#">删除</a>&nbsp;&nbsp;&nbsp;&nbsp;</sjc:auth>';
					txt +='<sjc:auth url="/admin/player/index"><a onClick="opens(this,\''+ row.title +'\')" dataid="wfms'+row.id+'" href="#" data-href="<c:url value="/admin/player/index?lotteryId="/>'+ row.id +'">玩法描述</a>&nbsp;&nbsp;&nbsp;&nbsp;</sjc:auth>';
					txt +='<sjc:auth url="/admin/bonusGroupDetails/index"><a onClick="opens(this,\''+ row.title +'\')" dataid="jjz'+row.id+'" href="#" data-href="<c:url value="/admin/bonusGroupDetails/index?lotteryId="/>'+ row.id +'">奖金组</a>&nbsp;&nbsp;&nbsp;&nbsp;</sjc:auth>';
					txt +='<sjc:auth url="/admin/lotteryCloseRule/index"><a onClick="opens(this,\''+ row.title +'\')" dataid="xssj'+row.id+'" href="#" data-href="<c:url value="/admin/lotteryCloseRule/index?lotteryId="/>'+ row.id +'">休市时间</a>&nbsp;&nbsp;&nbsp;&nbsp;</sjc:auth>';
					txt +='<sjc:auth url="/admin/lotterySaleRule/index"><a onClick="opens(this,\''+ row.title +'\')" dataid="jqgz'+row.id+'" href="#" data-href="<c:url value="/admin/lotterySaleRule/index?lotteryId="/>'+ row.id +'">奖期规则</a>&nbsp;&nbsp;&nbsp;&nbsp;</sjc:auth>';
					txt +='<sjc:auth url="/admin/crawler/index"><a onClick="opens(this,\''+ row.title +'\')" dataid="hylb'+row.id+'" href="#" data-href="<c:url value="/admin/crawler/index?lotteryId="/>'+ row.id +'">号源列表</a>&nbsp;&nbsp;&nbsp;&nbsp;</sjc:auth>';
					txt +='<sjc:auth url="/admin/lotterySaleTime"><a onClick="opens(this,\''+ row.title +'\')" dataid="'+row.id+'" href="#" data-href="<c:url value="/admin/lotterySaleTime/index?lotteryId="/>'+ row.id +'">奖期列表</a>&nbsp;&nbsp;&nbsp;&nbsp;</sjc:auth>';
					txt +='<sjc:auth url="/admin/seasonForDate/index"><a onClick="opens(this,\''+ row.title +'\')" dataid="jzqh'+row.id+'" href="#" data-href="<c:url value="/admin/seasonForDate/index?lotteryId="/>'+ row.id +'">基准期号</a>&nbsp;&nbsp;&nbsp;&nbsp;</sjc:auth>';
					txt +='<sjc:auth url="/admin/lotts/open"><a onClick="opens(this,\''+ row.title +'\')" dataid="kjlb'+row.id+'" href="#" data-href="<c:url value="/admin/lotts/open?lotteryId="/>'+ row.id +'">开奖列表</a>&nbsp;&nbsp;&nbsp;&nbsp;</sjc:auth>';
					txt +='<sjc:auth url="/admin/lotts/createSeason"><a onClick="showWin(\'#createSeasonWin\',\'createSeason\',{lotteryId:\''+ row.id+'\'})"  href="#">期号生成</a>&nbsp;&nbsp;&nbsp;&nbsp;</sjc:auth>';
					txt +='<sjc:auth url="/admin/lotts/cancel"><a onClick="showWin(\'#cancelWin\',\'cancel\',{lotteryId:\''+ row.id+'\'})"  href="#">系统撤单</a>&nbsp;&nbsp;&nbsp;&nbsp;</sjc:auth>';
					txt +='<sjc:auth url="/admin/lotts/reSettlement"><a onClick="showWin(\'#reSettlementWin\',\'reSettlement\',{lotteryId:\''+ row.id+'\'})"  href="#">重新派奖</a>&nbsp;&nbsp;&nbsp;&nbsp;</sjc:auth>';
					txt +='<sjc:auth url="/admin/lotts/processEmergency"><a onClick="showWin(\'#processEmergencyWin\',\'processEmergency\',{lotteryId:\''+ row.id+'\'})"  href="#">应急处理</a>&nbsp;&nbsp;&nbsp;&nbsp;</sjc:auth>';
					txt +='<sjc:auth url="/admin/lotts/openByUser"><a onClick="showWin(\'#openByUser\',\'openByUser\',{lotteryId:\''+ row.id+'\'})"  href="#">人工开奖</a>&nbsp;&nbsp;&nbsp;&nbsp;</sjc:auth>';
					txt +='<sjc:auth url="/admin/lotts/addOpen"><a onClick="showWin(\'#addOpen\',\'addOpen\',{lotteryId:\''+ row.id+ '\'})"  href="#">补录号码</a>&nbsp;&nbsp;&nbsp;&nbsp;</sjc:auth>';
					return txt;
				}
			}] ]
		};
		createGrid('#grid',options);
		createWin('#cancelWin');
		createWin('#createSeasonWin');
		createWin('#reSettlementWin');
		createWin('#processEmergencyWin');
		createWin('#openByUser');
		createWin('#addOpen');
		createWin('#win',{width:600});
	});
function opens(a,title){
	addTab(title+' - '+$(a).text(),$(a).attr("data-href"),$(a).attr("dataid"));
}
function delns(id) {
	var tid=id;
	if (id="") {
		$.messager.alert('提示', '请选择一条记录进行操作!', 'info');
	}
	else{
		$.messager.confirm("确认", '相关的彩种配置信息一起删除，确认要删除该彩种【'+tid+'】?', function(r) {
			if (r) {
				var url ="<c:url value='/admin/lotts/delete?id='/>"+ tid;
				ajaxData(url,function(rel){
					reloadGrid("#grid");
				});
			}
		});
	}
}
function ajaxData(url, func) {
	$.ajax({
		url : url,
		type : 'GET',
		dataType : 'json',
		timeout : 500000,
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			$.messager.alert('错误', XMLHttpRequest.status+' '+XMLHttpRequest.statusText, 'error');
		},
		success : function(rel) {
			if (rel.status == 200) {
				if(func){
					func(rel);
				}
			} else {
				$.messager.alert('错误', rel.content, 'error');
			}
		}
	});
}
function addOpenItem(){
	var n = $("#openList div").length;
	var div = "<div style='text-align: center;'>";
	div+='期号：<input type="text" class="addSeason" name="simpleSeasons['+ n +'].season" value="${a.season}" /> ';
	div+='号码：<input type="text" class="addNums" name="simpleSeasons['+ n +'].nums" value="${a.nums}" /> ';
	div+='<a href="#" class="easyui-linkbutton" icon="icon-edit" onClick="deleteOpen(this)">删除</a>';
	div+="</div>";
	$("#openList").append(div);
	$(".easyui-linkbutton").linkbutton();
}
//删除
function deleteOpen(a) {
	$(a).parent().remove();
	resetNo();
}
function loadOPen() {
	var url = "<c:url value='/admin/lotts/getOpened?'/>"+"lotteryId="+$("#lotteryId").val()+"&startSeason="+$("#startSeasonId").val()+"&endSeason="+$("#endSeasonId").val();
    $.getJSON(url, function(data) {
    	if (data.status==200){
	        $("#openList").html("");//清空openList内容
	        $.each(data.content, function(i, item) {
	        	var n = $("#openList div").length;
	    		var div = "<div style='text-align: center;'>";
	    		div+='期号：<input type="text" class="addSeason" name="simpleSeasons['+ i +'].season" value="'+item.season+'" /> ';
	    		div+='号码：<input type="text" class="addNums" name="simpleSeasons['+ i +'].nums" value="'+item.nums+'" /> ';
	    		div+='<a href="#" class="easyui-linkbutton" icon="icon-edit" onClick="deleteOpen(this)">删除</a>';
	    		div+="</div>";
	    		$("#openList").append(div);
	    		$(".easyui-linkbutton").linkbutton();
	        });
    	}else {
			$.messager.alert('错误', rel.content, 'error');
		}
    });
}
function resetNo(){
	jQuery('.addSeason').each(function(i,value){
	     $(this).attr("name","simpleSeasons["+i+"].season");
	});
	jQuery('.addNums').each(function(i,value){
	     $(this).attr("name","simpleSeasons["+i+"].nums");
	});
}
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<div>
			<sjc:auth url="/admin/lotts/add"><a href="#" plain="true" class="easyui-linkbutton" icon="icon-add" onClick="showWin('#win','add',{status:0,orderId:0})">添加</a></sjc:auth>
		</div>
	</div>
	<div id="win">
		<form method="post" style="margin: 20px;" id="form">
			<table class="formtable">
				<tr>
					<td class="input-title">彩种组</td>
					<td><select name="groupName">
						<c:forEach items="${groups }" var="a">
							<option value="${a }">${a }</option>
						</c:forEach>
					</select>
					</td>
				</tr>
				<tr>
					<td class="input-title">期号规则</td>
					<td><select name="seasonRule">
						<c:forEach items="${seasonRules}" var="a">
						<option value="${a.title }">${a.remark }</option>
						</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td class="input-title">彩票标示</td>
					<td><input type="text" name="id" /></td>
				</tr>
				<tr>
					<td class="input-title">彩票名称</td>
					<td><input type="text" name="title" /></td>
				</tr>
				<tr>
					<td class="input-title">热门</td>
					<td><select name="isHot">
						<option value="0">否</option>
						<option value="1">是</option>
					</select></td>
				</tr>
				<tr>
					<td class="input-title">自主</td>
					<td><select name="isSelf">
						<option value="0">否</option>
						<option value="1">是</option>
					</select></td>
				</tr>
				<tr>
					<td class="input-title">最新</td>
					<td><select name="isNew">
						<option value="0">否</option>
						<option value="1">是</option>
					</select></td>
				</tr>
				<tr>
					<td class="input-title">显示行</td>
					<td><input type="text" name="showGroup" /></td>
				</tr>
				<tr>
					<td class="input-title">显示分类</td>
					<td><select name="lotteryGroupId">
						<c:forEach items="${groupId }" var="a">
						<option value="${a.id }">${a.name }</option>
						</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td class="input-title">权重</td>
					<td><input type="text" name="weight" /></td>
				</tr>
				<tr>
					<td class="input-title">最大追号</td>
					<td><input type="text" name="maxPlan" /></td>
				</tr>
				<tr>
					<td class="input-title">状态</td>
					<td><select name="status">
						<option value="0">启用</option>
						<option value="1">禁用</option>
					</select></td>
				</tr>
				<tr>
					<td class="input-title">彩中彩开关</td>
					<td><select name="betInStatus">
						<option value="0">启用</option>
						<option value="1">禁用</option>
					</select></td>
				</tr>
				<tr>
					<td class="input-title">手机端</td>
					<td><select name="mobileStatus">
						<option value="0">显示</option>
						<option value="1">不显示</option>
					</select></td>
				</tr>
				<tr>
					<td class="input-title">重新派奖超时(分钟)</td>
					<td><input type="text" name="reSettleTime" /></td>
				</tr>
				<tr>
					<td class="input-title">排序</td>
					<td><input type="text" name="orderId" /></td>
				</tr>
				<tr>
					<td class="input-title">描述</td>
					<td><textarea cols="50" rows="4" name="remark"></textarea></td>
				</tr>
			</table>
			<div style="text-align: center; padding: 5px;">
				<a href="#" class="btn-save" icon="icon-save" onClick="saveData(this, function(rel){ closeWin('#win','#grid')})">保存</a>
				<a href="#" class="btn-cancel" icon="icon-cancel" onClick="closeWin('#win')">取消</a>
			</div>
		</form>
	</div>
	<div id="cancelWin">
		<form method="post" style="margin: 20px;">
		<input type="hidden" name="lotteryId" />
			<table class="formtable">
				<tr>
					<td class="input-title">期号</td>
					<td><input type="text" name="startSeasonId" /></td> 
					<td>-</td>
					<td><input type="text" name="endSeasonId" /></td>
				</tr>
				
			</table>
			<div style="text-align: center; padding: 5px;">
				<a href="#" class="btn-save" icon="icon-save" onClick="saveData(this, function(rel){ closeWin('#cancelWin')})">保存</a>
				<a href="#" class="btn-cancel" icon="icon-cancel" onClick="closeWin('#cancelWin')">取消</a>
			</div>
		</form>
	</div>
	<div id="createSeasonWin">
		<form method="post" style="margin: 20px;">
		<input type="hidden" name="lotteryId" />
			<table class="formtable">
				<tr>
					<td class="input-title">起始日期</td>
					<td><input type="date" name="startDate" style="width:147px"/></td>
				</tr>
				<tr>
					<td class="input-title">天数</td>
					<td><input type="text" name="days" /></td>
				</tr>
			</table>
			<div style="text-align: center; padding: 5px;">
				<a href="#" class="btn-save" icon="icon-save" onClick="saveData(this, function(rel){ closeWin('#createSeasonWin')})">保存</a>
				<a href="#" class="btn-cancel" icon="icon-cancel" onClick="closeWin('#createSeasonWin')">取消</a>
			</div>
		</form>
	</div>
	<div id="reSettlementWin">
		<form method="post" style="margin: 20px;">
		<input type="hidden" name="lotteryId" />
			<table class="formtable">
				<tr>
					<td class="input-title">期号</td>
					<td><input type="text" name="seasonId" /></td>
				</tr>
				<tr>
					<td class="input-title">开奖号码</td>
					<td><input type="text" name="openNum" /></td>
				</tr>
				<tr style="height:30px">
					<td><input type="hidden" name="test" /></td>
					<td><input type="checkbox" name="enforce" value="1" />强制执行</td>
				</tr>
			</table>
			<div style="text-align: center; padding: 5px;">
				<a href="#" class="btn-save" icon="icon-save" onClick="saveData(this, function(rel){ closeWin('#reSettlementWin')})">保存</a>
				<a href="#" class="btn-cancel" icon="icon-cancel" onClick="closeWin('#reSettlementWin')">取消</a>
			</div>
		</form>
	</div>
	<div id="processEmergencyWin">
		<form method="post" style="margin: 20px;">
		<input type="hidden" name="lotteryId" />
			<table class="formtable">
				<tr>
					<td class="input-title">期号起</td>
					<td><input type="text" name="seasonIdBegin" /></td>
				</tr>
				<tr>
					<td class="input-title">是否强制处理</td>
					<td>
						<input type="radio" name="force" value="1" checked="checked" />否
						<input type="radio" name="force" value="0" />是
					</td>
				</tr>
			</table>
			<div style="text-align: center; padding: 5px;">
				<a href="#" class="btn-save" icon="icon-save" onClick="saveData(this, function(rel){ closeWin('#processEmergencyWin')})">处理</a>
				<a href="#" class="btn-cancel" icon="icon-cancel" onClick="closeWin('#processEmergencyWin')">取消</a>
			</div>
		</form>
	</div>
	<div id="openByUser">
		<form method="post" style="margin: 20px;">
		<input type="hidden" name="lotteryId" />
			<table class="formtable">
				<tr>
					<td class="input-title">期号</td>
					<td><input type="text" name="seasonId" /></td>
				</tr>
				<tr>
					<td class="input-title">开奖号码</td>
					<td><input type="text" name="openNum" /></td>
				</tr>
			</table>
			<div style="text-align: center; padding: 5px;">
				<a href="#" class="btn-save" icon="icon-save" onClick="saveData(this, function(rel){ closeWin('#openByUser')})">保存</a>
				<a href="#" class="btn-cancel" icon="icon-cancel" onClick="closeWin('#openByUser')">取消</a>
			</div>
		</form>
	</div>
	<div id="addOpen">
		<form method="post" style="margin: 20px;" enctype="multipart/form-data">
			<input type="hidden" id="lotteryId" name="lotteryId" />
			<table class="formtable">
				<tr>
					<div style="text-align: center; padding: 5px;">
						起始期号<input type="text" id="startSeasonId" name="startSeasonId" />
						结束期号<input type="text" id="endSeasonId" name="endSeasonId" />
						<a href="#" class="easyui-linkbutton" onClick="loadOPen()">抓取</a>
						<a href="#" class="easyui-linkbutton"  onClick="addOpenItem()">手工</a>
						<input type="checkbox" name="enforce" value="1" />强制执行
					</div>
					<hr/>
				</tr>
				<tr id="openList"></tr>
			</table>
				<div style="text-align: center; padding: 5px;">
					<a href="#" class="btn-save" icon="icon-save"
						onClick="saveData(this, function(rel){ closeWin('#addOpen')})">保存</a>
					<a href="#" class="btn-cancel" icon="icon-cancel"
						onClick="closeWin('#addOpen')">取消</a>
				</div>
		</form>
	</div>
</body>
</html>