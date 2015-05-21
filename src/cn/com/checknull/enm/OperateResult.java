/**  
* @Project: xproduct
* @Title: OperateResult.java
* @Package cn.com.checknull.enm
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-3-17 下午5:13:20
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.enm;
/**
 * @ClassName OperateResult
 * @Description TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-3-17   下午5:13:20
 */
public enum OperateResult {
	SUCCESS(1),ERROR(0);
	
	private int result;
	private OperateResult(int result){
		this.result = result;
	}
	
	public int getResult(){
		return this.result;
	}
}

