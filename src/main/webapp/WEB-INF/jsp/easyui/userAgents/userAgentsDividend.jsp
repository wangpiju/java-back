<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <script type="text/javascript">

        $(function() {

            var options = {

                columns : [ [ {

                    field : 'programName',

                    title : '方案名称',
                    formatter : function(value, row) {
                        var	txt ="";
                        if(value!=null){
                            txt= "<span  style=\"color:blue;\" >" + value + "</span>";
                        }
                        return txt;
                    }

                }, {

                    field : 'negativeProfit',

                    title : '负盈利（元）— 不含代理本人'

                }, {

                    field : 'proportion',

                    title : '周期分红比例（%）'

                }, {

                    field : 'activeNumber',

                    title : '活跃人数'

                }, {

                    field : 'cycle',

                    title : '计算周期',

                    formatter : function(value, row) {
                        if (value == 1) {
                            var	txt ="";
                            if(value!=null){
                                txt= "<span  style=\"color:red;\" >半月</span>";
                            }
                            return txt;
                        } else if (value == 2) {
                            var	txt ="";
                            if(value!=null){
                                txt= "<span  style=\"color:blue;\" >月</span>";
                            }
                            return txt;
                        } else {
                            return value;
                        }
                    }

                }, {

                    field : 'status',

                    title : '状态',
                    formatter : function(value, row) {
                        if (value == 1) {
                            var	txt ="";
                            if(value!=null){
                                txt= "<span  style=\"color:red;\" >开启</span>";
                            }
                            return txt;
                        } else if (value == 0) {
                            return '关闭';
                        } else {
                            return value;
                        }
                    }

                }, {

                    field : 'hint',

                    title : '提示语'

                },{

                    field : 'other',

                    title : '操作',

                    formatter : function(value, row) {

                        var win ="'#win'";

                        var url = "'edit'";

                        var dat = "'edit?id=" + row.id +"'";

                        var txt = '<sjc:auth url="/admin/userAgents/dividend/edit"><a href="#" onClick="showWin('+ win +',' +url+ ','+ dat +')">编辑</a></sjc:auth>&nbsp;&nbsp;';

                        return txt;

                    }

                }] ],
                queryParams : getQueryParams()
            };

            createGrid('#grid',options);
            createWin('#win');


            $("#search").click(function(){
                $("#grid").datagrid("options").queryParams = getQueryParams();
                reloadGrid("#grid");
            });


        });

        function getQueryParams() {
            var p={};
            $.each($("#queryForm").serializeArray(),function(){
                p[this.name]=this.value;
            });
            return p;
        }

    </script>

</head>

<body>

<div id="grid"></div>

<div id="tb">

    <div>

        <sjc:auth url="/admin/userAgents/dividend/edit"><a href="#" plain="true" icon="icon-add" class="easyui-linkbutton" onClick="showWin('#win','edit')">添加</a></sjc:auth>

    </div>

    <form id="queryForm" action="list" method="post">
        <table>
            <tr>
                <td>方案名称：</td>
                <td><input type="text" size="10" name="q_programName" /></td>
                <td>状态：</td>
                <td>
                    <select name="q_status">
                        <option value="">全部</option>
                        <option value="0">关闭</option>
                        <option value="1">开启</option>
                    </select>
                </td>
                <td><a href="#" plain="true" id="search" class="easyui-linkbutton" icon="icon-search">查询</a></td>
            </tr>
        </table>
    </form>
    <div id="win">

        <form method="post" style="margin: 20px;" method="post">

            <input type="hidden" name="id" />

            <table class="formtable">

                <tr>

                    <td class="input-title">方案名称</td>

                    <td><input type="text" name="programName" /></td>

                </tr>

                <tr>

                    <td class="input-title">负盈利（元）</td>

                    <td><input type="text" name="negativeProfit" /></td>

                </tr>

                <tr>

                    <td class="input-title">周期分红比例</td>

                    <td><input type="text" name="proportion" />&nbsp;%</td>

                </tr>

                <tr>

                    <td class="input-title">活跃人数</td>

                    <td><input type="text" name="activeNumber" /></td>

                </tr>

                <tr>

                    <td class="input-title">计算周期</td>

                    <td><select name="cycle">

                        <option value="1">半月</option>

                        <option value="2">月</option>

                    </select></td>

                </tr>

                <tr>

                    <td class="input-title">状态</td>

                    <td><select name="status">

                        <option value="0">关闭</option>

                        <option value="1">开启</option>

                    </select></td>

                </tr>

                <tr>

                    <td class="input-title">提示语</td>

                    <td><input type="text" name="hint" /></td>

                </tr>

            </table>

            <div style="text-align: center; padding: 5px;">

                <a href="#" class="btn-save" icon="icon-save" onClick="saveData(this, function(rel){ closeWin('#win','#grid')})">保存</a>

                <a href="#" class="btn-cancel" icon="icon-cancel" onClick="closeWin('#win')">取消</a>

            </div>

        </form>
    </div>
</body>

</html>