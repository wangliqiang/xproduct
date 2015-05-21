/**  
* @Project: xproduct
* @Title: EntityDaoImpl.java
* @Package cn.com.checknull.dao
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-2-26 上午9:50:28
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.dao;

import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.Entity;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;

import cn.com.checknull.vo.QueryResult;

/**
 * @ClassName EntityDaoImpl
 * @Description TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-2-26   上午9:50:28
 */
@Repository
public class EntityDaoImpl implements EntityDao{
	
	@PersistenceContext
	protected EntityManager em;
	@Override
	public <T> T get(Class<T> entityClass, Object entityId) throws SQLException {
		
		return em.find(entityClass, entityId);
	}

	@Override
	public <T> T get(Class<T> entityClass, String whereJpql,
			Object[] queryParams) throws SQLException {
		
		QueryResult<T> qr = this.getPagingData(entityClass, whereJpql, queryParams);
		List<T> result = qr.getRows();
		return result!=null && !result.isEmpty() ? result.get(0) : null;
		
	}

	@SuppressWarnings("unchecked")
	@Override
	public <T> QueryResult<T> getPagingData(Class<T> entityClass,
			int firstIndex, int maxResult, String whereJpql,
			Object[] queryParams, LinkedHashMap<String, String> orderBy)
			throws SQLException {
		
		QueryResult<T> qr = new QueryResult<T>();
		Query query = em.createQuery("SELECT o FROM "
				+ getEntityName(entityClass) + " o "
				+ (whereJpql == null ? "" : "WHERE " + whereJpql)
				+ buildOrderby(orderBy));
		setQueryParams(query, queryParams);
		if (firstIndex != -1 && maxResult != -1){
			if (firstIndex < 1) firstIndex = 1;
			if (maxResult < 1) maxResult = 1;
			query.setFirstResult((firstIndex-1) * maxResult).setMaxResults(maxResult);
		}
		qr.setRows(query.getResultList());
		
		query = em.createQuery("SELECT COUNT(o) FROM "+getEntityName(entityClass)+" o "+(whereJpql==null? "":"WHERE "+whereJpql));
		setQueryParams(query,queryParams);
		qr.setTotal((Long)query.getSingleResult());
		
		return qr;
		
	}

	private void setQueryParams(Query query, Object[] queryParams) {
		if (queryParams != null && queryParams.length > 0) {
			for (int i = 0; i < queryParams.length; i++) {
				query.setParameter(i + 1, queryParams[i]);
			}
		}
	}

	private String buildOrderby(LinkedHashMap<String, String> orderby) {
		StringBuffer orderbyql = new StringBuffer("");
		if (orderby != null && orderby.size() > 0) {
			orderbyql.append(" ORDER BY ");
			for (String key : orderby.keySet()) {
				orderbyql.append("o.").append(key).append(" ")
						.append(orderby.get(key)).append(",");
			}
			orderbyql.deleteCharAt(orderbyql.length() - 1);
		}
		return orderbyql.toString();
	}

	private <T> String getEntityName(Class<T> entityClass) {
		// 默认实体名称
		String entityname = entityClass.getSimpleName();
		// 取得自定义实体名称
		Entity entity = entityClass.getAnnotation(Entity.class);
		if (entity.name() != null && !"".equals(entity.name())) {
			entityname = entity.name();
		}
		return entityname;
	}
	
	@Override
	public <T> QueryResult<T> getPagingData(Class<T> entityClass,
			int firstIndex, int maxResult, String whereJpql,
			Object[] queryParams) throws SQLException {
		
		return getPagingData(entityClass, firstIndex, maxResult, whereJpql,
				queryParams, null);
	}

	@Override
	public <T> QueryResult<T> getPagingData(Class<T> entityClass,
			int firstIndex, int maxResult, LinkedHashMap<String, String> orderBy)
			throws SQLException {
		
		return getPagingData(entityClass, firstIndex, maxResult, null, null,
				orderBy);
		
	}

	@Override
	public <T> QueryResult<T> getPagingData(Class<T> entityClass,
			int firstIndex, int maxResult) throws SQLException {
		
		return getPagingData(entityClass, firstIndex, maxResult, null, null,
				null);
		
	}

	@Override
	public <T> QueryResult<T> getPagingData(Class<T> entityClass,
			String whereJpql, Object[] queryParams) throws SQLException {
		
		return getPagingData(entityClass, -1, -1, whereJpql, queryParams, null);
		
	}

	@Override
	public <T> QueryResult<T> getPagingData(Class<T> entityClass)
			throws SQLException {
		
		return getPagingData(entityClass, -1, -1, null, null, null);
		
	}

	@SuppressWarnings("unchecked")
	@Override
	public <T> List<T> getPagingDataByJpql(Class<T> entityClass, String jpql,
			Object[] queryParams, int firstIndex, int maxResult)
			throws SQLException {
		
		if (StringUtils.isEmpty(jpql)) {
			return null;
		}
		Query query = em.createQuery(jpql, entityClass);
		setQueryParams(query, queryParams);
		if (firstIndex != -1 && maxResult != -1){
			if (firstIndex < 1) firstIndex = 1;
			if (maxResult < 1) maxResult = 1;
			query.setFirstResult((firstIndex-1) * maxResult).setMaxResults(maxResult);
		}
		return query.getResultList();
	}

	@Override
	public List<Map<String, Object>> getPagingDataByHql(String hql,
			Object[] queryParams, int firstIndex, int maxResult)
			throws SQLException {
		
		if (StringUtils.isEmpty(hql)) {
			return null;
		}
		Session session = (Session) em.getDelegate();
		org.hibernate.Query query = session.createQuery(hql);
		if (queryParams != null && queryParams.length > 0) {
			for (int i = 0; i < queryParams.length; i++) {
				query.setParameter(i, queryParams[i]);
			}
		}
		if (firstIndex != -1 && maxResult != -1){
			if (firstIndex < 1) firstIndex = 1;
			if (maxResult < 1) maxResult = 1;
			query.setFirstResult((firstIndex-1) * maxResult).setMaxResults(maxResult);
		}
		@SuppressWarnings("unchecked")
		List<Map<String, Object>> results = query.setResultTransformer(
				Criteria.ALIAS_TO_ENTITY_MAP).list();
		return results;
		
	}

	@Override
	public List<Map<String, Object>> getPagingDataBySql(String sql,
			Object[] queryParams, int firstIndex, int maxResult)
			throws SQLException {
		
		if (StringUtils.isEmpty(sql)){
			return null;
		}
		Session session = (Session) em.getDelegate();
		org.hibernate.SQLQuery query = session.createSQLQuery(sql);
		if (queryParams != null && queryParams.length > 0){
			for (int i = 0; i < queryParams.length; i ++){
				query.setParameter(i, queryParams[i]);
			}
		}
		if(firstIndex!=-1 && maxResult!=-1){
			if (firstIndex < 1) firstIndex = 1;
			if (maxResult < 1) maxResult = 1;
			query.setFirstResult((firstIndex-1) * maxResult).setMaxResults(maxResult);
		}
		@SuppressWarnings("unchecked")
		List<Map<String, Object>> results =	query.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP).list();
		return results;
		
	}

	@SuppressWarnings("unchecked")
	@Override
	public <T> List<T> getPagingDataBySql(Class<T> entityClass, String sql,
			Object[] queryParams, int firstIndex, int maxResult)
			throws SQLException {
		
		if (StringUtils.isEmpty(sql)){
			return null;
		}
		Query query = em.createNativeQuery(sql, entityClass);
		if (queryParams != null && queryParams.length > 0){
			for (int i = 0; i < queryParams.length; i ++){
				query.setParameter(i, queryParams[i]);
			}
		}
		if(firstIndex!=-1 && maxResult!=-1){
			if (firstIndex < 1) firstIndex = 1;
			if (maxResult < 1) maxResult = 1;
			query.setFirstResult((firstIndex-1) * maxResult).setMaxResults(maxResult);
		}
		return query.getResultList();
		
	}

	@Override
	public Long save(Object entity) throws SQLException {
		
		Session session = (Session) em.getDelegate();
		Long id = (Long)session.save(entity);
		return id;
		
	}

	@Override
	public boolean update(Object entity) throws SQLException {
		
		return em.merge(entity) == null ? false : true;
	}

	@Override
	public void delete(Object entity) throws SQLException {
		em.remove(entity);
	}

}

