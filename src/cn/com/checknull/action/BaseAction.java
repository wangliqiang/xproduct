/**  
* @Project: xproduct
* @Title: BaseAction.java
* @Package cn.com.pkit.action
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-2-12 下午7:15:17
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.action;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import cn.com.checknull.enm.MenuCode;
import cn.com.checknull.enm.OperateResult;
import cn.com.checknull.enm.OperatorType;
import cn.com.checknull.enm.PrivCode;
import cn.com.checknull.enm.SessionAttribute;
import cn.com.checknull.entity.TLogOperate;
import cn.com.checknull.entity.TOperator;
import cn.com.checknull.service.TLogOperateService;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

/**
 * @ClassName BaseAction
 * @Description TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-2-12   下午7:15:17
 */
public abstract class BaseAction extends ActionSupport implements ServletRequestAware,ServletResponseAware{

	/** 
	* @Fields serialVersionUID : TODO
	*/ 
	private static final long serialVersionUID = 5750759967997984869L;
	protected Logger logger = LoggerFactory.getLogger(this.getClass());
	
	protected HttpServletRequest request;
	protected HttpServletResponse response;
	protected long id;
	protected String ids;
	protected String sort;
	protected String order;
	protected int pageIndex = 1;
	protected int pageSize = 20;
	protected static final String JSON = "json";
	protected String menuName;
	@Autowired
	protected TLogOperateService tlogOperateService;
	@Override
	public void setServletRequest(HttpServletRequest httpServletRequest) {
			this.request = httpServletRequest;
	}

	@Override
	public void setServletResponse(HttpServletResponse httpServletResponse) {
		this.response = httpServletResponse;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public int getPageIndex() {
		return pageIndex;
	}

	public void setPage(String page) {
		this.pageIndex = NumberUtils.toInt(page, 1);
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setRows(String rows) {
		this.pageSize = NumberUtils.toInt(rows, 20);
	}

	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		if (!StringUtils.isEmpty(menuName)){
			try {
				menuName = new String(menuName.getBytes("ISO-8859-1"), "UTF-8");
			} catch (UnsupportedEncodingException e) {
				logger.error(e.getMessage(), e);
			}
		}
		this.menuName = menuName;
	}

	protected void putJSONResult(Object object) {
		ActionContext.getContext().put(JSON, object);
	}
	
	public TOperator getCurrentOperator(){
		Object obj = request.getSession().getAttribute(SessionAttribute.OPERATOR.getAttribute());
		if (obj instanceof TOperator){
			return (TOperator)obj;
		}
		return null;
	}
	
	public boolean isPlatformOperator(){
		TOperator tmpTOperator = getCurrentOperator();
		if (tmpTOperator == null) return true;
        return tmpTOperator.getIsPlatoperator() == OperatorType.PLATFORM.getType() ? true : false;
    }
	
	public Long getCurrentCpCode(){
		TOperator tmpTOperator = getCurrentOperator();
		if (tmpTOperator == null) return null;
		return tmpTOperator.getIsPlatoperator() == OperatorType.PLATFORM.getType() ? null : tmpTOperator.getCpCode();
	}
	
	/**
	 * 
	* @Title: saveTLogOperate 
	* @Description: TODO
	* @param privCode
	* @param operateResult
	* @param menuCode
	* @param operateValue 操作值   （一般为每条记录的ID，也可以是其他的可以辨别的唯一标识）
	 */
	public void saveTLogOperate(PrivCode privCode, OperateResult operateResult, MenuCode menuCode, Object operateValue){
		 TLogOperate tmpTLogOperate= new TLogOperate();
		 tmpTLogOperate.setLoginName(getCurrentOperator().getLoginName());
		 tmpTLogOperate.setOperateObject(menuCode.getCode());
		 tmpTLogOperate.setOperateResult(operateResult.getResult());
		 tmpTLogOperate.setOperateTime(new Date());
		 tmpTLogOperate.setOperateType(privCode.getCode());
		 tmpTLogOperate.setOperateValue(operateValue + "");
		 tmpTLogOperate.setOperatorId(getCurrentOperator().getId());
		 tmpTLogOperate.setOperatorName(getCurrentOperator().getRealName());
		 try {
			tlogOperateService.insert(tmpTLogOperate);
		} catch (SQLException e) {
			logger.error(e.getMessage(), e);
		}
	}
}

