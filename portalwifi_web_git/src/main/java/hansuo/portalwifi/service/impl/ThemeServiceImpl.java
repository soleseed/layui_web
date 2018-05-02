package hansuo.portalwifi.service.impl;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeoutException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;

import hansuo.portalwifi.entity.ResourceData;
import hansuo.portalwifi.entity.Resources;
import hansuo.portalwifi.entity.Theme;
import hansuo.portalwifi.mapper.ResourcesMapper;
import hansuo.portalwifi.mapper.ThemeDao;
import hansuo.portalwifi.service.ThemeService;
import hansuo.portalwifi.utils.MessageProducerUtil;

@Service
public class ThemeServiceImpl implements ThemeService {

	@Autowired
	private ThemeDao dao;

	@Autowired
	private ResourcesMapper resourcesDao;

	@Autowired
	private MessageProducerUtil producer;

	@Value("${cbs.imagesPath}")
	private String imagePath;

	@Value("${cbs.videoPath}")
	private String videoPath;

	@Override
	public List<Theme> searchByPage(Theme theme) {
		return dao.search(theme);
	}

	@Override
	public int insert(Theme theme) {
		theme.setUpdateTime(new Date());
		return dao.insert(theme);
	}

	@Override
	public int delete(String id) {
		return dao.delete(id);
	}

	@Override
	public int update(Theme theme) {
		theme.setUpdateTime(new Date());
		return dao.update(theme);
	}

	@Override
	public String publish(Theme theme) {
		try {
			List<Resources> resources = resourcesDao.searchNotPublished(theme.getId());
			Object object = JSON.toJSON(ResourceData.genResourceDatas(resources, theme, imagePath, videoPath));
			producer.sendMessage(object);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (TimeoutException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public Theme getById(String id) {
		return dao.getById(id);
	}
}
