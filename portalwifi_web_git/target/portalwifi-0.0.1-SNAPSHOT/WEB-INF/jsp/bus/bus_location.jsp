<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>车企管理-无线设备管理系统</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />

<link href="${pageContext.request.contextPath }/css/map.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/smartmap/smartmap.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/font.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/xadmin.css">

<script src="${pageContext.request.contextPath }/lib/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/xadmin.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath }/smartmap/turf.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/smartmap/smartmap.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/smartmap/turf.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/smartmap/smartmap.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>

<style type="text/css">
	/*右侧悬浮菜单*/
	.slide{
		width: 140px;
		position: fixed;
		top: 0%;
		margin-top: 50px;
		background:#F7F7F7;
		right: -140px;
		border-radius: 5px 0 0 5px;
		z-index: 999;
	}
	/*控制菜单的按钮*/
	.index_cy{
		width: 30px;
		height: 30px;
		title:列车列表,点击可展开;
		background: url(../images/portalimage/22.png);
		position: fixed;
		right: 0;
		top: 0%;
		margin-top: 5px;
		background-position: 62px 0;
		cursor: pointer;
	}
	.index_cy2{
		width: 30px;
		height: 30px;
		background: url(../images/portalimage/11.png);
		position: fixed;
		right: 0;
		top: 0%;
		margin-top: 5px;
		background-position: 30px 0;
		cursor: pointer;
	}
	.li{
		width:50px !important;
	}
	/*自适应 当屏小于1050时隐藏*/
	@media screen and (max-width: 1050px) {
		.slide{
			display: none;
		}
		#btn{
			display: none;
		}
		
	}
	
	.tt{
		background-color:#eeeeee;
	}
	body .layui-tree-skin-shihuang .layui-tree-branch{color: #009688;}  
</style>
</head>
<body>
	<div id="allmap" ></div>
	<div id="btn"  title="车辆列表,点击可展开" class="index_cy2"></div>
	<!--右侧悬浮菜单-->
	<div  class="slide">
	  <div class="layui-inline">
	    <input class="layui-input" name="busNum" id="busNum" placeholder="输入车牌号，点击回车" autocomplete="off">
	  </div>
	  <div id="buslist"  style="max-height:700px;overflow:auto;overflow-x:hidden;">
	</div>
</body>
</html>
<script type="text/javascript">



layui.use('element', function(){
  var $ = layui.jquery
  ,element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块
  
  //触发事件
  var active = {
    tabAdd: function(){
      //新增一个Tab项
      element.tabAdd('demo', {
        title: '新选项'+ (Math.random()*1000|0) //用于演示
        ,content: '内容'+ (Math.random()*1000|0)
        ,id: new Date().getTime() //实际使用一般是规定好的id，这里以时间戳模拟下
      })
    }
    ,tabDelete: function(othis){
      //删除指定Tab项
      element.tabDelete('demo', '44'); //删除：“商品管理”
      
      
      othis.addClass('layui-btn-disabled');
    }
    ,tabChange: function(){
      //切换到指定Tab项
      element.tabChange('demo', '22'); //切换到：用户管理
    }
  };
  
  $('.site-demo-active').on('click', function(){
    var othis = $(this), type = othis.data('type');
    active[type] ? active[type].call(this, othis) : '';
  });
  
  //Hash地址的定位
  var layid = location.hash.replace(/^#test=/, '');
  element.tabChange('test', layid);
  
  element.on('tab(test)', function(elem){
    location.hash = 'test='+ $(this).attr('lay-id');
  });
  
});



var flag=1;
var executeflag="";

// 1. 创建地图
var center = [121.436876,31.294702];
var smartMap = new smtmap.Map("allmap");
smartMap.fitMap();
smartMap.centerAndZoom(center, 16);
 
// 2. 车皮图标(目前调度作业统一用绿色图标)
var greenTrainIcon = "assets/image/train_green.png"; // 绿色图标：车皮运行状态
var blackTrainIcon = "assets/image/train_black.png"; // 黑色图标：车皮静止状态
var redTrainIcon = "assets/image/train_red.png"; // 红色图标：管辖区域外#车皮运行状态
var yellowTrainIcon = "assets/image/train_yellow.png"; // 黄色图标：管辖区域外#车皮静止状态
var transTrainIcon = "assets/image/train_transparent.png"; // 透明图标：闪烁功能

smartMap.addEventListener("singleclick", function(e) {
	console.log(e.coordinate); // 地图点的坐标
});

//获取列表
function getBus(){
	
	//var busNum=$("#busNum").val();
	 $.ajax({ 
		data:{
			//busNum:busNum,
    	},
    	type:"GET",
		dataType:'json',
		url:"${pageContext.request.contextPath }/getBus",
		success:function(reslut){ 
			//var json="[{ name: '腾讯',children: [{name: '车辆001'},{name: '车辆002'}]},{name: '百度',children: [{name: '车辆001'},{name: '车辆002'}]}]";
			layui.use('tree', function(){
			   layui.tree({
				  elem: '#buslist' //传入元素选择器
				  ,skin: 'shihuang'
				  ,nodes: reslut.data
				  ,click: function(node){
				    console.log(node) //node即为当前点击的节点数据
				  }  
				});
			});
 		}						
  });
}


$(function() {
	
	$('#btn').click(function(){
		if($(this).hasClass('index_cy')){
			$('.slide').animate({right: '-140px'},300);
			$(this).removeClass('index_cy');
			$(this).addClass('index_cy2');
			document.getElementById ("btn").title ="列车列表,点击可展开";

		}else{
			$('.slide').animate({right: '0px'},300);
			$(this).removeClass('index_cy2');
			$(this).addClass('index_cy');
			document.getElementById ("btn").title ="列车列表,点击可隐藏";

		}
	});
	
	getBus();
	//getPosition(executeflag);
	//setInterval(function(){getPosition(executeflag);}, 2000);

	
})

// 转换后台数据库中点坐标集为前端点坐标集合
function convert(data) {
	return data.areaPoints.split('|').map(function(point) {
		// smartMap.addOverlay(new smtmap.Point(point.split(','))); // 展示管辖区边界点 @TEST
		return point.split(',');
	});
}

// 获取所有车皮位置数据信息
function getPosition(trainno) {
	if(trainno!=null){
		executeflag=trainno;
	}
	$.ajax({
		data:{
			trainno:trainno,
    	},
		type:"GET",
		dataType:'json',
		url:"${pageContext.request.contextPath}/location/getAllTrainPosition.json",
		success:function(data){
			if(trainno!=null&&trainno!=""){
				handlePostionOne(data.data);
			}else{
				handlePostion(data.data);
			}
		}					
	});
}

// 构建车皮坐标
var currentWindow = null; // 用于定义当前开启的窗口
function handlePostion(data) {
	data.forEach(function(item) {
		var point = [item.wtrainlocation.longitude, item.wtrainlocation.latitude];// 获取经纬度
		var infoWindow = buildInfoWindow(item);
		var marker = buildMarker(item);
		marker.addEventListener("mouseover", function (e) {
				smartMap.removeInfoWindow(currentWindow);
		        smartMap.openInfoWindow(infoWindow, point); 
		        currentWindow = infoWindow;
		    	infoTimeout(infoWindow);
	    });
		smartMap.addOverlay(marker);
	});
}

function handlePostionOne(data) {
	data.forEach(function(item) {
		var point = [item.wtrainlocation.longitude, item.wtrainlocation.latitude];// 获取经纬度
		var infoWindow = buildInfoWindow(item);
		var marker = buildMarker(item);
		marker.addEventListener("mouseover", function (e) {
			smartMap.removeInfoWindow(currentWindow);
	        smartMap.openInfoWindow(infoWindow, point); 
			currentWindow = infoWindow;
	    	infoTimeout(infoWindow);

	    	
	    });
		smartMap.removeInfoWindow(currentWindow);
		smartMap.openInfoWindow(infoWindow, point); 
		currentWindow = infoWindow;

		smartMap.clearOverlays();
		center=point;
		smartMap.centerAndZoom(center, 16);
		smartMap.addOverlay(marker);
		

	});
}

// 构建车皮展示TAB
function buildInfoWindow(item) {
	//alert(item.wtrainlocation.updatetime);
	var content='<div class = "infoWindow" style="margin:0px;line-height:18px;padding:2px;font-size:12px;">'
    	+ '车辆：' + item.trainno + '<br/>'
	    + '设备：' + item.equipmentno + '<br/>'
	    + '经度：' + toFixed(item.wtrainlocation.longitude) + '<br/>'
	    + '纬度：' + toFixed(item.wtrainlocation.latitude) + '<br/>'
	    + '时间：' + new Date(item.wtrainlocation.updatetime).pattern("yyyy/MM/dd HH:mm:ss")
        + '</div>';
	var opts = {
		    width: 180,
		    height: 110,
		    title: item.trainno,
		};
	return new smtmap.InfoWindow(content, opts);
}

// 构建车皮图标
var markerMap = new Map(); // 用于定义车皮图标数据集
var flashMap = new Map();
function buildMarker(item) {
	var point = [item.wtrainlocation.longitude, item.wtrainlocation.latitude];
	var marker = markerMap.get(item.trainno); // 从本地数据集中获取Marker
	if(typeof(marker) == 'undefined') {
		marker = new smtmap.Marker(point, greenTrainIcon);
	}
	marker.setIcon(item.iswarning  ==  0 ? greenTrainIcon : redTrainIcon);
	marker.setCoordinate(point);
	marker.setAnchor(0.5, 0.5);
	markerMap.set(item.trainno, marker);
	return marker;
}

// 定时关闭当前窗口
var windowTimeout = null; // 用于定义窗口超时控件
function infoTimeout(infoWindow) {
	clearTimeout(windowTimeout);
	windowTimeout = setTimeout(function() {
   		smartMap.removeInfoWindow(infoWindow);	
	}, 1000);
}

//显示经纬度数字
function toFixed(num) {
	return new Number(num).toFixed(7);
}


// 回转算法计算点在区域内
function isInsidePolygon(p, poly) {
	var sum = 0;
	var px = p[0], py = p[1];
	for(var i = 0, l = poly.length, j = l - 1; i < l; j = i, i++) {
		var sx = Number(poly[i][0]);
		var sy = Number(poly[i][1]);
		var tx = Number(poly[j][0]);
		var ty = Number(poly[j][1]);
		// 点与多边形顶点重合或在多边形的边上
   		if((sx - px) * (px - tx) >= 0 && (sy - py) * (py - ty) >= 0 && (px - sx) * (ty - sy) === (py - sy) * (tx - sx)) {
     		return 'on';
		}
		// 点与相邻顶点连线的夹角
		var angle = Math.atan2(sy - py, sx - px) - Math.atan2(ty - py, tx - px);
		// 确保夹角不超出取值范围（-π 到 π）
		if(angle >= Math.PI) {
		  angle = angle - Math.PI * 2;
		} else if(angle <= -Math.PI) {
		  angle = angle + Math.PI * 2;
		}
		sum += angle;
	}
	// 计算回转数并判断点和多边形的几何关系
	return Math.round(sum / Math.PI) === 0 ? 'out' : 'in';
}

function locationOne() {
	var equipId = $('#equipId').val();
	var marker = markerMap.get(equipId);
	var point = marker.getCoordinate();
	smartMap.centerAndZoom(point, 16);
}

//轨迹
var alpha = 0.03;
var fPoint = center;//起始点
var traj = new smtmap.Trajectory([fPoint],1000000);
smartMap.addOverlay(traj);

//traj.setMarker(new smtmap.Marker(fPoint, redTrainIcon));

function getPoint() {
    var pointA = fPoint;
    console.log("模拟偏移量:" + alpha * (Math.random() - 0.5));
    fPoint = [fPoint[0] + alpha * (Math.random() - 0.5), fPoint[1] + alpha * (Math.random() - 0.5)]
	console.log("getDistance: " + smartMap.getDistance(pointA, fPoint));
    return fPoint;
}

//优化方案#给定两个点#模拟两点之间的轨迹#随机数随次数而趋同
var dest = [121.44902252147033, 31.253277964147422];
var x = (dest[0] - center[0]) / 1000;
var y = (dest[1] - center[1]) / 1000;
function getPoint2() {
    fPoint = [fPoint[0] + x + alpha * (Math.random() - 0.5), fPoint[1] + y + alpha * (Math.random() - 0.5)];
	return fPoint;    
}
//模拟轨迹
function mock() {
	for(var i = 0; i < 1000; i++) {
		var p = getPoint2();
		smartMap.addOverlay(new smtmap.Point(p));
		traj.push(p);
	}
}

</script>

<script type="text/javascript">
/**       
* 对Date的扩展，将 Date 转化为指定格式的String       
* 月(M)、日(d)、12小时(h)、24小时(H)、分(m)、秒(s)、周(E)、季度(q) 可以用 1-2 个占位符       
* 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)       
* eg:       
* (new Date()).pattern("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423       
* (new Date()).pattern("yyyy-MM-dd E HH:mm:ss") ==> 2009-03-10 二 20:09:04       
* (new Date()).pattern("yyyy-MM-dd EE hh:mm:ss") ==> 2009-03-10 周二 08:09:04       
* (new Date()).pattern("yyyy-MM-dd EEE hh:mm:ss") ==> 2009-03-10 星期二 08:09:04       
* (new Date()).pattern("yyyy-M-d h:m:s.S") ==> 2006-7-2 8:9:4.18       
*/          
Date.prototype.pattern=function(fmt) {           
 var o = {           
 "M+" : this.getMonth()+1, //月份           
 "d+" : this.getDate(), //日           
 "h+" : this.getHours()%12 == 0 ? 12 : this.getHours()%12, //小时           
 "H+" : this.getHours(), //小时           
 "m+" : this.getMinutes(), //分           
 "s+" : this.getSeconds(), //秒           
 "q+" : Math.floor((this.getMonth()+3) / 3),         
 "S" : this.getMilliseconds() //毫秒           
 };           
 var week = {           
 "0" : "/u65e5",           
 "1" : "/u4e00",           
 "2" : "/u4e8c",           
 "3" : "/u4e09",           
 "4" : "/u56db",           
 "5" : "/u4e94",           
 "6" : "/u516d"          
 };           
 if(/(y+)/.test(fmt)){           
     fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));           
 }           
 if(/(E+)/.test(fmt)){           
     fmt=fmt.replace(RegExp.$1, ((RegExp.$1.length>1) ? (RegExp.$1.length>2 ? "/u661f/u671f" : "/u5468") : "")+week[this.getDay()+""]);           
 }           
 for(var k in o){           
     if(new RegExp("("+ k +")").test(fmt)){           
         fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));           
     }           
 }           
 return fmt;           
}  

//列表变色
function fun(obj){
	var leftbar = document.getElementById('trainlist');
	var obj_lis = leftbar.getElementsByTagName('li');
	for( var int_i = 0; int_i < obj_lis.length; int_i++ ){
		if( obj_lis[int_i] == obj ){
			obj_lis[int_i].className = 'tt';
		}
		else{
			obj_lis[int_i].className = '';
		}
	}
}



</script>
