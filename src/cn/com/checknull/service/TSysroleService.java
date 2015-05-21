/**  
* @Project: xproduct
* @Title: TSysroleService.java
* @Package cn.com.checknull.service
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-3-13 下午3:01:21
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.service;

import java.sql.SQLException;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.com.checknull.entity.TOperatorRole;
import cn.com.checknull.entity.TSysmenu;
import cn.com.checknull.entity.TSyspriv;
import cn.com.checknull.entity.TSysrole;
import cn.com.checknull.entity.TSysroleMenu;
import cn.com.checknull.entity.TSysrolePriv;
import cn.com.checknull.vo.QueryResult;

/**
 * @ClassName TSysroleService
 * @Description TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-3-13   下午3:01:21
 */
@Service
@Transactional
public class TSysroleService extends BaseService<TSysrole> {

	public TSysroleService() {
		super(TSysrole.class);
	}
	
	@Transactional(rollbackFor = Exception.class)
	public void insert(TSysrole entity, String menuIds, String privIds) throws SQLException {
		if (entity == null) return;
		QueryResult<TSysrole> result = findPage(-1, -1, "o.name='" + entity.getName() + "'", null, null, null);
		if (result != null && result.getTotal() > 0){
			throw new SQLException("角色（" + entity.getName() + "）已被使用");
		}
		entityDao.save(entity);
		
		if (!StringUtils.isEmpty(menuIds)) {
			String[] tmpMenuIdArray = menuIds.split(",");
			for (String tmpMenuId : tmpMenuIdArray){
				int id = NumberUtils.toInt(tmpMenuId);
				TSysmenu tmpTSysmenu = entityDao.get(TSysmenu.class, "o.id=" + id, null);
				if (tmpTSysmenu == null){
					throw new SQLException("菜单（" + id + "）不存在");
				}
			}
		}
		
		TSysroleMenu tmpTSysroleMenu = new TSysroleMenu();
		tmpTSysroleMenu.setMenuIds(menuIds);
		tmpTSysroleMenu.setRoleId(entity.getId());
		entityDao.save(tmpTSysroleMenu);
		
		if (!StringUtils.isEmpty(privIds)){
			String[] tmpPrivIdArray = privIds.split(",");
			for (String tmpPrivId : tmpPrivIdArray){
				int id = NumberUtils.toInt(tmpPrivId);
				TSyspriv tmpTSyspriv = entityDao.get(TSyspriv.class, "o.id=" + id, null);
				if (tmpTSyspriv == null){
					throw new SQLException("权限（" + id + "）不存在");
				}
			}
		}
		
		TSysrolePriv tmpTSysrolePriv = new TSysrolePriv();
		tmpTSysrolePriv.setPrivIds(privIds);
		tmpTSysrolePriv.setRoleId(entity.getId());
		entityDao.save(tmpTSysrolePriv);
	}
	
	public void mod(TSysrole entity, String menuIds, String privIds) throws SQLException {
		if (entity == null) return;
		Long id = entity.getId();
		if (find(id) == null) return;
		QueryResult<TSysrole> result = this.findPage(-1, -1, "o.id !=" + id + " and o.name='" + entity.getName() + "'", null, null, null);
		if (result != null && result.getTotal() > 0){
			throw new SQLException("角色（" + entity.getName() + "）已被使用");
		}
		entityDao.update(entity);
		
		if (!StringUtils.isEmpty(menuIds)){
			String[] tmpMenuIdArray = menuIds.split(",");
			for (String tmpMenuId : tmpMenuIdArray){
				int tmpId = NumberUtils.toInt(tmpMenuId);
				TSysmenu tmpTSysmenu = entityDao.get(TSysmenu.class, "o.id=" + tmpId, null);
				if (tmpTSysmenu == null){
					throw new SQLException("菜单（" + tmpId + "）不存在");
				}
			}
		}
		
		TSysroleMenu tmpTSysroleMenu = entityDao.get(TSysroleMenu.class, "o.roleId=" + id, null);
		if (tmpTSysroleMenu == null){
			tmpTSysroleMenu = new TSysroleMenu();
			tmpTSysroleMenu.setMenuIds(menuIds);
			tmpTSysroleMenu.setRoleId(entity.getId());
			entityDao.save(tmpTSysroleMenu);
		}else{
			tmpTSysroleMenu.setMenuIds(menuIds);
			entityDao.update(tmpTSysroleMenu);
		}
		
		if (!StringUtils.isEmpty(privIds)) {
			String[] tmpPrivIdArray = privIds.split(",");
			for (String tmpPrivId : tmpPrivIdArray){
				int tmpId = NumberUtils.toInt(tmpPrivId);
				TSyspriv tmpTSyspriv = entityDao.get(TSyspriv.class, "o.id=" + tmpId, null);
				if (tmpTSyspriv == null){
					throw new SQLException("权限（" + tmpId + "）不存在");
				}
			}
		}
		
		TSysrolePriv tmpTSysrolePriv = entityDao.get(TSysrolePriv.class, "o.roleId=" + id, null);
		if (tmpTSysrolePriv == null){
			tmpTSysrolePriv = new TSysrolePriv();
			tmpTSysrolePriv.setPrivIds(privIds);
			tmpTSysrolePriv.setRoleId(entity.getId());
			entityDao.save(tmpTSysrolePriv);
		}else{
			tmpTSysrolePriv.setPrivIds(privIds);
			entityDao.update(tmpTSysrolePriv);
		}
	}
	@Transactional(rollbackFor = Exception.class)
	public void bathDelete(String ids) throws SQLException {
		if (StringUtils.isEmpty(ids)) return;
		String[] array = ids.split(",");
		for (String str : array){
			Long id = NumberUtils.toLong(str, 0L);
			TSysrole entity = find(id);
			if (entity == null) continue;
			QueryResult<TOperatorRole> tmpQRTOperatorRole = entityDao.getPagingData(TOperatorRole.class, "LOCATE('," + id + ",',CONCAT(',', o.roleIds,',')) > 0", null);
			if (tmpQRTOperatorRole != null && tmpQRTOperatorRole.getTotal() > 0){
				throw new SQLException("角色（" + entity.getName() + "）已经与操作员绑定，请先解绑！");
			}
			entityDao.delete(entity);
			TSysroleMenu tmpTSysroleMenu = entityDao.get(TSysroleMenu.class, "o.roleId=" + id, null);
			if (tmpTSysroleMenu != null){
				entityDao.delete(tmpTSysroleMenu);
			}
			TSysrolePriv tmpTSysrolePriv = entityDao.get(TSysrolePriv.class, "o.roleId=" + id, null);
			if (tmpTSysrolePriv != null){
				entityDao.delete(tmpTSysrolePriv);
			}
		}
	}
	
	public void bathOn(String ids) throws SQLException {
		if (StringUtils.isEmpty(ids)) return;
		String[] array = ids.split(",");
		for (String str : array){
			Long id = NumberUtils.toLong(str, 0L);
			TSysrole entity = find(id);
			if (entity == null) continue;
			entity.setStatus(1);
			entityDao.update(entity);
		}
	}

	public void bathOff(String ids) throws SQLException {
		if (StringUtils.isEmpty(ids)) return;
		String[] array = ids.split(",");
		for (String str : array){
			Long id = NumberUtils.toLong(str, 0L);
			TSysrole entity = find(id);
			if (entity == null) continue;
			entity.setStatus(0);
			entityDao.update(entity);
		}
	}

}

