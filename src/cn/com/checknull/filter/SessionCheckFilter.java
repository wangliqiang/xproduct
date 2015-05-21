/**  
* @Project: xproduct
* @Title: SessionCheckFilter.java
* @Package cn.com.checknull.filter
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-2-11 下午4:02:45
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.filter;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.com.checknull.enm.SessionAttribute;

/**
 * @ClassName SessionCheckFilter
 * @Description 会话检查
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-2-11   下午4:02:45
 */
public class SessionCheckFilter implements Filter {

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
	}

	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse,
			FilterChain filterChain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		HttpServletResponse response = (HttpServletResponse) servletResponse;
		String url = request.getServletPath();
		// 如果是资源内容不做拦截
		if (url.contains(".jsp") || url.contains(".do")) {
			// 如果用户是登陆的不做拦截
			if (url.contains("login-success.jsp")
					|| url.contains("userLogin.do") || url.contains("login.do")
					|| url.contains("getMD5Key.do")) {
				filterChain.doFilter(request, response);
			}
			// 判断用户session是否失效
			else {
				HttpSession session = request.getSession();
				Object operator = session.getAttribute(SessionAttribute.OPERATOR.getAttribute()) ;
				Object permission = session.getAttribute(SessionAttribute.PERMISSION.getAttribute());
				if (operator == null || permission == null && !url.contains("index.do") ) {
					PrintWriter out = response.getWriter();
					out.println("<html>");
					out.println("<script>");
					out.println("window.open ('" + request.getContextPath()
							+ "/login.do?type=sessionOut','_top')");
					out.println("</script>");
					out.println("</html>");
				} else {
					filterChain.doFilter(request, response);
				}
			}
		} else {
			filterChain.doFilter(request, response);
		}
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		
		// TODO Auto-generated method stub
		
	}

}

