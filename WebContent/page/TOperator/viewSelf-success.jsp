<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>查看个人信息</title>
    <%@ include file="../Common/meta.jsp" %>
</head>
<body class="easyui-layout">
<div data-options="region:'center'" border="false">
	<div id="dlg" style="padding:10px 20px">
	   <div class="myftitle">基本信息</div>
	   <form id="myfm" method="post" novalidate>
	       <div class="fitem">
	           <label>登录名称:</label>
	           <s:property value="toperator.loginName"/>
	       </div>
	       <div class="fitem">
	           <label>真实姓名:</label>
	           <s:property value="toperator.realName"/>
	       </div>
	       <div class="fitem">
	           <label>性别:</label>
	           <s:if test="toperator.gender == 1">
	           	男
	           </s:if>
	           <s:else>
	           	女
	           </s:else>
	       </div>
	       <div class="fitem">
	           <label>邮箱:</label>
	           <s:property value="toperator.email"/>
	       </div>
	       <div class="fitem">
	           <label>电话:</label>
	           <s:property value="toperator.phone"/>
	       </div>
	       <div class="fitem">
	           <label>移动手机:</label>
	           <s:property value="toperator.mobile"/>
	       </div>
	       <div class="fitem">
	           <label>传真:</label>
	           <s:property value="toperator.fax"/>
	       </div>
	       <div class="fitem">
	           <label>登录IP:</label>
	           <s:property value="toperator.loginIp"/>
	       </div>
	       <div class="fitem">
	           <label>登录时间:</label>
	           <s:date format="yyyy-MM-dd HH:mm:ss" name="toperator.loginTime"/>
	       </div>
	       <div class="fitem">
	           <label>更新时间:</label>
	           <s:date format="yyyy-MM-dd HH:mm:ss" name="toperator.updateTime"/>
	       </div>
	       <div class="fitem">
	           <label>创建时间:</label>
	           <s:date format="yyyy-MM-dd HH:mm:ss" name="toperator.createTime"/>
	       </div>
	       <div class="fitem">
	           <label>状态:</label>
	           <s:if test="toperator.status==1">
	           	启用
	           </s:if>
	           <s:elseif test="toperator.status==0">
	          	 停用
	           </s:elseif>
	            <s:else>
	           	停用
	           </s:else>
	       </div>
	   </form>
    </div>
	</div>
	<div data-options="region:'south'" style="height: 50px;" border="false">
		<hr>
		<div style="text-align:center;padding:5px">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="top.framework.closeTab('查看个人信息')">关闭 </a>
    	</div>
	</div>
</body>
</html>
