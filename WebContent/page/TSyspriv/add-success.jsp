<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>新增权限</title>
    <%@ include file="../Common/meta.jsp" %>
	<script type="text/javascript">
		
		function submitForm(){
	        $('#myfm').form('submit',{
	            url: '../TSyspriv/save.do',
	            onSubmit: function(){
	                return $(this).form('validate');
	            },
	            success: function(result){
	                var result = eval('('+result+')');
	                if (result.iserror){
	                	Common.showMsg('失败',result.message);
	                } else {
	                	Common.showMsg('成功',result.message);
	                	top.framework.closeAndReloadTab('新增权限', '<%=menuName%>');
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
	   	   <input type="hidden" name="tsyspriv.menu.id" value="<s:property value="menuId"/>">
	   	   <table cellpadding="5">
	   	   		<tr>
                    <td>所属菜单:</td>
                    <td><input class="easyui-validatebox" type="text" value="<s:property value="tsysmenu.name"/>" disabled="disabled"></input></td>
                </tr>
                <tr>
                    <td>权限名称:</td>
                    <td><input class="easyui-validatebox" type="text" name="tsyspriv.name" data-options="required:true,validType:'length[2,32]'"></input></td>
                </tr>
                <tr>
                    <td>权限代码:</td>
                    <td><input class="easyui-validatebox" type="text" name="tsyspriv.code" data-options="required:true"></input></td>
                </tr>
                <tr>
                    <td>图标样式:</td>
                    <td><input class="easyui-validatebox" type="text" name="tsyspriv.iconCls" data-options="required:true"></input></td>
                </tr>
                <tr>
                    <td>方法名称:</td>
                    <td><input class="easyui-validatebox" type="text" name="tsyspriv.method" data-options="required:true"></input></td>
                </tr>
                <tr>
                    <td>序列号:</td>
                    <td><input class="easyui-numberspinner" name="tsyspriv.sequence" value="10" data-options="min:10,increment:10, editable:false"></input></td>
                </tr>
                <tr>
                    <td>状态:</td>
                    <td>
                        <select class="easyui-combobox" name="tsyspriv.status" data-options="required:true,editable:false">
	           				<option value="1" selected="selected">启用</option>
	           				<option value="0">停用</option>
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
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="top.framework.closeTab('新增权限')">关闭</a>
    	</div>
	</div>
</body>
</html>
