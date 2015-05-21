/**  
* @Project: xproduct
* @Title: TLogOperateService.java
* @Package cn.com.checknull.service
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-3-17 下午4:32:15
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.service;

import java.sql.SQLException;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.com.checknull.entity.TLogOperate;

/**
 * @ClassName TLogOperateService
 * @Description TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-3-17   下午4:32:15
 */
@Service
@Transactional
public class TLogOperateService extends BaseService<TLogOperate> {

	public TLogOperateService() {
		super(TLogOperate.class);
	}

	public void insert(TLogOperate entity) throws SQLException{
		if (entity == null) return;
		entityDao.save(entity);
	}
	
	public void bathDelete(String ids) throws SQLException {
		if (StringUtils.isEmpty(ids)) return;
		String[] array = ids.split(",");
		for (String str : array){
			Long id = NumberUtils.toLong(str, 0L);
			TLogOperate entity = find(id);
			if (entity == null) continue;
			entityDao.delete(entity);
		}
	}
}

