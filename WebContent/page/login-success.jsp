<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="Common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>系统管理平台</title>
    <%@ include file="Common/meta.jsp" %>
    <script type="text/javascript" src="static/js/jquery.md5.js"></script>
    <script type="text/javascript">
		
		function submitForm(){
			var md5Key = "";
			$.ajax( {
				url : 'TSysconfig/getMD5Key.do',
				dataType:'json',
				async: false,//同步
				success : function(result) {
					md5Key = result.data;
				},
				error : function(result) {
					md5Key = "";
				}
			});
			
	        $('#fm').form('submit',{
	            url: 'userLogin.do',
	            onSubmit: function(){
	            	var flag = $(this).form('validate');
	            	if (flag){
	            		var pwd = $("#password").val();
	        			pwd = MD5.md5(MD5.md5(pwd).toUpperCase() + md5Key);
	        			$("#password").val(pwd);
	        			flag = $(this).form('validate');
	            	}
	                return flag;
	            },
	            success: function(result){
	                var result = eval('('+result+')');
	                if (result.iserror){
	                	Common.showMsg('失败',result.message);
	                } else {
	                	window.location.href="index.do";
	                }
	            }
	        });
		}
		
		document.onkeydown=function(event){
			event = event|| window.event;
			if (event.keyCode == 13){
				submitForm();
			}
	    }
	    function init() {
			if(document.readyState=="complete"){
				document.getElementById("loginName").focus(); 
			}
		}	
	</script>
</head>
<body class="easyui-layout"  onload="init()">
	<div data-options="region:'west',border:false" style="background:#eee; width:460px" >
	</div>
	<div data-options="region:'north',border:false" style="background:#eee; height:130px" >
	</div>
	<div data-options="region:'center',border:false" style="background: #eee" >
		<div style="padding-left: 130px"><img src="static/css/img/layout/logo.png" alt="系统管理平台"></div>
		<div style="margin:10px 0;"></div>
		<div class="easyui-panel" style="width:400px;padding:30px 60px">
			<form id="fm" method="post" novalidate>
			<div style="margin-bottom:20px">
				<div>账号:</div>
				<input class="easyui-validatebox" name="loginName" id="loginName" data-options="required:true" style="width:100%;height:32px">
			</div>
			<div style="margin-bottom:20px">
				<div>密码:</div>
				<input class="easyui-validatebox" name="password" id="password" type="password" data-options="required:true" style="width:100%;height:32px">
			</div>
			<div>
				<a href="javascript:void(0)" onclick="submitForm()" class="easyui-linkbutton" style="width:100%;height:32px">登陆</a>
			</div>
			</form>
		</div>
	</div>
</body>
</html>