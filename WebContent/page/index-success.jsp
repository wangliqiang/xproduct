<%@ page language="java" import="java.util.*,cn.com.checknull.entity.TOperator" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="Common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>系统管理平台</title>
	<%@ include file="Common/meta.jsp" %>
	<link rel="stylesheet" type="text/css" href="static/css/index.css">
	<script type="text/javascript" src="static/js/index.js"></script>
</head>
<body class="easyui-layout" onunload="javascript:onunload()">
	<!-- <div class="easyui-layout" style="width:1350px;height:680px;"> -->
		<div data-options="region:'north',split:true" border="false" class="l-topmenu" >
			<div class="l-topmenu-l">
				<img class="logo" src="static/css/img/layout/logo.png" alt="系统管理平台"/>
			</div>
			<div class="l-topmenu-r">
				<span>您好,
					<a href="javascript:void(0);" onclick="addTab('查看个人信息','TOperator/viewSelf.do?id=<%=((TOperator) request.getSession().getAttribute("operator")).getId()%>');"><%=((TOperator) request.getSession().getAttribute("operator")).getLoginName()%></a>!</span>|
					<a href="javascript:void(0);" onclick="addTab('修改个人信息','TOperator/modifySelf.do?id=<%=((TOperator) request.getSession().getAttribute("operator")).getId()%>');">设置</a>|
					<a href="javascript:void(0);" onclick="addTab('修改个人密码','TOperator/modifyPassword.do?id=<%=((TOperator) request.getSession().getAttribute("operator")).getId()%>');">密码修改</a>|
					<a href="javascript:void(0);" onclick="Common.switchTheme()" class="l-skin">皮肤</a>|
					<a href="loginOut.do" class="l-exit">注销</a>
			</div>
		</div>
		<div data-options="region:'west',split:true" title="导航菜单" style="width:160px;" >
			<div class="easyui-accordion" data-options="fit:true,border:false">
				<s:if test="tsysmenus != null && !tsysmenus.isEmpty()">
       				<s:iterator value="tsysmenus" id="tsysmenu">
       					<s:if test="#tsysmenu.level == 1">
       						<div title="<s:property value="#tsysmenu.name"/><s:property value="#st.index"/>">
       							<s:iterator value="tsysmenus" id="tsysmenu2">
       								<s:if test="#tsysmenu2.level == 2 && #tsysmenu.id == #tsysmenu2.parentMenu.id && #tsysmenu2.id != #tsysmenu.id">
       									<ul style="margin:0px; padding:0px;">
				              				<li style="line-height:160%;text-decoration:none;list-style-type:none;">
				                      			<a href="javascript:addTab('<s:property value="#tsysmenu2.name"/>', '<s:property value="#tsysmenu2.navigateUrl"/>?menuName=<s:property value="#tsysmenu2.name"/>');" style="cursor:pointer;display:block;text-decoration:none;border-bottom:1px dotted #D8D8D8;padding:3px;padding-left:5px;"><s:property value="#tsysmenu2.name"/></a>
				              				</li>
	          							</ul>
       								</s:if>
       							</s:iterator>
       						</div>	
       					</s:if>
             		</s:iterator>
                </s:if>
                
       			<!-- <div title="设备管理" style="padding:10px">
       				<ul>
           				<li>
               				<div>
                   				<a href="javascript:addTab('设备管理', 'TOperator/list.do');" style="text-decoration: none;">设备管理</a>
                   			</div>
           				</li>
       				</ul>
       				<ul>
           				<li>
               				<div>
                   				<a href="javascript:addTab('用户管理', 'TSysrole/list.do');" style="text-decoration: none;">用户管理</a>
                   			</div>
           				</li>
       				</ul>
       				<ul>
           				<li>
               				<div>
                   				<a href="javascript:addTab('权限管理', 'TSyspriv/list.do');" style="text-decoration: none;">权限管理</a>
                   			</div>
           				</li>
       				</ul>
       				<ul>
           				<li>
               				<div>
                   				<a href="javascript:addTab('菜单管理', 'TSysmenu/list.do');" style="text-decoration: none;">菜单管理</a>
                   			</div>
           				</li>
       				</ul>
       				<ul>
           				<li>
               				<div>
                   				<a href="javascript:addTab('登录日志', 'TLogLogin/list.do');" style="text-decoration: none;">登录日志</a>
                   			</div>
           				</li>
       				</ul>
       				<ul>
           				<li>
               				<div>
                   				<a href="javascript:addTab('操作日志', 'TLogOperate/list.do');" style="text-decoration: none;">操作日志</a>
                   			</div>
           				</li>
       				</ul>
       				<ul>
           				<li>
               				<div>
                   				<a href="javascript:addTab('系统配置', 'TSysconfig/list.do');" style="text-decoration: none;">系统配置</a>
                   			</div>
           				</li>
       				</ul> 
       			</div> -->
   			</div> 
		</div>
		<div data-options="region:'south',split:true" style="height: 30px;">
			<!-- <div style="width: 100%;text-align: center;line-height: 25px;">版权所有：<a href="javascript:void(0)">王立强</a></div>  -->
		</div>
		<div data-options="region:'center'" style="background: #eee;" >
			<div class="easyui-tabs" border="false" id="tabs" fit="true">
				<div title="首页" >
					<iframe frameborder="0" name="mainFrame" id="mainFrame" src="page/welcome-success.jsp" scrolling="no" style="width:1170px;height:470px;"></iframe>
				</div>
 			</div>
		</div>
		<div data-options="region:'east',split:true" style="width:0px;" >
		</div>
		<div id="tabsMenu" class="easyui-menu" >  
 					<div name="close">关闭</div>  
 					<div name="Other">关闭其他</div>  
 					<div name="All">关闭所有</div>
		</div> 
</body>
</html>