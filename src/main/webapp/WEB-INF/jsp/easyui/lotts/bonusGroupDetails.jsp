<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	$(function() {
		$('.formSubmit').click(function() {
			if ($(this).linkbutton('options').disabled == true)
				return;
			$(this).linkbutton("disable");
			$(this).parents("form").form('submit', {
				url : 'edit',
				success : function(rel) {
					try {
						eval('var rel=' + rel);
					} catch (e) {
					}
					if (rel.status == 200) {
						$.messager.alert('提示', rel.content, 'success');
					} else {
						$.messager.alert('错误', rel.content, 'error');
					}
					$('.formSubmit').linkbutton("enable");
				}
			});
		});
	});
</script>
</head>
<body>
	<div class="easyui-panel" fit="true" border="none;">
		<div class="easyui-tabs" data-options="border:false">
			<c:forEach items="${bonusGroups }" var="bonusGroup">
				<div title="${bonusGroup.title }">
					<form method="post" action="edit">
						<input type="hidden" name="bonusGroupId" value="${bonusGroup.id }" /> <input type="hidden" name="lotteryId" value="${lott.id }" />
						<c:set var="index" value="0" />
						<table class="my-table">
							<thead>
								<tr>
									<th width="100">玩法群</th>
									<th width="100">玩法组</th>
									<th width="100">玩法</th>
									<th width="100">理论奖金</th>
									<th width="100">固定返奖率</th>
									<th width="100">返点</th>
									<th width="100">留水</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${tree.qun }" var="qun">
									<c:forEach items="${qun.groups }" var="group" varStatus="groupStatus">
										<c:forEach items="${group.players }" var="player" varStatus="status">
											<tr>
												<c:if test="${groupStatus.first && status.first}">
													<td rowspan="${qun.playerCount }">${qun.title }</td>
												</c:if>
												<c:if test="${status.first }">
													<td rowspan="${group.playerCount }">${group.title }</td>
												</c:if>
												<c:forEach items="${detail }" var="p">
													<c:if test="${p.id==player.id && p.bonusGroupId==bonusGroup.id}">
														<td>${player.title}</td>
														<td>${p.bonus}<input type="hidden" name="details[${index}].id" value="${p.id}" /></td>
														<td><input type="text" size="5" name="details[${index}].bonusRatio" value="${p.bonusRatio}" />%</td>
														<td><input type="text" size="5" name="details[${index}].rebateRatio" value="${p.rebateRatio}" />%</td>
														<td><span class="companyRatio">${100 - p.bonusRatio - p.rebateRatio }</span>%</td>
														<c:set var="index" value="${index+1 }" />
													</c:if>
												</c:forEach>
											</tr>
										</c:forEach>
									</c:forEach>
								</c:forEach>
							</tbody>
						</table>
						<div style="text-align: center; padding: 5px;">
							<sjc:auth url="/admin/bonusGroupDetails/edit"><a href="#" class="easyui-linkbutton formSubmit" icon="icon-edit">提交保存</a></sjc:auth>
						</div>
					</form>
				</div>
			</c:forEach>
		</div>
	</div>
</body>
</html>