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
                  <span class="x-red">*</span>所属企业
              </label>
              <div class="layui-input-inline" id='selectenterprise'></div>
		      <div class="layui-form-mid layui-word-aux">
                                                            如果选择不到，请先添加车企
              </div>
          </div>
          <div class="layui-form-item">
              <label  class="layui-form-label">
                  <span class="x-red">*</span>用户名
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="name" name="name"  value="${name}" lay-verify="required"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label  class="layui-form-label">
                  <span class="x-red">*</span>密码
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="pwd" name="pwd" value="${pwd}" lay-verify="required"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label  class="layui-form-label">
                  <span class="x-red">*</span>用户类型
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="type" name="type" value="${type}" lay-verify="required"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label  class="layui-form-label">
                  <span class="x-red">*</span>真实姓名
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="realName" name="realName" value="${realName}" lay-verify="required"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
           <div class="layui-form-item">
              <label  class="layui-form-label">
                  <span class="x-red">*</span>性别
              </label>
              <div class="layui-input-inline">
		      <input type="radio" name="sex" id="sex" value="1" title="男" checked="">
		      <input type="radio" name="sex" id="sex" value="2" title="女">
		     </div>
          </div>
          <div class="layui-form-item">
              <label  class="layui-form-label">
                  <span class="x-red">*</span>电话号码
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="telephone" name="telephone" value="${telephone}" lay-verify="required"
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
        
        //加载select
          var selecturl = "${pageContext.request.contextPath }/showSelect";
      	  $.ajax({
      		type : "POST",
      		url : selecturl,
      		dataType : "json",
      		data:{
      			urltype:"enterprise",
        	},
      		success : function(data) {
      			var result = eval('(' + data + ')');
      			var enterpriseJson = eval(result.data);
      			var insertText="<select name='enterprise' lay-verify='required' id='enterprise'  lay-search=''>";
				    insertText+="<option value=''>直接选择或搜索选择</option>";
      			 
      			for(var i=0;i<enterpriseJson.length;i++){  
    				insertText+="<option value='"+enterpriseJson[i].id+"'>"+enterpriseJson[i].enterpriseName+"</option>";
    			}
    			insertText+="</select>";
    			document.getElementById("selectenterprise").innerHTML = insertText;
    			
    			$("#enterprise").val('${enterprise}'); 
     			$("input[name='sex'][value='${sex}']").prop("checked",true) ;
     			
     			//layui重新radio进行渲染
     			form.render("radio");
    			//layui重新select进行渲染
    			form.render("select");
      		 }
      	  });
          
          //监听提交
          form.on('submit(add)', function(data){
        	  console.log(data.field);
        	  var enterprise    =data.field.enterprise;
        	  var name =data.field.name;
        	  var pwd     =data.field.pwd;
        	  var type   =data.field.type;
        	  var realName  =data.field.realName;
        	  var sex  =data.field.sex;
        	  var telephone  =data.field.telephone;
        	  var remark  =data.field.remark;
	       	  $.ajax({
	   		    type : "POST",
	   		    url : "${pageContext.request.contextPath }/update",  
	   	        data:{
		   	    	urltype:"user",
		   	    	id:id,
		   	    	enterprise:enterprise,
		   	    	name:name,
		   	    	pwd:pwd,
		   	    	type:type,
		   	    	telephone:telephone,
		   	    	realName:realName,
		   	    	sex:sex,
		   	    	remark:remark,
	         	},
	   	        dataType:"json",      
	   			success:function(data){
	   				var result = eval('(' + data + ')');
	   				if(result.code=="0000"){
	   		            layer.alert("修改成功", {icon: 6},function () {
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