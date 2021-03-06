package cn.com.checknull.entity;

// Generated 2015-3-17 16:18:12 by Hibernate Tools 3.4.0.CR1

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * TLogOperate generated by hbm2java
 */
@Entity
@Table(name="t_log_operate")
public class TLogOperate implements java.io.Serializable {

	/** 
	* @Fields serialVersionUID : TODO
	*/ 
	private static final long serialVersionUID = 2476298626711623156L;
	private Long id;
	private String loginName;
	private String operatorName;
	private Long operatorId;
	private String operateType;
	private Integer operateResult;
	private String operateObject;
	private String operateValue;
	private Date operateTime;

	public TLogOperate() {
	}

	public TLogOperate(String loginName, String operatorName, Long operatorId,
			String operateType, Integer operateResult, String operateObject,
			String operateValue, Date operateTime) {
		this.loginName = loginName;
		this.operatorName = operatorName;
		this.operatorId = operatorId;
		this.operateType = operateType;
		this.operateResult = operateResult;
		this.operateObject = operateObject;
		this.operateValue = operateValue;
		this.operateTime = operateTime;
	}
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="ID",length=20,nullable=false,unique=true)
	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	@Column(name="LOGIN_NAME",length=32,nullable=true)
	public String getLoginName() {
		return this.loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	@Column(name="OPERATOR_NAME",length=32,nullable=true)
	public String getOperatorName() {
		return this.operatorName;
	}

	public void setOperatorName(String operatorName) {
		this.operatorName = operatorName;
	}
	@Column(name="OPERATOR_ID",length=20,nullable=true)
	public Long getOperatorId() {
		return this.operatorId;
	}

	public void setOperatorId(Long operatorId) {
		this.operatorId = operatorId;
	}
	@Column(name="OPERATE_TYPE",length=50,nullable=true)
	public String getOperateType() {
		return this.operateType;
	}

	public void setOperateType(String operateType) {
		this.operateType = operateType;
	}
	@Column(name="OPERATE_RESULT",length=2,nullable=true)
	public Integer getOperateResult() {
		return this.operateResult;
	}

	public void setOperateResult(Integer operateResult) {
		this.operateResult = operateResult;
	}
	@Column(name="OPERATE_OBJECT",length=32,nullable=true)
	public String getOperateObject() {
		return this.operateObject;
	}

	public void setOperateObject(String operateObject) {
		this.operateObject = operateObject;
	}
	@Column(name="OPERATE_VALUE",nullable=true)
	public String getOperateValue() {
		return this.operateValue;
	}

	public void setOperateValue(String operateValue) {
		this.operateValue = operateValue;
	}
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="OPERATE_TIME", nullable=true)
	public Date getOperateTime() {
		return this.operateTime;
	}

	public void setOperateTime(Date operateTime) {
		this.operateTime = operateTime;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		TLogOperate other = (TLogOperate) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}

}
