<%@ tag pageEncoding="UTF-8" description="显示分页" %>
<%@ attribute name="formId" type="java.lang.String"  required="true" description="表单ID" %>
<%@ attribute name="btnId"  type="java.lang.String"  required="true"  description="提交按钮ID" %>
<%@ attribute name="rows"   type="java.lang.Integer" required="false" description="每页显示条数" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="pagination">
	<div class="page-l">
	<span>每页</span>
		<select class="labelCond" id="pageShowNum_${formId }" name="pageShowNum" onchange="hs.pagination.reloadPage(1, this.value, '${formId }', '${btnId }');">
            <option value="10" <c:if test="${rows == 10 }">selected="selected"</c:if> >10条</option>
            <option value="25" <c:if test="${rows == null || rows == 25 }">selected="selected"</c:if> >25条</option>
            <option value="50" <c:if test="${rows == 50 }">selected="selected"</c:if> >50条</option>
        </select>
		<span>共<span id="pageRowSpan_${formId }">0</span>条 </span><span>第<span id="pageCurrSpan_${formId }">0</span>/</span><span id="pageTotalSpan_${formId }">0</span><span>页</span>
	</div>
	<div class="page-r">
		<div class="page-home">
			<a id="pageHome_${formId }" href="javascript:void(0);" class="homePage">首页</a>
		</div>
		<div class="page-prev">
			<a id="pagePrev_${formId }" href="javascript:void(0);" class="pagePrevious">上一页</a>
		</div>
		<div class="page-list">
			<ul id="pageList_${formId }"></ul>
		</div>
		<div class="page-next">
			<a id="pageNext_${formId }" href="javascript:void(0);" class="pageNext">下一页</a>
		</div>
		<div class="page-end">
			<a id="pageEnd_${formId }" href="javascript:void(0);" class="endPage">尾页</a>
		</div>
	</div>
</div>
<script type="text/javascript">
$(function() {
	$("#${formId }").prepend("<input type='hidden' id='pageSize_${formId }' name='rows' value='${rows == null ? '25' : rows }' /><input type='hidden' id='pageCurr_${formId }' name='page' value='1' /><input type='hidden' id='pageBtnId_${formId }' value='${btnId }' />");
});
</script>