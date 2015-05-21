<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>权限管理</title>
    <%@ include file="../Common/meta.jsp" %>
    <script type="text/javascript">
    	
    	function view(){
   		   var selecteds = $('#tb1').datagrid('getSelections');
           if (selecteds == null || selecteds.length == 0) { 
        	Common.showMsg('查看权限','请选择操作项！');
           	return;
           }
           if (selecteds.length>1) {
        	Common.showMsg('查看权限','不支持多个操作！');
           	return; 
           }
           
           top.framework.openTab('查看权限', 'TSyspriv/view.do?id='+selecteds[0].id);
    	}
    	
    	function add(){
    		if (menuId == 0){
    			Common.showMsg('新增权限','请选择菜单！');
    			return;
    		}
    		top.framework.openTab('新增权限', 'TSyspriv/add.do?menuId=' + menuId+'&menuName=<%=menuName%>');
    	}
    	
    	function modify(){
    		var selecteds = $('#tb1').datagrid('getSelections');
            if (selecteds == null || selecteds.length == 0) { 
            	Common.showMsg('修改权限','请选择操作项！');
            	return;
            }
            if (selecteds.length>1) {
            	Common.showMsg('修改权限','不支持多个操作！');
            	return; 
            }
    		top.framework.openTab('修改权限', 'TSyspriv/modify.do?id='+selecteds[0].id+'&menuName=<%=menuName%>');
    	}
    	
    	function remove(){
    		var selecteds = $('#tb1').datagrid('getSelections');
            if (selecteds == null || selecteds.length == 0) { 
            	Common.showMsg('删除权限','请选择操作项！');
            	return;
            }
            $.messager.confirm('删除权限','确定删除吗?', 
            function(r){
                if (r){
                	var ids = '';
                    $(selecteds).each(function (index) {
                        ids = ids + selecteds[index].id + ",";
                    });
        			
                    ids = ids.substring(0, ids.length - 1);
            		
            		$.ajax( {
        				url : '../TSyspriv/remove.do',
        				dataType:'json',
        				data : {ids : ids},
        				success : function(result) {
        					var msg=result.message;
        					Common.showMsg('删除权限',msg);
        					search();
        				},
        				error : function(result) {
        					Common.showMsg('删除权限',result.msg);
        				}
        			});
                }
            });
            
    	}
    	
    	function on(){
    		var selecteds = $('#tb1').datagrid('getSelections');
            if (selecteds == null || selecteds.length == 0) { 
            	Common.showMsg('启用权限','请选择操作项！');
            	return;
            }
            var ids = '';
            var flag = false;
            var name = null;
            $(selecteds).each(function (index) {
            	if(selecteds[index].status == 1){
            		flag = true;
            		name = selecteds[index].name;
                	return;
            	}
                ids = ids + selecteds[index].id + ",";
				
            });
            if (flag){
            	Common.showMsg('启用菜单',name + '已经是启用状态！');
            	return;
            }
            
            ids = ids.substring(0, ids.length - 1); 
            
            $.ajax( {
				url : '../TSyspriv/on.do',
				dataType:'json',
				data : {ids : ids},
				success : function(result) {
					var msg=result.message;
					Common.showMsg('启用权限',msg);
					search();
				},
				error : function(result) {
					Common.showMsg('启用菜单',result.msg);
				}
			});
    	}

    	function off(){
    		var selecteds = $('#tb1').datagrid('getSelections');
            if (selecteds == null || selecteds.length == 0) { 
            	Common.showMsg('停用权限','请选择操作项！');
            	return;
            }
            
            var ids = '';
            var flag = false;
            var name = null;
            $(selecteds).each(function (index) {
            	if(selecteds[index].status == 0){
            		flag = true;
            		name = selecteds[index].name;
                	return;
            	}
                ids = ids + selecteds[index].id + ",";
				
            });
            if (flag){
            	Common.showMsg('停用权限',name + '已经是停用状态！');
            	return;
            }

            ids = ids.substring(0, ids.length - 1);
            $.ajax( {
				url : '../TSyspriv/off.do',
				dataType:'json',
				data : {ids : ids},
				success : function(result) {
					var msg=result.message;
					Common.showMsg('停用权限',msg);
					search();
				},
				error : function(result) {
					Common.showMsg('停用权限',result.msg);
				}
			});
    	}
    	
    	
	    function search(){
			var name = $("#nameS").val();
			var code = $("#codeS").val();
			var status = $("#statusS").combobox("getValue");
			$('#tb1').datagrid({
	            url:"../TSyspriv/getData.do",
	            queryParams:{
	            	menuId:menuId,
	            	name:name,
	            	code:code,
	            	status:status,
	            	date:new Date()
	            }
	        });
		}
	    
	    $(function () {
	    	menuId = 0;
    		initTree();
    	});
    	
    	function initTree() {
            $("#jsontree").tree({
                url: '../TSyspriv/getMenu.do',
                method: 'post',
                animate: true,
                onLoadSuccess: function (node, data) {
                	var node = $('#jsontree').tree('getRoot');
                    if (node != undefined && node != null){
                    	 var children = node.children;
                    	 if (children == null){
                    		 $('#jsontree').tree('select', node.target);
                    	 }else{
                    		 var children = $('#jsontree').tree('getChildren',node.target);
                        	 if (children != null){
                        		 var child = children[0];
                        		 $('#jsontree').tree('select', child.target);
                        	 } 
                    	 }
                    }
                },
                onSelect: function (node) {
                	var children = node.children;
                	if (children == null){
                		menuId=node.id;
                		search();
                	}
                    
                }
            });

        }
    </script>
</head>
<body class="easyui-layout">
	<div data-options="region:'west',split:true" title="系统菜单" style="width:160px;" >
		<ul id="jsontree" class="easyui-tree" />
	</div>
	<div data-options="region:'center'" style="background: #eee;" >
	<table id="tb1" class="easyui-datagrid" title="" width="100%" height="100%" fit="true" border="0"
           data-options="rownumbers:true,pagination:true,url:'',singleSelect:false,method:'post',toolbar:'#toolbar1',sortName:'sequence',sortOrder:'asc'">
        <thead>
            <tr>
            	<th data-options="field:'ck',checkbox:true"></th>
            	<th data-options="field:'id',hidden:true">id</th>
            	<th data-options="field:'name',width:100,align:'left',sortable:'true'">权限名称</th>
            	<th data-options="field:'code',width:100,align:'center',sortable:'true'">权限代码</th>
            	<th data-options="field:'iconCls',width:150,align:'center',sortable:'true'">图标样式</th>
            	<th data-options="field:'method',width:100,align:'center',sortable:'true'">方法名称</th>
            	<th data-options="field:'menu',width:150,align:'center',sortable:'true',
            		formatter:function(value,row){
            							if (value == null) return '未定义';
	                                    return value.name;
	                		  }
            	">菜单名称</th>
            	<th data-options="field:'createTime',width:150,align:'center',sortable:'true'">创建时间</th>
            	<th data-options="field:'sequence',width:100,align:'center',sortable:'true'">序列号</th>
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
	            <a href="javascript:off();" class="easyui-linkbutton" iconCls="icon-off-new" plain="true">停用</a> -->
	        </div>
        </div>
        <div>
            <form id="fm" method="post" novalidate>
            <table cellpadding="5">
              <tr>
                   <td>权限名称:</td>
                   <td><input class="easyui-validatebox textbox" type="text" name="nameS" id="nameS"></input></td>
                   <td>权限代码:</td>
                   <td><input class="easyui-validatebox textbox" type="text" name="codeS" id="codeS"></input></td>
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
    </div>
</body>
</html>