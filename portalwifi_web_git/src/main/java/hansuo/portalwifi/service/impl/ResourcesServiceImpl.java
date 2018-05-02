package hansuo.portalwifi.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import hansuo.portalwifi.entity.Resources;
import hansuo.portalwifi.mapper.ResourcesMapper;
import hansuo.portalwifi.service.ResourcesService;

@Service
public class ResourcesServiceImpl implements ResourcesService {

	@Value("${cbs.imagesPath}")
	private String imagePath;

	@Value("${cbs.videoPath}")
	private String videoPath;

	@Autowired
	private ResourcesMapper mapper;

	public ResourcesServiceImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public List<Resources> searchNotPublished(int themeId) {
		return mapper.searchNotPublished(themeId);
	}

	@Override
	public void insert(Resources resources) {
		mapper.insert(resources);

	}

	@Override
	public void update(Resources resources) {
		mapper.update(resources);
	}

	@Override
	public void updateWiFiIndex(int id, List<MultipartFile> focus, List<MultipartFile> hot, List<MultipartFile> movie)
			throws IOException {
		// 更新hot区域资源
		for (int i = 0; i <= hot.size() - 1; i++) {
			MultipartFile file = hot.get(i);
			createAndUpdateResource(file, i, id, "hot", "index");
		}

		// 更新focus区域资源
		for (int i = 0; i <= focus.size() - 1; i++) {
			MultipartFile file = focus.get(i);
			createAndUpdateResource(file, i, id, "focus", "index");
		}
		// TODO：更新movie区域资源
		for (int i = 0; i <= movie.size() - 1; i++) {
			MultipartFile file = movie.get(i);
			createAndUpdateResource(file, i, id, "movie", "index");
		}
	}

	/**
	 * 更新资源文件信息
	 * 
	 * @param file
	 *            资源文件
	 * @param i
	 * @param id
	 *            资源主题ID
	 * @param resourcesName
	 *            资源名
	 * @param resourcesModule
	 *            资源所属模块（index,video,banner,portal）
	 * @throws IOException
	 */
	private void createAndUpdateResource(MultipartFile file, int i, int id, String resourcesName,
			String resourcesModule) throws IOException {
		if (StringUtils.isNotBlank(file.getOriginalFilename())) {
			String suffix = file.getOriginalFilename().split("\\.")[1];
			String fileName = file.getName() + (i + 1) + "." + suffix;
			String folderPath = imagePath.replaceAll("file:", "") + id + "/";
			File fileFolder = new File(folderPath);
			if (!fileFolder.exists()) {
				fileFolder.mkdirs();
			}
			File filePic = new File(folderPath + fileName);
			if (!filePic.exists()) {
				filePic.createNewFile();
			}
			file.transferTo(filePic);
			// 保存此次资源更改记录
			Resources resources = mapper.selectByNameAndResourcesId(resourcesName, i + 1, id);
			if (resources == null) {
				resources = new Resources();
				resources.setThemeId(id);
				resources.setIsPublished(0);
				resources.setResourcesId(i + 1);
				resources.setResourcesModule(resourcesModule);
				resources.setResourcesName(resourcesName);
				resources.setResourcesPath(fileName);
				resources.setUpdateTime(new Date());
				mapper.insert(resources);
			} else {
				resources.setUpdateTime(new Date());
				resources.setThemeId(id);
				resources.setIsPublished(0);
				resources.setResourcesModule(resourcesModule);
				resources.setResourcesName(resourcesName);
				resources.setResourcesPath(fileName);
				mapper.update(resources);
			}
		}

	}

	/**
	 * 更新资源文件信息
	 * 
	 * @param file
	 * @param i
	 * @param id
	 * @param resourcesName
	 * @param resourcesModule
	 *            资源所属模块（index,video,banner,portal）
	 * @param title
	 *            资源标题（对应影片标题）
	 * @param description
	 *            资源描述（对应影片描述）
	 * @throws IOException
	 */
	private void createAndUpdateResource(MultipartFile file, int i, int id, String resourcesName,
			String resourcesModule, String title, String description) throws IOException {
		String fileName = null;
		if (StringUtils.isNotBlank(file.getOriginalFilename())) {
			String suffix = file.getOriginalFilename().split("\\.")[1];
			fileName = file.getName() + (i + 1) + "." + suffix;
			String folderPath = imagePath.replaceAll("file:", "") + id + "/";
			File fileFolder = new File(folderPath);
			if (!fileFolder.exists()) {
				fileFolder.mkdirs();
			}
			File filePic = new File(folderPath + fileName);
			if (!filePic.exists()) {
				filePic.createNewFile();
			}
			file.transferTo(filePic);
		}
		// 保存此次资源更改记录
		Resources resources = mapper.selectByNameAndResourcesId(resourcesName, i + 1, id);
		if (resources == null) {
			resources = new Resources();
			resources.setThemeId(id);
			resources.setIsPublished(0);
			resources.setResourcesId(i + 1);
			resources.setResourcesModule(resourcesModule);
			resources.setResourcesName(resourcesName);
			resources.setResourcesPath(fileName);
			resources.setUpdateTime(new Date());
			resources.setTitle(title);
			resources.setDescription(description);
			mapper.insert(resources);
		} else {
			resources.setUpdateTime(new Date());
			resources.setThemeId(id);
			resources.setIsPublished(0);
			resources.setResourcesModule(resourcesModule);
			resources.setResourcesName(resourcesName);
			resources.setResourcesPath(fileName);
			resources.setTitle(title);
			resources.setDescription(description);
			mapper.update(resources);
		}

	}

	@Override
	public List<Resources> selectAllByThemeId(int themeId) {
		return mapper.selectAllByThemeId(themeId);
	}

	@Override
	public List<Resources> selectNotPublishedByThemeId(int themeId) {
		return mapper.selectNotPublishedByThemeId(themeId);
	}

	@Override
	public void updateVideo(int id, List<MultipartFile> videoPic, List<String> titles, List<String> descriptions)
			throws IOException {
		for (int i = 0; i <= videoPic.size() - 1; i++) {
			MultipartFile file = videoPic.get(i);
			createAndUpdateResource(file, i, id, "video", "video", titles.get(i), descriptions.get(i));
		}
	}

	@Override
	public void updateBanner(int id, List<MultipartFile> bannerPic, MultipartFile bannerVideo) throws IOException {
		// TODO Auto-generated method stub
		for (int i = 0; i <= bannerPic.size() - 1; i++) {
			MultipartFile file = bannerPic.get(i);
			createAndUpdateResource(file, i, id, "bannerPic", "banner");
		}
		if (StringUtils.isNotBlank(bannerVideo.getOriginalFilename())) {
			String suffix = bannerVideo.getOriginalFilename().split("\\.")[1];
			String fileName = bannerVideo.getName() + "." + suffix;
			String folderPath = videoPath.replaceAll("file:", "") + id + "/";
			File fileFolder = new File(folderPath);
			if (!fileFolder.exists()) {
				fileFolder.mkdirs();
			}
			File fileVideo = new File(folderPath + fileName);
			if (!fileVideo.exists()) {
				fileVideo.createNewFile();
			}
			bannerVideo.transferTo(fileVideo);
			// 保存此次资源更改记录
			Resources resources = mapper.selectByNameAndResourcesId("bannerVideo", 1, id);
			if (resources == null) {
				resources = new Resources();
				resources.setThemeId(id);
				resources.setIsPublished(0);
				resources.setResourcesId(1);
				resources.setResourcesModule("banner");
				resources.setResourcesName("bannerVideo");
				resources.setResourcesPath(fileName);
				resources.setUpdateTime(new Date());
				mapper.insert(resources);
			} else {
				resources.setUpdateTime(new Date());
				resources.setThemeId(id);
				resources.setIsPublished(0);
				resources.setResourcesModule("banner");
				resources.setResourcesName("bannerVideo");
				resources.setResourcesPath(fileName);
				mapper.update(resources);
			}
		}
	}

	@Override
	public void updatePortal(int id, List<MultipartFile> portalPic) throws IOException {
		for (int i = 0; i <= portalPic.size() - 1; i++) {
			MultipartFile file = portalPic.get(i);
			createAndUpdateResource(file, i, id, "portalAds", "portal");
		}
	}

}
