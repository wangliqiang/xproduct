/**  
* @Project: xproduct
* @Title: Permission.java
* @Package cn.com.checknull.interceptor
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-3-18 下午2:41:45
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.interceptor;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import cn.com.checknull.enm.MenuCode;
import cn.com.checknull.enm.PrivCode;

/**
 * @ClassName Permission
 * @Description TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-3-18   下午2:41:45
 */
@Target( { ElementType.METHOD } )
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface Permission {
	/**
	 * 
	* @Title: menuCode 
	* @Description: 菜单代码
	* @return
	 */
	MenuCode menuCode();
	/**
	 * 
	* @Title: privCode 
	* @Description: 权限代码
	* @return
	 */
	PrivCode privCode();
}

