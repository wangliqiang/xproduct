<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>新增操作员</title>
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
			initTree();
		});
		function initTree() {
            $("#jsontree").tree({
                url: '../TOperator/getRoleTree.do',
                method: 'get',
                animate: true,
                checkbox:true
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
	            url: '../TOperator/save.do',
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
	                	top.framework.closeAndReloadTab('新增操作员', '<%=menuName%>');
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
	   	   <table cellpadding="10">
                <tr>
                    <td>
                    	<label for="toperator.loginname" >登录名称:</label>
                    	<input class="easyui-validatebox textbox" type="text" name="toperator.loginName" data-options="required:true,validType:'account[3,20]'"></input>
                    </td>
                    <td>
                    	<label for="toperator.password">密码:</label>
                    	<input class="easyui-validatebox" type="text" name="toperator.password" value="123456" data-options="required:true,validType:'length[6,20]'"></input>
                    </td>
                    <td>
                    	<label for="toperator.email">邮箱:</label>
                    	<input class="easyui-validatebox" type="text" name="toperator.email" ></input>
                    </td>
                    <td>
                    	<label for="toperator.status">状态:</label>
                        <select class="easyui-combobox" name="toperator.status" data-options="required:true,editable:false">
	           				<option value="1" selected="selected">启用</option>
	           				<option value="0">停用</option>
	           			</select>
                    </td>
                </tr>
                <tr>
                	<td>
                    	<label for="toperator.realname">真实姓名:</label>
                    	<input class="easyui-validatebox textbox" type="text" name="toperator.realName" data-options="required:true,validType:'length[3,20]'"></input>
                    </td>
                    <td>
                    	<label for="toperator.phone">电话:</label>
                    	<input class="easyui-validatebox" type="text" name="toperator.phone"></input>
                    </td>
                    <td>
                    	<label for="toperator.mobile">手机:</label>
                    	<input class="easyui-validatebox" type="text" name="toperator.mobile"></input>
                    </td>
                    <td>
                    	<label for="toperator.gender">性别:</label>
                        <select class="easyui-combobox" name="toperator.gender" data-options="required:true,editable:false">
	           				<option value="1" selected="selected">男</option>
	           				<option value="0">女</option>
	           			</select>
                    </td>
                </tr>
                <tr>
                	<td>
                    	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label for="toperator.fax">传真:</label>
                    	<input class="easyui-validatebox textbox" type="text" name="toperator.fax"></input>
                    </td>
                    <td>
                    	<label for="toperator.qq">&nbsp;&nbsp;QQ:</label>
                        <input class="easyui-validatebox textbox" type="text" name="toperator.qq"></input>
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
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="top.framework.closeTab('新增操作员')">关闭</a>
    	</div>
	</div>
</body>
</html>
