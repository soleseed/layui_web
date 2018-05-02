package hansuo.portalwifi.entity;

import java.io.Serializable;
import java.util.Date;

public class Resources implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 34507640703647358L;

	public Resources() {
		// TODO Auto-generated constructor stub
	}

	private int id;

	private int resourcesId;

	/* 主题的主键 */
	private int themeId;

	private String resourcesName;

	private String resourcesModule;

	private Date updateTime;

	private int isPublished;

	private String resourcesPath;

	private String views;

	private String title;

	private String description;

	public String getResourcesName() {
		return resourcesName;
	}

	public void setResourcesName(String resourcesName) {
		this.resourcesName = resourcesName;
	}

	public String getResourcesModule() {
		return resourcesModule;
	}

	public void setResourcesModule(String resourcesModule) {
		this.resourcesModule = resourcesModule;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public String getResourcesPath() {
		return resourcesPath;
	}

	public void setResourcesPath(String resourcesPath) {
		this.resourcesPath = resourcesPath;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getViews() {
		return views;
	}

	public void setViews(String views) {
		this.views = views;
	}

	public int getResourcesId() {
		return resourcesId;
	}

	public void setResourcesId(int resourcesId) {
		this.resourcesId = resourcesId;
	}

	public int getThemeId() {
		return themeId;
	}

	public void setThemeId(int themeId) {
		this.themeId = themeId;
	}

	public int getIsPublished() {
		return isPublished;
	}

	public void setIsPublished(int isPublished) {
		this.isPublished = isPublished;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

}
