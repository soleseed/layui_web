package hansuo.portalwifi.mapper;

import java.util.List;

import hansuo.portalwifi.entity.Theme;

public interface ThemeDao {

	List<Theme> search(Theme theme);

	int insert(Theme theme);

	int delete(String id);

	int update(Theme theme);

	Theme getById(String id);
}
