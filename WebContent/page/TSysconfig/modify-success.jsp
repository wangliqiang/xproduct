<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>修改系统配置</title>
    <%@ include file="../Common/meta.jsp" %>
	<script type="text/javascript">
		function submitForm(){
	        $('#myfm').form('submit',{
	            url: '../TSysconfig/update.do',
	            onSubmit: function(){
	                return $(this).form('validate');
	            },
	            success: function(result){
	                var result = eval('('+result+')');
	                if (result.iserror){
	                	Common.showMsg('失败',result.message);
	                } else {
	                	Common.showMsg('成功',result.message);
	                	top.framework.closeAndReloadTab('修改系统配置', '<%=menuName%>');
	                }
	            }
	        });
		}
		
	</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'center'" border="false">
	<div id="dlg" style="padding:10px 20px">
	   <div class="myftitle">基本信息</div>
	   <form id="myfm" method="post" novalidate>
	   <input type="hidden" name="tsysconfig.id" value="<s:property value="tsysconfig.id"/>">
	   	   <input type="hidden" name="tsysconfig.paramCode" value="<s:property value="tsysconfig.paramCode"/>">
	   	   <input type="hidden" name="tsysconfig.createTime" value="<s:property value="tsysconfig.createTime"/>">
	   	   <table cellpadding="5">
                <tr>
                    <td>配置名称:</td>
                    <td><input class="easyui-validatebox textbox" type="text" value="<s:property value="tsysconfig.paramName"/>" name="tsysconfig.paramName" data-options="required:true,validType:'length[3,50]'"></input></td>
                </tr>
                <tr>
                    <td>配置代码:</td>
                    <td><input class="easyui-validatebox textbox" type="text" value="<s:property value="tsysconfig.paramCode"/>" name="tsysconfig.paramCode" disabled="disabled"></input></td>
                </tr>
                <tr>
                    <td>配置值:</td>
                    <td><input class="easyui-validatebox textbox" type="text" value="<s:property value="tsysconfig.paramValue"/>" name="tsysconfig.paramValue" data-options="required:true,validType:'length[3,50]'"></input></td>
                </tr>
                <tr>
                	<td>配置描述:</td>
                    <td colspan="3">
                    <textarea name="tsysconfig.description" style="width:350px;height:60px;" ><s:property value="tsysconfig.description"/></textarea>
                    </td>
                </tr>
            </table>
	   </form>
    </div>
    </div>
    <div data-options="region:'south'" style="height: 50px;" border="false">
    	<hr>
		<div style="text-align:center;padding:5px">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">保存</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="top.framework.closeTab('修改系统配置')">关闭</a>
    	</div>
	</div>
</body>
</html>
