/**  
* @Project: xproduct
* @Title: EntityDao.java
* @Package cn.com.checknull.dao
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-2-26 上午10:02:24
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.dao;

import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import cn.com.checknull.vo.QueryResult;

/**
 * @ClassName EntityDao
 * @Description TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-2-26   上午10:02:24
 */
public interface EntityDao {

	/**
	 * 
	* @Title: get 
	* @Description: 根据ID查询单个对象
	* @param entityClass
	* @param entityid
	* @return
	* @throws SQLException
	 */
	<T> T get(Class<T> entityClass, Object entityId) throws SQLException;
	
	/**
	 * 
	* @Title: get 
	* @Description: 根据查询条件获取单个对象
	* @param entityClass
	* @param whereJpql
	* @param queryParams
	* @return
	* @throws SQLException
	 */
	<T> T get(Class<T> entityClass, String whereJpql,Object[] queryParams) throws SQLException;
	
	/**
	 * 
	* @Title: getPagingData 
	* @Description: 分页查询数据
	* @param entityClass
	* @param firstIndex
	* @param maxResult
	* @param whereJpql o.visible=?1 and o.xxx like ?2
	* @param queryParams {0,x1,x2,x3,...}
	* @param orderBy key 存放实体属性，value存放ASC/DESC
	* @return
	* @throws SQLException
	 */
	<T> QueryResult<T> getPagingData(Class<T> entityClass,int firstIndex,int maxResult,
			String whereJpql,Object[] queryParams,LinkedHashMap<String, String> orderBy) throws SQLException;
	
	/**
	 * 
	* @Title: getPagingData 
	* @Description: 分页查询数据
	* @param entityClass
	* @param firstIndex
	* @param maxResult
	* @param whereJpql o.visible=?1 and o.xxx like ?2
	* @param queryParams {0,x1,x2,x3,...}
	* @return
	* @throws SQLException
	 */
	<T> QueryResult<T> getPagingData(Class<T> entityClass,int firstIndex,int maxResult,
			String whereJpql,Object[] queryParams) throws SQLException;

	/**
	 * 
	* @Title: getPagingData 
	* @Description: 分页查询数据
	* @param entityClass
	* @param firstIndex
	* @param maxResult
	* @param orderBy 存放实体属性，value存放ASC/DESC
	* @return
	* @throws SQLException
	 */
	<T> QueryResult<T> getPagingData(Class<T> entityClass,int firstIndex,int maxResult,
			LinkedHashMap<String, String> orderBy) throws SQLException;

	/**
	 * 
	* @Title: getPagingData 
	* @Description: 分页查询数据
	* @param entityClass
	* @param firstIndex
	* @param maxResult
	* @return
	* @throws SQLException
	 */
	<T> QueryResult<T> getPagingData(Class<T> entityClass,int firstIndex,int maxResult) throws SQLException;

	/**
	 * 
	* @Title: getPagingData 
	* @Description: 分页查询数据
	* @param entityClass
	* @param whereJpql o.visible=?1 and o.xxx like ?2
	* @param queryParams {0,x1,x2,x3,...}
	* @return
	* @throws SQLException
	 */
	<T> QueryResult<T> getPagingData(Class<T> entityClass,String whereJpql,Object[] queryParams) throws SQLException;

	/**
	 * 
	* @Title: getPagingData 
	* @Description: 分页获取数据
	* @param entityClass
	* @return
	* @throws SQLException
	 */
	<T> QueryResult<T> getPagingData(Class<T> entityClass) throws SQLException;

	/**
	 * 
	* @Title: getPagingDataByJpql 
	* @Description: 分页获取数据
	* <br>例子：String jpql = "select k from PActivity k, PActivityType a where k.activityType=a.id and k.id=?1";
	* <br>List &lt;PActivity> results = EntityDao.getPagingDataByJpql( jpql, new Object[]{1}, 0, 1);
	* @param entityClass
	* @param jpql 
	* @param queryParams
	* @param firstIndex
	* @param maxResult
	* @return
	* @throws SQLException
	 */
	<T> List<T> getPagingDataByJpql(Class<T> entityClass,String jpql,Object[] queryParams,int firstIndex,int maxResult) throws SQLException;

	/**
	 * 
	* @Title: getPagingDataByHql 
	* @Description: 分页获取数据
	* <br>例子：String hql = "select k.id as id ,k.user as user from PActivity k, PActivityType a where k.activityType=a.id and k.id=?";
	* <br>List&lt;Map<String,Object>> results = EntityDao.getPagingDataByHql(hql, new Object[]{1}, 0, 1);
	* <br>	for (Map<String,Object> result : results){
	* <br>	System.out.println("==============================");
	* <br>	for (String key : result.keySet()){
	* <br>		System.out.println(key + ":" + result.get(key));
	* <br>	}
	* <br>}
	* @param hql
	* @param queryParams
	* @param firstIndex
	* @param maxResult
	* @return
	* @throws SQLException
	 */
	List<Map<String, Object>> getPagingDataByHql(String hql,Object[] queryParams,int firstIndex,int maxResult) throws SQLException;

	/**
	 * 
	* @Title: getPagingDataBySql 
	* @Description: 分页获取数据
	* <br>例子：select k.id,k.userId from p_activity k, p_activity_type a where k.activityTypeId=a.id and k.id=?"
	* <br>Listt&lt;Map<String,Object>> results = EntityDao.getPagingDataBySql(hql, new Object[]{1}, 0, 1);
	*	<br>for (Map<String,Object> result : results){
	*	<br>	System.out.println("==============================");
	*	<br>	for (String key : result.keySet()){
	*			System.out.println(key + ":" + result.get(key));
	*	<br>	}
	*	<br>}
	* @param sql
	* @param queryParams
	* @param firstIndex
	* @param maxResult
	* @return
	* @throws SQLException
	 */
	List<Map<String, Object>> getPagingDataBySql(String sql,Object[] queryParams,int firstIndex,int maxResult) throws SQLException;
	
	/**
	 * 
	* @Title: getPagingDataBySql 
	* @Description: 分页获取数据
	* <br>例子：String sql = "select t.* from t_user t where t.id=?0";
    *	<br>List&lt;TUser> results = EntityDao.getPagingDataBySql( sql, new Object[]{1}, 0, 1);
	* @param entityClass
	* @param entityClass
	* @param sql
	* @param queryParams
	* @param firstIndex
	* @param maxResult
	* @return
	* @throws SQLException
	 */
	<T> List<T> getPagingDataBySql(Class<T> entityClass,String sql,Object[] queryParams,int firstIndex,int maxResult) throws SQLException;
	
	Long save(Object entity) throws SQLException;
	
	boolean update(Object entity) throws SQLException;
	
	void delete(Object entity) throws SQLException;
}

