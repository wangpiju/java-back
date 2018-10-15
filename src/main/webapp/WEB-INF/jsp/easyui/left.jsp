<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sjc" uri="http://www.sjc168.com"%>
<sjc:authGroup element="div" elementAttr='title="人员管理"'>
	<sjc:auth url="/admin/rootUser/team"><a class="cs-navi-tab" href="${url}">团队列表</a><br /></sjc:auth>
	<sjc:auth url="/admin/user/index"><a class="cs-navi-tab" href="${url}">用户列表</a><br /></sjc:auth>
	<sjc:auth url="/admin/approval/index"><a class="cs-navi-tab" href="${url}">后台审核</a><br /></sjc:auth>
	<sjc:auth url="/admin/domain/index"><a class="cs-navi-tab" href="${url}">域名管理</a><br /></sjc:auth>
	<sjc:auth url="/admin/extCode/index"><a class="cs-navi-tab" href="${url}">开户连接</a><br /></sjc:auth>
	<sjc:auth url="/admin/userLoginIp/index"><a class="cs-navi-tab" href="${url}">IP反查</a><br /></sjc:auth>
	<sjc:auth url="/admin/bankUserAll/index"><a class="cs-navi-tab" href="${url}">银行卡反查</a><br /></sjc:auth>
	<sjc:auth url="/admin/contractRule/index"><a class="cs-navi-tab" href="${url}">契约管理</a><br /></sjc:auth>
	<sjc:auth url="/admin/contractBonus/index"><a class="cs-navi-tab" href="${url}">契约分红表</a><br /></sjc:auth>
	<sjc:auth url="/admin/contractBadrecord/index"><a class="cs-navi-tab" href="${url}">不良记录表</a><br /></sjc:auth>
	<sjc:auth url="/admin/contractConfig/index"><a class="cs-navi-tab" href="${url}">契约配置</a><br /></sjc:auth>
	<%-- <sjc:auth url="/admin/contractMessage/index"><a class="cs-navi-tab" href="${url}">契约消息</a><br /></sjc:auth> --%>
	<sjc:auth url="/admin/user/dailyRule/index"><a class="cs-navi-tab" href="${url}">日薪参数设定</a><br /></sjc:auth>
	<sjc:auth url="/admin/user/dailyData/index"><a class="cs-navi-tab" href="${url}">契约日薪查询</a><br /></sjc:auth>
	<sjc:auth url="/admin/privateRatioRule/index"><a class="cs-navi-tab" href="${url}">私返配置</a><br /></sjc:auth>
	<sjc:auth url="/admin/privateRatio/index"><a class="cs-navi-tab" href="${url}">私返查询</a><br /></sjc:auth>
	<sjc:auth url="/admin/userDoubleLogin/index"><a class="cs-navi-tab" href="${url}">重复登录配置</a><br /></sjc:auth>
</sjc:authGroup>
<sjc:authGroup element="div" elementAttr='title="代理商管理"'>
	<sjc:auth url="/admin/userAgents/nature/index"><a class="cs-navi-tab" href="${url}">代理商性质配置</a><br /></sjc:auth>
	<sjc:auth url="/admin/userAgents/daily/index"><a class="cs-navi-tab" href="${url}">日工资配置</a><br /></sjc:auth>
	<sjc:auth url="/admin/userAgents/dailyMg/index"><a class="cs-navi-tab" href="${url}">日工资派发</a><br /></sjc:auth>
	<sjc:auth url="/admin/userAgents/dividend/index"><a class="cs-navi-tab" href="${url}">周期分红配置</a><br /></sjc:auth>
	<sjc:auth url="/admin/userAgents/dividendMg/index"><a class="cs-navi-tab" href="${url}">周期分红派发</a><br /></sjc:auth>
	<sjc:auth url="/admin/userAgents/dailyLottery/index"><a class="cs-navi-tab" href="${url}">日工资彩种加奖配置</a><br /></sjc:auth>
	<sjc:auth url="/admin/userAgents/dailyLotteryMg/index"><a class="cs-navi-tab" href="${url}">日工资彩种加奖派发</a><br /></sjc:auth>
	<sjc:auth url="/admin/userAgents/dividendLottery/index"><a class="cs-navi-tab" href="${url}">周期分红彩种加奖配置</a><br /></sjc:auth>
	<sjc:auth url="/admin/userAgents/dividendLotteryMg/index"><a class="cs-navi-tab" href="${url}">周期分红彩种加奖派发</a><br /></sjc:auth>
</sjc:authGroup>
<sjc:authGroup element="div" elementAttr='title="银行管理"'>
	<sjc:auth url="/admin/bankName/index"><a class="cs-navi-tab" href="${url}">银行类型</a><br /></sjc:auth>
	<sjc:auth url="/admin/bankLevel/index"><a class="cs-navi-tab" href="${url}">银行等级</a><br /></sjc:auth>
	<sjc:auth url="/admin/bankGroup/index"><a class="cs-navi-tab" href="${url}">银行卡库</a><br /></sjc:auth>
	<sjc:auth url="/admin/bankSys/index"><a class="cs-navi-tab" href="${url}">银行列表</a><br /></sjc:auth>
	<sjc:auth url="/admin/bankApi/index"><a class="cs-navi-tab" href="${url}">第三方接口</a><br /></sjc:auth>
	<sjc:auth url="/admin/bankAcc/index"><a class="cs-navi-tab" href="${url}">第三方接口白名单</a><br /></sjc:auth>
	<sjc:auth url="/admin/bankApi/proxypay"><a class="cs-navi-tab" href="${url}">代付下发</a><br /></sjc:auth>
	<sjc:auth url="/admin/rechargeWay/index"><a class="cs-navi-tab" href="${url}">支付渠道</a><br /></sjc:auth>
</sjc:authGroup>
<sjc:authGroup element="div" elementAttr='title="彩票管理"'>
	<sjc:auth url="/admin/bonusGroup/index"><a class="cs-navi-tab" href="${url}">奖金组</a><br /></sjc:auth>
	<sjc:auth url="/admin/lotteryGroup/index"><a class="cs-navi-tab" href="${url}">彩票分类</a><br /></sjc:auth>
	<sjc:auth url="/admin/lottsMonitor/index"><a class="cs-navi-tab" href="${url}">开奖监控</a><br /></sjc:auth>
	<sjc:auth url="/admin/lotts/index"><a class="cs-navi-tab" href="${url}">彩票</a><br /></sjc:auth>
	<sjc:auth url="/admin/lotts/lock/index"><a class="cs-navi-tab" href="${url}">封锁表配置</a><br /></sjc:auth>
	<sjc:auth url="/admin/lotts/betChange/index"><a class="cs-navi-tab" href="${url}">改单配置</a><br /></sjc:auth>
	<sjc:auth url="/admin/lotts/betTigerConfig/index"><a class="cs-navi-tab" href="${url}">老虎机配置</a><br /></sjc:auth>
</sjc:authGroup>
<sjc:authGroup element="div" elementAttr='title="自营彩管理"' >
	<sjc:auth url="/admin/risk/bonus/index"><a class="cs-navi-tab" href="${url}">风控报表</a><br /></sjc:auth>
	<sjc:auth url="/admin/risk/bonusConfig/index"><a class="cs-navi-tab" href="${url}">风控设置</a><br /></sjc:auth>
</sjc:authGroup>
<%--
<sjc:authGroup element="div" elementAttr='title="彩中彩管理"'>
	<sjc:auth url="/admin/lotts/betInConfig/index"><a class="cs-navi-tab" href="${url}">彩中彩配置</a><br /></sjc:auth>
	<sjc:auth url="/admin/lotts/betInPrice/betInAll"><a class="cs-navi-tab" href="${url}">彩中彩概率分布</a><br /></sjc:auth>
	<sjc:auth url="/admin/lotts/betInPrice/index"><a class="cs-navi-tab" href="${url}">彩中彩数值区间</a><br /></sjc:auth>
	<sjc:auth url="/admin/lotts/betInRule/index"><a class="cs-navi-tab" href="${url}">彩中彩规则</a><br /></sjc:auth>
	<sjc:auth url="/admin/lotts/betInRuleFirst/index"><a class="cs-navi-tab" href="${url}">彩中彩首玩规则</a><br /></sjc:auth>
	<sjc:auth url="/admin/lotts/betInRuleKill/killIndex"><a class="cs-navi-tab" href="${url}">彩中彩追杀规则</a><br /></sjc:auth>
	<sjc:auth url="/admin/lotts/betInRuleKill/fishIndex"><a class="cs-navi-tab" href="${url}">彩中彩养鱼规则</a><br /></sjc:auth>
	<sjc:auth url="/admin/lotts/betInAmount/index"><a class="cs-navi-tab" href="${url}">彩中彩金额区间</a><br /></sjc:auth>
	<sjc:auth url="/admin/lotts/betInTime/index"><a class="cs-navi-tab" href="${url}">彩中彩时间区间</a><br /></sjc:auth>
	<sjc:auth url="/admin/lotts/betInTotal/index"><a class="cs-navi-tab" href="${url}">彩中彩</a><br /></sjc:auth>
</sjc:authGroup>
--%>
<sjc:authGroup element="div" elementAttr='title="内容管理"'>
	<sjc:auth url="/admin/activity/index"><a class="cs-navi-tab" href="${url}">活动管理</a><br /></sjc:auth>
	<sjc:auth url="/admin/article/articleGroup/index"><a class="cs-navi-tab" href="${url}">文章库管理</a><br /></sjc:auth>
	<sjc:auth url="/admin/article/article/index"><a class="cs-navi-tab" href="${url}">文章管理</a><br /></sjc:auth>
	<sjc:auth url="/admin/article/notice/index"><a class="cs-navi-tab" href="${url}">公告管理</a><br /> </sjc:auth>
	<sjc:auth url="/admin/article/menu/index"><a class="cs-navi-tab" href="${url}">菜单管理</a><br /></sjc:auth>
	<sjc:auth url="/admin/article/message/index"><a class="cs-navi-tab" href="${url}">消息管理</a><br /></sjc:auth>
	<sjc:auth url="/admin/img/index"> <a class="cs-navi-tab" href="${url}">轮番图片管理</a><br /></sjc:auth>
	<sjc:auth url="/admin/imgRegist/index"><a class="cs-navi-tab" href="${url}">注册轮番图片管理</a><br /></sjc:auth>
</sjc:authGroup>
<sjc:authGroup element="div" elementAttr='title="游戏报表"'>
	<sjc:auth url="/admin/report/betIndex"><a class="cs-navi-tab" href="${url}">投注记录</a><br /></sjc:auth>
	<sjc:auth url="/admin/report/traceIndex"><a class="cs-navi-tab" href="${url}">追号记录</a><br /></sjc:auth>
	<sjc:auth url="/admin/report/settlementIndex"><a class="cs-navi-tab" href="${url}">游戏账变</a><br /></sjc:auth>
	<sjc:auth url="/admin/accountChangeType/index"><a class="cs-navi-tab" href="${url}">账变类型管理</a><br /></sjc:auth>
	<sjc:auth url="/admin/report/userState"><a class="cs-navi-tab" href="${url}">网站用户概况</a><br /></sjc:auth>
	<sjc:auth url="/admin/report/zongDaiIndex"><a class="cs-navi-tab" href="${url}">总代开户信息</a><br /></sjc:auth>
	<sjc:auth url="/admin/profitReport/index"><a class="cs-navi-tab" href="${url}">盈亏报表</a><br /></sjc:auth>
	<sjc:auth url="/admin/userReport/index"><a class="cs-navi-tab" href="${url}">个人盈亏报表</a><br /></sjc:auth>
	<sjc:auth url="/admin/teamInReport/index"><a class="cs-navi-tab" href="${url}">彩中彩盈亏报表</a><br /></sjc:auth>
	<sjc:auth url="/admin/saleReport/index"><a class="cs-navi-tab" href="${url}">彩票销售</a><br /></sjc:auth>
	<sjc:auth url="/admin/saleReport/seasonIndex"><a class="cs-navi-tab" href="${url}">每期销售</a><br /></sjc:auth>
	<sjc:auth url="/admin/winLoseRankReport/index"><a class="cs-navi-tab" href="${url}">输赢排行</a><br /></sjc:auth>
	<sjc:auth url="/admin/report/operationReport/index"><a class="cs-navi-tab" href="${url}">运营统计</a><br /></sjc:auth>
	<sjc:auth url="/admin/report/onlineReport/index"><a class="cs-navi-tab" href="${url}">在线用户统计</a><br /></sjc:auth>
</sjc:authGroup>
<sjc:authGroup element="div" elementAttr='title="财务管理 FINANCE"'>
	<sjc:auth url="/admin/finance/recharge/index"><a class="cs-navi-tab" href="${url}">充值申请 DEP APPLICATION</a><br /></sjc:auth>
	<sjc:auth url="/admin/finance/recharge/rechargeRecord"><a class="cs-navi-tab" href="${url}">充值记录</a><br /></sjc:auth>
	<sjc:auth url="/admin/finance/rechargeReport/index"><a class="cs-navi-tab" href="${url}">充值统计</a><br /></sjc:auth>
	<sjc:auth url="/admin/finance/deposit/index"><a class="cs-navi-tab" href="${url}">提款申请</a><br /></sjc:auth>
	<sjc:auth url="/admin/finance/deposit/depositMission"><a class="cs-navi-tab" href="${url}">任务大厅 Mission Hall</a><br /></sjc:auth>
	<sjc:auth url="/admin/finance/deposit/depositAudit"><a class="cs-navi-tab" href="${url}">Operation panel(${user.account })</a><br /></sjc:auth>
	<sjc:auth url="/admin/finance/deposit/depositRecord"><a class="cs-navi-tab" href="${url}">提款记录</a><br /></sjc:auth>
	<sjc:auth url="/admin/finance/financeChange/index"><a class="cs-navi-tab" href="${url}">充提帐变</a><br /></sjc:auth>
	<sjc:auth url="/admin/finance/financeChange/financeChangeAdd"><a class="cs-navi-tab" href="${url}">添加帐变</a><br /></sjc:auth>
	<sjc:auth url="/admin/finance/financeSetting/index"><a class="cs-navi-tab" href="${url}">充提设置</a><br /></sjc:auth>
	<sjc:auth url="/admin/finance/financeSetting/indexStatus"><a class="cs-navi-tab" href="${url}">自动出款开关</a><br /></sjc:auth>
	<sjc:auth url="/admin/finance/financeMission/index"><a class="cs-navi-tab" href="${url}">任务设置</a><br /></sjc:auth>
	<sjc:auth url="/admin/finance/financeWithdraw/index"><a class="cs-navi-tab" href="${url}">自动出款接口</a><br /></sjc:auth>
	<sjc:auth url="/admin/finance/rechargeLower/index"><a class="cs-navi-tab" href="${url}">会员转账</a><br /></sjc:auth>
</sjc:authGroup>
<sjc:authGroup element="div" elementAttr='title="系统管理"'>
	<sjc:auth url="/admin/manager/index"><a class="cs-navi-tab" href="${url}">后台人员</a><br /></sjc:auth>
	<sjc:auth url="/admin/firstMenu/index"><a class="cs-navi-tab" href="${url}">一级菜单</a><br /></sjc:auth>
	<sjc:auth url="/admin/secondMenu/index"><a class="cs-navi-tab" href="${url}">二级菜单</a><br /></sjc:auth>
	<sjc:auth url="/admin/jur/index"><a class="cs-navi-tab" href="${url}">权限管理</a><br /></sjc:auth>
	<sjc:auth url="/admin/role/index"><a class="cs-navi-tab" href="${url}">角色管理</a><br /></sjc:auth>
	<sjc:auth url="/admin/ipWhite/index"><a class="cs-navi-tab" href="${url}">IP白名单</a><br /></sjc:auth>
	<sjc:auth url="/admin/ipBlack/index"><a class="cs-navi-tab" href="${url}">IP黑名单</a><br /></sjc:auth>
	<sjc:auth url="/admin/sysConfig/index"><a class="cs-navi-tab" href="${url}">系统参数</a><br /></sjc:auth>
	<sjc:auth url="/admin/log4j/index"><a class="cs-navi-tab" href="${url}">日志管理</a><br /></sjc:auth>
	<sjc:auth url="/admin/sys/logAll/index"><a class="cs-navi-tab" href="${url}">线程日志管理</a><br /></sjc:auth>
	<sjc:auth url="/admin/sys/sysClear/index"><a class="cs-navi-tab" href="${url}">后台数据清理配置</a><br /></sjc:auth>
	<sjc:auth url="/admin/sys/resettleMail/index"><a class="cs-navi-tab" href="${url}">邮箱配置</a><br /></sjc:auth>
	<sjc:auth url="/admin/managerReport/index"><a class="cs-navi-tab" href="${url}">报表数据管理</a><br /></sjc:auth>
	<sjc:auth url="/admin/sys/sysService/index"><a class="cs-navi-tab" href="${url}">在线客服配置</a><br /></sjc:auth>
</sjc:authGroup>
<sjc:authGroup element="div" elementAttr='title="新报表"'>
	<%--<sjc:auth url="/admin/newReport/cpsReport/index"><a class="cs-navi-tab" href="${url}">综合报表（旧）</a><br /></sjc:auth>--%>
	<sjc:auth url="/admin/newReport/cpsReport/indexNew"><a class="cs-navi-tab" href="${url}">综合报表</a><br /></sjc:auth>
	<%--<sjc:auth url="/admin/newReport/membershipReport/index"><a class="cs-navi-tab" href="${url}">会员报表（旧）</a><br /></sjc:auth>--%>
	<sjc:auth url="/admin/newReport/membershipReport/indexNew"><a class="cs-navi-tab" href="${url}">会员报表</a><br /></sjc:auth>
	<sjc:auth url="/admin/newReport/firstChargeReport/index"><a class="cs-navi-tab" href="${url}">首充报表</a><br /></sjc:auth>
	<sjc:auth url="/admin/newReport/agentsReport/index"><a class="cs-navi-tab" href="${url}">代理报表</a><br /></sjc:auth>
	<sjc:auth url="/admin/newReport/betReport/index"><a class="cs-navi-tab" href="${url}">彩种报表</a><br /></sjc:auth>
	<sjc:auth url="/admin/newReport/agentLotteryReport/index"><a class="cs-navi-tab" href="${url}">代理彩种报表</a><br /></sjc:auth>
	<sjc:auth url="/admin/newReport/cwbrReport/index"><a class="cs-navi-tab" href="${url}">用户可提现余额报表</a><br /></sjc:auth>
</sjc:authGroup>