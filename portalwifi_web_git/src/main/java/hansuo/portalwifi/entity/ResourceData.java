package hansuo.portalwifi.entity;

import java.io.Serializable;
import java.util.LinkedList;
import java.util.List;

public class ResourceData implements Serializable {
	private static final long serialVersionUID = 34507640703647358L;

	/* 页面类型：index,video,banner,portal */
	private String resourcesModule;

	/* 资源名 */
	private String resourcesName;

	/* 资源ID */
	private int resourcesId;

	/* 资源路径 */
	private String resourcesPath;

	/* 路线起点 */
	private String routeBegin;

	/* 路线终点 */
	private String routeEnd;

	public static List<ResourceData> genResourceDatas(List<Resources> list, Theme theme, String imagePath,
			String videoPath) {
		List<ResourceData> result = new LinkedList<ResourceData>();
		list.stream().forEach(item -> {
			ResourceData resourceData = new ResourceData();
			resourceData.setResourcesId(item.getResourcesId());
			resourceData.setResourcesModule(item.getResourcesModule());
			resourceData.setResourcesName(item.getResourcesName());
			if ("bannerVideo".equals(item.getResourcesName())) {
				resourceData.setResourcesPath(
						videoPath.substring(videoPath.indexOf("/")) + theme.getId() + "/" + item.getResourcesPath());
			} else {
				resourceData.setResourcesPath(
						imagePath.substring(imagePath.indexOf("/")) + theme.getId() + "/" + item.getResourcesPath());
			}
			resourceData.setRouteBegin(theme.getRouteBegin());
			resourceData.setRouteEnd(theme.getRouteEnd());
			result.add(resourceData);
		});
		return result;
	}

	public String getResourcesModule() {
		return resourcesModule;
	}

	public void setResourcesModule(String resourcesModule) {
		this.resourcesModule = resourcesModule;
	}

	public String getResourcesName() {
		return resourcesName;
	}

	public void setResourcesName(String resourcesName) {
		this.resourcesName = resourcesName;
	}

	public int getResourcesId() {
		return resourcesId;
	}

	public void setResourcesId(int resourcesId) {
		this.resourcesId = resourcesId;
	}

	public String getResourcesPath() {
		return resourcesPath;
	}

	public void setResourcesPath(String resourcesPath) {
		this.resourcesPath = resourcesPath;
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

}
