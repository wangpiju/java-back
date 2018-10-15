<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${p!=null }">
<div class="pager">
	<a href="?${p.params }1">首页</a> &nbsp;&nbsp; 
	<a href="?${p.params }${p.prev }">上页</a>&nbsp;&nbsp; 
	<a href="?${p.params }${p.next }">下页</a>&nbsp;&nbsp; 
	<a href="?${p.params }${p.pageCount }">尾页</a> 
	<a class="pagedump" href="#" data-href="?${p.params }" onClick="dumpPage(this)">跳至</a><input id="dumpInput" value="1" class="pagedump" />
	<span>${p.nowPage }/${p.pageCount } 页</span>
</div>
</c:if>