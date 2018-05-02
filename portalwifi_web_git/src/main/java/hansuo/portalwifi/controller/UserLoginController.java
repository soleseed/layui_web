package hansuo.portalwifi.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UserLoginController {

	/*
	 * @Autowired private UserDao userDao;
	 */

	@RequestMapping("/login")
	public String login() {
		return "login";
	}
	/*
	 * //登录方法
	 * 
	 * @RequestMapping("/addlogin") public String login(HttpServletRequest
	 * request,RedirectAttributes attr,HttpSession session){ String username =
	 * request.getParameter("username"); String password =
	 * request.getParameter("password"); User user =
	 * userDao.findByUsernameAndPassword(username,password); String str = ""; if
	 * (user !=null){ str = "index"; session.setAttribute("user", user); }else {
	 * str = "login"; attr.addAttribute("MyError", "50004"); } return str; }
	 */
}
