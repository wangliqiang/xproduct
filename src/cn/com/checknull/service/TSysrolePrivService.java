/**  
* @Project: xproduct
* @Title: TSysrolePrivService.java
* @Package cn.com.checknull.service
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-3-16 上午11:08:46
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.com.checknull.entity.TSysrolePriv;

/**
 * @ClassName TSysrolePrivService
 * @Description TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-3-16   上午11:08:46
 */
@Service
@Transactional
public class TSysrolePrivService extends BaseService<TSysrolePriv> {

	public TSysrolePrivService() {
		super(TSysrolePriv.class);
	}

}

