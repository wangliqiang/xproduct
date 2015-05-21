/**  
* @Project: xproduct
* @Title: OperatorType.java
* @Package cn.com.checknull.enm
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-3-19 下午2:20:05
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.enm;
/**
 * @ClassName OperatorType
 * @Description TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-3-19   下午2:20:05
 */
public enum OperatorType {
	/**
	 * 平台
	 */
	PLATFORM(1),
	/**
	 * 企业
	 */
	COMPANY(2);
	
	private int type;
	private OperatorType(int type){
		this.type = type;
	}
	
	public int getType(){
		return this.type;
	}
}

