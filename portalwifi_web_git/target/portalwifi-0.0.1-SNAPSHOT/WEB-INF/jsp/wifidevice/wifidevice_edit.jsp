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
              <div class="layui-input-inline">
                  <input type="text" id="bus" name="bus" value="${bus}" lay-verify="required"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label  class="layui-form-label">
                  <span class="x-red">*</span>序列号
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="deviceid" name="deviceid"  value="${deviceid}" lay-verify="required"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label  class="layui-form-label">
                  <span class="x-red">*</span>版本
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="portal" name="portal" value="${portal}" lay-verify="required"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label  class="layui-form-label">
                  <span class="x-red">*</span>固件版本
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="firmware" name="firmware" value="${firmware}" lay-verify="required"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label  class="layui-form-label">
                                                             备注
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="remark" name="remark" value="${remark}"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <div class="layui-input-inline">
                  <input type="hidden" name="id" id="id" value="${id}"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label class="layui-form-label">
              </label>
              <button  class="layui-btn" lay-filter="add" lay-submit="">
                    修改
              </button>
          </div>
      </form>
    </div>
    <script>
        layui.use(['form','layer'], function(){
          $ = layui.jquery;
          var form = layui.form
         ,layer = layui.layer;
        
          //监听提交
          form.on('submit(add)', function(data){
        	  console.log(data.field);
        	  var bus    =data.field.bus;
        	  var deviceid =data.field.deviceid;
        	  var portal     =data.field.portal;
        	  var firmware   =data.field.firmware;
        	  var remark  =data.field.remark;
	       	  $.ajax({
	       		type : "POST",
	       		url : "${pageContext.request.contextPath }/update", 
	       	 	data:{
		   	    	urltype:"enterprise",
		   	    	id:id,
		   	    	name:name,
		   	    	address:address,
		   	    	tel:tel,
		   	    	owner:owner,
		   	    	remark:remark,
	         	},
	   	        dataType:"json",      
	   			success:function(result){
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