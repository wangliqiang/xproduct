<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>查看权限</title>
    <%@ include file="../Common/meta.jsp" %>
</head>
<body class="easyui-layout">
<div data-options="region:'center'" border="false">
	<div id="dlg" style="padding:10px 20px">
	   <div class="myftitle">基本信息</div>
	   <form id="myfm" method="post" novalidate>
	   	   <div class="myfitem">
	           <label>所属菜单:</label>
	           <s:property value="tsyspriv.menu.name"/>
	       </div>
	       <div class="myfitem">
	           <label>权限名称:</label>
	           <s:property value="tsyspriv.name"/>
	       </div>
	       <div class="myfitem">
	           <label>权限代码:</label>
	           <s:property value="tsyspriv.code"/>
	       </div>
	       <div class="myfitem">
	           <label>图标样式:</label>
	           <s:property value="tsyspriv.iconCls"/>
	       </div>
	       <div class="myfitem">
	           <label>方法名称:</label>
	           <s:property value="tsyspriv.method"/>
	       </div>
	       <div class="myfitem">
	           <label>创建时间:</label>
	           <s:date format="yyyy-MM-dd HH:mm:ss" name="tsyspriv.createTime"/>
	       </div>
	       <div class="myfitem">
	           <label>序列号:</label>
	           <s:property value="tsyspriv.sequence"/>
	       </div>
	       <div class="myfitem">
	           <label>状态:</label>
	            <s:if test="tsyspriv.status == 1">
	           		启用
	           </s:if>
	           <s:elseif test="tsyspriv.status == 0">
	           		停用
	           </s:elseif>
	           <s:else>
	           		未定义
	           </s:else>
	       </div>
	   </form>
    </div>
	</div>
	
	<div data-options="region:'south'" style="height: 50px;" border="false">
		<hr>
		<div style="text-align:center;padding:5px">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="top.framework.closeTab('查看权限')">关闭 </a>
    	</div>
	</div>
</body>
</html>
