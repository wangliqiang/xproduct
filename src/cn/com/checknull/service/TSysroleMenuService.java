/**  
* @Project: xproduct
* @Title: TSysroleMenuService.java
* @Package cn.com.checknull.service
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-3-16 上午11:07:36
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.com.checknull.entity.TSysroleMenu;

/**
 * @ClassName TSysroleMenuService
 * @Description TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-3-16   上午11:07:36
 */
@Service
@Transactional
public class TSysroleMenuService extends BaseService<TSysroleMenu> {

	public TSysroleMenuService() {
		super(TSysroleMenu.class);
	}

}

