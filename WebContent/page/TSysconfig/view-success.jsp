<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>查看系统配置</title>
    <%@ include file="../Common/meta.jsp" %>
</head>
<body class="easyui-layout">
<div data-options="region:'center'" border="false">
	<div id="dlg" style="padding:10px 20px">
	   <div class="myftitle">基本信息</div>
	   <form id="myfm" method="post" novalidate>
	       <div class="fitem">
	           <label>配置名称:</label>
	           <s:property value="tsysconfig.paramName"/>
	       </div>
	       <div class="fitem">
	           <label>配置代码:</label>
	           <s:property value="tsysconfig.paramCode"/>
	       </div>
	       <div class="fitem">
	           <label>配置值:</label>
	           <s:property value="tsysconfig.paramValue"/>
	       </div>
	       <div class="fitem">
	           <label>创建时间:</label>
	           <s:date format="yyyy-MM-dd HH:mm:ss" name="tsysconfig.createTime"/>
	       </div>
	       <div class="fitem">
	           <label>配置描述:</label>
	           <s:property value="tsysconfig.description"/>
	       </div>
	   </form>
	   
    </div>
	</div>
	
	<div data-options="region:'south'" style="height: 50px;" border="false">
		<hr>
		<div style="text-align:center;padding:5px">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="top.framework.closeTab('查看系统配置')">关闭 </a>
    	</div>
	</div>
</body>
</html>
