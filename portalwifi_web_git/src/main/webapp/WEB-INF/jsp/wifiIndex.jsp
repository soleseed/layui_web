<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>  
<html>  
<head>  
<meta name="viewport" content="width=device-width, initial-scale=0.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
<title>主页</title>    
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>  

<style>
* {
	margin: 0;
	padding: 0;
}

body {
	font-size: 12px;
	color: #222;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	background: #f0f0f0;
}

.clearfix:after {
	content: ".";
	display: block;
	height: 0;
	clear: both;
	visibility: hidden;
}

.clearfix {
	zoom: 1;
}

ul, li {
	list-style: none;
}

img {
	border: 0;
}

.wrapper {
	width: 800px;
	margin: 0 auto;
	padding-bottom: 50px;
}

h1 {
	height: 50px;
	line-height: 50px;
	font-size: 22px;
	font-weight: normal;
	font-family: "Microsoft YaHei", SimHei;
	margin-top: 20px;
	/* background-color:#2980B9; */
}

span{
	float:right;
}

/* focus */
#focus {
	width: 800px;
	height: 280px;
	overflow: hidden;
	position: relative;
}

#focus ul {
	height: 380px;
	position: absolute;
}

#focus ul li {
	float: left;
	width: 800px;
	height: 280px;
	overflow: hidden;
	position: relative;
	background: #000;
}

#focus ul li div {
	position: absolute;
	overflow: hidden;
}

#focus .btnBg {
	position: absolute;
	width: 800px;
	height: 20px;
	left: 0;
	bottom: 0;
	background: #000;
}

#focus .btn {
	position: absolute;
	width: 780px;
	height: 10px;
	padding: 5px 10px;
	right: 0;
	bottom: 0;
	text-align: right;
}

#focus .btn span {
	display: inline-block;
	_display: inline;
	_zoom: 1;
	width: 25px;
	height: 10px;
	_font-size: 0;
	margin-left: 5px;
	cursor: pointer;
	background: #fff;
}

#focus .btn span.on {
	background: #fff;
}

#focus .preNext {
	width: 45px;
	height: 100px;
	position: absolute;
	top: 90px;
	background:
		url(${pageContext.request.contextPath }/images/portalimage/sprite.png)
		no-repeat 0 0;
	cursor: pointer;
}

#focus .pre {
	left: 0;
}

#focus .next {
	right: 0;
	background-position: right top;
}

#focus img{
	/* overflow:hidden; */
	max-height:500px;
}

.hot{
	width:800px;
	overflow:hidden;
}

.hot img{
	width:300px;
	overflow:hidden;
	max-height:151px;
}

.hot li {
    list-style: none;
    float: left;
    width: 32%;/*2列图片排列*/
    margin: 5px;
    overflow:hidden;
}

.fileInput{
	display:none;
}


#menu{width: 88px;height: auto; position: fixed;top: 50%;right: 100px;margin-top: -135px;}
#menu ul{display: block;list-style: none}
#menu ul li a{width: 88px; height: 54px; line-height: 54px; text-align: center;background-color: #fff;color: #32c96a;display: block}
#menu ul li a:hover,#menu ul li a.cur{background-color: #32c92a;color: #fff;}

</style>

<script type="text/javascript">
$(function() {  
    var sWidth = $("#focus").width(); //获取焦点图的宽度（显示面积）  
    var len = $("#focus ul li").length; //获取焦点图个数  
    var index = 0;  
    var picTimer;  
      
    //以下代码添加数字按钮和按钮后的半透明条，还有上一页、下一页两个按钮  
    var btn = "<div class='btnBg'></div><div class='btn'>";  
    for(var i=0; i < len; i++) {  
        btn += "<span></span>";  
    }  
    btn += "</div><div class='preNext pre'></div><div class='preNext next'></div>";  
    $("#focus").append(btn);  
    $("#focus .btnBg").css("opacity",0.5);  
  
    //为小按钮添加鼠标滑入事件，以显示相应的内容  
    $("#focus .btn span").css("opacity",0.4).mouseover(function() {  
        index = $("#focus .btn span").index(this);  
        showPics(index);  
    }).eq(0).trigger("mouseover");  
  
    //上一页、下一页按钮透明度处理  
    $("#focus .preNext").css("opacity",0.2).hover(function() {  
        $(this).stop(true,false).animate({"opacity":"0.5"},300);  
    },function() {  
        $(this).stop(true,false).animate({"opacity":"0.2"},300);  
    });  
  
    //上一页按钮  
    $("#focus .pre").click(function() {  
        index -= 1;  
        if(index == -1) {index = len - 1;}  
        showPics(index);  
    });  
  
    //下一页按钮  
    $("#focus .next").click(function() {  
        index += 1;  
        if(index == len) {index = 0;}  
        showPics(index);  
    });  
  
    //本例为左右滚动，即所有li元素都是在同一排向左浮动，所以这里需要计算出外围ul元素的宽度  
    $("#focus ul").css("width",sWidth * (len));  
      
    //鼠标滑上焦点图时停止自动播放，滑出时开始自动播放  
    $("#focus").hover(function() {  
        clearInterval(picTimer);  
    },function() {  
        picTimer = setInterval(function() {  
            showPics(index);  
            index++;  
            if(index == len) {index = 0;}  
        },4000); //此4000代表自动播放的间隔，单位：毫秒  
    }).trigger("mouseleave");  
      
    //显示图片函数，根据接收的index值显示相应的内容  
    function showPics(index) { //普通切换  
        var nowLeft = -index*sWidth; //根据index值计算ul元素的left值  
        $("#focus ul").stop(true,false).animate({"left":nowLeft},300); //通过animate()调整ul元素滚动到计算出的position  
        $("#focus .btn span").stop(true,false).animate({"opacity":"0.4"},300).eq(index).stop(true,false).animate({"opacity":"1"},300);//为当前的按钮切换到选中的效果   
    }  
    
    $(window).scroll(function(){
        var top = $(document).scrollTop();          //定义变量，获取滚动条的高度
        var menu = $("#menu");                      //定义变量，抓取#menu
        var items = $("#content").find(".item");    //定义变量，查找.item

        var curId = "";                             //定义变量，当前所在的楼层item #id 

        items.each(function(){
            var m = $(this);                        //定义变量，获取当前类
            var itemsTop = m.offset().top;        //定义变量，获取当前类的top偏移量
            if(top > itemsTop-100){
                curId = "#" + m.attr("id");
            }else{
                return false;
            }
        });

        //给相应的楼层设置cur,取消其他楼层的cur
        var curLink = menu.find(".cur");
        if( curId && curLink.attr("href") != curId ){
            curLink.removeClass("cur");
            menu.find( "[href=" + curId + "]" ).addClass("cur");
        }
        // console.log(top);
    });
});  


/** 
* 从 file 域获取 本地图片 url 
*/ 
function getFileUrl(sourceId) { 
var url; 
if (navigator.userAgent.indexOf("MSIE")>=1) { // IE 
url = document.getElementById(sourceId).value; 
} else if(navigator.userAgent.indexOf("Firefox")>0) { // Firefox 
url = window.URL.createObjectURL(document.getElementById(sourceId).files.item(0)); 
} else if(navigator.userAgent.indexOf("Chrome")>0) { // Chrome 
url = window.URL.createObjectURL(document.getElementById(sourceId).files.item(0)); 
} 
return url; 
} 

/** 
* 将本地图片 显示到浏览器上 
*/ 
function preImg(sourceId, targetId) { 
	var url = getFileUrl(sourceId); 
	var imgPre = document.getElementById(targetId); 
	imgPre.name= targetId;
	imgPre.src = url; 
} 


/* 
 *触发图片选择事件 
 */
function selectPic(index,name){
	document.getElementsByName(name)[index].click();
} 
 
function submit(){
	$("form").submit();
    // 获得frame索引
    var index = parent.layer.getFrameIndex(window.name);
    //关闭当前frame
    parent.layer.close(index);
}

function publish(){
	$("form").attr("action","${pageContext.request.contextPath }/theme/publish");
	$("form").submit();
	 // 获得frame索引
    var index = parent.layer.getFrameIndex(window.name);
    //关闭当前frame
    parent.layer.close(index);
}

	$(document).ready(function(){
		getResources();
	});
	
	function getResources(){
		var id = $("#themeId").val();
		var url = '${pageContext.request.contextPath }/resources/getResources?id=' + id;
		$.ajax({
			url: url,
			method:'get',
			async:false,
			cache:false,
			dataType:'json',
			success: function(result){
				$.each(result.resources,function(index, item){
					var imgId = item.resourcesName + item.resourcesId;
					$("#" + imgId).attr("src","${pageContext.request.contextPath }" + item.resourcesPath);
				});
			}
			
		});
	}
	
	function showNoImage(img){
		img.src = "${pageContext.request.contextPath }/upload/image/noimage.jpg";
	}
</script>
</head>  
<body>  
	<div id="menu">
	<ul>
		<li><a href="javascript:void(0);">#</a></li>
		<li><a href="javascript:void(0);" onclick="submit();">保存主题</a></li>
		<li><a href="javascript:void(0);" onclick="publish();">发布主题</a></li>
		<li><a href="javascript:void(0);">#</a></li>
	</ul>
	</div>
    <div class="wrapper"> 
      <form action="${pageContext.request.contextPath }/theme/updateWifiIndex" method="post" enctype="multipart/form-data">
    	<input class="fileInput" accept="image/*" type="file" name="hot" id="hotfile1" onchange="preImg(this.id,'hot1');" /> 
    	<input class="fileInput" accept="image/*" type="file" name="hot" id="hotfile2" onchange="preImg(this.id,'hot2');" />
    	<input class="fileInput" accept="image/*" type="file" name="hot" id="hotfile3" onchange="preImg(this.id,'hot3');" />
    	<input class="fileInput" accept="image/*" type="file" name="hot" id="hotfile4" onchange="preImg(this.id,'hot4');" /> 
    	<input class="fileInput" accept="image/*" type="file" name="hot" id="hotfile5" onchange="preImg(this.id,'hot5');" /> 
    	<input class="fileInput" accept="image/*" type="file" name="hot" id="hotfile6" onchange="preImg(this.id,'hot6');" />  
    	
    	<input class="fileInput" accept="image/*" type="file" name="focus" id="focusfile1" onchange="preImg(this.id,'focus1');" />
    	<input class="fileInput" accept="image/*" type="file" name="focus" id="focusfile2" onchange="preImg(this.id,'focus2');" />
    	<input class="fileInput" accept="image/*" type="file" name="focus" id="focusfile3" onchange="preImg(this.id,'focus3');" />
    	<input class="fileInput" accept="image/*" type="file" name="focus" id="focusfile4" onchange="preImg(this.id,'focus4');" />
    	
    	<input class="fileInput" accept="image/*" type="file" name="movie" id="moviefile1" onchange="preImg(this.id,'movie1');" />
    	<input class="fileInput" accept="image/*" type="file" name="movie" id="moviefile2" onchange="preImg(this.id,'movie2');" />
    	<input class="fileInput" accept="image/*" type="file" name="movie" id="moviefile3" onchange="preImg(this.id,'movie3');" />
    	<!-- <input type="submit" value="保存"/> -->
    	
    	<input type="hidden" id="themeId" name="id" value="${theme.id}"/>
    	<input type="hidden" name="routeBegin" value="${theme.routeBegin}"/>
    	<input type="hidden" name="routeEnd" value="${theme.routeEnd}"/>
      </form>
		<!-- <img id="imgPre" src="" width="300px" height="300px" style="display: block;" />   -->
       <div id="focus" style="text-align:center;">  
              <ul>  
                      <li><img id="focus1" onerror="showNoImage(this)" src="${pageContext.request.contextPath }/images/noimage.jpg" onclick="selectPic(0,'focus');" alt="" /></li>  
                      <li><img id="focus2" onerror="showNoImage(this)" src="${pageContext.request.contextPath }/images/noimage.jpg" onclick="selectPic(1,'focus');" alt="" /></li>  
                      <li><img id="focus3" onerror="showNoImage(this)" src="${pageContext.request.contextPath }/images/noimage.jpg" onclick="selectPic(2,'focus');" alt="" /></li>  
                      <li><img id="focus4" onerror="showNoImage(this)" src="${pageContext.request.contextPath }/images/noimage.jpg" onclick="selectPic(3,'focus');" alt="" /></li>
                      <span style="white-space:pre">                                 
              </ul>  
       </div>
       <div class="hot">
       		<h1>热门推荐</h1> 
       		 <ul>  
                  <li><img id="hot1" width="250px" height="250px" onerror="showNoImage(this)" src="${pageContext.request.contextPath }/images/noimage.jpg" onclick="selectPic(0,'hot');" alt="" /></li>  
                  <li><img id="hot2" onerror="showNoImage(this)" src="${pageContext.request.contextPath }/images/noimage.jpg" onclick="selectPic(1,'hot');" alt="" /></li>  
                  <li><img id="hot3" onerror="showNoImage(this)" src="${pageContext.request.contextPath }/images/noimage.jpg" onclick="selectPic(2,'hot');" alt="" /></li>  
                  <li><img id="hot4" onerror="showNoImage(this)" src="${pageContext.request.contextPath }/images/noimage.jpg" onclick="selectPic(3,'hot');" alt="" /></li>
                  <li><img id="hot5" onerror="showNoImage(this)" src="${pageContext.request.contextPath }/images/noimage.jpg" onclick="selectPic(4,'hot');" alt="" /></li>  
                  <li><img id="hot6" onerror="showNoImage(this)" src="${pageContext.request.contextPath }/images/noimage.jpg" onclick="selectPic(5,'hot');" alt="" /></li>
        	 </ul>   
       </div> 
       
       <div class="hot">
       		<h1>最新影视<span>更多></span></h1>
       		 <ul>  
                  <li><img id="movie1" onerror="showNoImage(this)" src="${pageContext.request.contextPath }/images/noimage.jpg" onclick="selectPic(0,'movie'); "alt="" /></li>  
                  <li><img id="movie2" onerror="showNoImage(this)" src="${pageContext.request.contextPath }/images/noimage.jpg" onclick="selectPic(1,'movie'); "alt="" /></li>  
                  <li><img id="movie3" onerror="showNoImage(this)" src="${pageContext.request.contextPath }/images/noimage.jpg" onclick="selectPic(2,'movie');" alt="" /></li>  
        	 </ul>   
       </div> 
    </div>  
</body>  
</html>  