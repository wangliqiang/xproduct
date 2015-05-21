/**  
* @Project: xproduct
* @Title: BaseService.java
* @Package cn.com.checknull.service
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-2-26 上午11:32:13
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.service;

import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import cn.com.checknull.dao.EntityDao;
import cn.com.checknull.vo.QueryResult;

/**
 * @ClassName BaseService
 * @Description TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-2-26   上午11:32:13
 */
@Transactional
public abstract class BaseService<T> {
	@Autowired
	protected EntityDao entityDao;
	private Class<T> entityClass;
	
	
    public BaseService(Class<T> entityClass) {
    	this.entityClass = entityClass;
	}
    @Transactional(readOnly = true, propagation = Propagation.NOT_SUPPORTED)
	public QueryResult<T> findPage(int pageIndex, int pageSize, String whereJpql, Object[] queryParams, String order, String sort) throws SQLException{
    	LinkedHashMap<String, String> orderBy = null;
		if (!StringUtils.isEmpty(order) && !StringUtils.isEmpty(sort)){
			orderBy = new LinkedHashMap<String, String>();
			orderBy.put(sort, order);
		}
		
		return entityDao.getPagingData(entityClass, pageIndex, pageSize, whereJpql, queryParams, orderBy);
    }
    @Transactional(readOnly = true, propagation = Propagation.NOT_SUPPORTED)
    public  List<Map<String, Object>>  findPage(int pageIndex, int pageSize, String hql, Object[] queryParams) throws SQLException{
		return entityDao.getPagingDataByHql(hql, queryParams, pageIndex, pageSize);
    }
    
    @Transactional(readOnly = true, propagation = Propagation.NOT_SUPPORTED)
    public  List<Map<String, Object>>  findPageBySql(int pageIndex, int pageSize, String sql, Object[] queryParams) throws SQLException{
    	return entityDao.getPagingDataBySql(sql, queryParams, pageIndex, pageSize);
    }
    
    @Transactional(readOnly = true, propagation = Propagation.NOT_SUPPORTED)
    public T find(Long id) throws SQLException{
    	return entityDao.get(entityClass, id);
    }
	
}

