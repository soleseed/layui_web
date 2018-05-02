package hansuo.portalwifi.entity;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Theme implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public Theme() {
		// TODO Auto-generated constructor stub
	}

	private int id;

	private String name;

	/* 主题模块 */
	private String module;

	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm")
	private Date updateTime;

	/* 路线起点 */
	private String routeBegin;

	/* 路线终点 */
	private String routeEnd;

	/* 所属企业 */
	private String enterprise;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getModule() {
		return module;
	}

	public void setModule(String module) {
		this.module = module;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public String getRouteBegin() {
		return routeBegin;
	}

	public void setRouteBegin(String routeBegin) {
		this.routeBegin = routeBegin;
	}

	public String getRouteEnd() {
		return routeEnd;
	}

	public void setRouteEnd(String routeEnd) {
		this.routeEnd = routeEnd;
	}

	public String getEnterprise() {
		return enterprise;
	}

	public void setEnterprise(String enterprise) {
		this.enterprise = enterprise;
	}

}
