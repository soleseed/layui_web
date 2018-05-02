<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html xmlns="http://www.w3.org/1999/xhtml" class="loading">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta name="viewport" content="width=device-width, initial-scale=0.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
<meta name="keywords" content="" />
<meta name="author" content="" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/videocss/style.css" />
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>  


<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta content="telephone=no" name="format-detection">
<link rel="apple-touch-icon-precomposed" href="images/favicon.ico">

<style>
img{
	width: 100%;
    height: 100%;
	/* max-width:100%;
	max-height:100%;
	/* width:300px; */ */
}

.middle{
	margin-bottom:100px;
}

#content{
	padding-bottom:0;
}

.left{
	display:inline-block;
	width:25%;
}

.right{
	display:inline-block;
	width:25%;
}

#content div{
	display:inline-block;
	width:33%;
}

.m {
	/* width: 740px; */
	/* height: 400px; */
	display:inline-block;
	width:49%;
}


.fileInput{
	display:none;
}

#_menu {
	width: 88px;
	height: auto;
	position: fixed;
	top: 50%;
	right: 100px;
	margin-top: -135px;
	z-index:99;
}


#_menu ul {
	display: block;
	list-style: none
}

#_menu ul li a {
	width: 88px;
	height: 54px;
	line-height: 54px;
	text-align: center;
	background-color: #fff;
	color: #32c96a;
	display: block
}

#_menu ul li a:hover, #menu ul li a.cur {
	background-color: #32c92a;
	color: #fff;
}

canvas {
	background: #111;
	border: 1px solid #171717;
	display: block;
	left: 50%;
	margin: -51px 0 0 -201px;
	position: absolute;
	top: 50%;
	/* z-index:100; */
}
</style>

<script type="text/javascript">
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
	function preSource(sourceId, targetId) { 
		var url = getFileUrl(sourceId); 
		var sourcePre = document.getElementById(targetId); 
		sourcePre.name= targetId;
		sourcePre.src = url; 
	} 


	/* 
	 *触发图片选择事件 
	 */
	function selectPic(index,name){
		document.getElementsByName(name)[index].click();
	} 
	
	function selectSource(){
		document.getElementById("bannerVideo").click();
	} 
	
	function publish(){
		$("form").attr("action","${pageContext.request.contextPath }/theme/publish");
		$("form").submit();
		 // 获得frame索引
	    var index = parent.layer.getFrameIndex(window.name);
	    //关闭当前frame
	    parent.layer.close(index);
	}
	
	function submit(){
		 var formData = new FormData($('form')[0]);
		    $.ajax({
		        url: '${pageContext.request.contextPath }/theme/updateBanner',  //server script to process data
		        type: 'POST',
		        xhr: function() {  // custom xhr
		            /* $("#script").html(); */
		            if(isCanvasSupported){
		            	  var c = document.createElement('canvas');
		            	  c.width = 400;
		            	  c.height = 100;			
		            	  var cw = c.width;
		            	  var ch = c.height;	
		            	  document.body.appendChild(c);	
		            	  var cl = new lightLoader(c, cw, ch);				
		            	  setupRAF();
		            	  cl.init();
		            }
		            myXhr = $.ajaxSettings.xhr();
		            return myXhr;
		        },
		        //Ajax事件
		        /* beforeSend: beforeSendHandler, */
		        success: function(){
		        	 // 获得frame索引
		    	    var index = parent.layer.getFrameIndex(window.name);
		    	    //关闭当前frame
		    	   	parent.layer.close(index);
		        },
		        /* error: errorHandler, */
		        // Form数据
		        data: formData,
		        //Options to tell JQuery not to process data or worry about content-type
		        cache: false,
		        contentType: false,
		        processData: false
		    });
		
	   
	}

	function progressHandlingFunction(e){
	    if(e.lengthComputable){
	        $('progress').attr({value:e.loaded,max:e.total});
	    }
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
					if(item.resourcesName != "bannerVideo"){
						var imgId = item.resourcesName + item.resourcesId;
						$("#" + imgId).attr("src","${pageContext.request.contextPath }" + item.resourcesPath);
					}else{
						$("#my-video").attr("src","${pageContext.request.contextPath }" + item.resourcesPath);
					}
					
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
	<div id="header">
		<div class="wrap">
			<div class="logo"></div>
			<i class="search_open"></i>
		</div>
		<div class="logo_msk"></div>
	</div>
	<div id="script"></div>
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/progress.js"></script>
	<form action="${pageContext.request.contextPath }/theme/updateBanner" method="post" enctype="multipart/form-data">
			<!-- 隐藏传值域 -->
			<input type="hidden" id="themeId" name="id" value="${theme.id}"/>
	    	<input type="hidden" name="routeBegin" value="${theme.routeBegin}"/>
	    	<input type="hidden" name="routeEnd" value="${theme.routeEnd}"/>
	    	
			<input class="fileInput" accept="image/*" type="file" name="bannerPic" id="bannerPicFile1" onchange="preSource(this.id,'bannerPic1');" /> 
	    	<input class="fileInput" accept="image/*" type="file" name="bannerPic" id="bannerPicFile2" onchange="preSource(this.id,'bannerPic2');" />
	    	<input class="fileInput" accept="image/*" type="file" name="bannerPic" id="bannerPicFile3" onchange="preSource(this.id,'bannerPic3');" />
	    	<input class="fileInput" accept="image/*" type="file" name="bannerPic" id="bannerPicFile4" onchange="preSource(this.id,'bannerPic4');" /> 
	    	<input class="fileInput" accept="image/*" type="file" name="bannerPic" id="bannerPicFile5" onchange="preSource(this.id,'bannerPic5');" />
	    	
	    	<input class="fileInput" accept="video/*" type="file" name="bannerVideo" id="bannerVideo" onchange="preSource(this.id,'my-video');" />
	</form>
	<div id="container">
		<div id="_menu">
			<ul>
				<li><a href="javascript:void(0);">#</a></li>
				<li><a href="javascript:void(0);" onclick="submit();">保存主题</a></li>
				<li><a href="javascript:void(0);" onclick="publish();">发布主题</a></li>
				<li><a href="javascript:void(0);">#</a></li>
			</ul>
		</div>
		<div id="content">
			<div>
				<img id="bannerPic1" onerror="showNoImage(this);" src="${pageContext.request.contextPath }/images/noimage.jpg" onclick="selectPic(0,'bannerPic');"/>
			</div>
			<div float="left">
				<img id="bannerPic2" onerror="showNoImage(this);" src="${pageContext.request.contextPath }/images/noimage.jpg" onclick="selectPic(1,'bannerPic');"/>
			</div>
			<div>
				<img id="bannerPic3" onerror="showNoImage(this);" src="${pageContext.request.contextPath }/images/noimage.jpg" onclick="selectPic(2,'bannerPic');"/>
			</div>
		</div>
		<div class="middle">
			<div class="left">
				<img id="bannerPic4" onerror="showNoImage(this);" src="${pageContext.request.contextPath }/images/noimage.jpg" onclick="selectPic(3,'bannerPic');"/>
			</div>
			<div class="m">
		    	<video id="my-video" <%-- src="${pageContext.request.contextPath}/upload/video/1.mp4" --%> class="video-js" style="width:100%; height:100%; object-fit: fill;" poster="" controls preload="auto"  data-setup='{ }' onclick="selectSource();">
			        <%-- <source src="${pageContext.request.contextPath}/upload/video/1.mp4" type="video/mp4"> --%>
			        <p class="vjs-no-js"> To view this video please enable JavaScript, and consider upgrading to a web browser that <a href="http://videojs.com/html5-video-support/" target="_blank">supports HTML5 video</a> </p>
		      	</video>
		    </div>
		    <div class="right">
				<img id="bannerPic5" onerror="showNoImage(this);" src="${pageContext.request.contextPath }/images/noimage.jpg" onclick="selectPic(4,'bannerPic');"/>
			</div>
		</div>
		
		<div class="push_msk"></div>
	</div>

	
				
	
	<div id="newwrap_t" class="newwrap">
		<div class="newwrap_msk"></div>
		<iframe id="newwrap" frameborder="0" width="100%" height="100%"></iframe>
	</div>
	
	<div class="loading_dark"></div>
	<div id="loading_mask">
		<div class="loading_mask">
			<ul class="anm">
				<li></li>
				<li></li>
				<li></li>
				<li></li>
				<li></li>
			</ul>
		</div>
	</div>
	<script language="javascript" src="${pageContext.request.contextPath }/js/zepto.min.js"></script>
	<script language="javascript" src="${pageContext.request.contextPath }/js/fx.js"></script>
	<script language="javascript" src="${pageContext.request.contextPath }/js/videoscript.js"></script>
	
</body>
</html>