<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>新增菜单</title>
    <%@ include file="../Common/meta.jsp" %>
	<script type="text/javascript">
		
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
        		$('#parentId').combogrid({
    	            url:'../TSysmenu/getData.do?level=1&rows=150',
    	            required:true,
    	            disabled:false
    	        });
			}else{
				$('#code').validatebox({ required: false });
				$("#code").attr("disabled","disabled");
        		$('#code').val('');
        		
				$('#navigateUrl').validatebox({ required: false });
				$("#navigateUrl").attr("disabled","disabled");
        		$('#navigateUrl').val('');
				$('#parentId').combogrid({
    	            url:'',
    	            required:false,
    	            disabled:true
    	        });
				$('#parentId').combogrid('reset');
			}
		}
		
		function search(){
			var name = $("#nameS").val();
			$('#parentId').combogrid({
	            url:"../TSysmenu/getData.do",
	            queryParams:{
	            	name:name,
	            	date:new Date()
	            }
	        });
		}
		
		function submitForm(){
	        $('#myfm').form('submit',{
	            url: '../TSysmenu/save.do',
	            onSubmit: function(){
	                return $(this).form('validate');
	            },
	            success: function(result){
	                var result = eval('('+result+')');
	                if (result.iserror){
	                	Common.showMsg('失败',result.message);
	                } else {
	                	Common.showMsg('成功',result.message);
	                	top.framework.closeAndReloadTab('新增菜单', '<%=menuName%>');
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
                    <td>菜单名称:</td>
                    <td><input class="easyui-validatebox" type="text" name="tsysmenu.name" data-options="required:true,validType:'length[3,32]'"></input></td>
                </tr>
                <tr>
                    <td>菜单等级:</td>
                    <td>
                        <select class="easyui-combobox" name="tsysmenu.level" data-options="required:true,editable:false,onChange:levelOnChange">
	           				<option value="1" selected="selected">一级</option>
	           				<option value="2">二级</option>
	           			</select>
                    </td>
                </tr>
                <tr>
                    <td>菜单代码:</td>
                    <td><input class="easyui-validatebox" type="text" id="code" name="tsysmenu.code" data-options="required:false" disabled="disabled"></input></td>
                </tr>
                <tr>
                    <td>导航地址:</td>
                    <td><input class="easyui-validatebox" type="text" id="navigateUrl" name="tsysmenu.navigateUrl" data-options="required:false" disabled="disabled"></input></td>
                </tr>
                <tr>
                    <td>父级菜单:</td>
                    <td>
                        <input id="parentId" class="easyui-combogrid" name="tsysmenu.parentMenu.id" data-options="
				            required:false,
				            editable:false,
				            panelWidth: 300,
				            multiple: false,
				            idField: 'id',
				            textField: 'name',
				            sortName:'id',
				            sortOrder:'asc',
				            disabled:true,
				            url: '',
				            method: 'post',
				            toolbar:'#tb',
				            columns: [[
				                {field:'id',title:'id',hidden:true,width:80},
				                {field:'name',title:'菜单名称',width:120,align:'left',sortable:'true'},
				                {field:'status',title:'状态',width:60,align:'center',formatter:function(value,row){
	                                    if(value == 1) return '启用';
	                                    if(value == 0) return '停用';
	                                    return '未定义';
	                		  	},sortable:'true'}
				            ]],
				            fitColumns: true
				        " >
						</input>
                    </td>
                </tr>
                <tr>
                    <td>序列号:</td>
                    <td><input class="easyui-numberspinner" name="tsysmenu.sequence" value="10" data-options="min:10,increment:10, editable:false"></input></td>
                </tr>
                <tr>
                    <td>状态:</td>
                    <td>
                        <select class="easyui-combobox" name="tsysmenu.status" data-options="required:true,editable:false">
	           				<option value="1" selected="selected">启用</option>
	           				<option value="0">停用</option>
	           			</select>
                    </td>
                </tr>
            </table>
            
            <div id="tb" style="padding:2px 5px;">
		                       菜单名称: <input class="easyui-validatebox textbox" name="nameS" id="nameS" style="width:110px"></input>
		       <a href="javascript:search()" class="easyui-linkbutton" iconCls="icon-search">查找</a>
    		</div>
	   </form>
    </div>
    </div>
    <div data-options="region:'south'" style="height: 50px;" border="false">
    	<hr>
		<div style="text-align:center;padding:5px">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">保存</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="top.framework.closeTab('新增菜单')">关闭</a>
    	</div>
	</div>
</body>
</html>
