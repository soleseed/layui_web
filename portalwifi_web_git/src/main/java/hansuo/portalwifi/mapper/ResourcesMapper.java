package hansuo.portalwifi.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.UpdateProvider;

import hansuo.portalwifi.entity.Resources;

public interface ResourcesMapper {

	/**
	 * 查询没有发布的模块资源
	 * 
	 * @param themeId
	 *            资源所属主题ID
	 * @return
	 */
	@Select("SELECT * FROM resources WHERE themeId = #{themeId} and isPublished = 0")
	List<Resources> searchNotPublished(@Param("themeId") int themeId);

	/**
	 * 查询指定模块的特定资源
	 * 
	 * @param resourcesName
	 *            资源名
	 * @param resourcesId
	 *            资源编号
	 * @param themeId
	 *            主题主键
	 * @return
	 */
	@Select("SELECT * FROM resources WHERE resourcesName = #{resourcesName} and resourcesId = #{resourcesId} and themeId = #{themeId}")
	Resources selectByNameAndResourcesId(@Param("resourcesName") String resourcesName,
			@Param("resourcesId") int resourcesId, @Param("themeId") int themeId);

	/**
	 * 查询特定主题的所有资源
	 * 
	 * @param themeId
	 * @return
	 */
	@Select("SELECT * FROM resources WHERE themeId = #{themeId}")
	List<Resources> selectAllByThemeId(@Param("themeId") int themeId);

	/**
	 * 查询特定主题未发布的所有资源
	 * 
	 * @param themeId
	 * @return
	 */
	@Select("SELECT * FROM resources WHERE themeId = #{themeId} and isPublished = 0")
	List<Resources> selectNotPublishedByThemeId(@Param("themeId") int themeId);

	@Insert("INSERT INTO resources(id,resourcesId,themeId,resourcesName,resourcesModule,updateTime,isPublished,resourcesPath,views,title,description)"
			+ " VALUES(#{id}, #{resourcesId}, #{themeId},#{resourcesName}, #{resourcesModule}, #{updateTime}, #{isPublished}, #{resourcesPath},#{views},#{title},#{description})")
	void insert(Resources resources);

	@UpdateProvider(type = ResourcesSqlProvider.class, method = "update")
	void update(Resources resources);

}
