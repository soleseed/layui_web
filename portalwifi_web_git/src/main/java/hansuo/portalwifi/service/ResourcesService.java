package hansuo.portalwifi.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import hansuo.portalwifi.entity.Resources;

public interface ResourcesService {

	/**
	 * 查询没有发布的模块资源
	 * 
	 * @param themeId
	 *            资源所属主题ID
	 * @return
	 */
	List<Resources> searchNotPublished(int themeId);

	/**
	 * 查询特定主题的所有资源
	 * 
	 * @param themeId
	 * @return
	 */
	List<Resources> selectAllByThemeId(int themeId);

	/**
	 * 查询特定主题未发布的所有资源
	 * 
	 * @param themeId
	 * @return
	 */
	List<Resources> selectNotPublishedByThemeId(int themeId);

	void insert(Resources resources);

	void update(Resources resources);

	// 更新WIFI主页资源
	void updateWiFiIndex(int id, List<MultipartFile> focus, List<MultipartFile> hot, List<MultipartFile> movie)
			throws IOException;

	// 更新Video主页资源
	void updateVideo(int id, List<MultipartFile> videoPic, List<String> titles, List<String> descriptions)
			throws IOException;

	// 更新Banner主页资源
	void updateBanner(int id, List<MultipartFile> bannerPic, MultipartFile bannerVideo) throws IOException;

	// 更新Portal主页资源
	void updatePortal(int id, List<MultipartFile> portalPic) throws IOException;
}
