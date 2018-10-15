<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
</head>
<body>
	<div class="easyui-panel" fit="true" border="none;">
		<form method="post" action="edit" id="form">
			<input type="hidden" name="lotteryId" value="${lott.id }" />
			<table class="my-table">
				<thead>
					<tr>
						<th width="100">玩法群</th>
						<th width="100">玩法组</th>
						<th width="100">玩法</th>
						<th width="100">销售状态</th>
						<th width="100">手机端</th>
						<th width="500">玩法说明</th>
						<th width="300">玩法举例</th>
					</tr>
				</thead>
				<tbody>
					<c:set var="index" value="0" />
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
									<c:forEach items="${players }" var="p">
										<c:if test="${p.id==player.id }">
											<td>${p.title}</td>
											<td><c:choose>
													<c:when test="${p.saleStatus==0 }">
														<input type="checkbox" name="details[${index }].saleStatus" value="1" />
														<span style="color: green;">销售中</span>
													</c:when>
													<c:otherwise>
														<input type="checkbox" name="details[${index}].saleStatus" value="0" />
														<span style="color: red;">已停售</span>
													</c:otherwise>
												</c:choose>
												<input type="hidden" name="details[${index }].id" value="${p.id }" />
												</td>
											<td>
												<c:choose>
													<c:when test="${p.mobileStatus==0 }">
													
														<input type="checkbox" name="details[${index}].mobileStatus" value="1" />
													<span style="color: green;">显示</span>
													</c:when>
													<c:otherwise>
														<input type="checkbox" name="details[${index}].mobileStatus" value="0" />
														<span style="color: red;">不显示</span>
													</c:otherwise>
												</c:choose>
											</td>
											<td><textarea cols="50" name="details[${index }].remark">${p.remark}</textarea></td>
											<td><textarea cols="50" name="details[${index }].example">${p.example}</textarea></td>
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
				<sjc:auth url="/admin/player/edit"><a class="easyui-linkbutton" href="#" onClick="$('#form').submit();" icon="icon-edit">提交保存</a></sjc:auth>
			</div>
		</form>
	</div>
</body>
</html>