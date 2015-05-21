<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>系统配置</title>
    <%@ include file="../Common/meta.jsp" %>
    <script type="text/javascript">
    	
    	function view(){
   		   var selecteds = $('#tb1').datagrid('getSelections');
           if (selecteds == null || selecteds.length == 0) { 
        	Common.showMsg('查看系统配置','请选择操作项！');
           	return;
           }
           if (selecteds.length>1) {
        	Common.showMsg('查看系统配置','不支持多个操作！');
           	return; 
           }
           
           top.framework.openTab('查看系统配置', 'TSysconfig/view.do?id='+selecteds[0].id);
    	}
    	
    	function add(){
    		top.framework.openTab('新增系统配置', 'TSysconfig/add.do?menuName=<%=menuName%>');
    	}
    	
    	function modify(){
    		var selecteds = $('#tb1').datagrid('getSelections');
            if (selecteds == null || selecteds.length == 0) { 
            	Common.showMsg('修改系统配置','请选择操作项！');
            	return;
            }
            if (selecteds.length>1) {
            	Common.showMsg('修改系统配置','不支持多个操作！');
            	return; 
            }
            top.framework.openTab('修改系统配置', 'TSysconfig/modify.do?id='+selecteds[0].id+'&menuName=<%=menuName%>');
    	}
    	
    	function remove(){
    		var selecteds = $('#tb1').datagrid('getSelections');
            if (selecteds == null || selecteds.length == 0) { 
            	Common.showMsg('删除系统配置','请选择操作项！');
            	return;
            }
            $.messager.confirm('删除系统配置','确定删除吗?', 
            function(r){
                if (r){
                	var ids = '';
                    $(selecteds).each(function (index) {
                        ids = ids + selecteds[index].id + ",";
                    });
        			
                    ids = ids.substring(0, ids.length - 1);
            		
            		$.ajax( {
        				url : '../TSysconfig/remove.do',
        				dataType:'json',
        				data : {ids : ids},
        				success : function(result) {
        					var msg=result.message;
        					Common.showMsg('删除系统配置',msg);
        					search();
        				},
        				error : function(result) {
        					Common.showMsg('删除系统配置',result.msg);
        				}
        			});
                }
            });
            
    	}
    	
	    function search(){
			var paramName = $("#paramNameS").val();
			var paramCode = $("#paramCodeS").val();
			$('#tb1').datagrid({
	            url:"../TSysconfig/getData.do",
	            queryParams:{
	            	paramName:paramName,
	            	paramCode:paramCode,
	            	date:new Date()
	            }
	        });
		}
    </script>
</head>
<body>

	<table id="tb1" class="easyui-datagrid" title="" width="100%" height="100%" fit="true" border="0"
           data-options="rownumbers:true,pagination:true,url:'../TSysconfig/getData.do',singleSelect:false,method:'post',toolbar:'#toolbar1',sortName:'id',sortOrder:'asc'">
        <thead>
            <tr>
            	<th data-options="field:'ck',checkbox:true"></th>
            	<th data-options="field:'id',hidden:true">id</th>
            	<th data-options="field:'paramName',width:250,align:'left',sortable:'true'">配置名称</th>
            	<th data-options="field:'paramCode',width:250,align:'center',sortable:'true'">配置代码</th>
            	<th data-options="field:'paramValue',width:250,align:'center',sortable:'true'">配置值</th>
            	<th data-options="field:'createTime',width:250,align:'center',sortable:'true'">创建时间</th>
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
	            <a href="javascript:remove();" class="easyui-linkbutton" iconCls="icon-remove-new" plain="true">删除</a> -->
	        </div>
        </div>
        <div>
            <form id="fm" method="post" novalidate>
            <table cellpadding="5">
              <tr>
                   <td>配置名称:</td>
                   <td><input class="easyui-validatebox textbox" type="text" name="paramNameS" id="paramNameS"></input></td>
                   <td>配置代码:</td>
                   <td><input class="easyui-validatebox textbox" type="text" name="paramCodeS" id="paramCodeS"></input></td>
                   <td>&nbsp;&nbsp;</td>
                   <td><a href="javascript:search()" class="easyui-linkbutton" iconCls="icon-search">查找</a></td>
               </tr>
           </table>
           </form>
        </div>
    </div>
    
</body>
</html>