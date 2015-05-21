package cn.com.checknull.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

// Generated 2015-3-13 14:52:20 by Hibernate Tools 3.4.0.CR1

/**
 * TSysroleMenu generated by hbm2java
 */
@Entity
@Table(name="t_sysrole_menu")
public class TSysroleMenu implements java.io.Serializable {

	/** 
	* @Fields serialVersionUID : TODO
	*/ 
	private static final long serialVersionUID = 6781941064180564271L;
	private Long id;
	private Long roleId;
	private String menuIds;

	public TSysroleMenu() {
	}

	public TSysroleMenu(Long roleId, String menuIds) {
		this.roleId = roleId;
		this.menuIds = menuIds;
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
	@Column(name="ROLE_ID",length=20,nullable=true)
	public Long getRoleId() {
		return this.roleId;
	}

	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}
	@Column(name="MENU_IDS",nullable=true)
	public String getMenuIds() {
		return this.menuIds;
	}

	public void setMenuIds(String menuIds) {
		this.menuIds = menuIds;
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
		TSysroleMenu other = (TSysroleMenu) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}

}