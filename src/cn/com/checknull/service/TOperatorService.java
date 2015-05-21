/**  
* @Project: xproduct
* @Title: TOperatorService.java
* @Package cn.com.checknull.service
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-3-17 上午9:47:19
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.service;

import java.sql.SQLException;
import java.util.Date;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.com.checknull.enm.OperatorType;
import cn.com.checknull.entity.TOperator;
import cn.com.checknull.entity.TOperatorRole;
import cn.com.checknull.entity.TSysrole;
import cn.com.checknull.util.Md5Utils;

/**
 * @ClassName TOperatorService
 * @Description TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-3-17   上午9:47:19
 */
@Service
@Transactional
public class TOperatorService extends BaseService<TOperator> {

	public TOperatorService() {
		super(TOperator.class);
	}

	@Transactional(rollbackFor = Exception.class)
	public void insert(TOperator entity, String roleIds) throws SQLException{
		if (entity == null) return;
		TOperator tmpTOperator = entityDao.get(TOperator.class, "o.loginName=?1", new Object[]{entity.getLoginName()});
		if (tmpTOperator != null){
			throw new SQLException("登录名（" + entity.getLoginName() + "），已被使用");
		}
		entity.setIsPlatoperator(OperatorType.PLATFORM.getType());//管理员账号
		entity.setPassword(Md5Utils.md5Encode(entity.getPassword()));
		entityDao.save(entity);
		
		if (roleIds == null || StringUtils.isEmpty(roleIds)) return;
		String[] array = roleIds.split(",");
		for (String str : array){
			Long id = NumberUtils.toLong(str, 0L);
			TSysrole tmpTSysrole = entityDao.get(TSysrole.class, id);
			if(tmpTSysrole == null){
				throw new SQLException("角色ID（" + id + "），已不存在");
			}
			if (tmpTSysrole.getType() == OperatorType.COMPANY.getType()){
				throw new SQLException("平台账号，只能添加平台角色");
			}
		}
		TOperatorRole tmpTOperatorRole = new TOperatorRole();
		tmpTOperatorRole.setOperatorId(entity.getId());
		tmpTOperatorRole.setRoleIds(roleIds);
		entityDao.save(tmpTOperatorRole);
	}
	public void mod(TOperator entity) throws SQLException {
		if (entity == null) return;
		Long id = entity.getId();
		if (find(id) == null) return;
		entity.setUpdateTime(new Date());
		entityDao.update(entity);
	}
	
	@Transactional(rollbackFor = Exception.class)
	public void mod(TOperator entity, String roleIds) throws SQLException {
		if (entity == null) return;
		Long id = entity.getId();
		if (find(id) == null) return;
		TOperator tmpTOperator = entityDao.get(TOperator.class, "o.loginName=?1 and o.id!=?2", new Object[]{entity.getLoginName(),entity.getId()});
		if (tmpTOperator != null){
			throw new SQLException("登录名（" + entity.getLoginName() + "），已被使用");
		}
		entity.setUpdateTime(new Date());
		entityDao.update(entity);
		if (roleIds != null && !StringUtils.isEmpty(roleIds)) {
			String[] array = roleIds.split(",");
			for (String str : array){
				Long tmpId = NumberUtils.toLong(str, 0L);
				TSysrole tmpTSysrole = entityDao.get(TSysrole.class, tmpId);
				if(tmpTSysrole == null){
					throw new SQLException("角色ID（" + id + "），已不存在");
				}
				
				if (entity.getIsPlatoperator() == OperatorType.PLATFORM.getType() && tmpTSysrole.getType() == OperatorType.COMPANY.getType()){
					throw new SQLException("平台账号，只能添加平台角色");
				}
				if (entity.getIsPlatoperator() == OperatorType.COMPANY.getType() && tmpTSysrole.getType() == OperatorType.PLATFORM.getType()){
					throw new SQLException("企业账号，只能添加企业角色");
				}
			}
		}
		
		TOperatorRole tmpTOperatorRole = entityDao.get(TOperatorRole.class, "o.operatorId=?1", new Object[]{entity.getId()});
		if (tmpTOperatorRole != null){
			tmpTOperatorRole.setRoleIds(roleIds);
			entityDao.update(tmpTOperatorRole);
		}else{
			tmpTOperatorRole = new TOperatorRole();
			tmpTOperatorRole.setOperatorId(entity.getId());
			tmpTOperatorRole.setRoleIds(roleIds);
			entityDao.save(tmpTOperatorRole);
		}
	}
	
	public void bathDelete(String ids) throws SQLException {
		if (StringUtils.isEmpty(ids)) return;
		String[] array = ids.split(",");
		for (String str : array){
			Long id = NumberUtils.toLong(str, 0L);
			TOperator entity = find(id);
			if (entity == null) continue;
			TOperatorRole tmpTOperatorRole = entityDao.get(TOperatorRole.class, "o.operatorId=?1", new Object[]{entity.getId()});
			if (tmpTOperatorRole != null){
				entityDao.delete(tmpTOperatorRole);
			}
			entityDao.delete(entity);
		}
	}
	
	public void bathOn(String ids) throws SQLException {
		if (StringUtils.isEmpty(ids)) return;
		String[] array = ids.split(",");
		for (String str : array){
			Long id = NumberUtils.toLong(str, 0L);
			TOperator entity = find(id);
			if (entity == null) continue;
			entity.setStatus(1);
			entity.setUpdateTime(new Date());
			entityDao.update(entity);
		}
	}

	public void bathOff(String ids) throws SQLException {
		if (StringUtils.isEmpty(ids)) return;
		String[] array = ids.split(",");
		for (String str : array){
			Long id = NumberUtils.toLong(str, 0L);
			TOperator entity = find(id);
			if (entity == null) continue;
			entity.setStatus(0);
			entity.setUpdateTime(new Date());
			entityDao.update(entity);
		}
	}
	
	public void bathResetPassword(String ids) throws SQLException {
		if (StringUtils.isEmpty(ids)) return;
		String[] array = ids.split(",");
		for (String str : array){
			Long id = NumberUtils.toLong(str, 0L);
			TOperator entity = find(id);
			if (entity == null) continue;
			entity.setPassword(Md5Utils.md5Encode("123456"));
			entity.setUpdateTime(new Date());
			entityDao.update(entity);
		}
	}

}

