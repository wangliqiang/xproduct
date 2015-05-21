/**  
* @Project: xproduct
* @Title: TOperatorAction.java
* @Package cn.com.checknull.action
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-3-17 上午9:53:41
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.action;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.springframework.beans.factory.annotation.Autowired;

import cn.com.checknull.enm.MenuCode;
import cn.com.checknull.enm.OperateResult;
import cn.com.checknull.enm.PrivCode;
import cn.com.checknull.entity.TOperator;
import cn.com.checknull.entity.TOperatorRole;
import cn.com.checknull.entity.TSysrole;
import cn.com.checknull.interceptor.Permission;
import cn.com.checknull.service.TOperatorRoleService;
import cn.com.checknull.service.TOperatorService;
import cn.com.checknull.service.TSysroleService;
import cn.com.checknull.util.Md5Utils;
import cn.com.checknull.vo.EasyTree;
import cn.com.checknull.vo.QueryResult;
import cn.com.checknull.vo.ResultData;

/**
 * @ClassName TOperatorAction
 * @Description TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-3-17   上午9:53:41
 */
@Namespace("/TOperator")
@ParentPackage("xproduct")
public class TOperatorAction extends BaseAction {

	/** 
	* @Fields serialVersionUID : TODO
	*/ 
	private static final long serialVersionUID = 4060638567136765654L;

	@Autowired
	private TOperatorService toperatorService;
	@Autowired
	private TOperatorRoleService toperatorRoleService;
	@Autowired
	private TSysroleService tsysroleService;
	/**
	 * 供搜索使用
	 */
	private String loginName;
	private String realName;
	private String status;
	private String isPlatoperator;
	/**
	 * 供查看使用
	 */
	private TOperator toperator;
	private List<String> roleNames;
	/**
	 * 供新增、修改使用
	 */
	private String roleIds;
	
	/**
	 * 修改个人密码
	 */
	private String password;
	private String newPassword;
	private String newPasswordRepeat;
	@Permission(menuCode=MenuCode.operator, privCode=PrivCode.list)
	@Action("list")
	public String list() {
		return SUCCESS;
	}
	@Permission(menuCode=MenuCode.operator, privCode=PrivCode.list)
	@Action("getData")
	public String getData(){
		try {
			String whereJpql = "1=1";
			if (!StringUtils.isEmpty(loginName)){
				whereJpql =whereJpql + " and o.loginName = '"  + loginName + "'";
			}
			if (!StringUtils.isEmpty(realName)){
				whereJpql =whereJpql + " and o.realName = '"  + realName + "'";
			}
			if (!StringUtils.isEmpty(status)){
				int temStatus = NumberUtils.toInt(status,1);
				whereJpql = whereJpql + " and o.status = " + temStatus;
			}
			if (!StringUtils.isEmpty(isPlatoperator)){
				int temIsPlatoperator = NumberUtils.toInt(isPlatoperator,1);
				whereJpql = whereJpql + " and o.isPlatoperator = " + temIsPlatoperator;
			}
			QueryResult<TOperator> pages = toperatorService.findPage(pageIndex, pageSize, whereJpql, null, order, sort);
			putJSONResult(pages);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		return JSON;
	}
	@Permission(menuCode=MenuCode.operator, privCode=PrivCode.view)
	@Action("view")
	public String view(){
		try {
			toperator = toperatorService.find(id);
			QueryResult<TOperatorRole> tmpQRTOperatorRole = toperatorRoleService.findPage(-1, -1, "o.operatorId=?1", new Object[]{id}, null, null);
			if (tmpQRTOperatorRole != null && tmpQRTOperatorRole.getTotal() > 0){
				roleIds = tmpQRTOperatorRole.getRows().get(0).getRoleIds();
				if (StringUtils.isEmpty(roleIds)) return SUCCESS;
				QueryResult<TSysrole> tmpQRTSysrole = tsysroleService.findPage(-1, -1, "o.id in (" + roleIds + ")", null, "asc", "id");
			    if (tmpQRTSysrole != null && tmpQRTSysrole.getTotal() > 0){
			    	roleNames = new ArrayList<String>();
			    	for (TSysrole tmpTSysrole : tmpQRTSysrole.getRows()){
			    		if (StringUtils.isEmpty(tmpTSysrole.getName())) continue;
			    		roleNames.add(tmpTSysrole.getName());
			    	}
			    }
			}
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		return SUCCESS;
	}
	@Action("viewSelf")
	public String viewSelf(){
		try {
			toperator = toperatorService.find(id);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		return SUCCESS;
	}
	@Permission(menuCode=MenuCode.operator, privCode=PrivCode.add)
	@Action("add")
	public String add(){
		return SUCCESS;
	}
	
	@Action("getRoleTree")
	public String getRoleTree(){
		List<EasyTree> easyTrees = new ArrayList<EasyTree>();
		try {
			 QueryResult<TSysrole> tmpQRTSysrole = tsysroleService.findPage(-1, -1, "o.status=1", null, "asc", "id");
			 if (tmpQRTSysrole != null && tmpQRTSysrole.getTotal() > 0){
				 EasyTree easyTree;
					for (TSysrole tmpTSysrole : tmpQRTSysrole.getRows()){
						easyTree = new EasyTree(tmpTSysrole.getId(), tmpTSysrole.getName());
						easyTrees.add(easyTree);
					}
			 }
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		putJSONResult(easyTrees);
		return JSON;
	}
	@Permission(menuCode=MenuCode.operator, privCode=PrivCode.add)
	@Action("save")
	public String save(){
		ResultData result = new ResultData();
		try {
			toperatorService.insert(toperator, roleIds);
			result.setIserror(false);
			result.setMessage("成功");
			saveTLogOperate(PrivCode.add, OperateResult.SUCCESS, MenuCode.operator, toperator.getLoginName());
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			result.setIserror(true);
			result.setMessage(e.getMessage());
		}
		putJSONResult(result);
		return JSON;
	}
	@Permission(menuCode=MenuCode.operator, privCode=PrivCode.modify)
	@Action("modify")
	public String modify(){
		try {
			toperator = toperatorService.find(id);
			 QueryResult<TOperatorRole> tmpTOperatorRole = toperatorRoleService.findPage(-1, -1, "o.operatorId=?1", new Object[]{id}, null, null);
			 if (tmpTOperatorRole != null && tmpTOperatorRole.getTotal() > 0){
				 roleIds = tmpTOperatorRole.getRows().get(0).getRoleIds();
			 }
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		return SUCCESS;
	}
	
	@Action("modifySelf")
	public String modifySelf(){
		try {
			toperator = toperatorService.find(id);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		return SUCCESS;
	}
	
	@Action("modifyPassword")
	public String modifyPassword(){
		return SUCCESS;
	}
	@Action("updatePassword")
	public String updatePassword(){
		ResultData result = new ResultData();
		try {
			toperator = toperatorService.find(id);
			if(!Md5Utils.md5Encode(password).equals(toperator.getPassword())){
				result.setIserror(true);
				result.setMessage("密码错误");
				putJSONResult(result);
				return JSON;
			}
			toperator.setPassword(Md5Utils.md5Encode(newPassword));
			toperatorService.mod(toperator);
			getCurrentOperator().setPassword(toperator.getPassword());
			result.setIserror(false);
			result.setMessage("成功");
			saveTLogOperate(PrivCode.modify, OperateResult.SUCCESS, MenuCode.operator, toperator.getLoginName());
		} catch (Exception e) {
			result.setIserror(true);
			result.setMessage("失败");
			logger.error(e.getMessage(), e);
		}
		putJSONResult(result);
		return JSON;
	}
	
	@Action("update")
	public String update(){
		ResultData result = new ResultData();
		try {
			toperatorService.mod(toperator,roleIds);
			result.setIserror(false);
			result.setMessage("成功");
			saveTLogOperate(PrivCode.modify, OperateResult.SUCCESS, MenuCode.operator, toperator.getLoginName());
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			result.setIserror(true);
			result.setMessage(e.getMessage());
		}
		putJSONResult(result);
		return JSON;
	}
	@Permission(menuCode=MenuCode.operator, privCode=PrivCode.remove)
	@Action("remove")
	public String remove(){
		ResultData result = new ResultData();
		try {
			toperatorService.bathDelete(ids);
			result.setIserror(false);
			result.setMessage("成功");
			saveTLogOperate(PrivCode.remove, OperateResult.SUCCESS, MenuCode.operator, ids);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			result.setIserror(true);
			result.setMessage(e.getMessage());
		}
		putJSONResult(result);
		return JSON;
	}
	@Permission(menuCode=MenuCode.operator, privCode=PrivCode.on)
	@Action("on")
	public String on(){
		ResultData result = new ResultData();
		try {
			toperatorService.bathOn(ids);
			result.setIserror(false);
			result.setMessage("成功");
			saveTLogOperate(PrivCode.on, OperateResult.SUCCESS, MenuCode.operator, ids);
		} catch (Exception e) {
			result.setIserror(true);
			result.setMessage("失败");
			logger.error(e.getMessage(), e);
		}
		putJSONResult(result);
		return JSON;
	}
	@Permission(menuCode=MenuCode.operator, privCode=PrivCode.off)
	@Action("off")
	public String off(){
		ResultData result = new ResultData();
		try {
			toperatorService.bathOff(ids);
			result.setIserror(false);
			result.setMessage("成功");
			saveTLogOperate(PrivCode.off, OperateResult.SUCCESS, MenuCode.operator, ids);
		} catch (Exception e) {
			result.setIserror(true);
			result.setMessage("失败");
			logger.error(e.getMessage(), e);
		}
		putJSONResult(result);
		return JSON;
	}
	@Permission(menuCode=MenuCode.operator, privCode=PrivCode.resetPassword)
	@Action("resetPassword")
	public String resetPassword(){
		ResultData result = new ResultData();
		try {
			toperatorService.bathResetPassword(ids);
			result.setIserror(false);
			result.setMessage("成功");
			saveTLogOperate(PrivCode.resetPassword, OperateResult.SUCCESS, MenuCode.operator, ids);
		} catch (Exception e) {
			result.setIserror(true);
			result.setMessage("失败");
			logger.error(e.getMessage(), e);
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

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getIsPlatoperator() {
		return isPlatoperator;
	}
	public void setIsPlatoperator(String isPlatoperator) {
		this.isPlatoperator = isPlatoperator;
	}
	public TOperator getToperator() {
		return toperator;
	}

	public void setToperator(TOperator toperator) {
		this.toperator = toperator;
	}

	public String getRoleIds() {
		return roleIds;
	}

	public void setRoleIds(String roleIds) {
		this.roleIds = roleIds;
	}

	public List<String> getRoleNames() {
		return roleNames;
	}

	public void setRoleNames(List<String> roleNames) {
		this.roleNames = roleNames;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getNewPassword() {
		return newPassword;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}

	public String getNewPasswordRepeat() {
		return newPasswordRepeat;
	}

	public void setNewPasswordRepeat(String newPasswordRepeat) {
		this.newPasswordRepeat = newPasswordRepeat;
	}
}

