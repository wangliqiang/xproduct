<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>查看操作日志</title>
    <%@ include file="../Common/meta.jsp" %>
</head>
<body class="easyui-layout">
<div data-options="region:'center'" border="false">
	<div id="dlg" style="padding:10px 20px">
	   <div class="myftitle">基本信息</div>
	   <form id="myfm" method="post" novalidate>
	       <div class="fitem">
	           <label>登录名称:</label>
	           <s:property value="tlogOperate.loginName"/>
	       </div>
	       <div class="fitem">
	           <label>真实姓名:</label>
	           <s:property value="tlogOperate.operatorName"/>
	       </div>
	       <div class="fitem">
	           <label>操作对象:</label>
	           <s:property value="tlogOperate.operateObject"/>
	       </div>
	       <div class="fitem">
	           <label>操作值:</label>
	           <s:property value="tlogOperate.operateValue"/>
	       </div>
	       <div class="fitem">
	           <label>操作类型:</label>
	           <s:property value="tlogOperate.operateType"/>
	       </div>
	       <div class="fitem">
	           <label>操作结果:</label>
	           <s:if test="tlogOperate.operateResult == 1">
	           	成功
	           </s:if>
	           <s:elseif test="tlogOperate.operateResult == 0">
	          	 失败
	           </s:elseif>
	           <s:else>
	           	<s:property value="tlogOperate.operateResult"/>
	           </s:else>
	           
	       </div>
	       <div class="fitem">
	           <label>操作时间:</label>
	           <s:date format="yyyy-MM-dd HH:mm:ss" name="tlogOperate.operateTime"/>
	       </div>
	   </form>
	   
    </div>
	</div>
	
	<div data-options="region:'south'" style="height: 50px;" border="false">
		<hr>
		<div style="text-align:center;padding:5px">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="top.framework.closeTab('查看操作日志')">关闭 </a>
    	</div>
	</div>
</body>
</html>
