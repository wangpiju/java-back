<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<style type="text/css">
		.datagrid-cell {
			height: 36px
		}
		.mission {
			line-height:30px;
			margin-bottom:10px;
			background-color:silver;
		}
	</style>
	<script type="text/javascript" src="<c:url value='/res/admin/js/audio/audio5.min.js'/>"></script>
	<script type="text/javascript">
        var missionLength = ${missionLength};
        var audio5js = new Audio5js({
            swf_path : '<c:url value="/res/admin/js/audio/audio5js.swf"/>',
            ready : function() {
                this.load('<c:url value="/res/admin/ALARM.WAV"/>');
            }
        });
        $(function() {
            var options = {
                rowStyler : function(index,row) {
                    if (row.remark == 'pt') {
                        return 'background-color:#d24646;';
                    }
                    if (row.status == 5) {
                        return 'background-color:silver;';
                    }
                },
                columns : [ [
                    {
                        field : 'status',
                        title : '状态<br>Status',
                        formatter : function(value, row) {
                            if (value == 0) {
                                return '未处理';
                            } else if (value == 1) {
                                return '拒绝';
                            } else if (value == 2) {
                                return "完成";
                            } else if (value == 3) {
                                return "已过期";
                            } else if (value == 4) {
                                return "已撤销";
                            } else if (value == 5) {
                                return "<span style='color:red;'>Be Claimed</span>";
                            } else if (value == 6) {
                                return "审核中";
                            } else if (value == 7) {
                                audio5js.play();
                                return "Not claimed";
                            } else if (value == 8) {
                                return "审核不通过";
                            } else if (value == 99) {
                                return "挂起"
                            } else {
                                return value;
                            }
                        }
                    },
                    {
                        field : 'amount',
                        title : '提现金额<br>Amount',
                        formatter : function(value, row) {
                            return "<span style='font-size:20px'>" + value + "</span>";
                        }
                    },
                    {
                        field : 'withdrawalTimes',
                        title : '取款次数<br>Withdrawal Times'
                    },
                    {
                        field : 'account',
                        title : '提现账户<br>Account'
                    },{
                        field : 'bankLevelTitle',
                        title : '用户等级<br>User Level'
                    },{
                        field : 'test',
                        title : '用户类型<br>User type',
                        formatter : function(value, row) {
                            if (value == 0) {
                                return '非测试';
                            } else if (value == 1) {
                                return "<span style='color:red;font-weight:bold;'>测试</span>";
                            } else {
                                return value;
                            }
                        }
                    },
                    {
                        field : 'createTime',
                        title : '提现时间<br>Sub time',
                        formatter : function(value, row) {
                            var	txt ="";
                            if(value!=null){
                                txt= "<span  style=\"color:black;\" >"+ timestampToTime(value) +"</span>";
                            }
                            return txt;
                        }
                    },
                    {
                        field : 'lastTime',
                        title : '最后处理时间<br>Last Time',
                        formatter : function(value, row) {
                            var	txt ="";
                            if(value!=null){
                                txt= "<span  style=\"color:black;\" >"+ timestampToTime(value) +"</span>";
                            }
                            return txt;
                        }
                    },
                    {
                        field : 'lastOperator',
                        title : '上个操作人员<br>Last Operator'
                    },
                    {
                        field : 'remark',
                        title : '备注<br>Remarks'
                    },
                    {
                        field : 'serialNumber',
                        title : '交易号<br>Serial No.'
                    },
                    {
                        field : 'other',
                        title : '操作<br>Action',
                        formatter : function(value, row) {
                            if (row.status != 0 && row.status != 5
                                && row.status != 6 && row.status != 7) {
                                return "";
                            }
                            var win1 = "'#win'";
                            var win2 = "'#win2'";
                            var dat = "'edit?id=" + row.id + "'";
                            var txt = "";
                            if (row.status == 0) {//未处理
                                txt += '<sjc:auth url="/admin/finance/deposit/edit"><a href="#" onClick="showWin(' + win1+ ',\'edit?operateType=3\',' + dat+ ')">审核</a></sjc:auth>';
                            } else if (row.status == 5) {//正在处理
                                txt += '--';
                            } else if (row.status == 6) {//审核中
                                txt += '<sjc:auth url="/admin/finance/deposit/edit"><a href="#" onClick="showWin(' + win1+ ',\'edit?operateType=4\',' + dat+ ')">不通过</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
                                txt += '<sjc:auth url="/admin/finance/deposit/edit"><a href="#" onClick="showWin(' + win1+ ',\'edit?operateType=5\',' + dat+ ')">通过</a></sjc:auth>';
                            } else if (row.status == 7) {//审核通过
                                txt += '<sjc:auth url="/admin/finance/deposit/edit"><a href="#" onClick="accpect(\'' + row.id + '\', \'' + row.remark + '\')">ACCPECT</a></sjc:auth>';
                            }
                            return txt;
                        }
                    },{
                        field : 'operator',
                        title : '现在操作的人员<br>Now Operator',
                        formatter : function(value, row) {
                            if (row.status == 5) {
                                return "<span style='color:red;font-size:20px;'>" + (value == null ? "" : value) + "</span>";
                            } else {
                                return value;
                            }
                        }
                    } ] ],
                url : 'list?statusArray=5,7&master=0'
            };

            for (var i = 1; i <= missionLength; i++) {
                options.queryParams = getQueryParams(i);
                createGrid('#grid' + i, options);
            }

            $("#search1").click(function() {
                for (var i = 1; i <= missionLength; i++) {
                    $("#grid" + i).datagrid("options").queryParams = getQueryParams(i);
                    reloadGrid("#grid" + i);
                }
            });

            createWin('#win');
            createWin('#win2');
        });

        var missionAmount = {};
        <c:forEach items="${financeMissionList }" var="financeMission" varStatus="st">
        missionAmount['minAmount${st.index + 1}'] = ${financeMission.minAmount};
        missionAmount['maxAmount${st.index + 1}'] = ${financeMission.maxAmount};
        </c:forEach>

        function accpect(id, remark) {
            $("#winId").val(id);
            $("#winRemark").val(remark);
            saveData($("#winSave")[0], function(rel){ closeWin('#win');$('#search1').click()});
        }

        function getQueryParams(i) {
            var p = {};
            $.each($("#form1").serializeArray(), function() {
                p[this.name] = this.value;
            });

            p['minAmount'] = missionAmount['minAmount' + i];
            p['maxAmount'] = missionAmount['maxAmount' + i];

            return p;
        }

        var suspend = false;
        var timer = setTimer(15000);

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
                    $("#search1").click();
                }
            }, t);
            return timer;
        }


	</script>
</head>
<body>
<div class="easyui-panel" fit="true" border="none;">
	<c:forEach items="${financeMissionList }" var="financeMission" varStatus="st">
		<div id="tb${st.index + 1 }" ${st.index != 0 ? "style='display: none'" : "" } >
			<div>
				<form id="form${st.index + 1 }" action="list" method="post">
					<input name="minAmount" value="${financeMission.minAmount }" type="hidden" />
					<input name="maxAmount" value="${financeMission.maxAmount }" type="hidden" />
					<table>
						<tr>
							<td>时间：</td>
							<td><input type="text" class="easyui-datetimebox beginTime"
									   size="20" name="startTime" />~<input type="text"
																			class="easyui-datetimebox endTime" size="20" name="endTime" /></td>
							<td>提现账户ACCOUNT：</td>
							<td><input type="text" size="10" name="account" /></td>
							<td>用户类型USER TYPE：</td>
							<td><select name="test">
								<option value="-1">不限all</option>
								<option value="0">非测试cash acc</option>
								<option value="1">测试test acc</option>
							</select></td>
							<td>状态STATUS：</td>
							<td><select name="status">
								<option value="-1">不限all</option>
								<option value="5">正在处理</option>
								<option value="7">审核通过</option>
							</select></td>
							<td><select onchange="refreshTime(this.value);">
								<option value="-1">暂停</option>
								<option value="15000" selected="selected">15秒</option>
								<option value="30000">30秒</option>
								<option value="45000">45秒</option>
								<option value="60000">60秒</option>
							</select> 自动刷新</td>
							<td><a href="#" plain="true" id="search${st.index + 1 }"
								   class="easyui-linkbutton" icon="icon-search">查询</a></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		<p class="mission">${financeMission.title }</p>
		<div class="easyui-panel" fit="false" border="none;" style="height: 300px;">
			<div id="grid${st.index + 1 }"></div>
		</div>
	</c:forEach>
</div>
<div id="win">
	<form method="post" style="margin: 20px;" action="edit?operateType=2">
		<input type="hidden" name="id" id="winId" />
		<table class="formtable">
			<tr>
				<td class="input-title">备注</td>
				<td><input type="text" name="remark" id="winRemark" /></td>
			</tr>
		</table>
		<div style="text-align: center; padding: 5px;">
			<a id="winSave" href="#" class="btn-save" icon="icon-save"
			   onClick="saveData(this, function(rel){ closeWin('#win');$('#search1').click()})">保存</a>
			<a href="#" class="btn-cancel" icon="icon-cancel"
			   onClick="closeWin('#win')">取消</a>
		</div>
	</form>
</div>
<div id="win2">
	<form method="post" style="margin: 20px;">
		<input type="hidden" name="id" />
		<table class="formtable">
			<tr>
				<td class="input-title">交易号</td>
				<td><input type="text" name="serialNumber" /></td>
			</tr>
			<tr>
				<td class="input-title">备注</td>
				<td><input type="text" name="remark" /></td>
			</tr>
		</table>
		<div style="text-align: center; padding: 5px;">
			<a href="#" class="btn-save" icon="icon-save"
			   onClick="saveData(this, function(rel){ closeWin('#win2','#grid')})">保存</a>
			<a href="#" class="btn-cancel" icon="icon-cancel"
			   onClick="closeWin('#win2')">取消</a>
		</div>
	</form>
</div>
</body>
</html>