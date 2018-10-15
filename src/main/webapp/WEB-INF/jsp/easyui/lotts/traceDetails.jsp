<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	var grid;
	$(function() {

		var options = {
			url : 'traceDetails',
			singleSelect : true,
			queryParams : {
				traceId : '${trace.id}'
			},
			columns : [ [
					{
						field : 'id',
						title : '序号',
					},
					{
						field : 'seasonId',
						title : '期号'
					},
					{
						field : 'price',
						title : '追号倍数',

					},
					{
						field : 'amount',
						title : '投注金额'
					},
					{
						field : 'openNum',
						title : '当期开奖号码',
						formatter : function(value, row) {
							if (value != null) {
								return '<span >' + value + '</span>';
							} else {
								return '<span >' + "" + '</span>';
							}
						}
					},
					{
						field : 'win',
						title : '奖金',
						formatter : function(value, row) {
							if (value != null) {
								return '<span >' + value + '</span>';
							} else {
								return '<span >' + "" + '</span>';
							}
						}
					},
					{
						field : 'status',
						title : '状态',
						formatter : function(value, row) {
							switch (value) {
							case 0:
								return '<span >等待开奖</span>';
							case 1:
								return '<span >已中奖</span>';
							case 2:
								return '<span >未中奖</span>';
							case 3:
								return '<span >未开始</span>';
							case 4:
								return '<span >个人撤单</span>';
							case 5:
								return '<span >系统撤单</span>';
							case 6:
								return '<span >等待开奖</span>';
							case 7:
								return '<span >恶意注单</span>';
							case 8:
								return '<span >暂停</span>';
							case 9:
								return '<span >追中撤单</span>';
							}
						}
					},
					{
						field : 'other',
						title : '操作',
						formatter : function(value, row) {
							var txt = " ";
							if (row.status == 3 || row.status==0) {
								txt = "<sjc:auth url="/admin/report/cleAllOrder"><a href='javascript:;' class='fontColorRed' onClick =\"ConfirmEx('是否删除该记录？','"+ row.id+ "','"+ row.account+ "')\">撤单</a</sjc:auth>";
							}
							return txt;
						}
					} ] ]
		};
		grid = createGrid('#grid', options);
		$("#search").click(function() {
			var p = {};
			$.each($("#form").serializeArray(), function() {
				p[this.name] = this.value;
			});
			reloadGrid("#grid", p);
		});
	});
	function opens(a, title) {
		addTab(title + ' - ' + $(a).text(), $(a).attr("data-href"));
	}
	function canCleOrder(id, account) {
		var url = '<c:url value="/admin/report/canCleOrder?id="/>' + id
				+ "&account=" + account;
		ajaxData(url, function(rel) {
			reloadGrid("#grid");
		});
	}
	function cleAllOrder(zid) {
		var url = '<c:url value="/admin/report/cleAllOrder?zid="/>' + zid;
		ajaxData(url, function(rel) {
			reloadGrid("#grid");
		});
	}
	function Confirm(msg) {
		$.messager.confirm("确认", msg, function(r) {
			if (r) {
				cleAllOrder('${trace.id }');
				return true;
			}
		});
		return false;
	}
	function ConfirmEx(msg,id,account) {
		$.messager.confirm("确认", msg, function(r) {
			if (r) {
				canCleOrder(id,account);
				return true;
			}
		});
		return false;
	}
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<table>
			<tr>
				<td colspan="3" align="center"><span>${trace.lotteryName }</span></td>
			</tr>
			<tr>
				<td><label for="#"> <span>起始期号：</span> <span>${trace.startSeason }</span>
				</label></td>
				<td><label for="#"> <span>追号时间：</span> <span>${trace.createTime}</span>
				</label></td>
			</tr>
			<tr>
				<td><label for="#"> <span>进度：</span> <span>已追${trace.finishTraceNum}期/总${trace.traceNum }期</span>
				</label></td>
				<td><label for="#"> <span>已追号金额：</span> <span>￥${trace.finishTraceAmount }元</span>
				</label></td>
				<td><label for="#"> <span>追号方案金额：</span> <span>￥${trace.traceAmount }元</span>
				</label></td>
			</tr>
			<tr>
				<td><label for="#"> <span>终止追号条件：</span> <c:choose>
							<c:when test="${trace.isWinStop==1}">
								<span>中奖即停</span>
							</c:when>
							<c:otherwise>
								<span>追中不停</span>
							</c:otherwise>
						</c:choose>
				</label></td>
				<td><label for="#"> <span>已获奖金：</span> <c:choose>
							<c:when test="${not empty trace.winAmount}">
								<span>￥${trace.winAmount }元</span>
							</c:when>
							<c:otherwise>
								<span>￥0.00元</span>
							</c:otherwise>
						</c:choose>
				</label></td>
				<td><label for="#"> <span>追号编号：</span> <span>${trace.id }</span>
				</label></td>
				<td><sjc:auth url="/admin/report/cleAllOrder"><a href="javascript:;" onclick="Confirm('是否删除该追号记录?')"
					style="font-size: 30px; margin-left: 30px">终止追号</a></sjc:auth></td>
			</tr>
		</table>
	</div>
</body>
</html>