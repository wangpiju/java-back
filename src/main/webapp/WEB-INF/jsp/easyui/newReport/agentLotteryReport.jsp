<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>

<html xmlns="http://www.w3.org/1999/xhtml">

<head>

    <script type="text/javascript">

        var countFields = ['betPerCount','betAmount','winningAmount','rebateAmount','betPerCountNoOwn','betAmountNoOwn','winningAmountNoOwn','rebateAmountNoOwn','profit','profitNoOwn'];

        $(function() {

            setWebDefaultTime_Z();

            if('${begin}') {

                $('.beginTime').datebox("setValue", '${begin}');

            }

            if('${end}') {

                $('.endTime').datebox("setValue", '${end}');

            }

            var options = {

                url:'agentLotteryReport',

                queryParams : getQueryParams(),

                columns : [ [ {

                    field : 'account',

                    title : '代理账户',

                    formatter : function(value, row) {
                        var	txt ="";
                        if(value!=null){
                            txt= "<span  style=\"color:blue;\" >"+value+"</span>";
                        }
                        return txt;
                    }

                }, {

                    field : 'lotteryName',

                    title : '彩种名称',

                }, {

                    field : 'betPerCount',

                    title : '投注人数'

                }, {

                    field : 'betAmount',

                    title : '投注金额'

                }, {

                    field : 'winningAmount',

                    title : '中奖金额'

                }, {

                    field : 'rebateAmount',

                    title : '返点金额'

                }, {

                    field : 'betPerCountNoOwn',

                    title : '投注人数（不含本人）'

                }, {

                    field : 'betAmountNoOwn',

                    title : '投注金额（不含本人）'

                }, {

                    field : 'winningAmountNoOwn',

                    title : '中奖金额（不含本人）'

                }, {

                    field : 'rebateAmountNoOwn',

                    title : '返点金额（不含本人）'

                }, {

                    field : 'profit',

                    title : '负盈利'

                }, {

                    field : 'profitNoOwn',

                    title : '负盈利（不含本人）'

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

            setLotterySelect();

        });

        function setLotterySelect(){

            $('#ddlLine').combotree({
                valueField: "id", //Value字段
                textField: "text", //Text字段
                multiple: true,
                method: 'get',
                /*data: [
                    { "id": "", "text": "", "children":
                            [
                                { "id": "dfk3", "text": "大順快3" },
                                { "id": "sj1fc", "text": "大順时时彩" },
                                { "id": "pk10", "text": "北京赛车"},
                                { "id": "cqssc", "text": "重庆时时彩"},
                                { "id": "ffpk10", "text": "大順PK10"},
                                { "id": "jsk3", "text": "江苏快3"},
                                { "id": "hbk3", "text": "湖北快3"},
                                { "id": "ahk3", "text": "安徽快3"},
                                { "id": "shk3", "text": "上海快3"},
                                { "id": "gsuk3", "text": "甘肅快3"},
                                { "id": "hebk3", "text": "河北快3"},
                                { "id": "bjk3", "text": "北京快3"},
                                { "id": "gsk3", "text": "广西快3"},
                                { "id": "xjssc", "text": "新疆时时彩"},
                                { "id": "jlk3", "text": "吉林快3"}
                            ]
                    }
                ],*/
                url:'getLotterys', //数据源
                onCheck: function (node, checked) {
                    //让全选不显示
                    $("#ddlLine").combotree("setText", $("#ddlLine").combobox("getText").toString().replace("全选,", ""));
                    //alert('1111---' + node.id);
                    var selectData = $("#ddlLine").combotree("getValues");
                    document.getElementById('lotteryId').value = selectData;
                    //alert(selectData);
                    //debugger;


                },
                onClick: function (node, checked) {
                    //让全选不显示
                    //$("#ddlLine").combotree("setText", $("#ddlLine").combobox("getText").toString().replace("全选,", ""));

                    //alert('2222---' + node.id);

                }

            })


        }



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

        <form id="form" action="agentLotteryReport" method="post">

            <table>

                <tr>

                    <td>用户名：</td>

                    <td> <input type="text" size="10" name="account" value="" /></td>

                    <td>彩种：</td>

                    <td>
                        <input type="hidden" id="lotteryId" name="lotteryId" />
                        <select id="ddlLine" class="easyui-combotree" style="width: 230px; height: 24px;">
                        </select>
                    </td>

                    <td>查询时间：</td>

                    <td><input type="text" class="easyui-datebox beginTime" size="16" name="startDateStr" />~<input type="text" class="easyui-datebox endTime" size="16" name="endDateStr" /></td>

                    <td> <a href="#" plain="true" id="search" class="easyui-linkbutton" icon="icon-search">查询</a></td>

                </tr>

            </table>

        </form>

    </div>

</div>

</body>

</html>