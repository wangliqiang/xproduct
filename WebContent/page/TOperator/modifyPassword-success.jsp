<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>修改个人密码</title>
    <%@ include file="../Common/meta.jsp" %>
	<script type="text/javascript">
	
	function submitForm(){
        $('#myfm').form('submit',{
            url: '../TOperator/updatePassword.do',
            onSubmit: function(){
            	if ($(this).form('validate')){
            		var password = $("#password").val();
            		var newPassword = $("#newPassword").val();
            		var newPasswordRepeat = $("#newPasswordRepeat").val();
            		if (password == newPassword){
            			Common.showMsg('失败','新旧密码相同');
            			return false;
            		}
            		if (newPassword != newPasswordRepeat){
            			Common.showMsg('失败','两次输入的新密码不一致');
            			return false;
            		}
            		return true;
            	}else{
            		return false;
            	}
            },
            success: function(result){
                var result = eval('('+result+')');
                if (result.iserror){
                	Common.showMsg('失败',result.message);
                } else {
                	Common.showMsg('成功',result.message);
                	top.framework.closeTab('修改个人密码');
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
	   	   <input type="hidden" name="id" value="<s:property value="id"/>">
	   	   <table cellpadding="5">
                <tr>
                    <td>旧密码:</td>
                    <td><input id="password" class="easyui-validatebox textbox" type="password" name="password" data-options="required:true,validType:'length[6,32]'"></input></td>
                </tr>
                <tr>
                    <td>新密码:</td>
                    <td><input id="newPassword" class="easyui-validatebox textbox" type="password" name="newPassword" data-options="required:true,validType:'length[6,32]'"></input></td>
                </tr>
                <tr>
                    <td>重复:</td>
                    <td><input id="newPasswordRepeat" class="easyui-validatebox textbox" type="password" name="newPasswordRepeat" data-options="required:true,validType:'length[6,32]'"></input></td>
                </tr>
            </table>
	   </form>
    </div>
    </div>
    <div data-options="region:'south'" style="height: 50px;" border="false">
    	<hr>
		<div style="text-align:center;padding:5px">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">保存</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="top.framework.closeTab('修改个人密码')">关闭</a>
    	</div>
	</div>
</body>
</html>