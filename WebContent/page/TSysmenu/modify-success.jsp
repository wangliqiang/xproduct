<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>修改菜单</title>
    <%@ include file="../Common/meta.jsp" %>
	<script type="text/javascript">
		$(function () {
	    	var level = '<%= request.getAttribute("tsysmenu.level")%>';
	    	var parent = '<%= request.getAttribute("tsysmenu.parentMenu")%>';
	    	var parentId = '';
	    	if (parent != 'null' && parent != ''){
	    		parentId = '<%= request.getAttribute("tsysmenu.parentMenu.id")%>';
	    	}
	    	var two = '2';
	    	if (level == two){
        		$('#parentId').combogrid({
    	            url:'../TSysmenu/getData.do?level=1&rows=150',
    	            required:true,
    	            disabled:false
    	        });
        		$('#parentId').combogrid('setValue', parentId);
	    	}
		});
	
		function levelOnChange(newValue, oldValue){
			if (newValue == oldValue) return;
			var two = 2;
			if (newValue == two){
				$('#code').validatebox({ required: true });
        		$("#code").removeAttr("disabled");
        		$('#code').val('');
        		
				$('#navigateUrl').validatebox({ required: true });
        		$("#navigateUrl").removeAttr("disabled");
        		$('#navigateUrl').val('');
			}else{
				$('#code').validatebox({ required: false });
				$("#code").attr("disabled","disabled");
        		$('#code').val('');
        		
				$('#navigateUrl').validatebox({ required: false });
				$("#navigateUrl").attr("disabled","disabled");
        		$('#navigateUrl').val('');
			}
		}
		
		function submitForm(){
	        $('#myfm').form('submit',{
	            url: '../TSysmenu/update.do',
	            onSubmit: function(){
	                return $(this).form('validate');
	            },
	            success: function(result){
	                var result = eval('('+result+')');
	                if (result.iserror){
	                	Common.showMsg('失败',result.message);
	                } else {
	                	Common.showMsg('成功',result.message);
	                	top.framework.closeAndReloadTab('修改菜单', '<%=menuName%>');
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
	   <input type="hidden" name="tsysmenu.id" value="<s:property value="tsysmenu.id"/>">
	   <input type="hidden" name="tsysmenu.parentMenu.id" value="<s:property value="tsysmenu.parentMenu.id"/>">
	   <input type="hidden" name="tsysmenu.createTime" value="<s:property value="tsysmenu.createTime"/>">
	   	   <table cellpadding="5">
                <tr>
                    <td>菜单名称:</td>
                    <td><input class="easyui-validatebox" type="text" value="<s:property value="tsysmenu.name"/>" name="tsysmenu.name" data-options="required:true,validType:'length[3,32]'"></input></td>
                </tr>
                <tr>
                    <td>菜单等级:</td>
                    <td>
                        <select class="easyui-combobox" name="tsysmenu.level" data-options="required:true,editable:false,disabled:true">
	           				<s:if test="tsysmenu.level == 1">
	           					<option value="1" selected="selected">一级</option>
	           				</s:if>
	           				<s:else>
	           					<option value="1">一级</option>
	           				</s:else>
	           				<s:if test="tsysmenu.level == 2">
	           					<option value="2" selected="selected">二级</option>
	           				</s:if>
	           				<s:else>
	           					<option value="2">二级</option>
	           				</s:else>
	           			</select>
                    </td>
                </tr>
                <tr>
                    <td>菜单代码:</td>
                    <td>
                    	<s:if test="tsysmenu.level == 1">
                    		<input class="easyui-validatebox" type="text" id="code" name="tsysmenu.code" data-options="required:false" disabled="disabled"></input>
                    	</s:if>
                    	<s:else>
                    		<input class="easyui-validatebox" type="text" id="code" value="<s:property value="tsysmenu.code"/>" name="tsysmenu.code" data-options="required:true"></input>
                    	</s:else>
                    </td>
                </tr>
                <tr>
                    <td>导航地址:</td>
                    <td>
                    	<s:if test="tsysmenu.level == 1">
                    		<input class="easyui-validatebox" type="text" id="navigateUrl" name="tsysmenu.navigateUrl" data-options="required:false" disabled="disabled"></input>
                    	</s:if>
                    	<s:else>
                    		<input class="easyui-validatebox" type="text" id="navigateUrl" value="<s:property value="tsysmenu.navigateUrl"/>" name="tsysmenu.navigateUrl" data-options="required:true"></input>
                    	</s:else>
                    </td>
                </tr>
                <tr>
                    <td>父级菜单:</td>
                    <td>
                    	<s:if test="tsysmenu.level == 1">
                    		<input class="easyui-validatebox" type="text" name="tsysmenu.parentMenu.name" data-options="required:false" disabled="disabled"></input>
                    	</s:if>
                    	<s:else>
                    		<input class="easyui-validatebox" type="text" value="<s:property value="tsysmenu.parentMenu.name"/>" name="tsysmenu.parentMenu.name" disabled="disabled"></input>
                    	</s:else>
                    </td>
                </tr>
                <tr>
                    <td>序列号:</td>
                    <td><input class="easyui-numberspinner" name="tsysmenu.sequence" value="<s:property value="tsysmenu.sequence"/>" data-options="min:10,increment:10, editable:false"></input></td>
                </tr>
                <tr>
                    <td>状态:</td>
                    <td>
                        <select class="easyui-combobox" name="tsysmenu.status" data-options="required:true,editable:false">
	           				<s:if test="tsysmenu.status == 1">
	           					<option value="1" selected="selected">启用</option>
	           				</s:if>
	           				<s:else>
	           					<option value="1">启用</option>
	           				</s:else>
	           				<s:if test="tsysmenu.status == 0">
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
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="top.framework.closeTab('修改菜单')">关闭</a>
    	</div>
	</div>
</body>
</html>