/**  
* @Project: xproduct
* @Title: TLogLoginAction.java
* @Package cn.com.checknull.action
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-3-18 上午9:53:03
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.action;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.springframework.beans.factory.annotation.Autowired;

import cn.com.checknull.enm.MenuCode;
import cn.com.checknull.enm.PrivCode;
import cn.com.checknull.entity.TLogLogin;
import cn.com.checknull.interceptor.Permission;
import cn.com.checknull.service.TLogLoginService;
import cn.com.checknull.vo.QueryResult;
import cn.com.checknull.vo.ResultData;

/**
 * @ClassName TLogLoginAction
 * @Description TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-3-18   上午9:53:03
 */
@Namespace("/TLogLogin")
@ParentPackage("xproduct")
public class TLogLoginAction extends BaseAction {

	/** 
	* @Fields serialVersionUID : TODO
	*/ 
	private static final long serialVersionUID = -651547515983913196L;
	@Autowired
	private TLogLoginService tlogLoginService;
	
	/**
	 * 供搜索使用
	 */
	private String loginName;
	private String operatorName;
	private String result;
	private String type;
	
	/**
	 * 供查看使用
	 */
	private TLogLogin tlogLogin;
	@Permission(menuCode=MenuCode.logLogin, privCode=PrivCode.list)
	@Action("list")
	public String list() {
		return SUCCESS;
	}
	@Permission(menuCode=MenuCode.logLogin, privCode=PrivCode.list)
	@Action("getData")
	public String getData(){
		try {
			String whereJpql = "1=1";
			if (!StringUtils.isEmpty(loginName)){
				whereJpql =whereJpql + " and o.loginName = '"  + loginName + "'";
			}
			if (!StringUtils.isEmpty(operatorName)){
				whereJpql =whereJpql + " and o.operatorName = '"  + operatorName + "'";
			}
			if (!StringUtils.isEmpty(result)){
				int temResult = NumberUtils.toInt(result,1);
				whereJpql = whereJpql + " and o.result = " + temResult;
			}
			if (!StringUtils.isEmpty(type)){
				int temType = NumberUtils.toInt(type,1);
				whereJpql = whereJpql + " and o.type = " + temType;
			}
			QueryResult<TLogLogin> pages = tlogLoginService.findPage(pageIndex, pageSize, whereJpql, null, order, sort);
			putJSONResult(pages);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		return JSON;
	}
	@Permission(menuCode=MenuCode.logLogin, privCode=PrivCode.view)
	@Action("view")
	public String view(){
		try {
			tlogLogin = tlogLoginService.find(id);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		return SUCCESS;
	}
	@Permission(menuCode=MenuCode.logLogin, privCode=PrivCode.remove)
	@Action("remove")
	public String remove(){
		ResultData result = new ResultData();
		try {
			tlogLoginService.bathDelete(ids);
			result.setIserror(false);
			result.setMessage("成功");
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			result.setIserror(true);
			result.setMessage(e.getMessage());
		}
		putJSONResult(result);
		return JSON;
	}
	
	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getOperatorName() {
		return operatorName;
	}

	public void setOperatorName(String operatorName) {
		this.operatorName = operatorName;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public TLogLogin getTlogLogin() {
		return tlogLogin;
	}

	public void setTlogLogin(TLogLogin tlogLogin) {
		this.tlogLogin = tlogLogin;
	}
	
}

