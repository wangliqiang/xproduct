<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>查看登录日志</title>
    <%@ include file="../Common/meta.jsp" %>
</head>
<body class="easyui-layout">
<div data-options="region:'center'" border="false">
	<div id="dlg" style="padding:10px 20px">
	   <div class="myftitle">基本信息</div>
	   <form id="myfm" method="post" novalidate>
	       <div class="fitem">
	           <label>登录名称:</label>
	           <s:property value="tlogLogin.loginName"/>
	       </div>
	       <div class="fitem">
	           <label>真实姓名:</label>
	           <s:property value="tlogLogin.operatorName"/>
	       </div>
	       <div class="fitem">
	           <label>类型:</label>
	           <s:if test="tlogLogin.type == 1">登录</s:if>
	           <s:elseif test="tlogLogin.type == 2">注销</s:elseif>
	           <s:else>未定义</s:else>
	       </div>
	       <div class="fitem">
	           <label>结果</label>
	           <s:if test="tlogLogin.result == 1">成功</s:if>
	           <s:elseif test="tlogLogin.result == 0">失败</s:elseif>
	           <s:else>未定义</s:else>
	       </div>
	       <div class="fitem">
	           <label>时间:</label>
	           <s:date format="yyyy-MM-dd HH:mm:ss" name="tlogLogin.time"/>
	       </div>
	       <div class="fitem">
	           <label>IP地址:</label>
	           <s:property value="tlogLogin.loginIp"/>
	       </div>
	       <div class="fitem">
	           <label>描述:</label>
	           <s:property value="tlogLogin.description"/>
	       </div>
	   </form>
	   
    </div>
	</div>
	
	<div data-options="region:'south'" style="height: 50px;" border="false">
		<hr>
		<div style="text-align:center;padding:5px">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="top.framework.closeTab('查看登录日志')">关闭 </a>
    	</div>
	</div>
</body>
</html>
