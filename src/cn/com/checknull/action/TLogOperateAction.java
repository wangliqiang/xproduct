/**  
* @Project: xproduct
* @Title: TLogOperateAction.java
* @Package cn.com.checknull.action
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-3-18 上午10:00:08
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
import cn.com.checknull.entity.TLogOperate;
import cn.com.checknull.interceptor.Permission;
import cn.com.checknull.service.TLogOperateService;
import cn.com.checknull.vo.QueryResult;
import cn.com.checknull.vo.ResultData;

/**
 * @ClassName TLogOperateAction
 * @Description TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-3-18   上午10:00:08
 */
@Namespace("/TLogOperate")
@ParentPackage("xproduct")
public class TLogOperateAction extends BaseAction {

	/** 
	* @Fields serialVersionUID : TODO
	*/ 
	private static final long serialVersionUID = -5386146197854682703L;

	@Autowired
	private TLogOperateService tlogOperateService;
	
	/**
	 * 供搜索使用
	 */
	private String loginName;
	private String operatorName;
	private String operateObject;
	private String operateResult;
	
	/**
	 * 供查看使用
	 */
	private TLogOperate tlogOperate;
	@Permission(menuCode=MenuCode.logOperate, privCode=PrivCode.list)
	@Action("list")
	public String list() {
		return SUCCESS;
	}
	@Permission(menuCode=MenuCode.logOperate, privCode=PrivCode.list)
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
			if (!StringUtils.isEmpty(operateObject)){
				whereJpql =whereJpql + " and o.operateObject = '"  + operateObject + "'";
			}
			if (!StringUtils.isEmpty(operateResult)){
				int temOperateResult = NumberUtils.toInt(operateResult,1);
				whereJpql = whereJpql + " and o.operateResult = " + temOperateResult;
			}
			QueryResult<TLogOperate> pages = tlogOperateService.findPage(pageIndex, pageSize, whereJpql, null, order, sort);
			putJSONResult(pages);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		return JSON;
	}
	@Permission(menuCode=MenuCode.logOperate, privCode=PrivCode.view)
	@Action("view")
	public String view(){
		try {
			tlogOperate = tlogOperateService.find(id);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		return SUCCESS;
	}
	@Permission(menuCode=MenuCode.logOperate, privCode=PrivCode.remove)
	@Action("remove")
	public String remove(){
		ResultData result = new ResultData();
		try {
			tlogOperateService.bathDelete(ids);
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

	public String getOperateObject() {
		return operateObject;
	}

	public void setOperateObject(String operateObject) {
		this.operateObject = operateObject;
	}

	public String getOperateResult() {
		return operateResult;
	}

	public void setOperateResult(String operateResult) {
		this.operateResult = operateResult;
	}

	public TLogOperate getTlogOperate() {
		return tlogOperate;
	}

	public void setTlogOperate(TLogOperate tlogOperate) {
		this.tlogOperate = tlogOperate;
	}
}

