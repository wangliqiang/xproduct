<%@ taglib uri="/struts-tags" prefix="s" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String menuName = request.getParameter("menuName");
if (menuName != null && menuName != ""){
	menuName = new String(menuName.getBytes("ISO-8859-1"),"UTF-8");
}
%>
