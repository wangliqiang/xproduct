<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>操作日志</title>
    <%@ include file="../Common/meta.jsp" %>
    <script type="text/javascript">
    	
    	function view(){
   		   var selecteds = $('#tb1').datagrid('getSelections');
           if (selecteds == null || selecteds.length == 0) { 
        	Common.showMsg('查看操作日志','请选择操作项！');
           	return;
           }
           if (selecteds.length>1) {
        	Common.showMsg('查看操作日志','不支持多个操作！');
           	return; 
           }
           
           top.framework.openTab('查看操作日志', 'TLogOperate/view.do?id='+selecteds[0].id);
    	}
    	
    	function remove(){
    		var selecteds = $('#tb1').datagrid('getSelections');
            if (selecteds == null || selecteds.length == 0) { 
            	Common.showMsg('删除操作日志','请选择操作项！');
            	return;
            }
            $.messager.confirm('删除操作日志','确定删除吗?', 
            function(r){
                if (r){
                	var ids = '';
                    $(selecteds).each(function (index) {
                        ids = ids + selecteds[index].id + ",";
                    });
        			
                    ids = ids.substring(0, ids.length - 1);
            		
            		$.ajax( {
        				url : '../TLogOperate/remove.do',
        				dataType:'json',
        				data : {ids : ids},
        				success : function(result) {
        					var msg=result.message;
        					Common.showMsg('删除操作日志',msg);
        					search();
        				},
        				error : function(result) {
        					Common.showMsg('删除操作日志',result.msg);
        				}
        			});
                }
            });
            
    	}
    	
	    function search(){
			var loginName = $("#loginNameS").val();
			var operatorName = $("#operatorNameS").val();
			var operateObject = $("#operateObjectS").val();
			var operateResult = $("#operateResultS").combobox("getValue");
			$('#tb1').datagrid({
	            url:"../TLogOperate/getData.do",
	            queryParams:{
	            	loginName:loginName,
	            	operatorName:operatorName,
	            	operateObject:operateObject,
	            	operateResult:operateResult,
	            	date:new Date()
	            }
	        });
		}
    </script>
</head>
<body>

	<table id="tb1" class="easyui-datagrid" title="" width="100%" height="100%" fit="true" border="0"
           data-options="rownumbers:true,pagination:true,url:'../TLogOperate/getData.do',singleSelect:false,method:'post',toolbar:'#toolbar1',sortName:'id',sortOrder:'asc'">
        <thead>
            <tr>
            	<th data-options="field:'ck',checkbox:true"></th>
            	<th data-options="field:'id',hidden:true">id</th>
            	<th data-options="field:'loginName',width:200,align:'left',sortable:'true'">登录名称</th>
            	<th data-options="field:'operatorName',width:200,align:'center',sortable:'true'">真实姓名</th>
            	<th data-options="field:'operateObject',width:200,align:'center',sortable:'true'">操作对象</th>
            	<th data-options="field:'operateType',width:150,align:'center',sortable:'true'">操作类型</th>
            	<th data-options="field:'operateResult',width:150,align:'center',sortable:'true',
            		formatter:function(value,row){
                                    if (value == null) return value;
                                    if(value == 0) return '失败';
                                    if(value == 1) return '成功';
                                    return value;
                		  }
            	">操作结果</th>
            	<th data-options="field:'operateTime',width:200,align:'center',sortable:'true'">操作时间</th>
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
	            <a href="javascript:remove();" class="easyui-linkbutton" iconCls="icon-remove-new" plain="true">删除</a> -->
	        </div>
        </div>
        <div>
            <form id="fm" method="post" novalidate>
            <table cellpadding="5">
              <tr>
                   <td>登录名称:</td>
                   <td><input class="easyui-validatebox textbox" type="text" name="loginNameS" id="loginNameS"></input></td>
                   <td>真实姓名:</td>
                   <td><input class="easyui-validatebox textbox" type="text" name="operatorNameS" id="operatorNameS"></input></td>
                   <td>操作对象:</td>
                   <td><input class="easyui-validatebox textbox" type="text" name="operateObjectS" id="operateObjectS"></input></td>
                   <td>操作结果:</td>
                   <td>
                        <select class="easyui-combobox" name="operateResultS" id="operateResultS" data-options="editable:false">
                        	<option value="">全部</option>
	           				<option value="1">成功</option>
	           				<option value="0">失败</option>
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