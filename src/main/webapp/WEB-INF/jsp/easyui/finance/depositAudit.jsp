<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <style type="text/css">
        .selectRow {
            background-color: #f198b4
        }
    </style>
    <script type="text/javascript" src="<c:url value='/res/admin/js/audio/audio5.min.js'/>"></script>
    <script type="text/javascript">
        var audio5js = new Audio5js({
            swf_path: '<c:url value="/res/admin/js/audio/audio5js.swf"/>',
            ready: function () {
                this.load('<c:url value="/res/admin/ALARM.WAV"/>');
            }
        });
        $(function () {
            var options = {
                rowStyler: function (index, row) {
                    if (row.remark == 'pt') {
                        return 'background-color:#d24646;';
                    }
                },
                columns: [[
                    {
                        field: 'other2',
                        title: 'ACTION',
                        formatter: function (value, row) {
                            if (row.status != 0 && row.status != 5
                                && row.status != 6 && row.status != 7) {
                                return "";
                            }
                            var win1 = "'#win'";
                            var win2 = "'#win2'";
                            var dat = "'edit?id=" + row.id + "'";
                            var txt = "";
                            if (row.status == 0) {//未处理
                                txt += '<sjc:auth url="/admin/finance/deposit/edit"><a href="#" onClick="showWin(' + win1 + ',\'edit?operateType=3\',' + dat + ')">审核</a></sjc:auth>';
                            } else if (row.status == 5) {//正在处理
                                txt += '<sjc:auth url="/admin/finance/deposit/edit"><a href="#" onClick="refuse(this, ' + win1 + ',' + dat + ')"><span style=\'color:red;\'>Refuse</span></a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
                            } else if (row.status == 6) {//审核中
                                txt += '<sjc:auth url="/admin/finance/deposit/edit"><a href="#" onClick="showWin(' + win1 + ',\'edit?operateType=4\',' + dat + ')">不通过</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
                                txt += '<sjc:auth url="/admin/finance/deposit/edit"><a href="#" onClick="showWin(' + win1 + ',\'edit?operateType=5\',' + dat + ')">通过</a></sjc:auth>';
                            } else if (row.status == 7) {//审核通过
                                txt += '<sjc:auth url="/admin/finance/deposit/edit"><a href="#" onClick="showWin(' + win1 + ',\'edit?operateType=2\',' + dat + ')">处理</a></sjc:auth>';
                            }
                            return txt;
                        }
                    },
                    {
                        field: 'account',
                        title: 'Account'
                    },{
                        field : 'bankLevelTitle',
                        title : '用户等级'
                    },{
                        field: 'test',
                        title: 'User type',
                        formatter: function (value, row) {
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
                        field: 'amount',
                        title: 'Amount',
                        formatter: function (value, row) {
                            //console.log(  row)style="cursor:default;"
                            return "<span style='font-size:20px;color:red;cursor:default;' onClick='showWin(\"#win3detail\",\"\", {account:\""+row.account+"\", bankname:\""+row.bankName+"\", bankcard:\""+row.card+"\", bankaccount:\""+row.niceName+"\",amount:\""+row.amount+"\",address:\""+row.address+"\"})'>" + value + "</span>";
                        }
                    },
                    {
                        field: 'withdrawalTimes',
                        title: 'Success Times'
                    },
                    {
                        field: 'createTime',
                        title: 'Sub time',
                        formatter : function(value, row) {
                            var	txt ="";
                            if(value!=null){
                                txt= "<span  style=\"color:black;\" >"+ timestampToTime(value) +"</span>";
                            }
                            return txt;
                        }
                    },
                    {
                        field: 'lastTime',
                        title: 'Last Time',
                        formatter : function(value, row) {
                            var	txt ="";
                            if(value!=null){
                                txt= "<span  style=\"color:black;\" >"+ timestampToTime(value) +"</span>";
                            }
                            return txt;
                        }
                    },
                    {
                        field: 'lastOperator',
                        title: 'Last Operator'
                    },
                    {
                        field: 'remark',
                        title: 'Remarks'
                    },
                    {
                        field: 'bankName',
                        title: 'Bank Name'
                    },
                    {
                        field: 'card',
                        title: 'Bank Card No.'
                    },
                    {
                        field: 'address',
                        title: '提现银行支行地址'
                    },
                    {
                        field: 'niceName',
                        title: 'User Name'
                    },
                    {
                        field: 'other',
                        title: 'ACTION',
                        formatter: function (value, row) {
                            if (row.status != 0 && row.status != 5
                                && row.status != 6 && row.status != 7) {
                                return "";
                            }
                            var win1 = "'#win'";
                            var win2 = "'#win2'";
                            var dat = "'edit?id=" + row.id + "'";
                            var txt = "";
                            if (row.status == 0) {//未处理
                                txt += '<sjc:auth url="/admin/finance/deposit/edit"><a href="#" onClick="showWin(' + win1 + ',\'edit?operateType=3\',' + dat + ')">审核</a></sjc:auth>';
                            } else if (row.status == 5) {//正在处理
                                txt += '<sjc:auth url="/admin/finance/deposit/edit"><a href="#" onClick="done(this, \'' + row.id + '\',\'' + row.card + '\',\'' + row.amount + '\')">Done</a></sjc:auth>';
                            } else if (row.status == 6) {//审核中
                                txt += '<sjc:auth url="/admin/finance/deposit/edit"><a href="#" onClick="showWin(' + win1 + ',\'edit?operateType=4\',' + dat + ')">不通过</a></sjc:auth>&nbsp;&nbsp;&nbsp;&nbsp;';
                                txt += '<sjc:auth url="/admin/finance/deposit/edit"><a href="#" onClick="showWin(' + win1 + ',\'edit?operateType=5\',' + dat + ')">通过</a></sjc:auth>';
                            } else if (row.status == 7) {//审核通过
                                txt += '<sjc:auth url="/admin/finance/deposit/edit"><a href="#" onClick="showWin(' + win1 + ',\'edit?operateType=2\',' + dat + ')">处理</a></sjc:auth>';
                            }
                            return txt;
                        }
                    }]],
                url: 'listMy?statusArray=5&master=0',
                queryParams: getQueryParams()
            };
            createGrid('#grid', options);
            createWin('#win', {
                onClose: function () {
                    $('a.btn-save').linkbutton("enable");
                    $("tr").removeClass("selectRow");
                }
            });
            createWin('#win2', {
                onClose: function () {
                    $('a.btn-save').linkbutton("enable");
                    $("tr").removeClass("selectRow");
                }
            });

            createWin('#win3detail', {width: 500});

            $("#form").form();

            $("#search").click(function () {
                $("#grid").datagrid("options").queryParams = getQueryParams();
                reloadGrid("#grid");
            });
        });

        function refuse(ths, win1, dat) {
            $(ths).parents("tr").addClass("selectRow");

            showWin(win1, 'edit?operateType=0', dat);
        }

        function done(ths, id, card, amount) {
            $(ths).parents("tr").addClass("selectRow");

            $("#tdBankCardNo").html("**" + card.substring(card.length - 4));
            $("#tdAmount").html("￥  " + amount);

            showWin('#win2', 'edit?operateType=1');
            $("#win2Id").val(id);
        }

        function getQueryParams() {
            var p = {};
            $.each($("#form").serializeArray(), function () {
                p[this.name] = this.value;
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
            var timer = setInterval(function () {
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
    <div>
        <form id="form" action="listMy" method="post">
            <table>
                <tr>
                    <td>时间：</td>
                    <td><input type="text" class="easyui-datetimebox beginTime"
                               size="20" name="startTime"/>~<input type="text"
                                                                   class="easyui-datetimebox endTime" size="20"
                                                                   name="endTime"/></td>
                    <td>提现账户：</td>
                    <td><input type="text" size="10" name="account"/></td>
                    <td>用户类型：</td>
                    <td><select name="test">
                        <option value="-1">不限</option>
                        <option value="0">非测试</option>
                        <option value="1">测试</option>
                    </select></td>
                    <td>状态：</td>
                    <td><select name="status">
                        <option value="-1">不限</option>
                        <option value="5">正在处理</option>
                        <option value="7">审核通过</option>
                    </select></td>
                    <td><select onchange="refreshTime(this.value);">
                        <option value="-1">暂停</option>
                        <option value="15000" selected="selected">15秒</option>
                        <option value="30000">30秒</option>
                        <option value="45000">45秒</option>
                        <option value="60000">60秒</option>
                    </select> 自动刷新
                    </td>
                    <td><a href="#" plain="true" id="search"
                           class="easyui-linkbutton" icon="icon-search">查询</a></td>
                </tr>
            </table>
        </form>
    </div>
</div>
<div id="win">
    <form method="post" style="margin: 20px;" id="form">
        <input type="hidden" name="id"/>
        <table class="formtable">
            <tr>
                <td class="input-title">备注</td>
                <td><input type="text" name="remark"/></td>
            </tr>
        </table>
        <div style="text-align: center; padding: 5px;">
            <a href="#" class="btn-save" icon="icon-save"
               onClick="saveData(this, function(rel){ closeWin('#win','#grid')})">保存</a>
            <a href="#" class="btn-cancel" icon="icon-cancel"
               onClick="closeWin('#win')">取消</a>
        </div>
    </form>
</div>
<div id="win2">
    <form method="post" style="margin: 20px; width: 300px" id="form2" action="edit?operateType=1">
        <input type="hidden" name="id" id="win2Id"/>
        <table class="formtable">
            <tr>
                <td class="input-title">Last 4 digit:</td>
                <td id="tdBankCardNo" style="font-size: 20pt"></td>
            </tr>
            <tr>
                <td class="input-title">Amount:</td>
                <td id="tdAmount" style="font-size: 20pt"></td>
            </tr>
        </table>
        <div style="text-align: center; padding: 5px;">
            <a id="win2Save" href="#" class="btn-save" icon="icon-save"
               onClick="saveData(this, function(rel){ closeWin('#win2','#grid')})">保存</a>
            <a href="#" class="btn-cancel" icon="icon-cancel"
               onClick="closeWin('#win2')">取消</a>
        </div>
    </form>
</div>
<div id="win3detail">
    <form method="post" style="margin: 20px;">
        <table class="formtable">
            <tbody>
            <tr>
                <td class="input-title">会员帐号</td>
                <td><input type="text" readonly name="account" id="copy_account"/></td>
                <td style="cursor:default;" onclick="copyWord('copy_account')">复制</td>
            </tr>

            <tr>
                <td class="input-title">银行名称</td>
                <td><input type="text" readonly name="bankname" id="copy_bankname" /></td>
                <td style="cursor:default;" onclick="copyWord('copy_bankname')">复制</td>
            </tr>

            <tr>
                <td class="input-title">提现银行支行地址</td>
                <td><input type="text" readonly name="address" id="copy_address" /></td>
                <td style="cursor:default;" onclick="copyWord('copy_address')">复制</td>
            </tr>

            <tr>
                <td class="input-title">银行卡号</td>
                <td><input type="text" readonly name="bankcard" id="copy_bankcard"/></td>
                <td style="cursor:default;" onclick="copyWord('copy_bankcard')">复制</td>
            </tr>

            <tr>
                <td class="input-title">银行姓名</td>
                <td><input type="text" readonly name="bankaccount" id="copy_bankaccount"/></td>
                <td style="cursor:default;" onclick="copyWord('copy_bankaccount')">复制</td>
            </tr>

            <tr>
                <td class="input-title">出款金额</td>
                <td><input type="text" readonly name="amount" id="copy_amount"/></td>
                <td style="cursor:default;" onclick="copyWord('copy_amount')">复制</td>
            </tr>

            </tbody>
        </table>
    </form>
</div>
</body>
</html>