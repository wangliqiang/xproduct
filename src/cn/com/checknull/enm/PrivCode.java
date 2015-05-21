/**  
* @Project: xproduct
* @Title: PrivCode.java
* @Package cn.com.checknull.enm
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-3-19 上午10:04:11
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.enm;
/**
 * @ClassName PrivCode
 * @Description TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-3-19   上午10:04:11
 */
public enum PrivCode {
	/**列表*/
	list("list"),
	/**查看*/
	view("view"),
	/**新增*/
	add("add"),
	/**修改*/
	modify("modify"),
	/**删除*/
	remove("remove"),
	/**启用*/
	on("on"),
	/**停用*/
	off("off"),
	/**上线*/
	online("online"),
	/**下线*/
	offline("offline"),
	/**批量导入*/
	batchImport("batchImport"),
	/**批量导出*/
	batchExport("batchExport"),
	/**重置密码*/
	resetPassword("resetPassword"),
	/**排序*/
	sort("sort");
	private String code;
	
	private PrivCode(String code){
		this.code = code;
	}
	
	public String getCode(){
		return this.code;
	}
}

