$.extend($.fn.datagrid.methods, {

    autoMergeCells : function (jq, fields) {

        return jq.each(function () {

            var target = $(this);

            if (!fields) {

                fields = target.datagrid("getColumnFields");

            }

            var rows = target.datagrid("getRows");

            var i = 0,

                j = 0,

                temp = {};

            for (i; i < rows.length; i++) {

                var row = rows[i];

                j = 0;

                for (j; j < fields.length; j++) {

                    var field = fields[j];

                    var tf = temp[field];

                    if (!tf) {

                        tf = temp[field] = {};

                        tf[row[field]] = [i];

                    } else {

                        var tfv = tf[row[field]];

                        if (tfv) {

                            tfv.push(i);

                        } else {

                            tfv = tf[row[field]] = [i];

                        }

                    }

                }

            }

            $.each(temp, function (field, colunm) {

                $.each(colunm, function () {

                    var group = this;



                    if (group.length > 1) {

                        var before,

                            after,

                            megerIndex = group[0];

                        for (var i = 0; i < group.length; i++) {

                            before = group[i];

                            after = group[i + 1];

                            if (after && (after - before) == 1) {

                                continue;

                            }

                            var rowspan = before - megerIndex + 1;

                            if (rowspan > 1) {

                                target.datagrid('mergeCells', {

                                    index : megerIndex,

                                    field : field,

                                    rowspan : rowspan

                                });

                            }

                            if (after && (after - before) != 1) {

                                megerIndex = after;

                            }

                        }

                    }

                });

            });

        });

    }

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

//		pageSize : 25,

//		pageList:[25,50,100,200],

//		pagination : true,

//		rownumbers : true,

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

            $(this).datagrid("autoMergeCells");



        },

        toolbar : '#tb'

    };



    settings = jQuery.extend(settings, options);

    return $(grid).datagrid(settings);

}