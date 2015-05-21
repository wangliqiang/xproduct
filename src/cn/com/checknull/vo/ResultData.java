/**  
* @Project: xproduct
* @Title: ResultData.java
* @Package cn.com.checknull.vo
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-2-27 上午11:37:41
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.vo;
/**
 * @ClassName ResultData
 * @Description action响应结果集
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-2-27   上午11:37:41
 */
public class ResultData {
	private String message;
	private boolean iserror;
	private Object data;
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public boolean isIserror() {
		return iserror;
	}
	public void setIserror(boolean iserror) {
		this.iserror = iserror;
	}
	public Object getData() {
		return data;
	}
	public void setData(Object data) {
		this.data = data;
	}
}

