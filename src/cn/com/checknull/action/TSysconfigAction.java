/**  
* @Project: xproduct
* @Title: TSysconfigAction.java
* @Package cn.com.checknull.action
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-3-17 下午5:18:05
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.action;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.springframework.beans.factory.annotation.Autowired;

import cn.com.checknull.enm.MenuCode;
import cn.com.checknull.enm.OperateResult;
import cn.com.checknull.enm.PrivCode;
import cn.com.checknull.enm.SysconfigKey;
import cn.com.checknull.entity.TSysconfig;
import cn.com.checknull.interceptor.Permission;
import cn.com.checknull.service.TSysconfigService;
import cn.com.checknull.util.Md5Utils;
import cn.com.checknull.vo.QueryResult;
import cn.com.checknull.vo.ResultData;

/**
 * @ClassName TSysconfigAction
 * @Description TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-3-17   下午5:18:05
 */
@Namespace("/TSysconfig")
@ParentPackage("xproduct")
public class TSysconfigAction extends BaseAction {

	/** 
	* @Fields serialVersionUID : TODO
	*/ 
	private static final long serialVersionUID = -397609315837687168L;

	@Autowired
	private TSysconfigService tsysconfigService;
	
	/**
	 * 供搜索使用
	 */
	private String paramName;
	private String paramCode;
	
	/**
	 * 供查看使用
	 */
	private TSysconfig tsysconfig;
	@Permission(menuCode=MenuCode.sysconfig, privCode=PrivCode.list)
	@Action("list")
	public String list() {
		return SUCCESS;
	}
	@Permission(menuCode=MenuCode.sysconfig, privCode=PrivCode.list)
	@Action("getData")
	public String getData(){
		try {
			String whereJpql = "1=1";
			if (!StringUtils.isEmpty(paramName)){
				whereJpql =whereJpql + " and o.paramName = '"  + paramName + "'";
			}
			if (!StringUtils.isEmpty(paramCode)){
				whereJpql =whereJpql + " and o.paramCode = '"  + paramCode + "'";
			}
			QueryResult<TSysconfig> pages = tsysconfigService.findPage(pageIndex, pageSize, whereJpql, null, order, sort);
			putJSONResult(pages);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		return JSON;
	}
	@Permission(menuCode=MenuCode.sysconfig, privCode=PrivCode.view)
	@Action("view")
	public String view(){
		try {
			tsysconfig = tsysconfigService.find(id);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		return SUCCESS;
	}
	@Permission(menuCode=MenuCode.sysconfig, privCode=PrivCode.add)
	@Action("add")
	public String add(){
		return SUCCESS;
	}
	@Permission(menuCode=MenuCode.sysconfig, privCode=PrivCode.add)
	@Action("save")
	public String save(){
		ResultData result = new ResultData();
		try {
			tsysconfigService.insert(tsysconfig);
			result.setIserror(false);
			result.setMessage("成功");
			saveTLogOperate(PrivCode.add, OperateResult.SUCCESS, MenuCode.sysconfig, tsysconfig.getParamCode());
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			result.setIserror(true);
			result.setMessage(e.getMessage());
		}
		putJSONResult(result);
		return JSON;
	}
	@Permission(menuCode=MenuCode.sysconfig, privCode=PrivCode.modify)
	@Action("modify")
	public String modify(){
		try {
			tsysconfig = tsysconfigService.find(id);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		return SUCCESS;
	}
	@Permission(menuCode=MenuCode.sysconfig, privCode=PrivCode.modify)
	@Action("update")
	public String update(){
		ResultData result = new ResultData();
		try {
			tsysconfigService.mod(tsysconfig);
			result.setIserror(false);
			result.setMessage("成功");
			saveTLogOperate(PrivCode.modify, OperateResult.SUCCESS, MenuCode.sysconfig, tsysconfig.getParamCode());
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			result.setIserror(true);
			result.setMessage(e.getMessage());
		}
		putJSONResult(result);
		return JSON;
	}
	@Permission(menuCode=MenuCode.sysconfig, privCode=PrivCode.remove)
	@Action("remove")
	public String remove(){
		ResultData result = new ResultData();
		try {
			tsysconfigService.bathDelete(ids);
			result.setIserror(false);
			result.setMessage("成功");
			saveTLogOperate(PrivCode.remove, OperateResult.SUCCESS, MenuCode.sysconfig, ids);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			result.setIserror(true);
			result.setMessage(e.getMessage());
		}
		putJSONResult(result);
		return JSON;
	}
	
	@Action("getMD5Key")
	public String getMD5Key(){
		ResultData result = new ResultData();
		try {
			String md5Key = "";
			QueryResult<TSysconfig> tmpQRTSysconfig = tsysconfigService.findPage(-1, -1, "o.paramCode=?1", new Object[]{SysconfigKey.MD5_KEY.getKey()}, null, null);
			if (tmpQRTSysconfig != null && tmpQRTSysconfig.getTotal() > 0){
				md5Key = tmpQRTSysconfig.getRows().get(0).getParamValue();
			}
			result.setIserror(false);
			result.setData(Md5Utils.md5Encode(md5Key));
			result.setMessage("成功");
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			result.setIserror(true);
			result.setMessage(e.getMessage());
		}
		putJSONResult(result);
		return JSON;
	}

	public String getParamName() {
		return paramName;
	}

	public void setParamName(String paramName) {
		this.paramName = paramName;
	}

	public String getParamCode() {
		return paramCode;
	}

	public void setParamCode(String paramCode) {
		this.paramCode = paramCode;
	}

	public TSysconfig getTsysconfig() {
		return tsysconfig;
	}

	public void setTsysconfig(TSysconfig tsysconfig) {
		this.tsysconfig = tsysconfig;
	}
}

