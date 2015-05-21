/**  
* @Project: xproduct
* @Title: EasyTree.java
* @Package cn.com.checknull.vo
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-3-2 下午3:08:21
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.vo;

import java.util.List;

/**
 * @ClassName EasyTree
 * @Description TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-3-2   下午3:08:21
 */
public class EasyTree {
	private Object id;
	private String text;
	private String state;
	private List<EasyTree> children;
	private String iconCls;
	public EasyTree() {
		super();
	}
	public EasyTree(Object id, String text) {
		super();
		this.id = id;
		this.text = text;
	}
	
	public EasyTree(Object id, String text, String state) {
		super();
		this.id = id;
		this.text = text;
		this.state = state;
	}
	public Object getId() {
		return id;
	}
	public void setId(Object id) {
		this.id = id;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public List<EasyTree> getChildren() {
		return children;
	}
	public void setChildren(List<EasyTree> children) {
		this.children = children;
	}
	public String getIconCls() {
		return iconCls;
	}
	public void setIconCls(String iconCls) {
		this.iconCls = iconCls;
	}
}

