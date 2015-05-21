/**  
* @Project: xproduct
* @Title: SessionListener.java
* @Package cn.com.checknull.listener
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-2-11 下午5:26:44
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.listener;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import cn.com.checknull.enm.SessionAttribute;

/**
 * @ClassName SessionListener
 * @Description TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-2-11   下午5:26:44
 */
public class SessionListener implements HttpSessionListener {

	@Override
	public void sessionCreated(HttpSessionEvent arg0) {
		// TODO Auto-generated method stub
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent httpSessionEvent) {
		String attribute = SessionAttribute.OPERATOR.getAttribute();
		if (httpSessionEvent.getSession().getAttribute(attribute) != null) {
			httpSessionEvent.getSession().setAttribute(attribute, null);
		}
	}

}

