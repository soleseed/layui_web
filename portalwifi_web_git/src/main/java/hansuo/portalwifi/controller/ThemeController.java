package hansuo.portalwifi.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;

import hansuo.portalwifi.entity.Theme;
import hansuo.portalwifi.service.ResourcesService;
import hansuo.portalwifi.service.ThemeService;

@Controller
@RequestMapping("/theme")
public class ThemeController {

	@Autowired
	private ResourcesService resourcesService;

	@Autowired
	private ThemeService themeService;

	@RequestMapping("/search")
	public ModelAndView search(Theme theme) {
		ModelAndView mv = new ModelAndView();
		try {
			// TODO：设置主题所属车企
			List<Theme> themes = themeService.searchByPage(theme);
			mv.addObject("themes", themes);
			mv.setViewName("theme/theme_list");
		} catch (Exception e) {
			mv.setViewName("error");
		}
		return mv;
	}

	@RequestMapping("/toSearch")
	public String toSearch(Theme theme) {
		return "theme/theme_list";
	}

	@RequestMapping("/searchJson")
	@ResponseBody
	public Map<String, Object> searchJson(Theme theme, Integer page) {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Theme> themes = new ArrayList<Theme>();
		/* Page<Theme> page = new Page<Theme>(); */
		try {
			Page<Theme> pageInfo = PageHelper.startPage(page, hansuo.portalwifi.page.Page.PAGE_SIZE);
			themes = themeService.searchByPage(theme);
			/* result.put("pageInfo", page.toPageInfo()); */
			result.put("count", pageInfo.getTotal());
			result.put("code", 0);
			result.put("message", "success");
			result.put("data", themes);
		} catch (Exception e) {
		}
		return result;
	}

	@RequestMapping("/toAdd")
	public String toAdd() {
		return "theme/theme_add";
	}

	@RequestMapping("/add")
	@ResponseBody
	public int add(Theme theme) {
		int result = 0;
		try {
			result = themeService.insert(theme);
		} catch (Exception e) {
			result = 0;
		}
		return result;
	}

	@RequestMapping("/toEdit")
	public String toEdit() {
		return "theme/theme_edit";
	}

	@RequestMapping("/edit")
	@ResponseBody
	public int edit(Theme theme) {
		int result = 0;
		try {
			result = themeService.update(theme);
		} catch (Exception e) {
			result = 0;
		}
		return result;
	}

	@RequestMapping("/delete")
	@ResponseBody
	public int delete(String id) {
		int result = 0;
		try {
			result = themeService.delete(id);
		} catch (Exception e) {
			result = 0;
		}
		return result;
	}

	@RequestMapping(value = "/updateWifiIndex")
	@ResponseBody
	public String updateWifiIndex(int id, @RequestParam("hot") List<MultipartFile> hot,
			@RequestParam("focus") List<MultipartFile> focus, @RequestParam("movie") List<MultipartFile> movie) {
		try {
			resourcesService.updateWiFiIndex(id, focus, hot, movie);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@RequestMapping(value = "/updateVideo")
	@ResponseBody
	public String updateVideo(int id, @RequestParam("videoPic") List<MultipartFile> videoPic,
			@RequestParam("titles") List<String> titles, @RequestParam("descriptions") List<String> descriptions) {
		try {
			resourcesService.updateVideo(id, videoPic, titles, descriptions);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@RequestMapping(value = "/updateBanner")
	@ResponseBody
	public boolean updateBanner(int id, @RequestParam("bannerPic") List<MultipartFile> bannerPic,
			MultipartFile bannerVideo) {
		try {
			resourcesService.updateBanner(id, bannerPic, bannerVideo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}

	@RequestMapping(value = "/updatePortal")
	public void updatePortal(int id, @RequestParam("portalPic") List<MultipartFile> portalPic) {
		try {
			resourcesService.updatePortal(id, portalPic);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "/publish")
	public void publish(Theme theme) {
		themeService.publish(theme);
	}
}
