package hansuo.portalwifi.service;

import java.util.List;

import hansuo.portalwifi.entity.Theme;

public interface ThemeService {

	List<Theme> searchByPage(Theme theme);

	int insert(Theme theme);

	int delete(String id);

	int update(Theme theme);

	Theme getById(String id);

	String publish(Theme theme);
}
