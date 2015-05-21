/**  
* @Project: xproduct
* @Title: TSysmenuService.java
* @Package cn.com.checknull.service
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-2-28 下午2:04:05
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.service;

import java.sql.SQLException;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.com.checknull.entity.TSysmenu;
import cn.com.checknull.entity.TSyspriv;
import cn.com.checknull.entity.TSysroleMenu;
import cn.com.checknull.vo.QueryResult;

/**
 * @ClassName TSysmenuService
 * @Description TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-2-28   下午2:04:05
 */
@Service
@Transactional
public class TSysmenuService extends BaseService<TSysmenu> {

	public TSysmenuService() {
		super(TSysmenu.class);
	}

	public void insert(TSysmenu entity) throws SQLException{
		if (entity == null) return;
		TSysmenu tmpParent = entity.getParentMenu();
		if (tmpParent != null && tmpParent.getId() == null){
			entity.setParentMenu(null);
		}
		entityDao.save(entity);
	}
	
	public void mod(TSysmenu entity) throws SQLException {
		if (entity == null) return;
		TSysmenu tmpParent = entity.getParentMenu();
		if (tmpParent != null && tmpParent.getId() == null){
			entity.setParentMenu(null);
		}
		entityDao.update(entity);
	}
	
	public void bathDelete(String ids) throws SQLException {
		if (StringUtils.isEmpty(ids)) return;
		String[] array = ids.split(",");
		for (String str : array){
			Long id = NumberUtils.toLong(str, 0L);
			TSysmenu entity = find(id);
			if (entity == null) continue;
			
			QueryResult<TSysmenu> tmpQRTSysmenu = entityDao.getPagingData(TSysmenu.class, "o.parentMenu.id=" + id, null);
			if (tmpQRTSysmenu != null && tmpQRTSysmenu.getTotal() > 0){
				throw new SQLException("菜单（" + entity.getName() + "）拥有子菜单，请先解绑！");
			}
			
			QueryResult<TSyspriv> tmpQRTSyspriv = entityDao.getPagingData(TSyspriv.class, "o.menu.id=" + id, null);
			if (tmpQRTSyspriv != null && tmpQRTSyspriv.getTotal() > 0){
				throw new SQLException("菜单（" + entity.getName() + "）已经与权限绑定，请先解绑！");
			}
			
			QueryResult<TSysroleMenu> tmpQRTSysroleMenu = entityDao.getPagingData(TSysroleMenu.class, "LOCATE('," + id + ",',CONCAT(',', o.menuIds,',')) > 0", null);
			if (tmpQRTSysroleMenu != null && tmpQRTSysroleMenu.getTotal() > 0){
				throw new SQLException("菜单（" + entity.getName() + "）已经与角色绑定，请先解绑！");
			}
			entityDao.delete(entity);
		}
	}
	
	public void bathOn(String ids) throws SQLException {
		if (StringUtils.isEmpty(ids)) return;
		String[] array = ids.split(",");
		for (String str : array){
			Long id = NumberUtils.toLong(str, 0L);
			TSysmenu entity = find(id);
			if (entity == null) continue;
			QueryResult<TSysmenu> tmpQRTSysmenu = entityDao.getPagingData(TSysmenu.class, "o.parentMenu.id=" + id, null);
			if (tmpQRTSysmenu != null && tmpQRTSysmenu.getTotal() > 0){
				for (TSysmenu tmpTSysmenu : tmpQRTSysmenu.getRows()){
					tmpTSysmenu.setStatus(1);
					entityDao.update(tmpTSysmenu);
				}
			}
			entity.setStatus(1);
			entityDao.update(entity);
		}
	}

	public void bathOff(String ids) throws SQLException {
		if (StringUtils.isEmpty(ids)) return;
		String[] array = ids.split(",");
		for (String str : array){
			Long id = NumberUtils.toLong(str, 0L);
			TSysmenu entity = find(id);
			if (entity == null) continue;
			QueryResult<TSysmenu> tmpQRTSysmenu = entityDao.getPagingData(TSysmenu.class, "o.parentMenu.id=" + id, null);
			if (tmpQRTSysmenu != null && tmpQRTSysmenu.getTotal() > 0){
				for (TSysmenu tmpTSysmenu : tmpQRTSysmenu.getRows()){
					tmpTSysmenu.setStatus(0);
					entityDao.update(tmpTSysmenu);
				}
			}
			entity.setStatus(0);
			entityDao.update(entity);
		}
	}
	
	@Transactional(rollbackFor=Exception.class)
	public void sort(String sorts) throws SQLException {
		if (StringUtils.isEmpty(sorts)) return;
		String[] array1 = sorts.split(",");
		for (String str : array1){
			if (StringUtils.isEmpty(str)) continue;
			String[] array2 = str.split("-");
			if (array2.length != 2) continue;
			Long id = NumberUtils.toLong(array2[0], 0L);
			Integer sequence = NumberUtils.toInt(array2[1], 10);
			TSysmenu entity = find(id);
			if (entity == null) continue;
			entity.setSequence(sequence);
			entityDao.update(entity);
		}
	}
}

