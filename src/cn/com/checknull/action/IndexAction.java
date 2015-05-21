/**  
* @Project: xproduct
* @Title: IndexAction.java
* @Package cn.com.pkit.action
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-2-13 上午10:09:38
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.action;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.springframework.beans.factory.annotation.Autowired;

import cn.com.checknull.enm.SessionAttribute;
import cn.com.checknull.entity.TOperator;
import cn.com.checknull.entity.TOperatorRole;
import cn.com.checknull.entity.TSysmenu;
import cn.com.checknull.entity.TSyspriv;
import cn.com.checknull.entity.TSysroleMenu;
import cn.com.checknull.entity.TSysrolePriv;
import cn.com.checknull.service.TOperatorRoleService;
import cn.com.checknull.service.TOperatorService;
import cn.com.checknull.service.TSysmenuService;
import cn.com.checknull.service.TSysprivService;
import cn.com.checknull.service.TSysroleMenuService;
import cn.com.checknull.service.TSysrolePrivService;
import cn.com.checknull.vo.QueryResult;

/**
 * @ClassName IndexAction
 * @Description TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-2-13   上午10:09:38
 */
@Namespace("/")
@ParentPackage("xproduct")
public class IndexAction extends BaseAction {

	/** 
	* @Fields serialVersionUID : TODO
	*/ 
	private static final long serialVersionUID = -5994334327851063634L;
	
	@Autowired
	private TOperatorService toperatorService;
	@Autowired
	private TOperatorRoleService toperatorRoleService;
	@Autowired
	private TSysroleMenuService tsysroleMenuService;
	@Autowired
	private TSysrolePrivService tsysrolePrivService;
	@Autowired
	private TSysmenuService  tsysmenuService;
	@Autowired
	private TSysprivService tsysprivService;
	
	private List<TSysmenu> tsysmenus;
	
	public void validateIndex(){
		logger.debug("do validateIndex...");
	}
	
	public void validateDoIndex(){
		logger.debug("do validateDoIndex...");
	}
	
	@Action("index")
	public String index(){
		try{
			TOperator toperator = getCurrentOperator();
			TOperator tmpTOperator = toperator == null ? null : toperatorService.find(toperator.getId()); 
			if (tmpTOperator == null) return SUCCESS;
			QueryResult<TOperatorRole>  tmpQRTOperatorRole = toperatorRoleService.findPage(-1, -1, "o.operatorId=?1", new Object[]{toperator.getId()}, null, null);
			if (tmpQRTOperatorRole == null || tmpQRTOperatorRole.getTotal() == 0) return SUCCESS;
			TOperatorRole tmpTOperatorRole = tmpQRTOperatorRole.getRows().get(0);
			String tmpRoleIds = tmpTOperatorRole.getRoleIds();
			if (StringUtils.isEmpty(tmpRoleIds)) return SUCCESS;
			QueryResult<TSysroleMenu> tmpQRTSysroleMenu = tsysroleMenuService.findPage(-1, -1, "o.roleId in (" + tmpRoleIds + ")", null, "asc", "id");
			if (tmpQRTSysroleMenu == null || tmpQRTSysroleMenu.getTotal() == 0) return SUCCESS;
			String tmpRepeatMenuIds = "";
			for (TSysroleMenu tmpTSysroleMenu : tmpQRTSysroleMenu.getRows()){
				if (StringUtils.isEmpty(tmpTSysroleMenu.getMenuIds())) continue;
				tmpRepeatMenuIds = tmpRepeatMenuIds + tmpTSysroleMenu.getMenuIds() + ",";
			}
			if (StringUtils.isEmpty(tmpRepeatMenuIds)) return SUCCESS;
			tmpRepeatMenuIds = StringUtils.removeEnd(tmpRepeatMenuIds, ",");
			String[] tmpArrayMenuId = tmpRepeatMenuIds.split(",");
			Set<String> tmpSetMenuId = new HashSet<String>();
			for (String tmpMenuId : tmpArrayMenuId){
				tmpSetMenuId.add(tmpMenuId);
			}
			String tmpMenuIds = "";
			for (String tmpMenuId : tmpSetMenuId){
				tmpMenuIds = tmpMenuIds + tmpMenuId + ",";
			}
			tmpMenuIds = StringUtils.removeEnd(tmpMenuIds, ",");
			QueryResult<TSysmenu> tmpQRTSysmenu = tsysmenuService.findPage(-1, -1, "o.id in (" + tmpMenuIds + ")", null, "asc", "sequence");
			if (tmpQRTSysmenu == null || tmpQRTSysmenu.getTotal() == 0) return SUCCESS;
			tsysmenus = tmpQRTSysmenu.getRows();
			QueryResult<TSysrolePriv> tmpQRTSysrolePriv = tsysrolePrivService.findPage(-1, -1, "o.roleId in (" + tmpRoleIds + ")", null, "asc", "id");
			if (tmpQRTSysrolePriv == null || tmpQRTSysrolePriv.getTotal() == 0) return SUCCESS;
			String tmpRepeatPrivIds = "";
			for (TSysrolePriv tmpTSysrolePriv : tmpQRTSysrolePriv.getRows()){
				if (StringUtils.isEmpty(tmpTSysrolePriv.getPrivIds())) continue;
				tmpRepeatPrivIds = tmpRepeatPrivIds + tmpTSysrolePriv.getPrivIds() + ",";
			}
			if (StringUtils.isEmpty(tmpRepeatPrivIds)) return SUCCESS;
			tmpRepeatPrivIds = StringUtils.removeEnd(tmpRepeatPrivIds, ",");
			String[] tmpArrayPrivId = tmpRepeatPrivIds.split(",");
			Set<String> tmpSetPrivId = new HashSet<String>();
			for (String tmpPrivId : tmpArrayPrivId){
				tmpSetPrivId.add(tmpPrivId);
			}
			String tmpPrivIds = "";
			for (String tmpPrivId : tmpSetPrivId){
				tmpPrivIds = tmpPrivIds + tmpPrivId + ",";
			}
			tmpPrivIds = "," + tmpPrivIds;
			//权限
			Map<String, List<TSyspriv>> permission = new LinkedHashMap<String, List<TSyspriv>>();
			List<TSyspriv> tmpListTSyspriv;
			for (TSysmenu tmpTSysmenu : tsysmenus){
				if (StringUtils.isEmpty(tmpTSysmenu.getCode())) continue;
				 QueryResult<TSyspriv> tmpQRTSyspriv = tsysprivService.findPage(-1, -1, "o.menu.id=?1", new Object[]{tmpTSysmenu.getId()}, "asc", "sequence");
				 if (tmpQRTSyspriv == null || tmpQRTSyspriv.getTotal() == 0) {
					 permission.put(tmpTSysmenu.getCode(), null);
					 continue;
				 }
				 tmpListTSyspriv = new ArrayList<TSyspriv>();
				 for (TSyspriv tmpTSyspriv : tmpQRTSyspriv.getRows()){
					 String tmpPrivId = "," + tmpTSyspriv.getId() + ",";
					 if (tmpPrivIds.indexOf(tmpPrivId) >= 0){
						 tmpListTSyspriv.add(tmpTSyspriv);
					 }
				 }
				if (tmpListTSyspriv.isEmpty()) permission.put(tmpTSysmenu.getCode(), null);
				else permission.put(tmpTSysmenu.getCode(), tmpListTSyspriv);
				
				request.getSession().setAttribute(SessionAttribute.PERMISSION.getAttribute(), permission);
			}
			
				
		}catch (Exception e){
			logger.error(e.getMessage(), e);
		}
		return SUCCESS;
	}
	
	@Action("welcome")
	public String welcome(){
		return SUCCESS;
	}

	public List<TSysmenu> getTsysmenus() {
		return tsysmenus;
	}

	public void setTsysmenus(List<TSysmenu> tsysmenus) {
		this.tsysmenus = tsysmenus;
	}
}

