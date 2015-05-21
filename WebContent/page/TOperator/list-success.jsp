<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>操作员管理</title>
    <%@ include file="../Common/meta.jsp" %>
    <script type="text/javascript">
    	
    	function view(){
   		   var selecteds = $('#tb1').datagrid('getSelections');
           if (selecteds == null || selecteds.length == 0) { 
        	Common.showMsg('查看操作员','请选择操作项！');
           	return;
           }
           if (selecteds.length>1) {
        	Common.showMsg('查看操作员','不支持多个操作！');
           	return; 
           }
           
           top.framework.openTab('查看操作员', 'TOperator/view.do?id='+selecteds[0].id);
    	}
    	
    	function add(){
    		top.framework.openTab('新增操作员', 'TOperator/add.do?menuName=<%=menuName%>');
    	}
    	
    	function modify(){
    		var selecteds = $('#tb1').datagrid('getSelections');
            if (selecteds == null || selecteds.length == 0) { 
            	Common.showMsg('修改操作员','请选择操作项！');
            	return;
            }
            if (selecteds.length>1) {
            	Common.showMsg('修改操作员','不支持多个操作！');
            	return; 
            }
    		top.framework.openTab('修改操作员', 'TOperator/modify.do?id='+selecteds[0].id+'&menuName=<%=menuName%>');
    	}
    	
    	function remove(){
    		var selecteds = $('#tb1').datagrid('getSelections');
            if (selecteds == null || selecteds.length == 0) { 
            	Common.showMsg('删除操作员','请选择操作项！');
            	return;
            }
            $.messager.confirm('删除操作员','确定删除吗?', 
            function(r){
                if (r){
                	var ids = '';
                    $(selecteds).each(function (index) {
                        ids = ids + selecteds[index].id + ",";
                    });
        			
                    ids = ids.substring(0, ids.length - 1);
            		
            		$.ajax( {
        				url : '../TOperator/remove.do',
        				dataType:'json',
        				data : {ids : ids},
        				success : function(result) {
        					var msg=result.message;
        					Common.showMsg('删除操作员',msg);
        					search();
        				},
        				error : function(result) {
        					Common.showMsg('删除操作员',result.msg);
        				}
        			});
                }
            });
            
    	}
    	
    	function on(){
    		var selecteds = $('#tb1').datagrid('getSelections');
            if (selecteds == null || selecteds.length == 0) { 
            	Common.showMsg('启用操作员','请选择操作项！');
            	return;
            }
            var ids = '';
            var flag = false;
            var name = null;
            $(selecteds).each(function (index) {
            	if(selecteds[index].status == 1){
            		flag = true;
            		name = selecteds[index].loginName;
                	return;
            	}
                ids = ids + selecteds[index].id + ",";
				
            });
            if (flag){
            	Common.showMsg('启用操作员',name + '已经是启用状态！');
            	return;
            }
            
            ids = ids.substring(0, ids.length - 1); 
            
            $.ajax( {
				url : '../TOperator/on.do',
				dataType:'json',
				data : {ids : ids},
				success : function(result) {
					var msg=result.message;
					Common.showMsg('启用操作员',msg);
					search();
				},
				error : function(result) {
					Common.showMsg('启用操作员',result.msg);
				}
			});
    	}

    	function off(){
    		var selecteds = $('#tb1').datagrid('getSelections');
            if (selecteds == null || selecteds.length == 0) { 
            	Common.showMsg('停用操作员','请选择操作项！');
            	return;
            }
            
            var ids = '';
            var flag = false;
            var name = null;
            $(selecteds).each(function (index) {
            	if(selecteds[index].status == 0){
            		flag = true;
            		name = selecteds[index].loginName;
                	return;
            	}
                ids = ids + selecteds[index].id + ",";
				
            });
            if (flag){
            	Common.showMsg('停用操作员',name + '已经是停用状态！');
            	return;
            }

            ids = ids.substring(0, ids.length - 1);
            $.ajax( {
				url : '../TOperator/off.do',
				dataType:'json',
				data : {ids : ids},
				success : function(result) {
					var msg=result.message;
					Common.showMsg('停用操作员',msg);
					search();
				},
				error : function(result) {
					Common.showMsg('停用操作员',result.msg);
				}
			});
    	}
    	
    	function resetPassword(){
    		var selecteds = $('#tb1').datagrid('getSelections');
            if (selecteds == null || selecteds.length == 0) { 
            	Common.showMsg('重置密码','请选择操作项！');
            	return;
            }
            $.messager.confirm('重置密码','确定重置吗?', 
            function(r){
                if (r){
                	var ids = '';
                    $(selecteds).each(function (index) {
                        ids = ids + selecteds[index].id + ",";
                    });
        			
                    ids = ids.substring(0, ids.length - 1);
            		
            		$.ajax( {
        				url : '../TOperator/resetPassword.do',
        				dataType:'json',
        				data : {ids : ids},
        				success : function(result) {
        					var msg=result.message;
        					Common.showMsg('重置密码',msg);
        					search();
        				},
        				error : function(result) {
        					Common.showMsg('重置密码',result.msg);
        				}
        			});
                }
            });
    	}
    	
	    function search(){
			var loginName = $("#loginNameS").val();
			var realName = $("#realNameS").val();
			var isPlatoperator = $("#isPlatoperatorS").combobox("getValue");
			var status = $("#statusS").combobox("getValue");
			$('#tb1').datagrid({
	            url:"../TOperator/getData.do",
	            queryParams:{
	            	loginName:loginName,
	            	realName:realName,
	            	isPlatoperator:isPlatoperator,
	            	status:status,
	            	date:new Date()
	            }
	        });
		}
    </script>
</head>
<body>

	<table id="tb1" class="easyui-datagrid" title="" width="100%" height="100%" fit="true" border="0"
           data-options="rownumbers:true,pagination:true,url:'../TOperator/getData.do',singleSelect:false,method:'post',toolbar:'#toolbar1',sortName:'id',sortOrder:'asc'">
        <thead>
            <tr>
            	<th data-options="field:'ck',checkbox:true"></th>
            	<th data-options="field:'id',hidden:true">id</th>
            	<th data-options="field:'loginName',width:175,align:'left',sortable:'true'">登录名</th>
            	<th data-options="field:'realName',width:175,align:'center',sortable:'true'">真实姓名</th>
            	<th data-options="field:'isPlatoperator',width:150,align:'center',sortable:'true',
            		formatter:function(value,row){
	                                    if(value == 1) return '平台账号';
	                                    if(value == 2) return '企业账号';
	                                    return '未定义';
	                		  }
            	">类型</th>
            	<th data-options="field:'email',width:175,align:'center',sortable:'true'">邮箱</th>
            	<th data-options="field:'mobile',width:175,align:'center',sortable:'true'">电话</th>
            	<th data-options="field:'createTime',width:175,align:'center',sortable:'true'">创建时间</th>
            	<th data-options="field:'status',width:100,align:'center',sortable:'true',
            		formatter:function(value,row){
	                                    if(value == 1) return '启用';
	                                    if(value == 0) return '停用';
	                                    return '未定义';
	                		  }
            	">状态</th>
            	
            </tr>
        </thead>
   	</table>
    <div id="toolbar1" style="padding:5px;height:auto">
        <div id="operateBtn" style="margin-bottom:5px;margin-top:5px">
            <div id="operateBtn" style="margin-bottom:5px;margin-top:5px">
            	<s:iterator value="#request.privList" var="priv">
            		<a href="javascript:<s:property value="#priv.method"/>;" class="easyui-linkbutton" iconCls="<s:property value="#priv.iconCls"/>" plain="true"><s:property value="#priv.name"/></a>
            	</s:iterator>
	            <!-- <a href="javascript:view();" class="easyui-linkbutton" iconCls="icon-view-new" plain="true">查看</a>
	            <a href="javascript:add();" class="easyui-linkbutton" iconCls="icon-add-new" plain="true">新增</a>
	            <a href="javascript:modify();" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true">修改</a>
	            <a href="javascript:remove();" class="easyui-linkbutton" iconCls="icon-remove-new" plain="true">删除</a>
	            <a href="javascript:on();" class="easyui-linkbutton" iconCls="icon-on-new" plain="true">启用</a>
	            <a href="javascript:off();" class="easyui-linkbutton" iconCls="icon-off-new" plain="true">停用</a>
	            <a href="javascript:resetPassword();" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true">密码重置</a> -->
	        </div>
        </div>
        <div>
            <form id="fm" method="post" novalidate>
            <table cellpadding="5">
              <tr>
                   <td>登录名:</td>
                   <td><input class="easyui-validatebox textbox" type="text" name="loginNameS" id="loginNameS"></input></td>
                   <td>真实姓名:</td>
                   <td><input class="easyui-validatebox textbox" type="text" name="realNameS" id="realNameS"></input></td>
                   <td>类型:</td>
                   <td>
                        <select class="easyui-combobox" name="isPlatoperatorS" id="isPlatoperatorS" data-options="editable:false">
                        	<option value="">全部</option>
	           				<option value="1">平台账号</option>
	           				<option value="2">企业账号</option>
	           			</select>
                   </td>
                   <td>状态:</td>
                   <td>
                        <select class="easyui-combobox" name="statusS" id="statusS" data-options="editable:false">
                        	<option value="">全部</option>
	           				<option value="1">启用</option>
	           				<option value="0">停用</option>
	           			</select>
                   </td>
                   <td>&nbsp;&nbsp;</td>
                   <td><a href="javascript:search()" class="easyui-linkbutton" iconCls="icon-search">查找</a></td>
               </tr>
           </table>
           </form>
        </div>
    </div>
    
</body>
</html>