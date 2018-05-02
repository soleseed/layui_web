<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>首页-无线设备管理系统</title>
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />

    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/font.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/css/xadmin.css">
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/xadmin.js"></script>


</head>
<body>
    <!-- 顶部开始 -->
    <div class="container">
        <div class="logo"><a href="index">无线设备管理系统</a></div>
        <div class="left_open">
            <i title="展开左侧栏" class="iconfont">&#xe699;</i>
        </div>
        <ul class="layui-nav left fast-add" lay-filter="">
          <li class="layui-nav-item">
            <a href="javascript:;">+新增</a>
            <dl class="layui-nav-child"> <!-- 二级菜单 -->
              <dd><a onclick="x_admin_show('车企','enterprise_add')"><i class="iconfont">&#xe6a2;</i>车企</a></dd>
              <dd><a onclick="x_admin_show('车辆','bus_add')"><i class="iconfont">&#xe6a8;</i>车辆</a></dd>
              <dd><a onclick="x_admin_show('用户','user_add')"><i class="iconfont">&#xe6b8;</i>用户</a></dd>
              <dd><a onclick="x_admin_show('WIFI设备','wifidevice_add')"><i class="iconfont">&#xe688;</i>WIFI设备</a></dd>
            </dl>
          </li>
        </ul>
        <ul class="layui-nav right" lay-filter="">
          <li class="layui-nav-item">
            <a href="javascript:;">admin</a>
            <!-- <dl class="layui-nav-child"> 二级菜单
              <dd><a onclick="x_admin_show('个人信息','http://www.baidu.com')">个人信息</a></dd>
              <dd><a onclick="x_admin_show('切换帐号','http://www.baidu.com')">切换帐号</a></dd>
              <dd><a href="./login.html">退出</a></dd>
            </dl> -->
          </li>
          <li class="layui-nav-item to-index"><a href="/">注销</a></li>
        </ul>
        
    </div>
    <!-- 顶部结束 -->
    <!-- 中部开始 -->
     <!-- 左侧菜单开始 -->
    <div class="left-nav">
      <div id="side-nav">
        <ul id="nav">
        	<li>
                <a href="javascript:;">
                    <i class="iconfont">&#xe723;</i>
                    <cite>主题定制</cite>
                    <i class="iconfont nav_right">&#xe697;</i>
                </a>
                <ul class="sub-menu">
                	 <li>
                        <a _href="theme/search">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>主题管理</cite>
                        </a>
                    </li >
                </ul>
            </li>
            <li>
                <a href="javascript:;">
                    <i class="iconfont">&#xe723;</i>
                    <cite>基础管理</cite>
                    <i class="iconfont nav_right">&#xe697;</i>
                </a>
                <ul class="sub-menu">
                	<li>
                        <a _href="bus_location">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>车辆位置</cite>
                        </a>
                    </li >
                    <li>
                        <a _href="enterprise_list">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>车企管理</cite>
                        </a>
                    </li >
                    <li>
                        <a _href="bus_list">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>车辆管理</cite>
                            
                        </a>
                    </li>
                    <li>
                        <a _href="wifidevice_list">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>设备管理</cite>
                            
                        </a>
                    </li>
                </ul>
            </li>
            <li>
                <a href="javascript:;">
                    <i class="iconfont">&#xe726;</i>
                    <cite>管理员管理</cite>
                    <i class="iconfont nav_right">&#xe697;</i>
                </a>
                <ul class="sub-menu">
                    <li>
                        <a _href="user_list">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>用户管理</cite>
                        </a>
                    </li >
                    <!-- <li>
                        <a _href="admin-role.html">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>角色管理</cite>
                        </a>
                    </li >
                    <li>
                        <a _href="admin-cate.html">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>权限分类</cite>
                        </a>
                    </li >
                    <li>
                        <a _href="admin-rule.html">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>权限管理</cite>
                        </a>
                    </li > -->
                </ul>
            </li>
        </ul>
      </div>
    </div>
    <!-- <div class="x-slide_left"></div> -->
    <!-- 左侧菜单结束 -->
    <!-- 右侧主体开始 -->
    <div class="page-content">
        <div class="layui-tab tab" lay-filter="xbs_tab" lay-allowclose="false">
          <ul class="layui-tab-title">
            <li>首页</li>
          </ul>
          <div class="layui-tab-content">
            <div class="layui-tab-item layui-show">
                <iframe src='theme/toSearch' frameborder="0" scrolling="yes" class="x-iframe"></iframe>
            </div>
          </div>
        </div>
    </div>
    <div class="page-content-bg"></div>
    <!-- 右侧主体结束 -->
    <!-- 中部结束 -->
    <!-- 底部开始 -->
    <div class="footer">
        <div class="copyright">版权所有：上海瀚所信息技术有限公司 copyright ©hansuotech</div>  
    </div>
</body>
</html>