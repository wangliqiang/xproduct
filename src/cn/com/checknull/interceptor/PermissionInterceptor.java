/**  
* @Project: xproduct
* @Title: PermissionInterceptor.java
* @Package cn.com.checknull.interceptor
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-2-12 上午10:53:30
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.interceptor;

import java.lang.reflect.Method;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.StrutsStatics;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.com.checknull.enm.PrivCode;
import cn.com.checknull.enm.SessionAttribute;
import cn.com.checknull.entity.TSyspriv;
import cn.com.checknull.vo.ResultData;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;

/**
 * @ClassName PermissionInterceptor
 * @Description 权限拦截
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-2-12   上午10:53:30
 */
public class PermissionInterceptor implements Interceptor {

	/** 
	* @Fields serialVersionUID : TODO
	*/ 
	private static final long serialVersionUID = -156795477717580820L;

	private static final Logger logger = LoggerFactory.getLogger(PermissionInterceptor.class);
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
	}

	@Override
	public void init() {
		// TODO Auto-generated method stub
	}

	@Override
	public String intercept(ActionInvocation actionInvocation) throws Exception {
		try{
			Method currentMethod = actionInvocation.getProxy().getAction().getClass().getMethod(actionInvocation.getProxy().getMethod(), new Class[] {});
			if (currentMethod == null || !currentMethod.isAnnotationPresent(Permission.class)){
				return actionInvocation.invoke();
			}
			Permission permission = currentMethod.getAnnotation(Permission.class);
			if (permission.menuCode() == null || permission.privCode() == null) return withoutPermission();
			HttpServletRequest request = (HttpServletRequest) actionInvocation.getInvocationContext().get(StrutsStatics.HTTP_REQUEST);
			HttpSession session = request.getSession();
			Object objSession = session.getAttribute(SessionAttribute.PERMISSION.getAttribute());
			if (objSession == null) return withoutPermission();
			@SuppressWarnings("unchecked")
			Map<String, List<TSyspriv>> ListMapPrivs = (Map<String, List<TSyspriv>>) objSession;
			if (ListMapPrivs == null || ListMapPrivs.isEmpty()) return withoutPermission();
			 List<TSyspriv> tmpListTSyspriv = ListMapPrivs.get(permission.menuCode().getCode());
			 if (tmpListTSyspriv == null) return withoutPermission();
			 if (permission.privCode().getCode().equals(PrivCode.list.getCode())) {
				 //session中存放的菜单代码现在还未在系统中使用
				request.setAttribute(SessionAttribute.MENU_CODE.getAttribute(), permission.menuCode());
				request.setAttribute(SessionAttribute.PRIV_LIST.getAttribute(), tmpListTSyspriv);
				return actionInvocation.invoke();
			 }
			 boolean hasPermission = false;
			 for (TSyspriv tmpTSyspriv : tmpListTSyspriv){
				 if (StringUtils.isEmpty(tmpTSyspriv.getCode())) continue;
				 if (tmpTSyspriv.getCode().equals(permission.privCode().getCode())) {
					 hasPermission = true;
					 break;
				 }
			 }
			 if (!hasPermission) return withoutPermission();
		}catch (Exception e){
			logger.error(e.getMessage(), e);
			return withoutPermission();
		}
		return actionInvocation.invoke();
	}
	
	private String withoutPermission(){
		ResultData result = new ResultData();
		result.setIserror(true);
		result.setMessage("对不起，您没有操作权限！请联系管理员！");
		ActionContext.getContext().put("json", result);
		return "json";
	}

}

