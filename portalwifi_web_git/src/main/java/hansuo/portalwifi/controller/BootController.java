package hansuo.portalwifi.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringEscapeUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.StringUtil;

import hansuo.portalwifi.base.HttpUtil;
import hansuo.portalwifi.base.Tree;

@Controller
public class BootController {
	
	private final String httpurl="http://172.20.19.121:8080/buswifi/";

	@RequestMapping("/helloworld")
	public String helloWorld() {
		return "中文乱码";
	}

	@RequestMapping("/portal")
	public String portal() {
		return "portal";
	}
	/**
	 * 登陆页面
	 * @return
	 */
	@RequestMapping("/")
	public String home() {
		return "login";
	}
	/**
	 * 工作首页
	 * @return
	 */
	@RequestMapping("index")
	public String index() {
		return "index";
	}
	/**
	 * 车企列表页
	 * @return
	 */
	@RequestMapping("enterprise_list")
	public String carprices_list() {
		return "enterprise/enterprise_list";
	}
	/**
	 * 车企增加页
	 * @return
	 */
	@RequestMapping("enterprise_add")
	public String enterprise_add() {
		return "enterprise/enterprise_add";
	}
	/**
	 * 车企编辑页
	 * @return
	 */
	@RequestMapping("enterprise_edit")
	public String enterprise_edit(HttpServletRequest request,Model model) {
		
		String args=request.getParameter("args");
		System.out.println("args1"+args);

		JSONArray json = (JSONArray) JSONArray.parse("["+args+"]");
	    for (Object obj : json) {
	       JSONObject jo = (JSONObject)obj;
	       
	        model.addAttribute("name",jo.getString("enterpriseName"));
	        model.addAttribute("address",jo.getString("enterpriseAddress"));
	        model.addAttribute("tel",jo.getString("enterpriseTel"));
	        model.addAttribute("owner",jo.getString("enterpriseOwner"));
	        model.addAttribute("remark",jo.getString("remark"));
	        model.addAttribute("id",jo.getString("id"));
	    }
		return "enterprise/enterprise_edit";
	}
	/**
	 * 车辆列表页
	 * @return
	 */
	@RequestMapping("bus_list")
	public String bus_list() {
		return "bus/bus_list";
	}
	/**
	 * 车辆增加页
	 * @return
	 */
	@RequestMapping("bus_add")
	public String bus_add() {
		return "bus/bus_add";
	}
	
	/**
	 * 车辆编辑页
	 * @return
	 */
	@RequestMapping("bus_edit")
	public String bus_edit(HttpServletRequest request,Model model) {
		
		String args=request.getParameter("args");
		System.out.println("args"+args);
		
		JSONArray json = (JSONArray) JSONArray.parse("["+args+"]");
	    for (Object obj : json) {
	       JSONObject jo = (JSONObject)obj;
	        model.addAttribute("enterprise",jo.getString("enterpriseId"));
	        model.addAttribute("num",jo.getString("busNum"));
	        model.addAttribute("routeBegin",jo.getString("routeBegin"));
	        model.addAttribute("routeEnd",jo.getString("routeEnd"));
	        model.addAttribute("location",jo.getString("busLocation"));
	        model.addAttribute("remark",jo.getString("remark"));
	        model.addAttribute("id",jo.getString("id"));
	    }
		
		return "bus/bus_edit";
	}
	/**
	 * 用户列表页
	 * @return
	 */
	@RequestMapping("user_list")
	public String user_list() {
		return "user/user_list";
	}
	/**
	 * 用户增加页
	 * @return
	 */
	@RequestMapping("user_add")
	public String user_add() {
		return "user/user_add";
	}
	/**
	 * 用户编辑页
	 * @return
	 */
	@RequestMapping("user_edit")
	public String user_edit(HttpServletRequest request,Model model) {
		
		String args=request.getParameter("args");
		System.out.println("args"+args);
		
		JSONArray json = (JSONArray) JSONArray.parse("["+args+"]");
	    for (Object obj : json) {
	        JSONObject jo = (JSONObject)obj;
	        model.addAttribute("enterprise",jo.getString("enterpriseId"));
	        model.addAttribute("name",jo.getString("userName"));
	        model.addAttribute("pwd",jo.getString("userPwd"));
	        model.addAttribute("type",jo.getString("userType"));
	        model.addAttribute("realName",jo.getString("userRealName"));
	        model.addAttribute("telephone",jo.getString("userTelephone"));
	        model.addAttribute("sex",jo.getString("userSex"));
	        model.addAttribute("remark",jo.getString("remark"));
	        model.addAttribute("id",jo.getString("id"));
	    }
		
		return "user/user_edit";
	}
	/**
	 * WIFI设备列表页
	 * @return
	 */
	@RequestMapping("wifidevice_list")
	public String wifidevice_list() {
		return "wifidevice/wifidevice_list";
	}
	/**
	 * WIFI设备增加页
	 * @return
	 */
	@RequestMapping("wifidevice_add")
	public String wifidevice_add() {
		return "wifidevice/wifidevice_add";
	}
	/**
	 * WIFI设备编辑页
	 * @return
	 */
	@RequestMapping("wifidevice_edit")
	public String wifidevice_edit(HttpServletRequest request,Model model) {
		
		String args=request.getParameter("args");
		System.out.println("args"+args);
		
		JSONArray json = (JSONArray) JSONArray.parse("["+args+"]");
	    for (Object obj : json) {
	       JSONObject jo = (JSONObject)obj;
	       
	        model.addAttribute("busId",jo.getString("busId"));
	        model.addAttribute("mac",jo.getString("mac"));
	        model.addAttribute("wanIp",jo.getString("wanIp"));
	        model.addAttribute("ssid",jo.getString("ssid"));
	        model.addAttribute("onlineStatus",jo.getString("onlineStatus"));
	        model.addAttribute("totalFlew",jo.getString("totalFlew"));
	        model.addAttribute("remainFlew",jo.getString("remainFlew"));
	        model.addAttribute("portalVersion",jo.getString("portalVersion"));
	        model.addAttribute("firmWareVersion",jo.getString("firmWareVersion"));
	        model.addAttribute("id",jo.getString("id"));
	    }
		
		return "wifidevice/wifidevice_edit";
	}
	/**
	 * 车辆定位页面
	 * @return
	 */
	@RequestMapping("bus_location")
	public String bus_location() {
		return "bus/bus_location";
	}
	
	
	/**
	 *上网用户查看页面
	 * @return
	 */
	@RequestMapping("passenger_list")
	public String passenger_list() {
		return "passenger/passenger_list";
	}
	/**
	 *上网用户监控
	 * @return
	 */
	@RequestMapping("passenger_log")
	public String passenger_log() {
		return "passenger/passenger_log";
	}
	
	/**
	 * 设备状态
	 * @return
	 */
	@RequestMapping("devicelog_list")
	public String devicelog_list() {
		return "devicelog/devicelog_list";
	}
	
	
	/**
	 * 查询所有接口
	 * @return
	 */
	@RequestMapping(value ="/show" , method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
    public  JSONObject show(HttpServletRequest request) {
		//TYPE:enterprise|bus|user|device
		String urltype=request.getParameter("urltype");
		//公共参数
		String page=request.getParameter("page");
		String limit=request.getParameter("limit");
		String offset="";
		if(StringUtil.isNotEmpty(page)&&StringUtil.isNotEmpty(limit)){
			offset=(Integer.parseInt(page)-1)*10+"";//第几条开始
		}
    	//URL前缀
		String url=httpurl+urltype;
		String param="limit="+limit+"&offset="+offset;

		
		if("enterprise".equals(urltype)){
			
			String name=request.getParameter("name");
			String address=request.getParameter("address");
			String owner=request.getParameter("owner");

			if(name != null && name.length() > 0){
				param=param+"&enterpriseName="+name;
			}
			if(address != null && address.length() > 0){
				param=param+"&enterpriseAddress="+address;
			}
			if(owner != null && owner.length() > 0){
				param=param+"&enterpriseOwner="+owner;
			}
			
		}else if("bus".equals(urltype)){
			String busNum=request.getParameter("num");
			String enterpriseId=request.getParameter("enterprise");
			String busLocation=request.getParameter("location");

			if(busNum!= null && busNum.length() > 0){
				param=param+"&busNum="+busNum;
			}
			if(enterpriseId != null && enterpriseId.length() > 0){
				param=param+"&enterpriseId="+enterpriseId;
			}
			if(busLocation != null && busLocation.length() > 0){
				param=param+"&busLocation="+busLocation;
			}
			
		}else if("user".equals(urltype)){
			String enterpriseId=request.getParameter("enterprise");
			String userName=request.getParameter("name");
			String userType=request.getParameter("type");

			if(enterpriseId != null && enterpriseId.length() > 0){
				param=param+"&enterpriseId="+enterpriseId;
			}
			if(userName!= null && userName.length()> 0){
				param=param+"&userName="+userName;
			}
			if(userType != null && userType.length() > 0){
				param=param+"&userType="+userType;
			}
			
		}else if("device".equals(urltype)){
			String bus=request.getParameter("bus");
			String deviceid=request.getParameter("deviceid");
			String portal=request.getParameter("portal");

			if(bus != null && bus.length() > 0){
				param=param+"&bus="+bus;
			}
			if(deviceid != null && deviceid.length() > 0){
				param=param+"&deviceid="+deviceid;
			}
			if(portal != null && portal.length()> 0){
				param=param+"&owner="+portal;
			}
		}else if("passenger".equals(urltype)){
			String phone=request.getParameter("phone");
			String mobileMac=request.getParameter("mobileMac");
			String mac=request.getParameter("mac");

			if(phone != null && phone.length() > 0){
				param=param+"&phone="+phone;
			}
			if(mobileMac != null && mobileMac.length() > 0){
				param=param+"&mobileMac="+mobileMac;
			}
			if(mac != null && mac.length()> 0){
				param=param+"&mac="+mac;
			}
		}else if("passengerlog".equals(urltype)){
			String phone=request.getParameter("phone");
			String isLocal=request.getParameter("isLocal");

			if(phone != null && phone.length() > 0){
				param=param+"&phone="+phone;
			}
			if(isLocal != null && isLocal.length() > 0){
				param=param+"&isLocal="+isLocal;
			}
			url=httpurl+"passenger/log";
		}else if("devicelog".equals(urltype)){
			String mac=request.getParameter("mac");
			String signal=request.getParameter("signal");

			if(signal != null && signal.length() > 0){
				param=param+"&signal="+signal;
			}
			if(mac != null && mac.length() > 0){
				param=param+"&mac="+mac;
			}
			url=httpurl+"device/status";
		}else{
			System.out.println("数据有误！");
		}
		
        JSONObject jo = new JSONObject(getJson(url,param));
		return jo;
	}
	
	
	/**
	 * 新增
	 * @param request
	 * @return
	 */
	@RequestMapping(value ="/add" , method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public  String add(HttpServletRequest request) {
		
		//TYPE:enterprise|bus|user|device
		String urltype=request.getParameter("urltype");
		
		
		//获取URL
		String url=httpurl+urltype;
		String param="";
		
		if("enterprise".equals(urltype)){
			String name=request.getParameter("name");
			String address=request.getParameter("address");
			String tel=request.getParameter("tel");
			String owner=request.getParameter("owner");
			String remark=request.getParameter("remark");
			
			param="enterpriseName="+name+"&enterpriseAddress="+address+"&enterpriseTel="+tel+"&enterpriseOwner="+owner+"&remark="+remark;
			
		}else if("bus".equals(urltype)){
			String num=request.getParameter("num");
			String enterprise=request.getParameter("enterprise");
			String location=request.getParameter("location");
			String routeBegin=request.getParameter("routeBegin");
			String routeEnd=request.getParameter("routeEnd");
			String remark=request.getParameter("remark");
			
			param="enterpriseId="+enterprise+"&busNum="+num+"&routeBegin="+routeBegin+"&routeEnd="+routeEnd+"&busLocation="+location+"&remark="+remark;

		}else if("user".equals(urltype)){
			String enterpriseId=request.getParameter("enterprise");
			String userName=request.getParameter("name");
			String userType=request.getParameter("type");
			String userPwd=request.getParameter("pwd");
			String userRealName=request.getParameter("realName");
			String userTelephone=request.getParameter("telephone");
			String userSex=request.getParameter("sex");
			String remark=request.getParameter("remark");
			
			param="enterpriseId="+enterpriseId+"&userName="+userName+"&userType="+userType+"&userPwd="+userPwd+"&userTelephone="+userTelephone+"&userRealName="+userRealName+"&userSex="+userSex+"&remark="+remark;

		}else if("device".equals(urltype)){
			String busId=request.getParameter("busId");
			String mac=request.getParameter("mac");
			String wanIp=request.getParameter("wanIp");
			String ssid=request.getParameter("ssid");
			String onlineStatus=request.getParameter("onlineStatus");
			String totalFlew=request.getParameter("totalFlew");
			String remainDlew=request.getParameter("remainFlew");
			String portalVersion=request.getParameter("portalVersion");
			String firmWareVersion=request.getParameter("firmWareVersion");
			
			param="busId="+busId+"&mac="+mac+"&wanIp="+wanIp+"&ssid="+ssid+"&onlineStatus="+onlineStatus+"&totalFlew="+totalFlew+"&remainDlew="+remainDlew+"&portalVersion="+portalVersion+"&firmWareVersion="+firmWareVersion;

		}else{
			System.out.println("数据有误！");
		}
		
		System.out.println("url:"+url+"?"+param);
		//增加
		String jsonString=HttpUtil.sendPost(url,param);
		
		return jsonString;
	}
	
	/**
	 * 修改
	 * @param request
	 * @return
	 */
	@RequestMapping(value ="/update" , method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public  String update(HttpServletRequest request) {
		
		//TYPE:enterprise|bus|user|device
		String urltype=request.getParameter("urltype");
		String id=request.getParameter("id");
		
		//获取URL
		String url=httpurl+urltype+"/"+id;
		String param="";
		
		if("enterprise".equals(urltype)){
			String name=request.getParameter("name");
			String address=request.getParameter("address");
			String tel=request.getParameter("tel");
			String owner=request.getParameter("owner");
			String remark=request.getParameter("remark");
			
			param="enterpriseName="+name+"&enterpriseAddress="+address+"&enterpriseTel="+tel+"&enterpriseOwner="+owner+"&remark="+remark;
			
		}else if("bus".equals(urltype)){
			String num=request.getParameter("num");
			String enterprise=request.getParameter("enterprise");
			String location=request.getParameter("location");
			String routeBegin=request.getParameter("routeBegin");
			String routeEnd=request.getParameter("routeEnd");
			String remark=request.getParameter("remark");
			
			param="enterpriseId="+enterprise+"&busNum="+num+"&routeBegin="+routeBegin+"&routeEnd="+routeEnd+"&busLocation="+location+"&remark="+remark;

			System.out.println(">>>>>>>>>:"+url+"?"+param);
			
		}else if("user".equals(urltype)){
			String enterpriseId=request.getParameter("enterprise");
			String userName=request.getParameter("name");
			String userType=request.getParameter("type");
			String userPwd=request.getParameter("pwd");
			String userRealName=request.getParameter("realName");
			String userTelephone=request.getParameter("telephone");
			String userSex=request.getParameter("sex");
			String remark=request.getParameter("remark");
			
			param="enterpriseId="+enterpriseId+"&userName="+userName+"&userType="+userType+"&userPwd="+userPwd+"&userRealName="+userRealName+"&userTelephone="+userTelephone+"&userRealName="+userRealName+"&userSex="+userSex+"&remark="+remark;

		}else if("device".equals(urltype)){
			String busId=request.getParameter("busId");
			String mac=request.getParameter("mac");
			String wanIp=request.getParameter("wanIp");
			String ssid=request.getParameter("ssid");
			String onlineStatus=request.getParameter("onlineStatus");
			String totalFlew=request.getParameter("totalFlew");
			String remainDlew=request.getParameter("remainFlew");
			String portalVersion=request.getParameter("portalVersion");
			String firmWareVersion=request.getParameter("firmWareVersion");
			
			param="busId="+busId+"&mac="+mac+"&wanIp="+wanIp+"&ssid="+ssid+"&onlineStatus="+onlineStatus+"&totalFlew="+totalFlew+"&remainDlew="+remainDlew+"&portalVersion="+portalVersion+"&firmWareVersion="+firmWareVersion;

		}else{
			System.out.println("数据有误！");
		}

		String jsonString=HttpUtil.sendPut(url,param);
		System.out.println(url);

		return jsonString;
	}
	
	
	/**
	 * 删除
	 * @param request
	 * @return
	 */
	@RequestMapping(value ="/delete" , method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public  String delete(HttpServletRequest request) {
		
		//URLlTYPE:enterprise|bus|user|device
		String urltype=request.getParameter("urltype");
		//业务ID
        String id=request.getParameter("id");
		//获取URL
		String url=httpurl+urltype+"/"+id;
		//删除
		String jsonString=HttpUtil.sendDelete(url);
		
		return jsonString;
	}
	
	
	/**
	 * 查询单一
	 * @param request
	 * @return
	 */
	@RequestMapping(value ="/selectone" , method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public  String selectone(HttpServletRequest request) {
		
		//URLlTYPE:enterprise|bus|user|device
		String urltype=request.getParameter("urltype");
		//业务ID
        String id=request.getParameter("id");
		//获取URL
		String url=httpurl+urltype+"/"+id;
		//删除
		String jsonString=HttpUtil.sendGet(url,"");
		
		return jsonString;
	}
	
	/**
	 * 测试类
	 * @param request
	 * @return
	 */
	@RequestMapping(value ="/getBus" , method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public  JSONObject getBus(HttpServletRequest request) {
		
		/**
		 * 1.查询所有企业id,添加到一个list
		 * 2.循环list，找到每个车企下的车辆集合
		 * 3.组成tree实体类，返回json对象到页面(翻译ID)
		 */
		
		String url="http://172.20.19.121:8080/buswifi/enterprise";
		String param="";
		//获取JSON
		JSONObject obj = new JSONObject(getJson(url,param));
		
	    HashMap<String, Object> map = new HashMap<String, Object>();
		List<hansuo.portalwifi.base.Tree> list_tree=new ArrayList<hansuo.portalwifi.base.Tree>();
		Map<String,String> map_enterprise=new HashMap<String,String>();
		
		JSONArray aar = (JSONArray) JSONArray.parse(obj.getString("data"));
	    for (Object o : aar) {
	        JSONObject jo = (JSONObject)o;
	        String enterpriseId=jo.getString("id");
	        String enterpriseName=jo.getString("enterpriseName");
	        map_enterprise.put(enterpriseId,enterpriseName);
	    }
	    
	    for (String key : map_enterprise.keySet()) {
	        System.out.println(key + ":" + map_enterprise.get(key));
	        
	        List<Tree> list_treeBus=new ArrayList<Tree>();
	    	Tree tree=new Tree();
	    	
	    	String url_bus="http://172.20.19.121:8080/buswifi/bus";
	    	String param_bus="enterpriseId="+key;
	    	
	    	JSONObject busJson = new JSONObject(getJson(url_bus,param_bus));
	    	
	    	System.out.println("busJson:"+busJson);
	    	JSONArray arr_bus= (JSONArray) JSONArray.parse(busJson.getString("data"));
	    	for (Object o : arr_bus) {
		        JSONObject bus = (JSONObject)o;
		        String busNum=bus.getString("busNum");
	    	      Tree tree_bus=new Tree();
	    	      tree_bus.setName(busNum);
	    	      list_treeBus.add(tree_bus);
		    }
	    	System.out.println("id:"+key);
    	    tree.setName(map_enterprise.get(key));
    	    tree.setChildren(list_treeBus);
	    	
			list_tree.add(tree);
	        
	    }
	    
		map.put("state", "0");//成功，
		map.put("message","获取设备组完成！");
	    map.put("data", list_tree);//成功
		
	    JSONObject jo = new JSONObject(map);
		
		return jo;
	}
	
	public static void main(String[] args) {
		String json="{\"code\":\"0000\",\"count\":4,\"data\":\"[{\\\"enterpriseAddress\\\":\\\"静安区1\\\",\\\"enterpriseName\\\":\\\"瀚所1\\\",\\\"enterpriseOwner\\\":\\\"华盛顿1\\\",\\\"enterpriseTel\\\":\\\"12314651\\\",\\\"id\\\":1,\\\"remark\\\":\\\"发阿发\\\"},{\\\"enterpriseAddress\\\":\\\"北京\\\",\\\"enterpriseName\\\":\\\"百度\\\",\\\"enterpriseOwner\\\":\\\"大声道\\\",\\\"enterpriseTel\\\":\\\"2135456\\\",\\\"id\\\":2,\\\"remark\\\":\\\"时的发生分散\\\"},{\\\"enterpriseAddress\\\":\\\"杭州\\\",\\\"enterpriseName\\\":\\\"阿里巴巴\\\",\\\"enterpriseOwner\\\":\\\"马云\\\",\\\"enterpriseTel\\\":\\\"293482983\\\",\\\"id\\\":3,\\\"remark\\\":\\\"爱国肌肤哦那个\\\"},{\\\"enterpriseAddress\\\":\\\"深圳\\\",\\\"enterpriseName\\\":\\\"腾讯\\\",\\\"enterpriseOwner\\\":\\\"马化腾\\\",\\\"enterpriseTel\\\":\\\"293415234\\\",\\\"id\\\":4,\\\"remark\\\":\\\"哈大法官\\\"}]\",\"msg\":\"\",\"total\":4}";
		com.alibaba.fastjson.JSONObject obj=(com.alibaba.fastjson.JSONObject) JSONObject.parse(json);
		System.out.println("code:"+obj.getString("code"));
		System.out.println("data:"+obj.getString("data"));
		
		 
		List<String> list = new ArrayList<String>();
		List<String> list_device=new ArrayList<String>();
		
		JSONArray aar = (JSONArray) JSONArray.parse(obj.getString("data"));
	    for (Object o : aar) {
	       JSONObject jo = (JSONObject)o;
			System.out.println("enterpriseName:"+jo.getString("enterpriseName"));
			list.add(jo.getString("enterpriseName"));
			list_device.add(jo.getString("enterpriseName"));
	    }
	    
	}
	/**
	 * 查询json转map
	 * @param url
	 * @param param
	 * @return
	 */
	public Map<String,Object> getJson(String url,String param){
		//maps
		Map<String,Object> maps=new HashMap<String,Object>();
		//data:list集合
		List<Object> list = new ArrayList<Object>();
		//获取查询JSON
		String json_fi=StringEscapeUtils.unescapeJava(HttpUtil.sendGet(url,param));
		String json_tw=json_fi.substring(1, json_fi.length()-1);
		//转JSON对象
		com.alibaba.fastjson.JSONObject obj=(com.alibaba.fastjson.JSONObject) JSONObject.parse(json_tw);
		//获取list集合
		JSONArray aar = (JSONArray) JSONArray.parse(obj.getString("data"));
	    for (Object o : aar) {
	        JSONObject jo = (JSONObject)o;
			list.add(jo);
	    }
		
		maps.put("code",obj.getString("code"));
		maps.put("msg", obj.getString("msg"));
		maps.put("count", obj.getString("total"));
		maps.put("data", list);
		
		return maps;
		
	}
	
    /**
     * 单查
     * @param request
     * @return
     */
	@RequestMapping(value ="/showSelect" , method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
    public  String showSelect(HttpServletRequest request) {
		//TYPE:enterprise|bus|user|device
		String urltype=request.getParameter("urltype");
		String url=httpurl+urltype;
		String param="";
		String jsonString=HttpUtil.sendGet(url, param);
		return jsonString;
	}
	
	@RequestMapping(value ="/getBusLoaction" , method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
    public  String getBusLoaction(HttpServletRequest request) {
		/**
		 * 1.获取前台传来的值：可能车企、可能车牌号
		 */
		String busNumOrEnterprise=request.getParameter("busNumOrEnterprise");
		//url>>http://ip地址:端口/buswifi/bus/location/id
		//url>>http://ip地址:端口/buswifi/bus/location
		String url=httpurl+"bus/";
		String jsonString="";
		if(StringUtil.isNotEmpty(busNumOrEnterprise)){
			url="location";
			jsonString=HttpUtil.sendGet(url, "");
		}else{
			//根据企业名字判断
			String json_en=HttpUtil.sendGet("http://172.20.19.121:8080/buswifi/enterprise", "enterpriseName="+busNumOrEnterprise);
			JSONObject obj_en=(JSONObject) JSONObject.parse(json_en);
			//获取list集合
			JSONArray aar = (JSONArray) JSONArray.parse(obj_en.getString("data"));
			if(aar.size()==0){
				String json_bus=HttpUtil.sendGet("http://172.20.19.121:8080/buswifi/bus", "busNum="+busNumOrEnterprise);
				JSONObject obj_bus=(JSONObject) JSONObject.parse(json_bus);
				
				JSONArray aar_bus = (JSONArray) JSONArray.parse(obj_bus.getString("data"));
			    for (Object o : aar_bus) {
			        JSONObject jo = (JSONObject)o;
			        String id=jo.getString("id");
			        //传过来是车辆
					jsonString=HttpUtil.sendGet(url+id, "");
			    }
			}else{
				//传过来是车企
			}
		   
		}
	
		return jsonString;
	}
	
	
	
}
