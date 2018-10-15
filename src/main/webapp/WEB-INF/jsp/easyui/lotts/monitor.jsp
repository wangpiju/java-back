<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript" src="<c:url value='/res/admin/js/audio/audio5.min.js'/>"></script>
<script type="text/javascript">
var json = ${json};

var suspend = true;
var timer = null;



function getQueryParams() {
	var p={};
	p['ignore'] = $('#ignore').combobox('getValues').join(",");
	$.each($("#form").serializeArray(),function(){  
        p[this.name]=this.value;  
    });
	
	return p;
}

function refreshTime(t) {
	if(timer) {
		clearInterval(timer);
	}
	if (t > 0) {
		timer = setInterval(function() {
			$("#search").click();
		}, t);
	}
}

var audio5js = new Audio5js({
	swf_path: '<c:url value="/res/admin/js/audio/audio5js.swf"/>',
	ready: function () {
		this.load('<c:url value="/res/admin/alarm/weikaijiang.wav"/>');
		//this.play();
		//playing
		//pause
	}
});

$(function() {
	var options = {
		singleSelect:true,
		url:'list',
		pagination : false,
		onLoadSuccess : function (pageData) {
			if(pageData.total>0) {
				audio5js.play();//播放声音
			}
		},
		columns : [ [ {
			field : 'lotteryId',
			title : '异常彩种',
			formatter:function(value,row) {
				for(var j in json) {
					var d = json[j];
					if(d.id == value) {
						return d.title;
					}
				}
				return value;
			}
		}] ]
	};

	$('#begin').datetimebox('setValue' , new Date().addHour(-4).format("yyyy-MM-dd 00:00:00"));
	$("#search").click(function(){
		$("#grid").datagrid("options").queryParams = getQueryParams();
		reloadGrid("#grid");
	});
	refreshTime(60000);
	createGrid('#grid',options);
});
</script>
</head>
<body>
	<div id="grid"></div>
	<div id="tb">
		<form id="form">
		开始时间:<input type="text" class="easyui-datetimebox" id="begin" name="begin" size="20"/>
		
		忽略监控：<select multiple="multiple" class="easyui-combobox" id="ignore">
			<c:forEach items="${lotterys }" var="a">
				<option value="${a.id }">${a.title }</option>
			</c:forEach>
        </select>
        
                         自动刷新：<select onchange="refreshTime(this.value);">
         		<option value="0">暂停</option>
         		<option value="15000">15秒</option>
               <option value="30000">30秒</option>
			<option value="45000">45秒</option>
			<option value="60000" selected="selected">60秒</option>
        </select>
		<a href="#" plain="true" id="search" class="easyui-linkbutton" icon="icon-search">查询</a>
		</form>
	</div>
</body>
</html>