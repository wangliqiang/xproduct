/**  
* @Project: xproduct
* @Title: RequestUtils.java
* @Package cn.com.checknull.util
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-2-11 下午5:28:15
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.util;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;

/**
 * @ClassName RequestUtils
 * @Description TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-2-11   下午5:28:15
 */
public abstract class RequestUtils {
	
	/**
	 * 
	* @Title: getRequsetIP 
	* @Description: 获取发起请求的IP
	* @param request
	* @return
	 */
	public static String getRequsetIP(HttpServletRequest request){
		String tmpIP = "";
		if (request == null) return tmpIP;
		tmpIP = request.getHeader("X-Real-IP");
		if (StringUtils.isEmpty(tmpIP) || "unknown".equalsIgnoreCase(tmpIP)) {
			tmpIP = request.getHeader("X-Forwarded-For");
		}
		if (StringUtils.isEmpty(tmpIP) || "unknown".equalsIgnoreCase(tmpIP)) {
			tmpIP = request.getRemoteAddr();
		}
		if ("0:0:0:0:0:0:0:1".equals(tmpIP)) {
			tmpIP = "127.0.0.1";
		}
		return tmpIP;
	}
}

