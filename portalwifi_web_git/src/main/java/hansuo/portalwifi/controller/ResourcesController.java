package hansuo.portalwifi.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import hansuo.portalwifi.entity.Resources;
import hansuo.portalwifi.entity.Theme;
import hansuo.portalwifi.service.ResourcesService;
import hansuo.portalwifi.service.ThemeService;

@Controller
@RequestMapping("/resources")
public class ResourcesController {

	@Value("${cbs.imagesPath}")
	private String imagePath;

	@Value("${cbs.videoPath}")
	private String videoPath;

	@Autowired
	private ResourcesService service;

	@Autowired
	private ThemeService themeService;

	@RequestMapping("/wifiIndex")
	public ModelAndView toWifiIndex(String id) {
		ModelAndView mv = new ModelAndView();
		Theme theme = themeService.getById(id);
		mv.addObject("theme", theme);
		mv.setViewName("wifiIndex");
		return mv;
	}

	@RequestMapping("/getResources")
	@ResponseBody
	public Map<String, Object> getResources(int id) {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Resources> resources = service.selectAllByThemeId(id);

		resources.stream().forEach(resource -> {
			if ("bannerVideo".equals(resource.getResourcesName())) {
				resource.setResourcesPath(
						videoPath.substring(videoPath.indexOf("/")) + id + "/" + resource.getResourcesPath());
			} else {
				resource.setResourcesPath(
						imagePath.substring(imagePath.indexOf("/")) + id + "/" + resource.getResourcesPath());
			}
		});
		result.put("resources", resources);
		return result;
	}

	@RequestMapping("/video")
	public ModelAndView toVedio(String id) {
		ModelAndView mv = new ModelAndView();
		Theme theme = themeService.getById(id);
		mv.addObject("theme", theme);
		mv.setViewName("video");
		return mv;
	}

	@RequestMapping("/banner")
	public ModelAndView toBanner(String id) {
		ModelAndView mv = new ModelAndView();
		Theme theme = themeService.getById(id);
		mv.addObject("theme", theme);
		mv.setViewName("banner");
		return mv;
	}

	@RequestMapping("/portal")
	public ModelAndView toPortal(String id) {
		ModelAndView mv = new ModelAndView();
		Theme theme = themeService.getById(id);
		mv.addObject("theme", theme);
		mv.setViewName("portal");
		return mv;
	}

}
