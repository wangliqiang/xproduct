<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>新增系统配置</title>
    <%@ include file="../Common/meta.jsp" %>
	<script type="text/javascript">
		function submitForm(){
	        $('#myfm').form('submit',{
	            url: '../TSysconfig/save.do',
	            onSubmit: function(){
	                return $(this).form('validate');
	            },
	            success: function(result){
	                var result = eval('('+result+')');
	                if (result.iserror){
	                	Common.showMsg('失败',result.message);
	                } else {
	                	Common.showMsg('成功',result.message);
	                	top.framework.closeAndReloadTab('新增系统配置', '<%=menuName%>');
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
	   	   <table cellpadding="5">
                <tr>
                    <td>配置名称:</td>
                    <td><input class="easyui-validatebox textbox" type="text" name="tsysconfig.paramName" data-options="required:true,validType:'length[3,50]'"></input></td>
                </tr>
                <tr>
                    <td>配置代码:</td>
                    <td><input class="easyui-validatebox textbox" type="text" name="tsysconfig.paramCode" data-options="required:true,validType:'length[3,50]'"></input></td>
                </tr>
                <tr>
                    <td>配置值:</td>
                    <td><input class="easyui-validatebox textbox" type="text" name="tsysconfig.paramValue" data-options="required:true,validType:'length[3,50]'"></input></td>
                </tr>
                <tr>
                	<td>配置描述:</td>
                    <td colspan="3">
                    <textarea name="tsysconfig.description" style="width:350px;height:60px;" ></textarea>
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
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="top.framework.closeTab('新增系统配置')">关闭</a>
    	</div>
	</div>
</body>
</html>