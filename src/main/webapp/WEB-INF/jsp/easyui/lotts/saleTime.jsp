<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<style>
	.titlered {
	 color:red;
	}
</style>
<script type="text/javascript" src="<c:url value='/res/admin/js/audio/audio5.min.js'/>"></script>
<script type="text/javascript">
var audio5js = new Audio5js({
	swf_path: '<c:url value="/res/admin/js/audio/audio5js.swf"/>',
	ready: function () {
		this.load('<c:url value="/res/admin/alarm/weikaijiang.wav"/>');
		//this.play();
		//playing
		//pause
	}
});
var noDeal=0;
var noDealS=0;
var noDealT=0;
var grid;
	$(function() {
		var options = {
			singleSelect:true,
			pageSize : 1600,
			pageList:[200,1600],
			columns : [ [ {
				field : 'seasonId',
				title : '奖期'
			}, {
				field : 'beginTime',
				title : '开始销售时间'
			}, {
				field : 'endTime',
				title : '截止销售时间'
			}, {
				field : 'openTime',
				title : '开奖时间'
			}, {
				field : 'openAfterTime',
				title : '超时时间'
			}, {
				field : 'openStatus',
				title : '开奖',
				formatter:function(value,row){
					if(value == 0){
						if (row.serviceTime>row.openAfterTime){
							getRootWin().setTabTitleRed($(window.parent.document).find('#${lotteryId}').attr('data'),audio5js);
						}
						noDeal=1;
						return '<span>未执行</span>';
					} else if(value == 1){
						getRootWin().setTabTitleRed($(window.parent.document).find('#${lotteryId}').attr('data'),audio5js);
						return '<span style="color:red;">已执行</span>';
					} else if(value == 3){
						//getRootWin().setTabTitleRed($(window.parent.document).find('#${lotteryId}').attr('data'),audio5js);
						return '<span style="color:red;">提前开奖</span>';
					} else if(value == 4){
						return '<span style="color:blue;">人工开奖</span>';
					} else if(value == 5){
						getRootWin().setTabTitleRed($(window.parent.document).find('#${lotteryId}').attr('data'),audio5js);
						return '<span style="color:red;">开奖超时</span>';
					} else if(value == 6){
						return '<span style="color:	#7B68EE;">系统撤单</span>';
					}else if(value == 7){
						return '<span style="color:red;">重复开奖</span>';
					} else {
						if (noDeal>0){
							getRootWin().setTabTitleRed($(window.parent.document).find('#${lotteryId}').attr('data'),audio5js);
						}
						return '<span style="color:green; font-weight:bold;">已完成</span>';
					}
				}
			}, {
				field : 'settleStatus',
				title : '结算',
				formatter:function(value,row){
					if(value == 0){
						if (row.serviceTime>row.openAfterTime){
							getRootWin().setTabTitleRed($(window.parent.document).find('#${lotteryId}').attr('data'),audio5js);
						}
						noDealS=1;
						return '<span>未执行</span>';
					} else if(value == 1){
						getRootWin().setTabTitleRed($(window.parent.document).find('#${lotteryId}').attr('data'),audio5js);
						return '<span style="color:red;">已执行</span>';
					} else if(value == 3){
						return '<span style="color:blue;">正在执行</span>';
					} else if(value == 6){
						return '<span style="color:	#7B68EE;">系统撤单</span>';
					} else {
						if (noDealS>0){
							getRootWin().setTabTitleRed($(window.parent.document).find('#${lotteryId}').attr('data'),audio5js);
						}
						return '<span style="color:green; font-weight:bold;">已完成</span>';
					}
				}
			}, {
				field : 'planStatus',
				title : '追号',
				formatter:function(value,row){
					if(value == 0){
						if (row.serviceTime>row.openAfterTime){
							getRootWin().setTabTitleRed($(window.parent.document).find('#${lotteryId}').attr('data'),audio5js);
						}
						noDealT=1;
						return '<span>未执行</span>';
					} else if(value == 1){
						getRootWin().setTabTitleRed($(window.parent.document).find('#${lotteryId}').attr('data'),audio5js);
						return '<span style="color:red;">已执行</span>';
					} else if(value == 3){
						return '<span style="color:blue;">正在执行</span>';
					} else if(value == 6){
						return '<span style="color:	#7B68EE;">系统撤单</span>';
					} else {
						if (noDealT>0){
							getRootWin().setTabTitleRed($(window.parent.document).find('#${lotteryId}').attr('data'),audio5js);
						}
						return '<span style="color:green; font-weight:bold;">已完成</span>';
					}
				}
			}] ]
		};
		createGridEx('#grid',options);
	});
	function createGridEx(grid, options) {
		// 表格
		var settings = {
			border : false,
			fit : true,
			fitColumns : true,
			url : 'list',
			idField : 'id',
			singleSelect : false,
			pageSize : 200,
			pageList:[50,100,200,1300],
			pagination : true,
			rownumbers : true,
			onLoadError: function(data){
				$.messager.alert('错误', '加载错误,请重试', 'error');
			},
			onLoadSuccess : function () {
				if (typeof (countFields) != 'undefined') {
					var param = {};
					for (var i = 0; i < countFields.length; i++) {
						param[countFields[i]] = countField(grid, countFields[i]);
					}
					$(grid).datagrid('appendRow', param);
					$(".datagrid-cell-rownumber").last().html("");
					$(".datagrid-cell-check").last().html("");
				}
			},
			toolbar : '#tb'
		};

		settings = jQuery.extend(settings, options);
		if (settings.singleSelect === false && !settings.frozenColumns) {
			settings.frozenColumns = [ [ {
				field : 'ck',
				checkbox : true
			} ] ];
		}
		return $(grid).datagrid(settings);
	}
	function finds(){
		getRootWin().setTabTitleBlack($(window.parent.document).find('#${lotteryId}').attr('data'),audio5js);
		var p = {
				begin:$("#begin").datebox("getValue"),
				end:$("#end").datebox("getValue"),
				lotteryId:'${lotteryId}'
		}
		noDeal=0;
		noDealS=0;
		noDealT=0;
		reloadGrid("#grid",p);
	}

	window.onload = function () { 
		$('#begin').datebox('setValue', new Date().format("yyyy-MM-dd"));
		$('#end').datebox('setValue', new Date().addDay(1).format("yyyy-MM-dd"));
	}
	var suspend = false;
	var timer = setTimer(60000);
	
	function refreshTime(t) {
		clearInterval(timer);
		if (t != -1) {
			clearInterval(timer);
			timer = setTimer(t);
		}
	}
	
	function setTimer(t) {
		var timer = setInterval(function() {
			if (!suspend) {
				$("#search").click();
			}
		}, t);
		return timer;
	}

</script>

</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		时间:<input type="text" class="easyui-datebox" id="begin" size="10"/>~<input type="text" class="easyui-datebox" id="end" size="10" /> 
			          	<select onchange="refreshTime(this.value);">
			          		<option value="-1">暂停</option>
			          		<option value="15000">15秒</option>
			                <option value="30000">30秒</option>
							<option value="45000">45秒</option>
							<option value="60000" selected="selected">60秒</option>
				        </select>
				                            自动刷新
		<a href="#" plain="true" id="search" class="easyui-linkbutton" icon="icon-search" onClick="finds()">查询</a>
	</div>
</body>
</html>