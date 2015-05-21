/**  
* @Project: xproduct
* @Title: SysconfigKey.java
* @Package cn.com.checknull.enm
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-3-17 下午4:47:13
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.enm;
/**
 * @ClassName SysconfigKey
 * @Description TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-3-17   下午4:47:13
 */
public enum SysconfigKey {
	
	MD5_KEY("md5Key");
	
	private String key;
	private SysconfigKey(String key){
		this.key = key;
	}
	
	public String getKey(){
		return this.key;
	}
}

