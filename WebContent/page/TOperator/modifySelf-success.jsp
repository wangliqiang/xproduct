<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>修改个人信息</title>
    <%@ include file="../Common/meta.jsp" %>
	<script type="text/javascript">
	
	function submitForm(){
        $('#myfm').form('submit',{
            url: '../TOperator/update.do',
            onSubmit: function(){
                return $(this).form('validate');
            },
            success: function(result){
                var result = eval('('+result+')');
                if (result.iserror){
                	Common.showMsg('失败',result.message);
                } else {
                	Common.showMsg('成功',result.message);
                	top.framework.closeTab('修改个人信息');
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
	   	   <input type="hidden" name="toperator.id" value="<s:property value="toperator.id"/>">
	   	   <input type="hidden" name="toperator.password" value="<s:property value="toperator.password"/>">
	   	   <input type="hidden" name="toperator.updateTime" value="<s:property value="toperator.updateTime"/>">
	   	   <input type="hidden" name="toperator.loginTime" value="<s:property value="toperator.loginTime"/>">
	   	   <input type="hidden" name="toperator.createTime" value="<s:property value="toperator.createTime"/>">
	   	   <input type="hidden" name="toperator.loginIp" value="<s:property value="toperator.loginIp"/>">
	   	   <input type="hidden" name="toperator.isPlatoperator" value="<s:property value="toperator.isPlatoperator"/>">
	   	   <input type="hidden" name="toperator.msn" value="<s:property value="toperator.msn"/>">
	   	   <input type="hidden" name="toperator.qq" value="<s:property value="toperator.qq"/>">
	   	   <input type="hidden" name="toperator.loginName" value="<s:property value="toperator.loginName"/>">
	   	   <input type="hidden" name="toperator.cpCode" value="<s:property value="toperator.cpCode"/>">
	   	   <table cellpadding="5">
                <tr>
                    <td>登录名称:</td>
                    <td><input class="easyui-validatebox textbox" type="text" value="<s:property value="toperator.loginName"/>" name="toperator.loginName" data-options="required:true,validType:'length[1,20]'" disabled="disabled"></input></td>
                </tr>
                <tr>
                    <td>真实姓名:</td>
                    <td><input class="easyui-validatebox" type="text" value="<s:property value="toperator.realName"/>" name="toperator.realName" data-options="required:true,validType:'length[1,20]'"></input></td>
                </tr>
                <tr>
                    <td>状态:</td>
                    <td>
                        <select class="easyui-combobox" name="toperator.gender" data-options="required:true,editable:false">
	           				<s:if test="toperator.gender == 1">
	           					<option value="1" selected="selected">男</option>
	           				</s:if>
	           				<s:else>
	           					<option value="1">男</option>
	           				</s:else>
	           				<s:if test="toperator.gender == 0">
	           					<option value="0" selected="selected">女</option>
	           				</s:if>
	           				<s:else>
	           					<option value="0">女</option>
	           				</s:else>
	           				
	           			</select>
                    </td>
                </tr>
                <tr>
                    <td>邮箱:</td>
                    <td><input class="easyui-validatebox" type="text" value="<s:property value="toperator.email"/>" name="toperator.email" data-options="validType:'email'"></input></td>
                </tr>
                <tr>
                    <td>电话:</td>
                    <td><input class="easyui-validatebox" type="text" value="<s:property value="toperator.phone"/>" name="toperator.phone"></input></td>
                </tr>
                <tr>
                    <td>移动手机:</td>
                    <td><input class="easyui-validatebox" type="text" value="<s:property value="toperator.mobile"/>" name="toperator.mobile"></input></td>
                </tr>
                <tr>
                    <td>传真:</td>
                    <td><input class="easyui-validatebox" type="text" value="<s:property value="toperator.fax"/>" name="toperator.fax"></input></td>
                </tr>
                <tr>
                    <td>状态:</td>
                    <td>
                        <select class="easyui-combobox" name="toperator.status" data-options="required:true,editable:false">
	           				<s:if test="toperator.status == 1">
	           					<option value="1" selected="selected">启用</option>
	           				</s:if>
	           				<s:else>
	           					<option value="1">启用</option>
	           				</s:else>
	           				<s:if test="toperator.status == 0">
	           					<option value="0" selected="selected">停用</option>
	           				</s:if>
	           				<s:else>
	           					<option value="0">停用</option>
	           				</s:else>
	           				
	           			</select>
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
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="top.framework.closeTab('修改个人信息')">关闭</a>
    	</div>
	</div>
</body>
</html>