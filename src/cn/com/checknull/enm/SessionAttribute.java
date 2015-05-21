/**  
* @Project: xproduct
* @Title: SessionAttribute.java
* @Package cn.com.checknull.enm
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-2-11 下午3:50:30
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.enm;
/**
 * @ClassName SessionAttribute
 * @Description TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-2-11   下午3:50:30
 */
public enum SessionAttribute {
	OPERATOR("operator"),
	PERMISSION("permission"),
	MENU_CODE("menuCode"),
	PRIV_LIST("privList");
	private String attribute;
	private SessionAttribute(String attribute){
		this.attribute = attribute;
	}
	
	public String getAttribute(){
		return this.attribute;
	}
	
}

