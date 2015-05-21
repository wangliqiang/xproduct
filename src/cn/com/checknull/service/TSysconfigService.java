/**  
* @Project: xproduct
* @Title: TSysconfigService.java
* @Package cn.com.checknull.service
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-3-17 下午4:32:53
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.service;

import java.sql.SQLException;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.com.checknull.entity.TSysconfig;
import cn.com.checknull.vo.QueryResult;

/**
 * @ClassName TSysconfigService
 * @Description TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-3-17   下午4:32:53
 */
@Service
@Transactional
public class TSysconfigService extends BaseService<TSysconfig> {

	public TSysconfigService() {
		super(TSysconfig.class);
	}
	
	public void insert(TSysconfig entity) throws SQLException{
		if (entity == null) return;
		QueryResult<TSysconfig> result = findPage(-1, -1, "o.paramName='" + entity.getParamName() + "'", null, null, null);
		if (result != null && result.getTotal() > 0){
			throw new SQLException("配置名称（" + entity.getParamName() + "）已被使用");
		}
		result = findPage(-1, -1, "o.paramCode='" + entity.getParamCode() + "'", null, null, null);
		if (result != null && result.getTotal() > 0){
			throw new SQLException("配置代码（" + entity.getParamCode() + "）已被使用");
		}
		entityDao.save(entity);
	}
	
	public void mod(TSysconfig entity) throws SQLException {
		if (entity == null) return;
		Long id = entity.getId();
		if (find(id) == null) return;
		QueryResult<TSysconfig> result = findPage(-1, -1, "o.paramName='" + entity.getParamName() + "' and o.id !=" + id, null, null, null);
		if (result != null && result.getTotal() > 0){
			throw new SQLException("配置名称（" + entity.getParamName() + "）已被使用");
		}
		result = findPage(-1, -1, "o.paramCode='" + entity.getParamCode() + "' and o.id !=" + id, null, null, null);
		if (result != null && result.getTotal() > 0){
			throw new SQLException("配置代码（" + entity.getParamCode() + "）已被使用");
		}
		entityDao.update(entity);
	}
	
	public void bathDelete(String ids) throws SQLException {
		if (StringUtils.isEmpty(ids)) return;
		String[] array = ids.split(",");
		for (String str : array){
			Long id = NumberUtils.toLong(str, 0L);
			TSysconfig entity = find(id);
			if (entity == null) continue;
			entityDao.delete(entity);
		}
	}
}

