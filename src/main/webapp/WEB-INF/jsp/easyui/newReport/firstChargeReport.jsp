<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>

<html xmlns="http://www.w3.org/1999/xhtml">

<head>

    <script type="text/javascript">

        var countFields = [];

        $(function() {

            setWebDefaultTime();

            if('${begin}') {

                $('.beginTime').datebox("setValue", '${begin}');

            }

            if('${end}') {

                $('.endTime').datebox("setValue", '${end}');

            }

            var options = {

                url:'listFirstCharge',

                queryParams : getQueryParams(),

                columns : [ [ {

                    field : 'account',

                    title : '会员账户',

                    formatter : function(value, row) {
                        var	txt ="";
                        if(value!=null){
                            txt= "<span  style=\"color:blue;\" >"+value+"</span>";
                        }
                        return txt;
                    }

                }, {

                    field : 'parentAccount',

                    title : '上级用户',

                }, {

                    field : 'userType',

                    title : '用户类型',

                    formatter : function(value, row) {

                        if(value==0){

                            return '<span >会员</span>';

                        }else if(value==1){

                            return '<span style="color:red;">代理</span>';

                        }else{

                            return ' ';

                        }

                    }

                }, {

                    field : 'amount',

                    title : '余额'

                }, {

                    field : 'rechargeFirstAmount',

                    title : '首充金额'

                }, {

                    field : 'rechargeFirstTimeStr',

                    title : '首充时间'

                }, {

                    field : 'rechargeType',

                    title : '充值方式',

                    formatter : function(value, row) {

                        if (value == 0) {
                            return '银行充值';
                        } else if (value == 1) {
                            return '第三方充值';
                        } else if (value == 2) {
                            return '现金充值';
                        } else if (value == 100) {
                            return '';
                        } else {
                            return value;
                        }

                    }

                }, {

                    field : 'userAgent',

                    title : '首充终端'

                }, {

                    field : 'regTimeStr',

                    title : '注册时间'

                }] ],

                onLoadSuccess : function (pageData) {

                    doCountField(grid);

                }

            };

            createGrid('#grid',options);

            $("#search").click(function(){

                $("#grid").datagrid("options").queryParams = getQueryParams();

                reloadGrid("#grid");

            });

        });



        function getQueryParams() {

            var p={};

            $.each($("#form").serializeArray(),function(){

                p[this.name]=this.value;

            });



            return p;

        }


        //初始化
        $(document).ready(function(){



        });

    </script>

</head>

<body>

<div id="grid"></div>

<div id="tb">

    <div>

        <form id="form" action="listFirstCharge" method="post">

            <table>

                <tr>

                    <td>用户名：</td>

                    <td> <input type="text" size="10" name="account" value="" /></td>

                    <td>上级：</td>

                    <td> <input type="text" size="10" name="parentAccount" value="" /></td>

                    <td>排序：</td>
                    <td>
                        <select id="sorting" name="sorting" style="width: 100px;" >
                        <option value="1">默认</option>
                        <option value="2">充值递减</option>
                        </select>
                    </td>

                    <td>首充时间：</td>

                    <td><input type="text" class="easyui-datetimebox beginTime" size="16" name="startDateStr" />~<input type="text" class="easyui-datetimebox endTime" size="16" name="endDateStr" /></td>

                    <td> <a href="#" plain="true" id="search" class="easyui-linkbutton" icon="icon-search">查询</a></td>

                </tr>

            </table>

        </form>

    </div>

</div>

</body>

</html>