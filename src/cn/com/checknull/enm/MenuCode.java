/**  
* @Project: xproduct
* @Title: MenuCode.java
* @Package cn.com.checknull.enm
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-3-19 上午9:49:19
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.enm;
/**
 * @ClassName MenuCode
 * @Description TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-3-19   上午9:49:19
 */
public enum MenuCode {
	/**操作者代码*/
	operator("TOperator"),
	/**角色代码*/
	sysrole("TSysrole"),
	/**权限代码*/
	syspriv("TSyspriv"),
	/**菜单代码*/
	sysmenu("TSysmenu"),
	/**登录日志代码*/
	logLogin("TLogLogin"),
	/**操作日志代码*/
	logOperate("TLogOperate"),
	/**系统配置代码*/
	sysconfig("TSysconfig");
	private String code;
	
	private MenuCode(String code){
		this.code = code;
	}
	
	public String getCode(){
		return this.code;
	}
}

