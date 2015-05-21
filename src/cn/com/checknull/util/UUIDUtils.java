/**  
* @Project: xproduct
* @Title: UUIDUtils.java
* @Package cn.com.checknull.util
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-3-5 下午12:36:42
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.util;

import java.util.UUID;

/**
 * @ClassName UUIDUtils
 * @Description TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-3-5   下午12:36:42
 */
public abstract class UUIDUtils {
	
	public static String randomUUID(){
		String tmpUUID = UUID.randomUUID().toString();
		tmpUUID = tmpUUID.replaceAll("-", "").toUpperCase();
		return tmpUUID;
	}
	
}

