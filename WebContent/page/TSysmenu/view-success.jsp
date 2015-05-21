<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>查看菜单</title>
    <%@ include file="../Common/meta.jsp" %>
</head>
<body class="easyui-layout">
<div data-options="region:'center'" border="false">
	<div id="dlg" style="padding:10px 20px">
	   <div class="myftitle">基本信息</div>
	   <form id="myfm" method="post" novalidate>
	       <div class="myfitem">
	           <label>菜单名称:</label>
	           <s:property value="tsysmenu.name"/>
	       </div>
	       <div class="myfitem">
	           <label>菜单代码:</label>
	           <s:property value="tsysmenu.code"/>
	       </div>
	       <div class="myfitem">
	           <label>导航地址:</label>
	           <s:property value="tsysmenu.navigateUrl"/>
	       </div>
	        <div class="myfitem">
	           <label>菜单等级:</label>
	           <s:if test="tsysmenu.level == 1">
	           		一级
	           </s:if>
	           <s:elseif test="tsysmenu.level == 2">
	           		二级
	           </s:elseif>
	           <s:else>
	           		未定义
	           </s:else>
	       </div>
	       <div class="myfitem">
	           <label>父级菜单:</label>
	           <s:if test="tsysmenu.parentMenu != null">
	           		<s:property value="tsysmenu.parentMenu.name"/>
	           </s:if>
	           <s:else>
	           		无
	           </s:else>
	       </div>
	       <div class="myfitem">
	           <label>创建时间:</label>
	           <s:date format="yyyy-MM-dd HH:mm:ss" name="tsysmenu.createTime"/>
	       </div>
	       <div class="myfitem">
	           <label>序列号:</label>
	           <s:property value="tsysmenu.sequence"/>
	       </div>
	       <div class="myfitem">
	           <label>状态:</label>
	            <s:if test="tsysmenu.status == 1">
	           		启用
	           </s:if>
	           <s:elseif test="tsysmenu.status == 0">
	           		停用
	           </s:elseif>
	           <s:else>
	           		未定义
	           </s:else>
	       </div>
	   </form>
	   
	   
	  <s:if test="tsysmenus != null && !tsysmenus.isEmpty()">
   	   	<div class="myftitle">二级菜单</div>
   		<form id="myfm" method="post" novalidate>
	   	   	<s:iterator value="tsysmenus" var="tmp">
	   	   		<div class="myfitem">
		           <label>菜单名称:</label>
		           <s:property value="#tmp.name"/>
	       		</div>
	   	   	</s:iterator>
   	   	</form>
	  </s:if>
	  
    </div>
	</div>
	
	<div data-options="region:'south'" style="height: 50px;" border="false">
		<hr>
		<div style="text-align:center;padding:5px">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="top.framework.closeTab('查看菜单')">关闭 </a>
    	</div>
	</div>
</body>
</html>
