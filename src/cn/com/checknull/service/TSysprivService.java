/**  
* @Project: xproduct
* @Title: TSysprivService.java
* @Package cn.com.checknull.service
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-3-2 下午2:25:38
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.service;

import java.sql.SQLException;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.com.checknull.entity.TSyspriv;
import cn.com.checknull.entity.TSysrolePriv;
import cn.com.checknull.vo.QueryResult;

/**
 * @ClassName TSyspriv
 * @Description TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-3-2   下午2:25:38
 */
@Service
@Transactional
public class TSysprivService extends BaseService<TSyspriv> {

	public TSysprivService() {
		super(TSyspriv.class);
	}
	
	public void insert(TSyspriv entity) throws SQLException{
		if (entity == null) return;
		QueryResult<TSyspriv> result = findPage(-1, -1, "o.name='" + entity.getName() + "' and o.menu.id =" + entity.getMenu().getId(), null, null, null);
		if (result != null && result.getTotal() > 0){
			throw new SQLException("权限名称（" + entity.getName() + "）已被使用");
		}
		result = findPage(-1, -1, "o.code='" + entity.getCode() + "' and o.menu.id =" + entity.getMenu().getId(), null, null, null);
		if (result != null && result.getTotal() > 0){
			throw new SQLException("权限代码（" + entity.getName() + "）已被使用");
		}
		entityDao.save(entity);
	}
	
	public void mod(TSyspriv entity) throws SQLException {
		if (entity == null) return;
		QueryResult<TSyspriv> result = findPage(-1, -1, "o.name='" + entity.getName() + "' and o.menu.id =" + entity.getMenu().getId() + " and o.id !=" + entity.getId(), null, null, null);
		if (result != null && result.getTotal() > 0){
			throw new SQLException("权限名称（" + entity.getName() + "）已被使用");
		}
		result = findPage(-1, -1, "o.code='" + entity.getCode() + "' and o.menu.id =" + entity.getMenu().getId()  + " and o.id !=" + entity.getId(), null, null, null);
		if (result != null && result.getTotal() > 0){
			throw new SQLException("权限代码（" + entity.getName() + "）已被使用");
		}
		entityDao.update(entity);
	}
	
	@Transactional(rollbackFor = Exception.class)
	public void bathDelete(String ids) throws SQLException {
		if (StringUtils.isEmpty(ids)) return;
		String[] array = ids.split(",");
		for (String str : array){
			Long id = NumberUtils.toLong(str, 0L);
			TSyspriv entity = find(id);
			if (entity == null) continue;
			QueryResult<TSysrolePriv> tmpQRTSysrolePriv = entityDao.getPagingData(TSysrolePriv.class, "LOCATE('," + id + ",',CONCAT(',', o.privIds,',')) > 0", null);
			if (tmpQRTSysrolePriv != null && tmpQRTSysrolePriv.getTotal() > 0){
				throw new SQLException("权限代码（" + entity.getName() + "）已经与角色绑定，请先解绑！");
			}
			entityDao.delete(entity);
		}
	}
	
	public void bathOn(String ids) throws SQLException {
		if (StringUtils.isEmpty(ids)) return;
		String[] array = ids.split(",");
		for (String str : array){
			Long id = NumberUtils.toLong(str, 0L);
			TSyspriv entity = find(id);
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
			TSyspriv entity = find(id);
			if (entity == null) continue;
			entity.setStatus(0);
			entityDao.update(entity);
		}
	}
}

