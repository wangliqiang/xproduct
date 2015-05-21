/**  
 * @Project: xproduct
 * @Title: SQLServerConnectTest.java
 * @Package cn.com.checknull.dao
 * @Description: TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-5-3 下午10:25:13
 * @Copyright: 2015 Pukka Co., Ltd All Rights Reserved.
 * @version v1.0  
 */

package cn.com.checknull.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.junit.Test;


/**
 * @ClassName SQLServerConnectTest
 * @Description TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-5-3 下午10:25:13
 */
public class SQLServerConnectTest {

	@Test
	public void test() {
		String dbDriver = "net.sourceforge.jtds.jdbc.Driver";
		String strConnection = "jdbc:jtds:sqlserver://localhost:1433/xproduct";
		String user = "sa";
		String password = "admin123";
		Connection conn = null;
		try {
			// 定义连接驱动
			Class.forName(dbDriver);
		} catch (java.lang.ClassNotFoundException e) {
			System.err.println("DBconnection():" + e.getMessage());
		}
		// --------连接SQL数据库------------------
		try {
			conn = DriverManager.getConnection(strConnection, user, password);
			Statement statement = conn.createStatement();
			ResultSet rs = statement.executeQuery("select * from t_operator");
			if (rs != null && rs.next()){
				System.out.println(rs.getString(3));
				System.out.println(rs.getString(4));
				System.out.println(rs.getString(5));
			}
		} catch (SQLException ex) {
			System.err.println("aq.executeQuery:" + ex.getMessage());
		}
	}

}
