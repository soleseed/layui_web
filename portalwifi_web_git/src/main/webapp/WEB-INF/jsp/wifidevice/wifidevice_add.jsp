<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>车企管理-无线设备管理系统</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/font.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/css/xadmin.css">
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath }/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/xadmin.js"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
      <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
      <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  
  <body>
    <div class="x-body">
        <form class="layui-form">
          <div class="layui-form-item">
              <label  class="layui-form-label">
                  <span class="x-red">*</span>所在车辆
              </label>
              <div class="layui-input-inline" id='selectbus'></div>
		      <div class="layui-form-mid layui-word-aux">
                                                            如果选择不到，请先添加车辆
              </div>
          </div>
          <div class="layui-form-item">
              <label  class="layui-form-label">
                  <span class="x-red">*</span>设备MAC
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="mac" name="mac"   lay-verify="required"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
           <div class="layui-form-item">
              <label  class="layui-form-label">
                  <span class="x-red">*</span>公网IP地址
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="wanIp" name="wanIp"   lay-verify="required"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
           <div class="layui-form-item">
              <label  class="layui-form-label">
                  <span class="x-red">*</span>WIFI名称
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="ssid" name="ssid"   lay-verify="required"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
           <div class="layui-form-item">
              <label  class="layui-form-label">
                  <span class="x-red">*</span>在线状态
              </label>
              <div class="layui-input-inline" id='selectonlineStatus'>
               <select name="onlineStatus" id="onlineStatus" lay-verify="required" lay-search="">
		          <option value="">选择在线状态</option>
		          <option value="0">未知</option>
		          <option value="1">在线</option>
		          <option value="2">不在线</option>
		        </select>
              </div>
          </div>
           <div class="layui-form-item">
              <label  class="layui-form-label">
                  <span class="x-red">*</span>本月总流量
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="totalFlew" name="totalFlew"   lay-verify="required"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
           <div class="layui-form-item">
              <label  class="layui-form-label">
                  <span class="x-red">*</span>本月剩余流量
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="remainFlew" name="remainFlew"   lay-verify="required"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          
          <div class="layui-form-item">
              <label  class="layui-form-label">
                  <span class="x-red">*</span>portal版本
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="portalVersion" name="portalVersion"  lay-verify="required"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label  class="layui-form-label">
                  <span class="x-red">*</span>固件版本
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="firmWareVersion" name="firmWareVersion"  lay-verify="required"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label class="layui-form-label">
              </label>
              <button  class="layui-btn" lay-filter="add" lay-submit="">
                  增加
              </button>
          </div>
      </form>
    </div>
    <script>
        layui.use(['form','layer'], function(){
          $ = layui.jquery;
          var form = layui.form
         ,layer = layui.layer;
        
          
        //加载select
          var selecturl = "${pageContext.request.contextPath }/showSelect";
      	  $.ajax({
      		type : "POST",
      		url : selecturl,
      		dataType : "json",
      		data:{
      			urltype:"bus",
        	},
      		success : function(data) {
      			var result = eval('(' + data + ')');
      			var busJson = eval(result.data);
      			var insertText="<select name='busId' lay-verify='required' id='busId'  lay-search=''>";
				    insertText+="<option value=''>直接选择或搜索选择</option>";
      			 
      			for(var i=0;i<busJson.length;i++){  
    				insertText+="<option value='"+busJson[i].id+"'>"+busJson[i].busNum+"</option>";
    			}
    			insertText+="</select>";
    			document.getElementById("selectbus").innerHTML = insertText;
    			//layui重新select进行渲染
    			form.render("select");
      		 }
      	  });
      	  
          //监听提交
          form.on('submit(add)', function(data){
        	  console.log(data.field);
        	  var busId    =data.field.busId;
        	  var mac =data.field.mac;
        	  var wanIp     =data.field.wanIp;
        	  var ssid   =data.field.ssid;
        	  var onlineStatus    =data.field.onlineStatus;
        	  var totalFlew =data.field.totalFlew;
        	  var remainFlew    =data.field.remainFlew;
        	  var portalVersion   =data.field.portalVersion;
        	  var firmWareVersion    =data.field.firmWareVersion;
        	 
	       	  $.ajax({
	       		type : "POST",
		   	    url : "${pageContext.request.contextPath }/add", 
		   	    data:{
		   	    	urltype:"device",
		   	    	busId :busId,
	        	    mac :mac,
	        	    wanIp :wanIp,
	        	    ssid  :ssid,
	        	    onlineStatus :onlineStatus,
	        	    totalFlew :totalFlew,
	        	    remainFlew :remainFlew,
	        	    portalVersion :portalVersion,
	        	    firmWareVersion :firmWareVersion,
	        	 
	         	},
	   	        dataType:"json",      
	   			success:function(data){
	   				var result = eval('(' + data + ')');
	   				if(result.code=="0000"){
	   		            layer.alert("增加成功", {icon: 6},function () {
	   		            	window.parent.location.reload(); //刷新父页面
	   		                // 获得frame索引
	   		                var index = parent.layer.getFrameIndex(window.name);
	   		                //关闭当前frame
	   		                parent.layer.close(index);
	   		            });
	   				}
	   			}
	   	      })    
              return false;
          });
          
          
        });
    </script>
  </body>
</html>