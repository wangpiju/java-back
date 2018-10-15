<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	$(function() {
		var options = {
			columns : [ [ {
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
				field : 'betAmount',
				title : '投注总额'
			}, {
				field : 'rebateAmount',
				title : '返点总额'
			}, {
				field : 'actualSaleAmount',
				title : '实际销售总额'
			}, {
				field : 'winAmount',
				title : '中奖总额'
			}, {
				field : 'count',
				title : '总盈亏'
			}, {
				field : 'winRatio',
				title : '中投比'
			} ] ]
		};
		grid = createGrid('#grid', options);
		$("#search").click(function() {
			var p = {};
			$.each($("#form").serializeArray(), function() {
				p[this.name] = this.value;
			});
			if ($("#select").val() == 1) {
				if (p["startTime"] == "" || p["endTime"] == "") {
					$.messager.alert("错误", "起始时间或者结束时间不能为空", "error");
					return;
				}
			}
// 			$("#grid").datagrid("options").queryParams = p;
			reloadGrid("#grid",p);
		});
	});
	function showTime(t) {
		if (t == 0) {
			$("#ddd").hide();
		} else {
			$("#ddd").show();
		}
	}
	$('document').ready(function() {
		$("#ddd").hide();
	})
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<div>
			<form id="form" action="list" method="post">
				设定时间：<select name="historyAndNow" onchange="showTime(this.value);"
					id="select">
					<option value="0">今天排行</option>
					<option value="1">历史排行</option>
				</select> 用户名： <input type="text" size="10" name="account" /> <label
					id="ddd">时间：<input type="text" size="10" name="startTime"
					class="easyui-datebox" id="startTime" />00:00:00~<input type="text"
					size="10" name="endTime" class="easyui-datebox" id="endTime" />23:59:59</label>
				输赢/中奖： <input type="text" size="10" name="count" /><span>(绝对值)</span>
				<span style="margin-left:20px">测试：</span><select name="test">
					<option value="0">否</option>
					<option value="1">是</option>
				</select> 排序：<select name="order">
					<option value="0">输赢正序</option>
					<option value="1">输赢倒序</option>
				</select> <a href="#" plain="true" id="search" class="easyui-linkbutton"
					icon="icon-search">查询</a>
			</form>
		</div>
	</div>
</body>
</html>