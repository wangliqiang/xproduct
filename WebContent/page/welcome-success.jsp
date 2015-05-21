<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>欢迎使用</title>
		
		<link href="../static/css/welcome.css" rel="stylesheet" type="text/css" />
	</head>
	<body>
		<div class="welcome-tip" style="display: none">
			提示：请使用1280*720以上的分辨率的显示器，操作体验更加友好。
			<span class="welcome-close"></span>
		</div>
		<div class="welcome-box">
			<div class="welcome-title">
				您好！欢迎使用系统管理平台。
			</div>
			<!-- <div class="br"></div> -->
			<dl class="welcome-lsit">
				<dt>功能模块</dt>
				<dd><a href="#">1. 操作员管理</a></dd>
				<dd><a href="#">2. 角色管理</a></dd>
				<dd><a href="#">3. 权限管理</a></dd>
				<dd><a href="#">4. 菜单管理</a></dd>
				<dd><a href="#">5. 登录日志</a></dd>
				<dd><a href="#">6. 操作日志</a></dd>
				<dd><a href="#">5. 系统配置</a></dd>
			</dl>
		</div>
		<script src="../static/js/jquery-1.9.1.js" type="text/javascript"></script>
		<script type="text/javascript">
		if(screen.width<1280||screen.height<720){
			jQuery(".welcome-tip").css("display","block");
			setTimeout(function() {
				jQuery(".welcome-tip").animate({marginTop:"-34px"}, 1000);
			}, 5000);
			
			jQuery(".welcome-close").click(function(){
				jQuery(".welcome-tip").animate({marginTop:"-34px"}, 500);
			})
		} 
	</script>
	</body>
</html>