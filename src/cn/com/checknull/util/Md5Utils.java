/**  
* @Project: xproduct
* @Title: Md5Utils.java
* @Package cn.com.checknull.util
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-3-17 上午10:49:56
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.util;

import java.security.MessageDigest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;

/**
 * @ClassName Md5Utils
 * @Description TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-3-17   上午10:49:56
 */
public abstract class Md5Utils {
	
	private static final Logger logger = LoggerFactory.getLogger(Md5Utils.class);
	
	private static final char HEX_DIGITS[]={'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};
	
	/**
	 * <p>将密码用MD5加密 </p>
	 * @param visiblePass : 密码明文
	 * @param secretKey : 密钥 
	 * @return : 返加密码明文的MD5摘要 
	 * @author 
	 */
	public final static String md5Encode(String visiblePass, String secretKey) {     
		Md5PasswordEncoder md5 = new Md5PasswordEncoder();  
	    md5.setEncodeHashAsBase64(false);  
	    return md5.encodePassword(visiblePass, secretKey);  
	}     
	       
	/**
	 * <p>验证密码</p>
	 * @param encodePass : 密码MD5摘要 
	 * @param visiblePass : 密码明文
	 * @param secretKey : 密钥 
	 * @return : 如果明文与摘要匹配返回true,反之返回false 
	 * @author 
	 */
	public final static boolean md5DecodeValid(String encodePass, String visiblePass, String secretKey) {     
	    Md5PasswordEncoder md5 = new Md5PasswordEncoder();  
	    md5.setEncodeHashAsBase64(false);  
	    return md5.isPasswordValid(encodePass, visiblePass, secretKey);  
	}
	
	public final static String md5Encode(String visiblePass){
		 byte[] btInput = visiblePass.getBytes();
		
		 try {
			 MessageDigest mdInst  = MessageDigest.getInstance("MD5");
			 mdInst .update(btInput);
             byte[] md = mdInst .digest();
             int j = md.length;
             char str[] = new char[j * 2];
             int k = 0;
             for (int i = 0; i < j; i++) {
                byte byte0 = md[i];
                str[k++] = HEX_DIGITS[byte0 >>> 4 & 0xf];
                str[k++] = HEX_DIGITS[byte0 & 0xf];
             }
            return new String(str).toUpperCase();
        } catch (Exception e) {
        	logger.error(e.getMessage(), e);
            return null;
        }
	}
}

