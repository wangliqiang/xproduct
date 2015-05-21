/**  
* @Project: xproduct
* @Title: TOperatorRoleService.java
* @Package cn.com.checknull.service
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-3-17 上午9:52:19
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.com.checknull.entity.TOperatorRole;

/**
 * @ClassName TOperatorRoleService
 * @Description TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-3-17   上午9:52:19
 */
@Service
@Transactional
public class TOperatorRoleService extends BaseService<TOperatorRole> {

	public TOperatorRoleService() {
		super(TOperatorRole.class);
	}

}

