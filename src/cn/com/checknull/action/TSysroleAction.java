/**  
* @Project: xproduct
* @Title: TSysroleAction.java
* @Package cn.com.checknull.action
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-3-13 下午3:08:14
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.action;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.springframework.beans.factory.annotation.Autowired;

import cn.com.checknull.enm.MenuCode;
import cn.com.checknull.enm.OperateResult;
import cn.com.checknull.enm.PrivCode;
import cn.com.checknull.entity.TSysmenu;
import cn.com.checknull.entity.TSyspriv;
import cn.com.checknull.entity.TSysrole;
import cn.com.checknull.entity.TSysroleMenu;
import cn.com.checknull.entity.TSysrolePriv;
import cn.com.checknull.interceptor.Permission;
import cn.com.checknull.service.TSysmenuService;
import cn.com.checknull.service.TSysprivService;
import cn.com.checknull.service.TSysroleMenuService;
import cn.com.checknull.service.TSysrolePrivService;
import cn.com.checknull.service.TSysroleService;
import cn.com.checknull.vo.EasyTree;
import cn.com.checknull.vo.QueryResult;
import cn.com.checknull.vo.ResultData;

/**
 * @ClassName TSysroleAction
 * @Description TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-3-13   下午3:08:14
 */
@Namespace("/TSysrole")
@ParentPackage("xproduct")
public class TSysroleAction extends BaseAction {

	/** 
	* @Fields serialVersionUID : TODO
	*/ 
	private static final long serialVersionUID = -3813839176151141931L;

	@Autowired
	private TSysroleService tsysroleService;
	@Autowired
	private TSysmenuService tsysmenuService;
	@Autowired
	private TSysprivService tsysprivService;
	@Autowired
	private TSysroleMenuService tsysroleMenuService;
	@Autowired
	private TSysrolePrivService tsysrolePrivService;
	/**
	 * 供搜索使用
	 */
	private String name;
	private String type;
	private String status;
	/**
	 * 供新增、修改使用
	 */
	private TSysrole tsysrole;
	private String menuIds;
	private String privIds;

	/**
	 * 供查看使用，key=menu，value=privs
	 */
	private Map<TSysmenu, List<TSyspriv>> maps = new LinkedHashMap<TSysmenu, List<TSyspriv>>();
	@Permission(menuCode=MenuCode.sysrole, privCode=PrivCode.list)
	@Action("list")
	public String list() {
		return SUCCESS;
	}
	@Permission(menuCode=MenuCode.sysrole, privCode=PrivCode.list)
	@Action("getData")
	public String getData(){
		try {
			String whereJpql = "1=1";
			if (!StringUtils.isEmpty(name)){
				whereJpql =whereJpql + " and o.name = '"  + name + "'";
			}
			if (!StringUtils.isEmpty(type)){
				int temType = NumberUtils.toInt(type,1);
				whereJpql = whereJpql + " and o.type = " + temType;
			}
			if (!StringUtils.isEmpty(status)){
				int temStatus = NumberUtils.toInt(status,1);
				whereJpql = whereJpql + " and o.status = " + temStatus;
			}
			QueryResult<TSysrole> pages = tsysroleService.findPage(pageIndex, pageSize, whereJpql, null, order, sort);
			putJSONResult(pages);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		return JSON;
	}
	@Permission(menuCode=MenuCode.sysrole, privCode=PrivCode.view)
	@Action("view")
	public String view(){
		try {
			tsysrole = tsysroleService.find(id);
			QueryResult<TSysroleMenu> tmpQRTSysroleMenu = tsysroleMenuService.findPage(-1, -1, "o.roleId=" + id, null, null, null);
			if (tmpQRTSysroleMenu != null && tmpQRTSysroleMenu.getTotal() > 0){
				TSysroleMenu tmpTSysroleMenu = tmpQRTSysroleMenu.getRows().get(0);
				menuIds = tmpTSysroleMenu.getMenuIds();
				if (StringUtils.isEmpty(menuIds)) return SUCCESS;
				QueryResult<TSysmenu> tmpQRTSysmenu = tsysmenuService.findPage(-1, -1, "o.id in (" + menuIds + ")", null, "asc", "sequence");
				if (tmpQRTSysmenu != null && tmpQRTSysmenu.getTotal() > 0){
					QueryResult<TSysrolePriv> tmpQRTSysrolePriv = tsysrolePrivService.findPage(-1, -1, "o.roleId=" + id, null, null, null);
					TSysrolePriv tmpTSysrolePriv = null;
					if (tmpQRTSysrolePriv != null && tmpQRTSysrolePriv.getTotal() > 0){
						tmpTSysrolePriv = tmpQRTSysrolePriv.getRows().get(0);
						List<TSyspriv> tmpListTSyspriv;
						privIds = tmpTSysrolePriv.getPrivIds();
						String tmpPrivIds = "," + privIds + ",";
						for (TSysmenu tmpTSysmenu : tmpQRTSysmenu.getRows()){
							if (StringUtils.isEmpty(privIds)){
								maps.put(tmpTSysmenu, null);
								continue;
							}
							QueryResult<TSyspriv> tmpQRTSyspriv = tsysprivService.findPage(-1, -1, "o.menu.id=" + tmpTSysmenu.getId(), null, "asc", "sequence");
							if (tmpQRTSyspriv != null && tmpQRTSyspriv.getTotal() > 0){
								tmpListTSyspriv = new ArrayList<TSyspriv>();
								for (TSyspriv tmpTSyspriv : tmpQRTSyspriv.getRows()){
									if (tmpPrivIds.indexOf("," + tmpTSyspriv.getId() + ",") >= 0){
										tmpListTSyspriv.add(tmpTSyspriv);
									}
								}
								maps.put(tmpTSysmenu, tmpListTSyspriv);
							}else{
								maps.put(tmpTSysmenu, null);
							}
						}
					}else{
						for (TSysmenu tmpTSysmenu : tmpQRTSysmenu.getRows()){
							maps.put(tmpTSysmenu, null);
						}
					}
				}
			}
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		return SUCCESS;
	}
	
	@Action("getPrivTree")
	public String getPrivTree(){
		List<EasyTree> tmpMenus = new ArrayList<EasyTree>();
		try {
			  //获取一级菜单
			 QueryResult<TSysmenu>  tmpQRTSysmenu = tsysmenuService.findPage(-1, -1, "o.level=1 and status=1", null, "asc", "sequence");
			 //获取二级菜单
			 QueryResult<TSysmenu>  tmpQR2TSysmenu = null;
			 //获取权限
			 QueryResult<TSyspriv> tmpQRTSyspriv = null;
			 if (tmpQRTSysmenu != null && tmpQRTSysmenu.getTotal() > 0){
				 EasyTree tmpMenu;
				 for (TSysmenu tmpTSysmenu : tmpQRTSysmenu.getRows()){
					 tmpMenu = new EasyTree(tmpTSysmenu.getId(), tmpTSysmenu.getName());
					 //获取二级菜单
					 tmpQR2TSysmenu = tsysmenuService.findPage(-1, -1, "o.level=2 and status=1 and o.parentMenu.id=" + tmpTSysmenu.getId(), null, "asc", "sequence");
					 if (tmpQR2TSysmenu != null && tmpQR2TSysmenu.getTotal() > 0){
						 List<EasyTree> tmp2Menus = new ArrayList<EasyTree>();
						 EasyTree tmp2Menu;
						 for (TSysmenu tmp2TSysmenu : tmpQR2TSysmenu.getRows()){
							 tmp2Menu = new EasyTree(tmpTSysmenu.getId() + "-" + tmp2TSysmenu.getId(), tmp2TSysmenu.getName(), "closed");
							 //获取权限
							 tmpQRTSyspriv = tsysprivService.findPage(-1, -1, "o.menu.id=" + tmp2TSysmenu.getId() + " and o.status=1", null, "asc", "sequence");
							 if (tmpQRTSyspriv != null && tmpQRTSyspriv.getTotal() > 0){
								 tmp2Menus.add(tmp2Menu);
								 List<EasyTree> tmp3Menus = new ArrayList<EasyTree>();
								 tmp2Menu.setChildren(tmp3Menus);
								 EasyTree tmp3Menu;
								 for (TSyspriv tmpTSyspriv : tmpQRTSyspriv.getRows()){
									 tmp3Menu = new EasyTree(tmpTSysmenu.getId() + "-" + tmp2TSysmenu.getId() + "-" + tmpTSyspriv.getId(), tmpTSyspriv.getName());
									 tmp3Menus.add(tmp3Menu);
								 }
							 }
						 }
						 if (tmpQRTSyspriv != null && tmpQRTSyspriv.getTotal() > 0){
							 tmpMenus.add(tmpMenu);
							 tmpMenu.setChildren(tmp2Menus);
						 }
					 }
				 }
			 }
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		putJSONResult(tmpMenus);
		return JSON;
	}
	@Permission(menuCode=MenuCode.sysrole, privCode=PrivCode.add)
	@Action("add")
	public String add(){
		return SUCCESS;
	}
	@Permission(menuCode=MenuCode.sysrole, privCode=PrivCode.add)
	@Action("save")
	public String save(){
		ResultData result = new ResultData();
		try {
			tsysroleService.insert(tsysrole, menuIds, privIds);
			result.setIserror(false);
			result.setMessage("成功");
			saveTLogOperate(PrivCode.add, OperateResult.SUCCESS, MenuCode.sysrole, tsysrole.getName());
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			result.setIserror(true);
			result.setMessage(e.getMessage());
		}
		putJSONResult(result);
		return JSON;
	}
	@Permission(menuCode=MenuCode.sysrole, privCode=PrivCode.modify)
	@Action("modify")
	public String modify(){
		try {
			tsysrole = tsysroleService.find(id);
			QueryResult<TSysrolePriv> tmpQRTSysrolePriv = tsysrolePrivService.findPage(-1, -1, "o.roleId=" + id, null, null, null);;
			 if (tmpQRTSysrolePriv != null && tmpQRTSysrolePriv.getTotal() > 0){
				 TSysrolePriv tmpTSysrolePriv = tmpQRTSysrolePriv.getRows().get(0);
				 privIds = tmpTSysrolePriv.getPrivIds();
			 }
			QueryResult<TSysroleMenu> tmpQRTSysroleMenu = tsysroleMenuService.findPage(-1, -1, "o.roleId=" + id, null, null, null);
			if (tmpQRTSysroleMenu != null && tmpQRTSysroleMenu.getTotal() > 0){
				TSysroleMenu tmpTSysroleMenu = tmpQRTSysroleMenu.getRows().get(0);
				menuIds = tmpTSysroleMenu.getMenuIds();
			}
			String finalPrivIds = "";
			if (!StringUtils.isEmpty(menuIds) && !StringUtils.isEmpty(privIds)){
				String tmpPrivIds = "," + privIds + ",";
				QueryResult<TSysmenu> tmpQRTSysmenu = tsysmenuService.findPage(-1, -1, "o.id in (" + menuIds + ") and o.status=1", null, "asc", "sequence");
				if (tmpQRTSysmenu != null && tmpQRTSysmenu.getTotal() > 0){
					long tmpMenuId;
					long tmpParentMuneId;
					QueryResult<TSyspriv> tmpQRTSyspriv;
					String tmpPrivId;
					for (TSysmenu tmpTSysmenu : tmpQRTSysmenu.getRows()){
						if (tmpTSysmenu.getLevel() == 2){
							tmpMenuId = tmpTSysmenu.getId();
							tmpParentMuneId = tmpTSysmenu.getParentMenu().getId();
							tmpQRTSyspriv = tsysprivService.findPage(-1, -1, "o.menu.id=" + tmpMenuId + " and o.status=1", null, "asc", "sequence");
							if (tmpQRTSyspriv != null && tmpQRTSyspriv.getTotal() > 0){
								for (TSyspriv tmpTSyspriv : tmpQRTSyspriv.getRows()){
									tmpPrivId = "," + tmpTSyspriv.getId() + ",";
									if (tmpPrivIds.indexOf(tmpPrivId) >= 0){
										finalPrivIds = finalPrivIds + tmpParentMuneId + "-" + tmpMenuId + "-" + tmpTSyspriv.getId() + "," ;
									}
								}
							}
						}
					}
				}
			}
			if (!StringUtils.isEmpty(finalPrivIds)){
				finalPrivIds = StringUtils.removeEnd(finalPrivIds, ",");
			}
			privIds = finalPrivIds;
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		return SUCCESS;
	}
	@Permission(menuCode=MenuCode.sysrole, privCode=PrivCode.modify)
	@Action("update")
	public String update(){
		ResultData result = new ResultData();
		try {
			tsysroleService.mod(tsysrole, menuIds, privIds);
			result.setIserror(false);
			result.setMessage("成功");
			saveTLogOperate(PrivCode.modify, OperateResult.SUCCESS, MenuCode.sysrole, tsysrole.getName());
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			result.setIserror(true);
			result.setMessage(e.getMessage());
		}
		putJSONResult(result);
		return JSON;
	}
	@Permission(menuCode=MenuCode.sysrole, privCode=PrivCode.remove)
	@Action("remove")
	public String remove(){
		ResultData result = new ResultData();
		try {
			tsysroleService.bathDelete(ids);
			result.setIserror(false);
			result.setMessage("成功");
			saveTLogOperate(PrivCode.remove, OperateResult.SUCCESS, MenuCode.sysrole, ids);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			result.setIserror(true);
			result.setMessage(e.getMessage());
		}
		putJSONResult(result);
		return JSON;
	}
	@Permission(menuCode=MenuCode.sysrole, privCode=PrivCode.on)
	@Action("on")
	public String on(){
		ResultData result = new ResultData();
		try {
			tsysroleService.bathOn(ids);
			result.setIserror(false);
			result.setMessage("成功");
			saveTLogOperate(PrivCode.on, OperateResult.SUCCESS, MenuCode.sysrole, ids);
		} catch (Exception e) {
			result.setIserror(true);
			result.setMessage("失败");
			logger.error(e.getMessage(), e);
		}
		putJSONResult(result);
		return JSON;
	}
	@Permission(menuCode=MenuCode.sysrole, privCode=PrivCode.off)
	@Action("off")
	public String off(){
		ResultData result = new ResultData();
		try {
			tsysroleService.bathOff(ids);
			result.setIserror(false);
			result.setMessage("成功");
			saveTLogOperate(PrivCode.off, OperateResult.SUCCESS, MenuCode.sysrole, ids);
		} catch (Exception e) {
			result.setIserror(true);
			result.setMessage("失败");
			logger.error(e.getMessage(), e);
		}
		putJSONResult(result);
		return JSON;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public TSysrole getTsysrole() {
		return tsysrole;
	}

	public void setTsysrole(TSysrole tsysrole) {
		this.tsysrole = tsysrole;
	}

	public String getMenuIds() {
		return menuIds;
	}

	public void setMenuIds(String menuIds) {
		this.menuIds = menuIds;
	}

	public String getPrivIds() {
		return privIds;
	}

	public void setPrivIds(String privIds) {
		this.privIds = privIds;
	}

	public Map<TSysmenu, List<TSyspriv>> getMaps() {
		return maps;
	}

	public void setMaps(Map<TSysmenu, List<TSyspriv>> maps) {
		this.maps = maps;
	}
}

