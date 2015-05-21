<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>菜单排序</title>
    <%@ include file="../Common/meta.jsp" %>
    <style type="text/css">
		.drag-item{
			list-style-type:none;
			display:block;
			padding:5px;
			border:1px solid #ccc;
			margin:2px;
			width:300px;
			background:#fafafa;
			color:#444;
		}
		.indicator{
			position:absolute;
			font-size:9px;
			width:10px;
			height:10px;
			display:none;
			color:red;
		}
	</style>
	<script type="text/javascript">
		$(function(){
			var indicator = $('<div class="indicator">>></div>').appendTo('body');
			$('.drag-item').draggable({
				revert:true,
				deltaX:0,
				deltaY:0
			}).droppable({
				onDragOver:function(e,source){
					indicator.css({
						display:'block',
						left:$(this).offset().left-10,
						top:$(this).offset().top+$(this).outerHeight()-5
					});
				},
				onDragLeave:function(e,source){
					indicator.hide();
				},
				onDrop:function(e,source){
					$(source).insertAfter(this);
					indicator.hide();
				}
			});
		});
		
		function save(){
			var sorts = '';
			$("ul").each(function(){
				var children = $(this).children();
				if (children == null || children == undefined || children.length == 0){
					Common.showMsg('菜单排序','无可用菜单！');
					return;
				}
				var seq = 10;
				$(children).each(function(index){
					var tmpText = $(this).text();
					if (tmpText != null && tmpText != ''){
						var tmpArray = tmpText.split('|');
						sorts = sorts + tmpArray[1] + '-' + seq + ",";
						seq = seq + 10;
					}
				});
			});
			if (sorts == ''){
				Common.showMsg('菜单排序','无可用菜单！');
				return;
			}
			sorts = sorts.substring(0,sorts.lastIndexOf(",",sorts.length - 1));
			//alert(sorts);
            $.messager.confirm('菜单排序','确定保存吗?', 
            function(r){
                if (r){
            		$.ajax( {
        				url : '../TSysmenu/sorting.do',
        				dataType:'json',
        				data : {sorts : sorts},
        				success : function(result) {
        					var msg=result.message;
        					Common.showMsg('菜单排序',msg);
        					top.framework.closeAndReloadTab('菜单排序', '<%=menuName%>');
        				},
        				error : function(result) {
        					Common.showMsg('菜单排序',result.msg);
        				}
        			});
                }
            });
    	}
	</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'center'" border="false">
	<div id="dlg" style="padding:10px 20px">
	   <div class="myftitle">拖动列表项改变他们的顺序</div>
	   <ul style="margin:0;padding:0;margin-left:10px;">
	   	<s:if test="tsysmenus != null && !tsysmenus.isEmpty()">
	   		<s:iterator value="tsysmenus" var="tsysmenu">
	   			<li class="drag-item"><s:property value="#tsysmenu.name"/>|<s:property value="#tsysmenu.id"/>|<s:property value="#tsysmenu.sequence"/>
	   			<s:if test="#tsysmenu.level==1">
	   				|一级
	   			</s:if>
	   			<s:elseif test="#tsysmenu.level==2">
	   				|二级
	   			</s:elseif>
	   			<s:else>
	   				|未定义
	   			</s:else>
	   			</li>
	   			
	   		</s:iterator>
	   	</s:if>
	    </ul>
    </div>
    </div>
    <div data-options="region:'south'" style="height: 50px;" border="false">
    	<hr>
		<div style="text-align:center;padding:5px">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="save()">保存</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="top.framework.closeTab('菜单排序')">关闭</a>
    	</div>
	</div>
</body>
</html>
