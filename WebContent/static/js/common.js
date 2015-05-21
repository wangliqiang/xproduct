$(function () {
	window['Common'] = {};
	
	//定义14个主题
	Common.themes = new Array("black","bootstrap","default","gray","metro",
			"metro-blue","metro-gray","metro-green","metro-orange","metro-red",
			"ui-cupertino","ui-dark-hive","ui-pepper-grinder","ui-sunny");
	//更换主题
	Common.switchTheme = function(theme) {
		var tmpTheme;
		if (theme != null){
			tmpTheme = theme;
		}else{
			var rndNum = parseInt(14*Math.random());
			tmpTheme = Common.themes[rndNum];
		}
		
		var linkHref = $("#skin").attr("href");
		var linkHrefSpit = linkHref.split("/");
		var tmpLinkHref = linkHrefSpit[9];
		linkHref = linkHref.replace(tmpLinkHref,tmpTheme);
		$("#skin").attr("href",linkHref);
		//记录一下cookie,防止刷新就回到原来的css路径
		$.cookie("css_skin",tmpTheme,{path:"/"});
	};
	
	//如果cookie不为空的时候就读取cookie的路径
    if($.cookie("css_skin") != null){
    	var theme = $.cookie("css_skin");
    	Common.switchTheme(theme);
    }
    
    //显示错误日志
    Common.showMsg = function(title,msg){
    	$.messager.show({
			title:title,
			msg:msg,
			showType:'slide',
			style:{
				right:'',
				top:'',
				bottom:-document.body.scrollTop-document.documentElement.scrollTop
			}
		});
    };
    
});