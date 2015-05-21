<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>查看角色</title>
    <%@ include file="../Common/meta.jsp" %>
</head>
<body class="easyui-layout">
<div data-options="region:'north'" border="false">
	<div id="dlg" style="padding:10px 20px">
	   <div class="myftitle">基本信息</div>
	   <form id="myfm" method="post" novalidate>
	       <div class="myfitem">
	           <label>角色名称:</label>
	           <s:property value="tsysrole.name"/>
	       </div>
	       <div class="myfitem">
	           <label>类型:</label>
	           <s:if test="tsysrole.type == 1">
	           	平台角色
	           </s:if>
	           <s:elseif test="tsysrole.type == 2">
	           	企业角色
	           </s:elseif>
	           <s:else>
	           	未定义
	           </s:else>
	       </div>
	       <div class="myfitem">
	           <label>描述:</label>
	           <s:property value="tsysrole.description"/>
	       </div>
	       <div class="myfitem">
	           <label>创建时间:</label>
	           <s:date format="yyyy-MM-dd HH:mm:ss" name="tsysrole.createTime"/>
	       </div>
	       <div class="myfitem">
	           <label>状态:</label>
	            <s:if test="tsysrole.status == 1">
	           		启用
	           </s:if>
	           <s:elseif test="tsysrole.status == 0">
	           		停用
	           </s:elseif>
	           <s:else>
	           		未定义
	           </s:else>
	       </div>
	   </form>
    </div>
	</div>
	<div data-options="region:'center'"border="false">
		<div id="dlg" style="padding:10px 20px">
	   <div class="myftitle">拥有权限</div>
	   <form id="myfm" method="post" novalidate>
	   	   <table cellpadding="10" >
	   	   	<s:if test="maps != null && !maps.isEmpty()">
	   	   		<s:iterator value="maps" var="column">
	   	   			<tr>
	   	   			<td><input type="checkbox" checked="checked" disabled="disabled"><s:property value="#column.key.name"/></input></td>
	   	   			<s:if test="#column.value != null && !#column.value.isEmpty()">
	   	   				<s:iterator value="#column.value">
	   	   					<td><input type="checkbox" checked="checked" disabled="disabled"><s:property value="name"/></input></td>
	   	   				</s:iterator>
	   	   			</s:if>
	   	   			</tr>
	   	   		</s:iterator>
	   	   	</s:if>
	   	   </table>
	   	</form>
    	</div>
	</div>
	<div data-options="region:'south'" style="height: 50px;" border="false">
		<hr>
		<div style="text-align:center;padding:5px">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="top.framework.closeTab('查看角色')">关闭 </a>
    	</div>
	</div>
</body>
</html>
