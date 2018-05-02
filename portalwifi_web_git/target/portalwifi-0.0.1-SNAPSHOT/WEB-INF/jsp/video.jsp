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
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta content="telephone=no" name="format-detection">
<link rel="apple-touch-icon-precomposed" href="images/favicon.ico"/>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
<style>
._input {
	border: 1px solid #D6D6D6;
	border-radius: 5px;
	margin-bottom: 5px;
}

._textarea {
	resize: none;
	overflow: auto;
	height: 50px;
}

._input ._textarea:hover {
	border-color: #006699;
}

._input ._textarea:focus {
	border-color: #0099ff;
	outline-style: none;
}

.fileInput {
	display: none;
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
					var titleId= "title" + item.resourcesId;
					$("#"+titleId).val(item.title);
					var descriptionId= "description" + item.resourcesId;
					$("#"+descriptionId).val(item.description);
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
			<i class="search_open" onclick="submit();"></i>
		</div>
		<div class="logo_msk"></div>
	</div>
	<div id="container">
		<div id="_menu">
			<ul>
				<li><a href="javascript:void(0);">#</a></li>
				<li><a href="javascript:void(0);" onclick="submit();">保存主题</a></li>
				<li><a href="javascript:void(0);" onclick="publish();">发布主题</a></li>
				<li><a href="javascript:void(0);">#</a></li>
			</ul>
		</div>
		<!-- <div id="sort">
			<table width="100%" border="0" cellspacing="0">
				<tr>
					<td class="sort_left">
						<div class="sort_cate">
							<div class="sort_b"><a href="#" onclick="return false;"><div class="sort_b_inner"><i class="cate_default"></i><span>全部</span><div class="clear"></div></div></a></div>
						</div>
					</td>
					<td>
						<div class="sort_sort">
							<div class="sort_b"><a href="#" onclick="return false;"><div class="sort_b_inner"><i class="cate_sort"></i><span>最新发布</span><div class="clear"></div></div></a></div>
						</div>
					</td>
					<td class="sort_right">
						<div class="sort_tag">
							<div class="sort_b"><a href="#" onclick="return false;"><div class="sort_b_inner"><i class="cate_tag"></i><span>版权</span><div class="clear"></div></div></a></div>
						</div>
					</td>
				</tr>
			</table>
		</div> -->
		<form action="${pageContext.request.contextPath }/theme/updateVideo" method="post" enctype="multipart/form-data">
			<input type="hidden" id="themeId" name="id" value="${themeId}"/>
			<input class="fileInput" accept="image/*" type="file" name="videoPic" id="videoPicFile1" onchange="preImg(this.id,'video1');" /> 
	    	<input class="fileInput" accept="image/*" type="file" name="videoPic" id="videoPicFile2" onchange="preImg(this.id,'video2');" />
	    	<input class="fileInput" accept="image/*" type="file" name="videoPic" id="videoPicFile3" onchange="preImg(this.id,'video3');" />
	    	<input class="fileInput" accept="image/*" type="file" name="videoPic" id="videoPicFile4" onchange="preImg(this.id,'video4');" /> 
	    	<input class="fileInput" accept="image/*" type="file" name="videoPic" id="videoPicFile5" onchange="preImg(this.id,'video5');" /> 
		<div id="content">	
			<div id="list">
				<ul>
					<li>
						<div class="wrap" style="padding:10px 0;">
								<div class="list_litpic fl">
									<img id="video1" onerror="showNoImage(this);" src="${pageContext.request.contextPath }/images/noimage.jpg" onclick="selectPic(0,'videoPic');"/></div>
								<div class="list_info">
									<div><input id="title1" name="titles" class="_input"></input ></div>
									<div><textarea id="description1" name="descriptions" class="_textarea"></textarea ></div>
								</div>
								<div class="clear"></div>
							
						</div>
					</li>
					<li>
						<div class="wrap" style="padding:10px 0;">
								<div class="list_litpic fl">
									<img id="video2" onerror="showNoImage(this);" src="${pageContext.request.contextPath }/images/noimage.jpg" onclick="selectPic(1,'videoPic');"/></div>
								<div class="list_info">
									<div><input id="title2" name="titles" class="_input"></input ></div>
									<div><textarea id="description2" name="descriptions" class="_textarea"></textarea ></div>
								</div>
								<div class="clear"></div>
							
						</div>
					</li>
					<li>
						<div class="wrap" style="padding:10px 0;">
								<div class="list_litpic fl">
									<img id="video3" onerror="showNoImage(this);" src="${pageContext.request.contextPath }/images/noimage.jpg" onclick="selectPic(2,'videoPic');"/></div>
								<div class="list_info">
									<div><input id="title3" name="titles" class="_input"></input ></div>
									<div><textarea id="description3" name="descriptions" class="_textarea"></textarea ></div>
								</div>
								<div class="clear"></div>
							
						</div>
					</li>
					<li>
						<div class="wrap" style="padding:10px 0;">
								<div class="list_litpic fl">
									<img id="video4" onerror="showNoImage(this);" src="${pageContext.request.contextPath }/images/noimage.jpg" onclick="selectPic(3,'videoPic');"/></div>
								<div class="list_info">
									<div><input id="title4" name="titles" class="_input"></input ></div>
									<div><textarea id="description4" name="descriptions" class="_textarea"></textarea ></div>
								</div>
								<div class="clear"></div>
							
						</div>
					</li>
					<li>
						<div class="wrap" style="padding:10px 0;">
								<div class="list_litpic fl">
									<img id="video5" onerror="showNoImage(this);" src="${pageContext.request.contextPath }/images/noimage.jpg" onclick="selectPic(4,'videoPic');"/></div>
								<div class="list_info">
									<div><input id="title5" name="titles" class="_input"></input ></div>
									<div><textarea id="description5" name="descriptions" class="_textarea"></textarea ></div>
								</div>
								<div class="clear"></div>
							
						</div>
					</li>
					<li>
						<div class="wrap" style="padding:10px 0;">
								<div class="list_litpic fl">
									<img id="video6" onerror="showNoImage(this);" src="${pageContext.request.contextPath }/images/noimage.jpg" onclick="selectPic(5,'videoPic');"/></div>
								<div class="list_info">
									<div><input id="title6" name="titles" class="_input"></input ></div>
									<div><textarea id="description6" name="descriptions" class="_textarea"></textarea ></div>
								</div>
								<div class="clear"></div>
						</div>
					</li>
				</ul>
				<div class="list_loading"><i></i><span>努力加载中...</span></div>
			</div>
		</div>
		</form>
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