<%@page contentType="text/html" pageEncoding="UTF-8"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><%@ taglib prefix="sjc" uri="http://www.sjc168.com"%><html xmlns="http://www.w3.org/1999/xhtml"><head><script type="text/javascript">	$(function() {		var options = {			columns : [ [ {				field : 'account',				title : '账户',                formatter : function(value, row) {					var	txt ="";					if(value!=null){						txt= "<span  style=\"color:blue;\" >" + value + "</span>";					}					return txt;                }			}, {				field : 'parentAccount',				title : '上级'			}, {				field : 'isA',				title : '是否A类代理',                formatter : function(value, row) {                    if (value == 1) {                        var	txt ="";                        if(value!=null){                            txt= "<span  style=\"color:red;\" >是</span>";                        }                        return txt;                    } else if (value == 0) {                        return '不是';                    } else {                        return value;                    }                }			}, {				field : 'isDaily',				title : '是否日工资',                formatter : function(value, row) {                    if (value == 1) {                        var	txt ="";                        if(value!=null){                            txt= "<span  style=\"color:red;\" >是</span>";                        }                        return txt;                    } else if (value == 0) {                        return '不是';                    } else {                        return value;                    }                }			}, {                field : 'isDividend',                title : '是否周期分红',                formatter : function(value, row) {                    if (value == 1) {                        var	txt ="";                        if(value!=null){                            txt= "<span  style=\"color:red;\" >是</span>";                        }                        return txt;                    } else if (value == 0) {                        return '不是';                    } else {                        return value;                    }                }            }, {                field : 'isDailyLottery',                title : '是否日工资彩种加奖',                formatter : function(value, row) {                    if (value == 1) {                        var	txt ="";                        if(value!=null){                            txt= "<span  style=\"color:red;\" >是</span>";                        }                        return txt;                    } else if (value == 0) {                        return '不是';                    } else {                        return value;                    }                }            }, {                field : 'isDividendLottery',                title : '是否周期分红彩种加奖',                formatter : function(value, row) {                    if (value == 1) {                        var	txt ="";                        if(value!=null){                            txt= "<span  style=\"color:red;\" >是</span>";                        }                        return txt;                    } else if (value == 0) {                        return '不是';                    } else {                        return value;                    }                }            }, {                field : 'modifyTime',                title : '修改时间'            }, {				field : 'operator',				title : '操作员'			},{				field : 'other',				title : '操作',				formatter : function(value, row) {					var win ="'#win'";					var url = "'edit'";					var dat = "'edit?account=" + row.account +"'";					var txt = '<sjc:auth url="/admin/userAgents/nature/edit"><a href="#" onClick="showWin('+ win +',' +url+ ','+ dat +')">编辑</a></sjc:auth>&nbsp;&nbsp;';					return txt;				}			}] ],            queryParams : getQueryParams()		};		createGrid('#grid',options);		createWin('#win');        $("#search").click(function(){            $("#grid").datagrid("options").queryParams = getQueryParams();            reloadGrid("#grid");        });    });    function getQueryParams() {        var p={};        $.each($("#queryForm").serializeArray(),function(){            p[this.name]=this.value;        });        return p;    }</script></head><body>	<div id="grid"></div>	<div id="tb">		<form id="queryForm" action="list" method="post">			<table>				<tr>					<td>账户：</td>					<td><input type="text" size="10" name="q_account" /></td>					<td>上级：</td>					<td><input type="text" size="10" name="q_parentAccount" /></td>					<td>是否A类代理：</td>					<td>						<select name="q_isA">							<option value="">全部</option>							<option value="0">否</option>							<option value="1">是</option>						</select>					</td>					<td>是否日工资：</td>					<td>						<select name="q_isDaily">							<option value="">全部</option>							<option value="0">否</option>							<option value="1">是</option>						</select>					</td>					<td>是否周期分红：</td>					<td>						<select name="q_isDividend">							<option value="">全部</option>							<option value="0">否</option>							<option value="1">是</option>						</select>					</td>					<td>是否日工资彩种加奖：</td>					<td>						<select name="q_isDailyLottery">							<option value="">全部</option>							<option value="0">否</option>							<option value="1">是</option>						</select>					</td>					<td>是否周期分红彩种加奖：</td>					<td>						<select name="q_isDividendLottery">							<option value="">全部</option>							<option value="0">否</option>							<option value="1">是</option>						</select>					</td>					<td><a href="#" plain="true" id="search" class="easyui-linkbutton" icon="icon-search">查询</a></td>				</tr>			</table>		</form>	<div id="win">		<form method="post" style="margin: 20px;" method="post">			<input type="hidden" name="id" />			<table class="formtable">				<tr>					<td class="input-title">账户</td>					<td><input type="text" name="account" /></td>				</tr>				<tr>					<td class="input-title">上级</td>					<td><input type="text" name="parentAccount" /></td>				</tr>				<tr>					<td class="input-title">是否A类代理</td>					<td><select name="isA">						<option value="0">否</option>						<option value="1">是</option>					</select></td>				</tr>				<tr>					<td class="input-title">是否日工资</td>					<td><select name="isDaily">						<option value="0">否</option>						<option value="1">是</option>					</select></td>				</tr>				<tr>					<td class="input-title">是否周期分红</td>					<td><select name="isDividend">						<option value="0">否</option>						<option value="1">是</option>					</select></td>				</tr>				<tr>					<td class="input-title">是否日工资彩种加奖</td>					<td><select name="isDailyLottery">						<option value="0">否</option>						<option value="1">是</option>					</select></td>				</tr>				<tr>					<td class="input-title">是否周期分红彩种加奖</td>					<td><select name="isDividendLottery">						<option value="0">否</option>						<option value="1">是</option>					</select></td>				</tr>			</table>			<div style="text-align: center; padding: 5px;">				<a href="#" class="btn-save" icon="icon-save" onClick="saveData(this, function(rel){ closeWin('#win','#grid')})">保存</a>				<a href="#" class="btn-cancel" icon="icon-cancel" onClick="closeWin('#win')">取消</a>			</div>		</form>	</div></body></html>