<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>修改角色</title>
    <%@ include file="../Common/meta.jsp" %>
    <style type="text/css">
	    .tree-file{
	    	<%-- background: url('<%=basePath%>/static/css/img/tree/tree-leaf.gif'); --%>
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
			selectPrivIds='<%=request.getAttribute("privIds")%>';
			initTree();
		});
		function initTree() {
            $("#jsontree").tree({
                url: '../TSysrole/getPrivTree.do',
                method: 'get',
                animate: true,
                checkbox:true,
                onLoadSuccess: function (node, data) {
                   	if (selectPrivIds != null && selectPrivIds != ''){
                   		var idArray = selectPrivIds.split(",");
                   		for (var i=0;i<idArray.length;i++){
                   			var node = $('#jsontree').tree('find', idArray[i]);
                   			if (node != undefined && node != null){
                   				$('#jsontree').tree('check', node.target);
                   			}
                   		} 
                   	} 
                }
            });
            $('#jsontree').tree('collapseAll');
        }
    	
    	function getChecked(){
            var nodes = $('#jsontree').tree('getChecked');
            var privIds = '';
            var menuIds = '';
            for(var i=0; i<nodes.length; i++){
            	var menuId1 = '';
            	var menuId2 = '';
            	var privId = '';
            	var tmpArray;
            	var nodeId = nodes[i].id + '';
            	if (nodeId == null || nodeId == '') continue;
            	if (nodeId.indexOf('-') < 0){
            		tmpArray = new Array(nodeId);
            	}else{
            		tmpArray = nodeId.split('-');
            	}
            	if (tmpArray.length == 1){
            		menuId1 = tmpArray[0] + ",";
            		if (menuIds == ''){
            			menuIds = menuId1;
            		}else if (menuIds.indexOf(menuId1) < 0){
            			menuIds = menuIds + menuId1;
            		}
            		
            	}else if (tmpArray.length == 2){
            		menuId1 = tmpArray[0] + ",";
            		menuId2 = tmpArray[1] + ",";
            		if (menuIds == ''){
            			menuIds = menuId1 + menuId2;
            		}else{
            			if (menuIds.indexOf(menuId1) < 0){
                			menuIds = menuIds + menuId1;
                		}
            			if (menuIds.indexOf(menuId2) < 0){
                			menuIds = menuIds + menuId2;
                		}
            		}
            	}else if (tmpArray.length == 3){
            		menuId1 = tmpArray[0] + ",";
            		menuId2 = tmpArray[1] + ",";
            		privId = tmpArray[2] + ",";
            		if (menuIds == ''){
            			menuIds = menuId1 + menuId2;
            		}else{
            			if (menuIds.indexOf(menuId1) < 0){
                			menuIds = menuIds + menuId1;
                		}
            			if (menuIds.indexOf(menuId2) < 0){
                			menuIds = menuIds + menuId2;
                		}
            		}
            		if (privIds == ''){
            			privIds = privId;
            		}else if(privIds.indexOf(privId) < 0){
            			privIds = privIds + privId;
            		}
            	}
            }
            if (menuIds != ''){
        		menuIds = menuIds.substring(0,menuIds.lastIndexOf(",",menuIds.length - 1));
        	}
        	if (privIds != ''){
        		privIds = privIds.substring(0,privIds.lastIndexOf(",",privIds.length - 1));
        	}
            $("#menuIds").val(menuIds);
            $("#privIds").val(privIds);
            /* alert("菜单：" + menuIds);
            alert("权限：" + privIds); */
        }
		
		function submitForm(){
	        $('#myfm').form('submit',{
	            url: '../TSysrole/update.do',
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
	                	top.framework.closeAndReloadTab('修改角色', '<%=menuName%>');
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
	   	   <input type="hidden" id="privIds" name="privIds">
	   	   <input type="hidden" id="menuIds" name="menuIds">
	   	   <input type="hidden" name="tsysrole.id" value="<s:property value="tsysrole.id"/>">
	       <input type="hidden" name="tsysrole.createTime" value="<s:property value="tsysrole.createTime"/>">
	   	   <table cellpadding="5">
                <tr>
                    <td>角色名称:</td>
                    <td><input class="easyui-validatebox" type="text" name="tsysrole.name" value="<s:property value="tsysrole.name"/>" data-options="required:true,validType:'length[3,32]'"></input></td>
                </tr>
                <tr>
                    <td>类型:</td>
                    <td>
                        <select class="easyui-combobox" name="tsysrole.type" data-options="required:true,editable:false">
	           				<s:if test="tsysrole.type == 1">
	           					<option value="1" selected="selected">平台角色</option>
	           				</s:if>
	           				<s:else>
	           					<option value="1">平台角色</option>
	           				</s:else>
	           				<s:if test="tsysrole.type == 2">
	           					<option value="2" selected="selected">企业角色</option>
	           				</s:if>
	           				<s:else>
	           					<option value="2">企业角色</option>
	           				</s:else>
	           			</select>
                    </td>
                </tr>
                <tr>
                	<td>描述:</td>
                    <td colspan="3">
                    <textarea id="description"  name="tsysrole.description" style="width:360px;height:60px;" ><s:property value="tsysrole.description"/></textarea>
                    </td>
                </tr>
                <tr>
                    <td>状态:</td>
                    <td>
                        <select class="easyui-combobox" name="tsysrole.status" data-options="required:true,editable:false">
	           				<s:if test="tsysrole.status == 1">
	           					<option value="1" selected="selected">启用</option>
	           				</s:if>
	           				<s:else>
	           					<option value="1">启用</option>
	           				</s:else>
	           				<s:if test="tsysrole.status == 0">
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
    <div data-options="region:'center'" border="false" title="权限定义">
    	<ul id="jsontree" class="easyui-tree" />
    </div>
    <div data-options="region:'south'" style="height: 50px;" border="false">
    	<hr>
		<div style="text-align:center;padding:5px">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">保存</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="top.framework.closeTab('修改角色')">关闭</a>
    	</div>
	</div>
</body>
</html>