<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html xmlns="http://www.w3.org/1999/xhtml" class="loading">
<head>
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta name="viewport" content="width=device-width, initial-scale=0.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
<meta name="keywords" content="" />
<meta name="author" content="" />
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta content="telephone=no" name="format-detection">
<link rel="apple-touch-icon-precomposed" href="images/favicon.ico"/>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
<style>

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

.ads{
	height: auto;
	top: 50%;
	right: 100px;
	/* margin-top: 15px; */
	text-align: center;
	z-index:99;

}

/* reset */
html,body,div,span,applet,object,iframe,h1,h2,h3,h4,h5,h6,p,blockquote,pre,a,abbr,acronym,address,big,cite,code,del,dfn,em,img,ins,kbd,q,s,samp,small,strike,strong,sub,sup,tt,var,b,u,i,dl,dt,dd,ol,nav ul,nav li,fieldset,form,label,legend,table,caption,tbody,tfoot,thead,tr,th,td,article,aside,canvas,details,embed,figure,figcaption,footer,header,hgroup,menu,nav,output,ruby,section,summary,time,mark,audio,video{margin:0;padding:0;border:0;font-size:100%;font:inherit;vertical-align:baseline;}
article, aside, details, figcaption, figure,footer, header, hgroup, menu, nav, section {display: block;}
ol,ul{list-style:none;margin:0px;padding:0px;}
blockquote,q{quotes:none;}
blockquote:before,blockquote:after,q:before,q:after{content:'';content:none;}
table{border-collapse:collapse;border-spacing:0;}
/* start editing from here */
a{text-decoration:none;}
.txt-rt{text-align:right;}/* text align right */
.txt-lt{text-align:left;}/* text align left */
.txt-center{text-align:center;}/* text align center */
.float-rt{float:right;}/* float right */
.float-lt{float:left;}/* float left */
.clear{clear:both;}/* clear float */
.pos-relative{position:relative;}/* Position Relative */
.pos-absolute{position:absolute;}/* Position Absolute */
.vertical-base{	vertical-align:baseline;}/* vertical align baseline */
.vertical-top{	vertical-align:top;}/* vertical align top */
nav.vertical ul li{	display:block;}/* vertical menu */
nav.horizontal ul li{	display: inline-block;}/* horizontal menu */
img{max-width:100%;}
/*end reset*/
/****-----start-body----****/
body{
	background: url(${pageContext.request.contextPath }/images/bg1.jpg) no-repeat 0px 0px;
	font-family: 'Open Sans', sans-serif;
	background-size:cover;
	-webkit-background-size:cover;
	-moz-background-size:cover;
	-o-background-size:cover;
	min-height:1050px;
}
.wrap{
	margin: 0 auto;
	width: 80%;
}
body a,form li,input[type="submit"],input[type="text"],.sixth-login input[type="submit"],.third-login input[type="submit"]{
	transition: 0.1s all;
	-webkit-transition: 0.1s all;
	-moz-transition: 0.1s all;
	-o-transition: 0.1s all;
}
h1 {
	  font-family: 'Exo 2', sans-serif;
	  text-align: center;
	  padding-top: 1em;
	  font-weight: 400;
	  color: #ff9800e3;
	  font-size: 2em;
}
.login-form {
	background: #2b2b36;
	position: relative;
	width: 30%;
	margin: 3% auto 0 auto;
	text-align: center;
	border-radius: 15px;
	-webkit-border-radius: 15px;
	-moz-border-radius: 15px;
	-o-border-radius: 15px;
}
.head img {
	width: 100%;
}
.avtar img {
  margin: 2em 0 0;
}
.head-info {
  padding: 5px 0;
  text-align: center;
  font-weight: 600;
  font-size: 2em;
  color: #fff;
  background: #23232e;
  height: 50px;
	border-top-left-radius: 10px;
	-webkit-border-top-left-radius: 10px;
	-moz-border-top-left-radius: 10px;
	-o-border-top-left-radius: 10px;
	border-top-right-radius: 10px;
	-webkit-border-top-right-radius: 10px;
	-moz-border-top-right-radius: 10px;
	-o-border-top-right-radius: 10p
}
input[type="text"] {
	  width: 70%;
	  padding: 1em 2em 1em 3em;
	  color: #9199aa;
	  font-size: 18px;
	  outline: none;
	  background: url(../images/adm.png) no-repeat 10px 15px;
	  border: none;
	  font-weight: 100;
	  border-bottom: 1px solid#484856;
	  /* margin-top: 2em; */
}
input[type="submit"]{
  font-size: 30px;
  color: #fff;
  outline: none;
  border: none;
  background: #3ea751;
  width: 100%;
  padding: 18px 0;
  border-bottom-left-radius: 15px;
	-webkit-border-bottom-left-radius: 15px;
	-moz-border-bottom-left-radius: 15px;
	-o-border-bottom-left-radius: 15px;
	border-bottom-right-radius: 15px;
	-webkit-border-bottom-right-radius: 15px;
	-moz-border-bottom-right-radius: 15px;
	-o-border-bottom-right-radius: 15px;
	cursor: pointer;
}
input[type="submit"]:hover {
	background: #ff2775;
  border-bottom-left-radius: 15px;
	-webkit-border-bottom-left-radius: 15px;
	-moz-border-bottom-left-radius: 15px;
	-o-border-bottom-left-radius: 15px;
	border-bottom-right-radius: 15px;
	-webkit-border-bottom-right-radius: 15px;
	-moz-border-bottom-right-radius: 15px;
	-o-border-bottom-right-radius: 15px;
  	transition: 1s all;
	-webkit-transition: 1s all;
	-moz-transition: 1s all;
	-o-transition: 1s all;
}
label.lbl-1 {
  background: #6756ea;
  width: 20px;
  height: 20px;
  display: block;
  float: right;
  border-radius: 50%;
  margin: 16px 10px 0px 0px;
}
label.lbl-2 {
  background: #ea569a;
  width: 20px;
  height: 20px;
  display: block;
  float: right;
  border-radius: 50%;
   margin: 16px 10px 0px 0px;
}
label.lbl-3 {
  background: #f1c85f;
  width: 20px;
  height: 20px;
  display: block;
  float: right;
  border-radius: 50%;
  margin: 16px 10px 0px 0px;
}
/*--start-responsive-design--*/
@media (max-width:1440px){
	.key {
	  background: url(../images/pass.png) no-repeat 376px 17px;
	}
	
	body {
	  min-height: 811px;
	}
}
@media (max-width:1366px){
	.key {
	  background: url(../images/pass.png) no-repeat 358px 19px;
	}
	body {
	  min-height: 768px;
	}
}
@media (max-width:1280px){
	.key {
	   background: url(../images/pass.png) no-repeat 336px 18px;
	}
	body {
	  min-height: 711px;
	}
}
@media (max-width:1024px){
	.login-form {
	  width: 37%;
	}
	h1 {
	  padding-top: 1em;
	}
	body {
	  min-height: 675px;
	}
}
@media (max-width:768px){
	.login-form {
	  width: 50%;
	    margin: 12% auto 0 auto;
	}
	.key {
	  background: url(../images/pass.png) no-repeat 342px 18px;
	}
	body {
	  min-height: 929px;
	}
}
@media (max-width:640px){
	.login-form {
	  width: 60%;
	  margin: 20% auto 0 auto;
	}
	.key {
	  background: url(../images/pass.png) no-repeat 342px 19px;
	}
}
@media (max-width:480px){
	.login-form {
	  width: 80%;
	}
}
@media (max-width:320px){
	h1 {
	  padding-top: 1em;
	  font-size: 1.5em;
	}
	.login-form {
	  width: 90%;
	  margin: 10% auto 0 auto;
	}
	input[type="text"] {
	  width: 62%;
	  padding: 1.2em 2em .5em 2.5em;
	  font-size: 17px;
	  margin-top: .5em;
	}
	.head-info {
	  height: 35px;
	  }
	label.lbl-1 {
	  margin: 8px 10px 0px 0px;
	}
	label.lbl-2 {
	  margin: 8px 10px 0px 0px;
	}
	label.lbl-3 {
	  margin: 8px 10px 0px 0px;
	}
	body {
	    min-height: 504px;
	}
	input[type="submit"] {
	  font-size: 28px;
	  padding: 10px 0;
	}
}
/*--end-responsive-design--*/

.validateCode{
	border-width:0;
	outline:0;
	-webkit-appearance:none;
	background-color:#04be02;
	margin-left:auto;
	margin-right:auto;
	margin-bottom:5px;
	text-decoration:none;
	border-radius:10px;
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
	<div id="container">
		<div id="_menu">
			<ul>
				<li><a href="javascript:void(0);">#</a></li>
				<li><a href="javascript:void(0)" onclick="submit();">保存主题</a></li>
				<li><a href="javascript:void(0)" onclick="publish();">发布主题</a></li>
				<li><a href="javascript:void(0);">#</a></li>
			</ul>
		</div>
		<form action="${pageContext.request.contextPath }/theme/updatePortal" method="post" enctype="multipart/form-data">
			<input type="hidden" id="themeId" name="id" value="${theme.id}"/>
	    	<input type="hidden" name="routeBegin" value="${theme.routeBegin}"/>
    		<input type="hidden" name="routeEnd" value="${theme.routeEnd}"/>
			<input class="fileInput" accept="image/*" type="file" name="portalPic" id="portalPicFile" onchange="preImg(this.id,'portalAds1');" /> 
		<div id="content">	
			<div class="ads">
				<img id="portalAds1" name="portalAds" onerror="showNoImage(this);" src="${pageContext.request.contextPath }/upload/image/noimage.jpg" onclick="selectPic(0,'portalPic');"/>
			</div>
		 	<h1>欢迎使用wifi服务</h1>
			<div class="login-form">
					<div class="head-info">
						<label class="lbl-1"> </label>
						<label class="lbl-2"> </label>
						<label class="lbl-3"> </label>
					</div>
						<div class="clear"> </div>
						<input type="text" class="text" value="请输入手机号" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = '请输入手机号';}" >
						<input type="text" width="50%" value="请输入验证码" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = '请输入验证码';}">
						<input class="validateCode" value="获取验证码" type="button"> </input>
				<div class="signin">
					<input type="submit" value="Login" >
				</div>
			</div>
		</div>
		</form>
	</div>
	
</body>
</html>