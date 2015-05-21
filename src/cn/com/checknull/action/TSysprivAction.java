/**  
* @Project: xproduct
* @Title: TSysprivAction.java
* @Package cn.com.checknull.action
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-3-2 下午2:28:56
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.action;

import java.sql.SQLException;
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
import cn.com.checknull.entity.TSysmenu;
import cn.com.checknull.entity.TSyspriv;
import cn.com.checknull.interceptor.Permission;
import cn.com.checknull.service.TSysmenuService;
import cn.com.checknull.service.TSysprivService;
import cn.com.checknull.vo.EasyTree;
import cn.com.checknull.vo.QueryResult;
import cn.com.checknull.vo.ResultData;

/**
 * @ClassName TSysprivAction
 * @Description TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-3-2   下午2:28:56
 */
@Namespace("/TSyspriv")
@ParentPackage("xproduct")
public class TSysprivAction extends BaseAction{

	/** 
	* @Fields serialVersionUID : TODO
	*/ 
	private static final long serialVersionUID = 2215659440946906295L;
	
	@Autowired
	private TSysprivService tsysprivService;
	@Autowired
	private TSysmenuService tsysmenuService;
	/**
	 * 供搜索使用
	 */
	private String name;
	private String code;
	private String status;
	private String menuId;
	/**
	 * 供查看、新增、修改使用
	 */
	private TSyspriv tsyspriv;
	/**
	 * 供新增使用
	 */
	private TSysmenu tsysmenu;
	@Permission(menuCode=MenuCode.syspriv, privCode=PrivCode.list)
	@Action("list")
	public String list() {
		return SUCCESS;
	}
	
	@Action("getMenu")
	public String getMenu() {
		List<EasyTree> menus = new ArrayList<EasyTree>();
		try {
			//查询一级菜单
			QueryResult<TSysmenu> topMenus = tsysmenuService.findPage(-1, -1, "o.level=1 and status=1", null, "asc", "sequence");
			if (topMenus != null && topMenus.getTotal() > 0){
				EasyTree menu;
				EasyTree child;
				List<EasyTree> children;
				QueryResult<TSysmenu> secondMenus;
				for (TSysmenu topMenu : topMenus.getRows()){
					menu = new EasyTree(topMenu.getId(), topMenu.getName());
					menus.add(menu);
					secondMenus = tsysmenuService.findPage(-1, -1, "o.level=2 and status=1 and o.parentMenu.id=" + menu.getId(), null, "asc", "sequence");
					if (secondMenus != null && secondMenus.getTotal() > 0){
						children = new ArrayList<EasyTree>(); 
						for (TSysmenu secondMenu : secondMenus.getRows()){
							child = new EasyTree(secondMenu.getId(), secondMenu.getName());
							children.add(child);
						} 
						menu.setChildren(children);
					}
				}
			}
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		putJSONResult(menus);
		return JSON;
	}
	@Permission(menuCode=MenuCode.syspriv, privCode=PrivCode.list)
	@Action("getData")
	public String getData(){
		try {
			String whereJpql = "1=1";
			if (!StringUtils.isEmpty(name)){
				whereJpql =whereJpql + " and o.name = '"  + name + "'";
			}
			if (!StringUtils.isEmpty(code)){
				whereJpql =whereJpql + " and o.code = '"  + code + "'";
			}
			if (!StringUtils.isEmpty(status)){
				int temStatus = NumberUtils.toInt(status,1);
				whereJpql = whereJpql + " and o.status = " + temStatus;
			}
			if (!StringUtils.isEmpty(menuId)){
				int temMenuId = NumberUtils.toInt(menuId,1);
				whereJpql = whereJpql + " and o.menu.id = " + temMenuId;
			}
			QueryResult<TSyspriv> pages = tsysprivService.findPage(pageIndex, pageSize, whereJpql, null, order, sort);
			putJSONResult(pages);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		return JSON;
	}
	@Permission(menuCode=MenuCode.syspriv, privCode=PrivCode.view)
	@Action("view")
	public String view(){
		try {
			tsyspriv = tsysprivService.find(id);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		return SUCCESS;
	}
	@Permission(menuCode=MenuCode.syspriv, privCode=PrivCode.add)
	@Action("add")
	public String add(){
		try {
			tsysmenu = tsysmenuService.find(NumberUtils.toLong(menuId));
		} catch (SQLException e) {
			logger.error(e.getMessage(), e);
		}
		return SUCCESS;
	}
	@Permission(menuCode=MenuCode.syspriv, privCode=PrivCode.add)
	@Action("save")
	public String save(){
		ResultData result = new ResultData();
		try {
			tsysprivService.insert(tsyspriv);
			result.setIserror(false);
			result.setMessage("成功");
			saveTLogOperate(PrivCode.add, OperateResult.SUCCESS, MenuCode.syspriv, tsyspriv.getName());
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			result.setIserror(true);
			result.setMessage(e.getMessage());
		}
		putJSONResult(result);
		return JSON;
	}
	@Permission(menuCode=MenuCode.syspriv, privCode=PrivCode.modify)
	@Action("modify")
	public String modify(){
		try {
			tsyspriv = tsysprivService.find(id);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		return SUCCESS;
	}
	@Permission(menuCode=MenuCode.syspriv, privCode=PrivCode.modify)
	@Action("update")
	public String update(){
		ResultData result = new ResultData();
		try {
			tsysprivService.mod(tsyspriv);
			result.setIserror(false);
			result.setMessage("成功");
			saveTLogOperate(PrivCode.modify, OperateResult.SUCCESS, MenuCode.syspriv, tsyspriv.getName());
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			result.setIserror(true);
			result.setMessage(e.getMessage());
		}
		putJSONResult(result);
		return JSON;
	}
	@Permission(menuCode=MenuCode.syspriv, privCode=PrivCode.remove)
	@Action("remove")
	public String remove(){
		ResultData result = new ResultData();
		try {
			tsysprivService.bathDelete(ids);
			result.setIserror(false);
			result.setMessage("成功");
			saveTLogOperate(PrivCode.remove, OperateResult.SUCCESS, MenuCode.syspriv, ids);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			result.setIserror(true);
			result.setMessage(e.getMessage());
		}
		putJSONResult(result);
		return JSON;
	}
	@Permission(menuCode=MenuCode.syspriv, privCode=PrivCode.on)
	@Action("on")
	public String on(){
		ResultData result = new ResultData();
		try {
			tsysprivService.bathOn(ids);
			result.setIserror(false);
			result.setMessage("成功");
			saveTLogOperate(PrivCode.on, OperateResult.SUCCESS, MenuCode.syspriv, ids);
		} catch (Exception e) {
			result.setIserror(true);
			result.setMessage("失败");
			logger.error(e.getMessage(), e);
		}
		putJSONResult(result);
		return JSON;
	}
	@Permission(menuCode=MenuCode.syspriv, privCode=PrivCode.off)
	@Action("off")
	public String off(){
		ResultData result = new ResultData();
		try {
			tsysprivService.bathOff(ids);
			result.setIserror(false);
			result.setMessage("成功");
			saveTLogOperate(PrivCode.off, OperateResult.SUCCESS, MenuCode.syspriv, ids);
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

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getMenuId() {
		return menuId;
	}

	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}

	public TSyspriv getTsyspriv() {
		return tsyspriv;
	}

	public void setTsyspriv(TSyspriv tsyspriv) {
		this.tsyspriv = tsyspriv;
	}

	public TSysmenu getTsysmenu() {
		return tsysmenu;
	}

	public void setTsysmenu(TSysmenu tsysmenu) {
		this.tsysmenu = tsysmenu;
	}
}

