<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <script type="text/javascript">

        var countFields = ['betPerNum','betAmount','winningAmount','rebateAmount','profit'];

        $(function() {

            setWebDefaultTime();

            if('${begin}') {

                $('.beginTime').datebox("setValue", '${begin}');

            }

            if('${end}') {

                $('.endTime').datebox("setValue", '${end}');

            }

            var options = {

                url:'betReport',

                queryParams : getQueryParams(),

                columns : [ [ {

                    field : 'lotteryName',

                    title : '彩种名称',

                    formatter : function(value, row) {
                        var	txt ="";
                        if(value!=null){
                            txt= "<span  style=\"color:blue;\" >"+value+"</span>";
                        }
                        return txt;
                    }

                }, {

                    field : 'betPerNum',

                    title : '投注人数',

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

                    field : 'profit',

                    title : '盈利',

                    formatter : function(value, row) {

                        var	txt ="";
                        if(value!=null){
                            if(value >= 0){
                                txt = "<span  style=\"color:red;\" >" + value.toFixed(2) + "</span>";
                            }else {
                                txt = "<span  style=\"color:green;\" >" + value.toFixed(2) + "</span>";
                            }
                        }
                        return txt;
                    }

                }, {

                    field : 'earningsRatio',

                    title : '盈率',

                    formatter : function(value, row) {
                        var	txt ="";
                        if(value!=null){
                            txt= value.toFixed(2) + "%" ;
                            if(value >= 0){
                                txt = "<span  style=\"color:red;\" >" + txt + "</span>";
                            }else {
                                txt = "<span  style=\"color:green;\" >" + txt + "</span>";
                            }
                        }
                        return txt;
                    }

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

        <form id="form" action="betReport" method="post">

            <table>

                <tr>

                    <td>彩种：</td>

                    <!--<td>
                        <select id="lotteryId" name="lotteryId" style="width: 120px;">
                            <option value="">----- 全部 -----</option>
                            <option value="dfk3">大順快3</option>
                            <option value="sj1fc">大順时时彩</option>
                            <option value="pk10">北京赛车</option>
                            <option value="cqssc">重庆时时彩</option>
                            <option value="ffpk10">大順PK10</option>
                            <option value="jsk3">江苏快3</option>
                            <option value="hbk3">湖北快3</option>
                            <option value="ahk3">安徽快3</option>
                            <option value="shk3">上海快3</option>
                            <option value="gsuk3">甘肅快3</option>
                            <option value="hebk3">河北快3</option>
                            <option value="bjk3">北京快3</option>
                            <option value="gsk3">广西快3</option>
                            <option value="xjssc">新疆时时彩</option>
                            <option value="jlk3">吉林快3</option>
                        </select>
                    </td>-->

                    <td>
                        <input type="hidden" id="lotteryId" name="lotteryId" />
                        <select id="ddlLine" class="easyui-combotree" style="width: 230px; height: 24px;">
                        </select>
                    </td>

                    <td>排序：</td>
                    <td>
                        <select id="sorting" name="sorting" style="width: 100px;" >
                            <option value="0">投注递减</option>
                            <option value="1">盈利递减</option>
                            <option value="2">盈利递增</option>
                            <option value="3">盈率递减</option>
                            <option value="4">盈率递增</option>
                            <option value="5">中奖递减</option>
                            <option value="6">人数递减</option>
                        </select>
                    </td>

                    <td>查询时间：</td>

                    <td><input type="text" class="easyui-datetimebox beginTime" size="16" name="startDateStr" />~<input type="text" class="easyui-datetimebox endTime" size="16" name="endDateStr" /></td>

                    <td> <a href="#" plain="true" id="search" class="easyui-linkbutton" icon="icon-search">查询</a></td>

                </tr>

            </table>

        </form>

    </div>

</div>

</body>

</html>