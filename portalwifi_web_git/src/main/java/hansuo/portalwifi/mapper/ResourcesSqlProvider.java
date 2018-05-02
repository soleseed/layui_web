package hansuo.portalwifi.mapper;

import org.apache.ibatis.jdbc.SQL;

import hansuo.portalwifi.entity.Resources;

public class ResourcesSqlProvider {

	/**
	 * @param demo
	 * @return
	 */
	public String update(final Resources resources) {
		return new SQL() {
			{
				UPDATE("resources");

				// 条件写法.
				if (resources.getResourcesId() != 0) {
					SET("resourcesId=#{resourcesId}");
				}
				if (resources.getResourcesName() != null) {
					SET("resourcesName=#{resourcesName}");
				}
				if (resources.getResourcesModule() != null) {
					SET("resourcesModule=#{resourcesModule}");
				}
				if (resources.getUpdateTime() != null) {
					SET("updateTime=#{updateTime}");
				}
				if (resources.getIsPublished() != -1) {
					SET("isPublished=#{isPublished}");
				}
				if (resources.getResourcesPath() != null) {
					SET("resourcesPath=#{resourcesPath}");
				}
				if (resources.getViews() != null) {
					SET("views=#{views}");
				}
				if (resources.getThemeId() != 0) {
					SET("themeId=#{themeId}");
				}
				if (resources.getTitle() != null) {
					SET("title=#{title}");
				}
				if (resources.getDescription() != null) {
					SET("description=#{description}");
				}
				WHERE("id=#{id}");
			}
		}.toString();
	}
}
