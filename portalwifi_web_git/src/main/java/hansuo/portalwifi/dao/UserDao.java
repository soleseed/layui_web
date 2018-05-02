package hansuo.portalwifi.dao;

import hansuo.portalwifi.entity.User;

public interface UserDao {

	User findByUsernameAndPassword(String username,String password);
}
