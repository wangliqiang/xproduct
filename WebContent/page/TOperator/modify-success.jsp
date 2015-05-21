<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>修改操作员</title>
    <%@ include file="../Common/meta.jsp" %>
    <script src="../static/js/validator.js" type="text/javascript"></script>
    <style type="text/css">
	    .tree-file{
	    	background: url('');
	    }
	    .tree-folder{
	    	background: url('');
	    }
	    .tree-folder-open{
	    	background: url('');
	    }
	</style>
	<script type="text/javascript">
	
		$(function () {
			selectRoleIds='<%=request.getAttribute("roleIds")%>';
			initTree();
		});
		function initTree() {
            $("#jsontree").tree({
                url: '../TOperator/getRoleTree.do',
                method: 'get',
                animate: true,
                checkbox:true,
                onLoadSuccess: function (node, data) {
                   	if (selectRoleIds != null && selectRoleIds != ''){
                   		var idArray = selectRoleIds.split(",");
                   		for (var i=0;i<idArray.length;i++){
                   			var node = $('#jsontree').tree('find', idArray[i]);
                   			if (node != undefined && node != null){
                   				$('#jsontree').tree('check', node.target);
                   			}
                   		} 
                   	} 
                }
            });

        }
    	
    	function getChecked(){
            var nodes = $('#jsontree').tree('getChecked');
            var roleIds = '';
            var roleId = '';
            for(var i=0; i<nodes.length; i++){
            	roleId = nodes[i].id + ',';
            	if (roleIds == ''){
            		roleIds = roleId;
            	}else{
            		roleIds = roleIds + roleId;
            	}
            }
            if (roleIds != ''){
            	roleIds = roleIds.substring(0,roleIds.lastIndexOf(",",roleIds.length - 1));
        	}
            $("#roleIds").val(roleIds);
        }
    	
		function submitForm(){
	        $('#myfm').form('submit',{
	            url: '../TOperator/update.do',
	            onSubmit: function(){
	            	getChecked();
	                return $(this).form('validate');
	            },
	            success: function(result){
	                var result = eval('('+result+')');
	                if (result.iserror){
	                	Common.showMsg('失败',result.message);
	                } else {
	                	Common.showMsg('成功',result.message);
	                	top.framework.closeAndReloadTab('修改操作员', '<%=menuName%>');
	                }
	            }
	        });
		}
		
	</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north'" border="false">
	<div id="dlg" style="padding:10px 20px">
	   <div class="myftitle">基本信息</div>
	   <form id="myfm" method="post" novalidate>
	   	   <input type="hidden" id="roleIds" name="roleIds">
	   	   <input type="hidden" name="toperator.id" value="<s:property value="toperator.id"/>">
	   	    <input type="hidden" name="toperator.createTime" value="<s:property value="toperator.createTime"/>">
	   	    <input type="hidden" name="toperator.loginIp" value="<s:property value="toperator.loginIp"/>">
	   	    <input type="hidden" name="toperator.isPlatoperator" value="<s:property value="toperator.isPlatoperator"/>">
	   	    <input type="hidden" name="toperator.loginTime" value="<s:property value="toperator.loginTime"/>">
	   	    <input type="hidden" name="toperator.password" value="<s:property value="toperator.password"/>">
	   	    <input type="hidden" name="toperator.loginName" value="<s:property value="toperator.loginName"/>">
	   	    <input type="hidden" name="toperator.cpCode" value="<s:property value="toperator.cpCode"/>">
	   	   <table cellpadding="10">
                <tr>
                    <td>
                    	<label for="toperator.loginname" >登录名称:</label>
                    	<input class="easyui-validatebox textbox" type="text" value="<s:property value="toperator.loginName"/>" name="toperator.loginName" disabled="disabled"></input>
                    </td>
                    <td>
                    	<label for="toperator.password">密码:</label>
                    	<input class="easyui-validatebox" type="text" value="<s:property value="toperator.password"/>" name="toperator.password" disabled="disabled"></input>
                    </td>
                    <td>
                    	<label for="toperator.email">邮箱:</label>
                    	<input class="easyui-validatebox" type="text" value="<s:property value="toperator.email"/>" name="toperator.email" ></input>
                    </td>
                    <td>
                    	<label for="toperator.status">状态:</label>
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
                <tr>
                	<td>
                    	<label for="toperator.realname">真实姓名:</label>
                    	<input class="easyui-validatebox textbox" type="text" value="<s:property value="toperator.realName"/>" name="toperator.realName" data-options="required:true,validType:'length[3,20]'"></input>
                    </td>
                    <td>
                    	<label for="toperator.phone">电话:</label>
                    	<input class="easyui-validatebox" type="text" value="<s:property value="toperator.phone"/>" name="toperator.phone"></input>
                    </td>
                    <td>
                    	<label for="toperator.mobile">手机:</label>
                    	<input class="easyui-validatebox" type="text" value="<s:property value="toperator.mobile"/>" name="toperator.mobile"></input>
                    </td>
                    <td>
                    	<label for="toperator.gender">性别:</label>
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
                	<td>
                    	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label for="toperator.fax">传真:</label>
                    	<input class="easyui-validatebox textbox" type="text" value="<s:property value="toperator.fax"/>" name="toperator.fax"></input>
                    </td>
                    <td>
                    	<label for="toperator.qq">&nbsp;&nbsp;QQ:</label>
                        <input class="easyui-validatebox textbox" type="text" value="<s:property value="toperator.qq"/>" name="toperator.qq"></input>
                    </td>
                </tr>
            </table>
	   </form>
    </div>
    </div>
    <div data-options="region:'center'" border="false" title="角色定义">
    	<ul id="jsontree" class="easyui-tree" />
    </div>
    <div data-options="region:'south'" style="height: 50px;" border="false">
    	<hr>
		<div style="text-align:center;padding:5px">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">保存</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="top.framework.closeTab('修改操作员')">关闭</a>
    	</div>
	</div>
</body>
</html>