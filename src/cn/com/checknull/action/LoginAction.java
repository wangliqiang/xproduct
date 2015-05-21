/**  
* @Project: xproduct
* @Title: LoginAction.java
* @Package cn.com.pkit.action
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-3-17 下午3:33:57
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.action;

import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Date;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.springframework.beans.factory.annotation.Autowired;

import cn.com.checknull.enm.SessionAttribute;
import cn.com.checknull.enm.SysconfigKey;
import cn.com.checknull.entity.TLogLogin;
import cn.com.checknull.entity.TOperator;
import cn.com.checknull.entity.TSysconfig;
import cn.com.checknull.service.TLogLoginService;
import cn.com.checknull.service.TOperatorService;
import cn.com.checknull.service.TSysconfigService;
import cn.com.checknull.util.Md5Utils;
import cn.com.checknull.util.RequestUtils;
import cn.com.checknull.vo.QueryResult;
import cn.com.checknull.vo.ResultData;

import com.opensymphony.xwork2.ActionContext;

/**
 * @ClassName LoginAction
 * @Description TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-3-17   下午3:33:57
 */
@Namespace("/")
@ParentPackage("xproduct")
public class LoginAction extends BaseAction {

	/** 
	* @Fields serialVersionUID : TODO
	*/ 
	private static final long serialVersionUID = 6611142046212075649L;

	private static final int ERROR_TIMES = 5;
	
	@Autowired
	private TOperatorService toperatorService;
	@Autowired
	private TLogLoginService tlogLoginService;
	@Autowired
	private TSysconfigService tsysconfigService;
	
	private String loginName;
	private String password;
	ResultData result = new ResultData();
	@Action("login")
	public String login() {
		return SUCCESS;
	}
	
	@Action("userLogin")
	public String userLogin() {
		try{
			if (StringUtils.isEmpty(loginName) || StringUtils.isEmpty(password)){
				result.setIserror(true);
				result.setMessage("密码或用户名为空");
				putJSONResult(result);
				return JSON;
			}
			
			QueryResult<TOperator> tmpQRTOperator = toperatorService.findPage(-1, -1, "o.loginName=?1", new Object[]{loginName}, null, null);
			if (tmpQRTOperator == null || tmpQRTOperator.getTotal() == 0){
				result.setIserror(true);
				result.setMessage("用户名不存在");
				putJSONResult(result);
				return JSON;
			}
			String requestIP = RequestUtils.getRequsetIP(request);
			TOperator tmpTOperator = tmpQRTOperator.getRows().get(0);
			TLogLogin tmpTLogLogin = new TLogLogin();
			tmpTLogLogin.setLoginIp(requestIP);
			tmpTLogLogin.setLoginName(loginName);
			tmpTLogLogin.setOperatorId(tmpTOperator.getId());
			tmpTLogLogin.setOperatorName(tmpTOperator.getRealName());
			tmpTLogLogin.setResult(0);//0表示失败
			tmpTLogLogin.setType(1);//1表示登陆
			if (tmpTOperator.getStatus() == 0){
				result.setIserror(true);
				result.setMessage("该用户已被停用");
				tmpTLogLogin.setDescription("该用户已被停用");
				tlogLoginService.insert(tmpTLogLogin);
				putJSONResult(result);
				return JSON;
			}
			if (tmpTOperator.getErrorTimes() >= ERROR_TIMES){
				result.setIserror(true);
				result.setMessage("密码错误5次,账号被锁定,请联系管理员");
				tmpTLogLogin.setDescription("密码错误5次,账号被锁定,请联系管理员");
				tlogLoginService.insert(tmpTLogLogin);
				putJSONResult(result);
				return JSON;
			}
			QueryResult<TSysconfig> tmpQRTSysconfig = tsysconfigService.findPage(-1, -1, "o.paramCode=?1", new Object[]{SysconfigKey.MD5_KEY.getKey()}, null, null);
			String key = "";
			if (tmpQRTSysconfig != null && tmpQRTSysconfig.getTotal() > 0){
				key = tmpQRTSysconfig.getRows().get(0).getParamValue();
				key = Md5Utils.md5Encode(key);
			}
			String operatorPwd =  Md5Utils.md5Encode(tmpTOperator.getPassword() + key);
			if (!password.toUpperCase().equals(operatorPwd)){
				tmpTOperator.setErrorTimes(tmpTOperator.getErrorTimes() + 1);
				toperatorService.mod(tmpTOperator);
				if (tmpTOperator.getErrorTimes() == ERROR_TIMES){
					result.setMessage("密码错误5次,账号被锁定,请联系管理员");
					tmpTLogLogin.setDescription("密码错误5次,账号被锁定,请联系管理员");
				}else{
					result.setMessage("密码错误" + tmpTOperator.getErrorTimes()+ "次,错误5次将被锁定！");
					tmpTLogLogin.setDescription("密码错误" + tmpTOperator.getErrorTimes()+ "次,错误5次将被锁定！");
				}
				tlogLoginService.insert(tmpTLogLogin);
				result.setIserror(true);
				putJSONResult(result);
				return JSON;
			}
			tmpTLogLogin.setDescription("登陆成功");
			tmpTLogLogin.setResult(1);//成功
			tmpTOperator.setErrorTimes(0);//登录
			tmpTOperator.setLoginTime(new Date());
			tmpTOperator.setLoginIp(requestIP);
			toperatorService.mod(tmpTOperator);
			
			ActionContext actionContext = ActionContext.getContext();
			Map<String, Object> session = actionContext.getSession();
			session.put(SessionAttribute.OPERATOR.getAttribute(), tmpTOperator);
			tlogLoginService.insert(tmpTLogLogin);
			result.setIserror(false);
			putJSONResult(result);
			return JSON;
		}catch (Exception e){
			logger.error(e.getMessage(),e);
			result.setMessage("系统发生错误");
			result.setIserror(true);
			putJSONResult(result);
			return JSON;
		}
	}

	@Action("loginOut")
	public void loginOut(){
		TLogLogin tmpTLogLogin = new TLogLogin();
		TOperator tmpTOperator = this.getCurrentOperator();
		if (tmpTOperator == null){
			logger.error("退出失败，当前操作者为空");
			return;
		}
		try{
			String requestIP = RequestUtils.getRequsetIP(request);
			tmpTLogLogin.setLoginIp(requestIP);
			tmpTLogLogin.setLoginName(tmpTOperator.getLoginName());
			tmpTLogLogin.setOperatorId(tmpTOperator.getId());
			tmpTLogLogin.setOperatorName(tmpTOperator.getRealName());
			tmpTLogLogin.setResult(1);//成功
			tmpTLogLogin.setType(2);//退出
			tmpTLogLogin.setDescription("退出成功");
			tlogLoginService.insert(tmpTLogLogin);
			
			//置空session中的当前操作者
			ActionContext actionContext = ActionContext.getContext();
			Map<String, Object> session = actionContext.getSession();
			session.put(SessionAttribute.OPERATOR.getAttribute(), null);
			session.clear();
			
			PrintWriter out = response.getWriter();
			out.println("<html>");
			out.println("<script>");
			out.println("window.open ('" + request.getContextPath()
					+ "/login.do','_top')");
			out.println("</script>");
			out.println("</html>");
		}catch (Exception e){
			tmpTLogLogin.setResult(0);//失败
			tmpTLogLogin.setDescription("退出失败");
			try {
				tlogLoginService.insert(tmpTLogLogin);
			} catch (SQLException e1) {
				logger.error(e1.getMessage(), e1);
			}
			logger.error(e.getMessage(), e);
		}
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public ResultData getResult() {
		return result;
	}

	public void setResult(ResultData result) {
		this.result = result;
	}
}

