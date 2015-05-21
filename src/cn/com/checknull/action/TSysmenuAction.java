/**  
* @Project: xproduct
* @Title: TSysmenuAction.java
* @Package cn.com.checknull.action
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-2-28 下午2:02:55
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.action;

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
import cn.com.checknull.interceptor.Permission;
import cn.com.checknull.service.TSysmenuService;
import cn.com.checknull.vo.QueryResult;
import cn.com.checknull.vo.ResultData;

/**
 * @ClassName TSysmenuAction
 * @Description TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-2-28   下午2:02:55
 */
@Namespace("/TSysmenu")
@ParentPackage("xproduct")
public class TSysmenuAction extends BaseAction {

	/** 
	* @Fields serialVersionUID : TODO
	*/ 
	private static final long serialVersionUID = -6690544421490797122L;

	@Autowired
	private TSysmenuService tsysmenuService;
	
	/**
	 * 供搜索使用
	 */
	private String name;
	private String code;
	private String status;
	private String level;
	
	/**
	 * 供查看、新增、修改使用
	 */
	private TSysmenu tsysmenu;
	private List<TSysmenu> tsysmenus;
	
	/**
	 * 供菜单排序使用
	 */
	private String sorts;
	
	@Permission(menuCode=MenuCode.sysmenu, privCode=PrivCode.list)
	@Action("list")
	public String list() {
		return SUCCESS;
	}
	@Permission(menuCode=MenuCode.sysmenu, privCode=PrivCode.list)
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
			if (!StringUtils.isEmpty(level)){
				int temLevel = NumberUtils.toInt(level,1);
				whereJpql = whereJpql + " and o.level = " + temLevel;
			}
			QueryResult<TSysmenu> pages = tsysmenuService.findPage(pageIndex, pageSize, whereJpql, null, order, sort);
			putJSONResult(pages);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		return JSON;
	}
	@Permission(menuCode=MenuCode.sysmenu, privCode=PrivCode.view)
	@Action("view")
	public String view(){
		try {
			tsysmenu = tsysmenuService.find(id);
			//查询二级菜单
			QueryResult<TSysmenu> pages = tsysmenuService.findPage(-1, -1, "o.parentMenu.id=" + id, null, "asc", "sequence");
			if (pages != null && pages.getTotal() > 0){
				tsysmenus = pages.getRows();
			}
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		return SUCCESS;
	}
	@Permission(menuCode=MenuCode.sysmenu, privCode=PrivCode.add)
	@Action("add")
	public String add(){
		return SUCCESS;
	}
	@Permission(menuCode=MenuCode.sysmenu, privCode=PrivCode.add)
	@Action("save")
	public String save(){
		ResultData result = new ResultData();
		try {
			tsysmenuService.insert(tsysmenu);
			result.setIserror(false);
			result.setMessage("成功");
			saveTLogOperate(PrivCode.add, OperateResult.SUCCESS, MenuCode.sysmenu, tsysmenu.getName());
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			result.setIserror(true);
			result.setMessage(e.getMessage());
		}
		putJSONResult(result);
		return JSON;
	}
	@Permission(menuCode=MenuCode.sysmenu, privCode=PrivCode.modify)
	@Action("modify")
	public String modify(){
		try {
			tsysmenu = tsysmenuService.find(id);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		return SUCCESS;
	}
	@Permission(menuCode=MenuCode.sysmenu, privCode=PrivCode.modify)
	@Action("update")
	public String update(){
		ResultData result = new ResultData();
		try {
			tsysmenuService.mod(tsysmenu);
			result.setIserror(false);
			result.setMessage("成功");
			saveTLogOperate(PrivCode.modify, OperateResult.SUCCESS, MenuCode.sysmenu, tsysmenu.getName());
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			result.setIserror(true);
			result.setMessage(e.getMessage());
		}
		putJSONResult(result);
		return JSON;
	}
	@Permission(menuCode=MenuCode.sysmenu, privCode=PrivCode.remove)
	@Action("remove")
	public String remove(){
		ResultData result = new ResultData();
		try {
			tsysmenuService.bathDelete(ids);
			result.setIserror(false);
			result.setMessage("成功");
			saveTLogOperate(PrivCode.remove, OperateResult.SUCCESS, MenuCode.sysmenu, ids);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			result.setIserror(true);
			result.setMessage(e.getMessage());
		}
		putJSONResult(result);
		return JSON;
	}
	@Permission(menuCode=MenuCode.sysmenu, privCode=PrivCode.on)
	@Action("on")
	public String on(){
		ResultData result = new ResultData();
		try {
			tsysmenuService.bathOn(ids);
			result.setIserror(false);
			result.setMessage("成功");
			saveTLogOperate(PrivCode.on, OperateResult.SUCCESS, MenuCode.sysmenu, ids);
		} catch (Exception e) {
			result.setIserror(true);
			result.setMessage("失败");
			logger.error(e.getMessage(), e);
		}
		putJSONResult(result);
		return JSON;
	}
	@Permission(menuCode=MenuCode.sysmenu, privCode=PrivCode.off)
	@Action("off")
	public String off(){
		ResultData result = new ResultData();
		try {
			tsysmenuService.bathOff(ids);
			result.setIserror(false);
			result.setMessage("成功");
			saveTLogOperate(PrivCode.off, OperateResult.SUCCESS, MenuCode.sysmenu, ids);
		} catch (Exception e) {
			result.setIserror(true);
			result.setMessage("失败");
			logger.error(e.getMessage(), e);
		}
		putJSONResult(result);
		return JSON;
	}
	
	@Permission(menuCode=MenuCode.sysmenu, privCode=PrivCode.sort)
	@Action("sort")
	public String sort(){
		try {
			QueryResult<TSysmenu> tmpQRTSysmenu = tsysmenuService.findPage(-1, -1, null, null, "asc", "sequence");
			if (tmpQRTSysmenu != null && tmpQRTSysmenu.getTotal() > 0){
				tsysmenus = tmpQRTSysmenu.getRows();
			}
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		return SUCCESS;
	}
	
	@Permission(menuCode=MenuCode.sysmenu, privCode=PrivCode.sort)
	@Action("sorting")
	public String sorting(){
		ResultData result = new ResultData();
		try {
			tsysmenuService.sort(sorts);
			result.setIserror(false);
			result.setMessage("成功");
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

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	public TSysmenu getTsysmenu() {
		return tsysmenu;
	}

	public void setTsysmenu(TSysmenu tsysmenu) {
		this.tsysmenu = tsysmenu;
	}

	public List<TSysmenu> getTsysmenus() {
		return tsysmenus;
	}

	public void setTsysmenus(List<TSysmenu> tsysmenus) {
		this.tsysmenus = tsysmenus;
	}
	public String getSorts() {
		return sorts;
	}
	public void setSorts(String sorts) {
		this.sorts = sorts;
	}
}

