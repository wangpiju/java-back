<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<script type="text/javascript" src="<c:url value='/res/admin/js/audio/audio5.min.js'/>"></script>
	<script type="text/javascript">
        var audio5js = new Audio5js({
            swf_path: '<c:url value="/res/admin/js/audio/audio5js.swf"/>',
            ready: function () {
                this.load('<c:url value="/res/admin/alarm/youtikuan.wav"/>');
            }
        });
        $(function() {
            var options = {
                rowStyler : function(index,row) {
                    if (row.status == 99) {
                        return 'background-color:grey;';
                    }
                    if (row.withdrawalTimes == 0) {
                        return 'background-color:#d24646;';
                    } else if (row.withdrawalTimes == 1 || row.withdrawalTimes == 2) {
                        return 'background-color:#27c114;';
                    }
                },
                columns : [ [ {
                    field : 'status',
                    title : '状态',
                    formatter : function(value, row) {
                        if (value == 0) {
                            audio5js.play();
                            return '未处理';
                        } else if (value == 1) {
                            return '拒绝';
                        } else if (value == 2) {
                            return "完成"
                        } else if (value == 3) {
                            return "已过期"
                        } else if (value == 4) {
                            return "已撤销"
                        } else if (value == 5) {
                            return "正在处理"
                        } else if (value == 6) {
                            return "审核中"
                        } else if (value == 7) {
                            return "审核通过"
                        } else if (value == 8) {
                            return "审核不通过"
                        } else if (value == 99) {
                            return "挂起"
                        } else {
                            return value;
                        }
                    }
                },{
                    field : 'other2',
                    title : '操作',
                    formatter : function(value, row) {
                        if (row.status != 5 && row.status != 6 && row.status != 99) {
                            return "";
                        }
                        var win1 = "'#win'";
                        var win3 = "'#win3'";
                        var win2 = "'#win2'";
                        var dat = "'edit?id=" + row.id +"'";
                        var txt = "";
                        if (row.status == 5) {//正在处理
                            txt += '<sjc:auth url="/admin/finance/deposit/edit"><a href="#" onClick="showWin('+ win1 + ',\'edit?operateType=0\','+ dat + ')">拒绝</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
// 						txt += '<sjc:auth url="/admin/finance/deposit/edit"><a href="#" onClick="showWin('+ win2 + ',\'edit?operateType=1\','+ dat + ')">完成</a></sjc:auth>';
                        } else if (row.status == 6) {//审核中
                            txt += '<sjc:auth url="/admin/finance/deposit/edit"><a href="#" onClick="showWin('+ win3 + ',\'edit?operateType=4\','+ dat + ')">不通过</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
// 						txt += '<sjc:auth url="/admin/finance/deposit/edit"><a href="#" onClick="showWin('+ win1 + ',\'edit?operateType=5\','+ dat + ')">通过</a></sjc:auth>';
                        } else if (row.status == 99) {
                            txt += '<a href="#" style="opacity: 0.2">不通过</a>&nbsp;&nbsp;&nbsp;&nbsp;';
                        }
                        return txt;
                    }

                },{
                    field : 'amount',
                    title : '提现金额'
                },{
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
                    title : '提现账户',
                    formatter : function(value, row) {
                        if (null != row.adminRemark && row.adminRemark != "") {
                            return "<span style='color:#0000ff;' title='" + row.adminRemark + "'>" + value + "</span>";
                        } else {
                            return value;
                        }
                    }
                },{
                    field : 'bankLevelTitle',
                    title : '用户等级'
                },{
                    field : 'withdrawalTimes',
                    title : '已提款次数'
                },{
                    field : 'test',
                    title : '用户类型',
                    formatter : function(value, row) {
                        if (value == 0) {
                            return '非测试';
                        } else if (value == 1) {
                            return "<span style='color:red;font-weight:bold;'>测试</span>";
                        } else {
                            return value;
                        }
                    }
                },{
                    field : 'createTime',
                    title : '提现时间',
                    formatter : function(value, row) {
                        var	txt ="";
                        if(value!=null){
                            txt= "<span  style=\"color:black;\" >"+ timestampToTime(value) +"</span>";
                        }
                        return txt;
                    }
                },{
                    field : 'lastTime',
                    title : '最后处理时间',
                    formatter : function(value, row) {
                        var	txt ="";
                        if(value!=null){
                            txt= "<span  style=\"color:black;\" >"+ timestampToTime(value) +"</span>";
                        }
                        return txt;
                    }
                },{
                    field : 'operator',
                    title : '现在操作的人员'
                },{
                    field : 'bankName',
                    title : '提现银行'
                },{
                    field : 'card',
                    title : '提现银行卡号'
                },{
                    field : 'address',
                    title : '提现银行支行地址',
                    width:100,
                    formatter:function(value,row) {
                        return '<span title="'+ value +'">'+ value +'</span>';
                    }
                },{
                    field : 'niceName',
                    title : '提现开户名'
                },{
                    field : 'remark',
                    title : '备注'
                },{
                    field : 'other',
                    title : '操作',
                    formatter : function(value, row) {
                        if (row.status != 0 && row.status != 5 && row.status != 6 && row.status != 7 && row.status != 99) {
                            return "";
                        }
                        var win1 = "'#win'";
                        var win3 = "'#win3'";
                        var win2 = "'#win2'";
                        var dat = "'edit?id=" + row.id +"'";
                        var txt = "";
                        if (row.status == 0) {//未处理
                            txt += '<sjc:auth url="/admin/finance/deposit/edit"><a href="#" onClick="ajaxPost(\'edit\',\'operateType=3&id='+row.id+'\',reCC)" style="color:#902d7e">审核</a></sjc:auth>';
                        } else if (row.status == 5) {//正在处理
// 						txt += '<sjc:auth url="/admin/finance/deposit/edit"><a href="#" onClick="showWin('+ win1 + ',\'edit?operateType=0\','+ dat + ')">拒绝</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
                            txt += '<sjc:auth url="/admin/finance/deposit/edit"><a href="#" onClick="showWin('+ win2 + ',\'edit?operateType=1\','+ dat + ')">完成</a></sjc:auth>';
                        } else if (row.status == 6) {//审核中
// 						txt += '<sjc:auth url="/admin/finance/deposit/edit"><a href="#" onClick="showWin('+ win3 + ',\'edit?operateType=4\','+ dat + ')">不通过</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
                            txt += '<sjc:auth url="/admin/finance/deposit/edit"><a href="#" onClick="showWin('+ win1 + ',\'edit?operateType=5\','+ dat + ')">通过</a></sjc:auth>';
                        } else if (row.status == 7) {//审核通过
                            txt += '<sjc:auth url="/admin/finance/deposit/edit"><a href="#" onClick="showWin('+ win1 + ',\'edit?operateType=2\','+ dat + ')">处理</a></sjc:auth>';
                        } else if (row.status == 99) {
                            txt += '<a href="#" style="opacity: 0.2">通过</a>&nbsp;&nbsp;&nbsp;&nbsp;';
                        }
                        return txt;
                    }
                }] ],
                url : 'list?statusArray=0,6,99&master=0',
                queryParams : getQueryParams()
            };
            createGrid('#grid',options);
            createWin('#win', {title:"<span style='color:green;font-weight: bold'>审核通过<span>"});
            createWin('#win3', {title:"<span style='color:red;font-weight: bold'>不通过<span>"});
            createWin('#win2');


            $("#form").form();

            $("#search").click(function(){
                $("#grid").datagrid("options").queryParams = getQueryParams();
                reloadGrid("#grid");
            });
        });


        function reCC(rel){
            reloadGrid('#grid');
        }

        function getQueryParams() {
            var p={};
            $.each($("#form").serializeArray(),function(){
                p[this.name]=this.value;
            });

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
                    $("#search").click();
                }
            }, t);
            return timer;
        }

        function setRemarkAndSave(remark, ths) {
            $("#winRemark").val(remark);
            saveData(ths, function(rel){ closeWin('#win','#grid')});
        }

        function editHand(handType) {
            var row = $('#grid').datagrid('getSelections');
            if (row){
                var ids = [];
                for (var i in row) {
                    if (handType == 0) {
                        if (row[i].status != 6) {
                            $.messager.alert('错误', "非审核中状态不能提款挂起", 'error');
                            return false;
                        }
                    } else if (handType == 1) {
                        if (row[i].status != 99) {
                            $.messager.alert('错误', "非挂起状态不能挂起解除", 'error');
                            return false;
                        }
                    }
                    ids.push(row[i].id);
                }

                ajaxPost('editHand', {ids:ids.join(','), handType:handType}, function(){reloadGrid('#grid');});
            }
        }
	</script>
</head>
<body>
<div id="grid"></div>
<a disabled="disabled"></a>
<div id="tb">
	<div>
		<form id="form" action="list" method="post">
			<table>
				<tr>
					<td>时间：</td>
					<td><input type="text" class="easyui-datetimebox beginTime" size="20" name="startTime"/>~<input type="text" class="easyui-datetimebox endTime" size="20" name="endTime"/></td>
					<td>提现账户：</td>
					<td><input type="text" size="10" name="account" /></td>
					<td>用户类型：</td>
					<td>
						<select name="test">
							<option value="-1">不限</option>
							<option value="0" selected="selected">非测试</option>
							<option value="1">测试</option>
						</select>
					</td>
					<td>状态：</td>
					<td>
						<select name="status">
							<option value="-1">不限</option>
							<option value="0">未处理</option>
							<option value="6">审核中</option>
						</select>
					</td>
					<td>
						<select onchange="refreshTime(this.value);">
							<option value="-1">暂停</option>
							<option value="15000" selected="selected">15秒</option>
							<option value="30000">30秒</option>
							<option value="45000">45秒</option>
							<option value="60000">60秒</option>
						</select>
						自动刷新
					</td>
					<td> <a href="#" plain="true" id="search" class="easyui-linkbutton" icon="icon-search">查询</a></td>
					<td> <a href="#" plain="true" onclick="editHand(0);" class="easyui-linkbutton" icon="icon-search">提款挂起</a></td>
					<td> <a href="#" plain="true" onclick="editHand(1);" class="easyui-linkbutton" icon="icon-search">挂起解除</a></td>
				</tr>
			</table>
		</form>
	</div>
</div>
<div id="win">
	<form method="post" style="margin: 20px;" id="form">
		<input type="hidden" name="id" />
		<input type="hidden" name="remark" id="winRemark" />
		<div style="text-align: center; padding: 5px; width: 300px">
			<a href="#" class="btn-save" icon="icon-save" onClick="setRemarkAndSave('pt', this);" style="color:#902d7e">PT通过</a>
			<a href="#" class="btn-save" icon="icon-save" onClick="setRemarkAndSave('', this);">PASS通过</a>
		</div>
		<div style="text-align: center; padding: 5px;">
			<a href="#" class="btn-cancel" icon="icon-cancel" onClick="closeWin('#win')">取消</a>
		</div>
	</form>
</div>
<div id="win3">
	<form method="post" style="margin: 20px;" id="form3">
		<input type="hidden" name="id" />
		<table class="formtable">
			<tr>
				<td class="input-title">备注</td>
				<td><input type="text" name="remark" /></td>
			</tr>
		</table>
		<div style="text-align: center; padding: 5px;">
			<a href="#" class="btn-save" icon="icon-save" onClick="saveData(this, function(rel){ closeWin('#win3','#grid')})">保存</a>
			<a href="#" class="btn-cancel" icon="icon-cancel" onClick="closeWin('#win3')">取消</a>
		</div>
	</form>
</div>
<div id="win2">
	<form method="post" style="margin: 20px;" id="form2">
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
			<a href="#" class="btn-save" icon="icon-save" onClick="saveData(this, function(rel){ closeWin('#win2','#grid')})">保存</a>
			<a href="#" class="btn-cancel" icon="icon-cancel" onClick="closeWin('#win2')">取消</a>
		</div>
	</form>
</div>
</body>
</html>