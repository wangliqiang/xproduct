/**  
* @Project: xproduct
* @Title: QueryResult.java
* @Package cn.com.checknull.vo
* @Description: TODO
* @author chenweiliu chenwei.liu@163.com
* @date 2015-2-26 上午10:05:11
* @Copyright: 2015 check_null Reserved.
* @version v1.0  
*/

package cn.com.checknull.vo;

import java.util.List;

/**
 * @ClassName QueryResult
 * @Description 定义一个存放查询结果的泛型类
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-2-26   上午10:05:11
 */
public class QueryResult<T> {
		// 存放结果接的记录总数
		private long total;
		// 存放结果集
		private List<T> rows;
		public long getTotal() {
			return total;
		}
		public void setTotal(long total) {
			this.total = total;
		}
		public List<T> getRows() {
			return rows;
		}
		public void setRows(List<T> rows) {
			this.rows = rows;
		}
}

