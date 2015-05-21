<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>菜单管理</title>
    <%@ include file="../Common/meta.jsp" %>
    <script type="text/javascript">
    	
    	function view(){
   		   var selecteds = $('#tb1').datagrid('getSelections');
           if (selecteds == null || selecteds.length == 0) { 
        	Common.showMsg('查看菜单','请选择操作项！');
           	return;
           }
           if (selecteds.length>1) {
        	Common.showMsg('查看菜单','不支持多个操作！');
           	return; 
           }
           
           top.framework.openTab('查看菜单', 'TSysmenu/view.do?id='+selecteds[0].id);
    	}
    	
    	function add(){
    		top.framework.openTab('新增菜单', 'TSysmenu/add.do?menuName=<%=menuName%>');
    	}
    	
    	function modify(){
    		var selecteds = $('#tb1').datagrid('getSelections');
            if (selecteds == null || selecteds.length == 0) { 
            	Common.showMsg('修改菜单','请选择操作项！');
            	return;
            }
            if (selecteds.length>1) {
            	Common.showMsg('修改菜单','不支持多个操作！');
            	return; 
            }
    		top.framework.openTab('修改菜单', 'TSysmenu/modify.do?id='+selecteds[0].id+'&menuName=<%=menuName%>');
    	}
    	
    	function remove(){
    		var selecteds = $('#tb1').datagrid('getSelections');
            if (selecteds == null || selecteds.length == 0) { 
            	Common.showMsg('删除菜单','请选择操作项！');
            	return;
            }
            $.messager.confirm('删除菜单','确定删除吗?', 
            function(r){
                if (r){
                	var ids = '';
                    $(selecteds).each(function (index) {
                        ids = ids + selecteds[index].id + ",";
                    });
        			
                    ids = ids.substring(0, ids.length - 1);
            		
            		$.ajax( {
        				url : '../TSysmenu/remove.do',
        				dataType:'json',
        				data : {ids : ids},
        				success : function(result) {
        					var msg=result.message;
        					Common.showMsg('删除菜单',msg);
        					search();
        				},
        				error : function(result) {
        					Common.showMsg('删除菜单',result.msg);
        				}
        			});
                }
            });
            
    	}
    	
    	function on(){
    		var selecteds = $('#tb1').datagrid('getSelections');
            if (selecteds == null || selecteds.length == 0) { 
            	Common.showMsg('启用菜单','请选择操作项！');
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
				url : '../TSysmenu/on.do',
				dataType:'json',
				data : {ids : ids},
				success : function(result) {
					var msg=result.message;
					Common.showMsg('启用菜单',msg);
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
            	Common.showMsg('停用菜单','请选择操作项！');
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
            	Common.showMsg('停用菜单',name + '已经是停用状态！');
            	return;
            }

            ids = ids.substring(0, ids.length - 1);
            $.ajax( {
				url : '../TSysmenu/off.do',
				dataType:'json',
				data : {ids : ids},
				success : function(result) {
					var msg=result.message;
					Common.showMsg('停用菜单',msg);
					search();
				},
				error : function(result) {
					Common.showMsg('停用菜单',result.msg);
				}
			});
    	}
    	
    	function sort(){
    		top.framework.openTab('菜单排序', 'TSysmenu/sort.do?menuName=<%=menuName%>');
    	}
    	
	    function search(){
			var name = $("#nameS").val();
			var code = $("#codeS").val();
			var status = $("#statusS").combobox("getValue");
			$('#tb1').datagrid({
	            url:"../TSysmenu/getData.do",
	            queryParams:{
	            	name:name,
	            	code:code,
	            	status:status,
	            	date:new Date()
	            }
	        });
		}
    </script>
</head>
<body>

	<table id="tb1" class="easyui-datagrid" title="" width="100%" height="100%" fit="true" border="0"
           data-options="rownumbers:true,pagination:true,url:'../TSysmenu/getData.do',singleSelect:false,method:'post',toolbar:'#toolbar1',sortName:'sequence',sortOrder:'asc'">
        <thead>
            <tr>
            	<th data-options="field:'ck',checkbox:true"></th>
            	<th data-options="field:'id',hidden:true">id</th>
            	<th data-options="field:'name',width:150,align:'left',sortable:'true'">菜单名称</th>
            	<th data-options="field:'code',width:150,align:'center',sortable:'true'">菜单代码</th>
            	<th data-options="field:'navigateUrl',width:200,align:'center',sortable:'true'">导航地址</th>
            	<!-- <th data-options="field:'icon',width:250,align:'center',sortable:'true'">图标地址</th> -->
            	<th data-options="field:'level',width:150,align:'center',sortable:'true',
            		formatter:function(value,row){
            							if (value == 1) return '一级';
            							if (value == 2) return '二级';
	                                    return '未定义';
	                		  }
            	">菜单等级</th>
            	<th data-options="field:'parentMenu',width:100,align:'center',sortable:'true',
            		formatter:function(value,row){
            							if (value == null) return '无';
	                                    return value.name;
	                		  }
            	">父级菜单</th>
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
	            <!-- <a href="javascript:add();" class="easyui-linkbutton" iconCls="icon-add-new" plain="true">新增</a>
	            <a href="javascript:modify();" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true">修改</a>
	            <a href="javascript:remove();" class="easyui-linkbutton" iconCls="icon-remove-new" plain="true">删除</a>
	            <a href="javascript:on();" class="easyui-linkbutton" iconCls="icon-on-new" plain="true">启用</a>
	            <a href="javascript:off();" class="easyui-linkbutton" iconCls="icon-off-new" plain="true">停用</a> 
	            <a href="javascript:sort();" class="easyui-linkbutton" iconCls="icon-view-new" plain="true">排序</a>-->
	        </div>
        </div>
        <div>
            <form id="fm" method="post" novalidate>
            <table cellpadding="5">
              <tr>
                   <td>菜单名称:</td>
                   <td><input class="easyui-validatebox textbox" type="text" name="nameS" id="nameS"></input></td>
                   <td>菜单代码:</td>
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
    
</body>
</html>