/**  
* @Project: xproduct
* @Title: Log4jFormatFilter.java
* @Package cn.com.checknull.filter
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-2-11 下午4:01:38
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.MDC;
import org.apache.struts2.RequestUtils;

import cn.com.checknull.enm.SessionAttribute;
import cn.com.checknull.entity.TOperator;

/**
 * @ClassName Log4jFormatFilter
 * @Description 格式化日志
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-2-11   下午4:01:38
 */
public class Log4jFormatFilter implements Filter {

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
	}

	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse,
			FilterChain filterChain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		HttpSession session = request.getSession();
		if (session == null) {
			MDC.put("user", "anonymous");
		} else {
			TOperator toperator = (TOperator) session.getAttribute(SessionAttribute.OPERATOR.getAttribute());
			if (toperator != null) {
				MDC.put("user", toperator.getLoginName());
			} else {
				MDC.put("user", "anonymous");
			}
		}
		MDC.put("ip", RequestUtils.getServletPath(request));
		filterChain.doFilter(request, servletResponse);
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
	}

}

