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
    <div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="">首页</a>
        <a href="">基础管理</a>
        <a>
          <cite>车辆管理</cite></a>
      </span>
      <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
    </div>
    <div class="x-body">
      <div class="layui-row">
        <form class="layui-form layui-col-md12 x-so">
          <input type="text" name="num"     placeholder="车牌号" autocomplete="off" class="layui-input">
          <input type="text" name="enterprise"  placeholder="所属企业" autocomplete="off" class="layui-input">
          <input type="text" name="location"    placeholder="区域" autocomplete="off" class="layui-input">
          
          <button class="layui-btn"  onclick="get_bus()"><i class="layui-icon">&#xe615;</i></button>
        </form>
      </div>
      <xblock>
        <button class="layui-btn" onclick="x_admin_show('添加','./bus_add',600,450)"><i class="layui-icon"></i>添加</button>
        <span id="total" class="x-right" style="line-height:40px"></span>
      </xblock>
      <table class="layui-table" id="bus">
      </table>
      <div id="page"></div>
    </div>
    <script>
    
       /*页面总数*/
       var totalpage=0;
       
       /*自动加载*/
	   $(function() {
	     get_bus(1);
	   });
	  
	   
	   
	  /*获取车企接口数据*/
      function get_bus(current_page){
    	var pagestart=(current_page-1)*10;//第几条开始
    	
    	//检索条件
	    var num    =$("#num").val();
	    var enterprise =$("#enterprise").val();
	    var location   =$("#location").val();
    		
    	var url = "${pageContext.request.contextPath }/show";
      	$.ajax({
      		type : "GET",
      		url : url,
      		dataType : "json",
      		data:{
      			urltype:"bus",
      			pagestart:pagestart,
      			num:num,
      			enterprise:enterprise,
      			location:location,
        	},
      		success : function(data) {
      			var result = eval('(' + data + ')');
      			var busJson = eval(result.data);
      			//总页数
      			totalpage=result.total;
      			
      			/*layu加载分页模块*/
	      	    layui.use([ 'jquery', 'layer','table', 'element','laypage' ], function() {
	      	         var laydate = layui.laydate //日期操作
	      	         ,table=layui.table          //table操作
	      	         ,element = layui.element    //元素操作
	      	         ,laypage = layui.laypage    //加载分页
	      	         //执行一个laypage实例
	      	         laypage.render({
	      	           elem: 'page' //注意，这里的 test1 是 ID，不用加 # 号
	      	          ,count: totalpage //数据总数，从服务端得到
	      	          ,jump: function(obj, first){
	      	        	    //obj包含了当前分页的所有参数，比如：
	      	        	    console.log(obj.curr); //得到当前页，以便向服务端请求对应页的数据。
	      	        	    console.log(obj.limit); //得到每页显示的条数
	      	        	    //首次不执行
	      	        	    if(!first){
	      	        	      //do something
	      	        	      get_bus(obj.curr);
	      	        	    }
	      	            }
	      	         });
	      	    });
      			
      			//显示总条数
      			$("#total").text("总共数据："+result.count+" 条");
      			//获取list,填充table
      			var insertText="<thead><tr><th>ID</th><th>所属企业</th><th>车牌号</th><th>线路起点</th><th>线路终点</th><th>区域</th><th>备注</th><th>操作</th></tr></thead><tbody>";
      			for(var i=0;i<busJson.length;i++){  
    				insertText+="<tr><td>"+busJson[i].id+"</td>";
    				insertText+="<td>"+busJson[i].enterpriseId+"</td>";
    				insertText+="<td>"+busJson[i].busNum+"</td>";
    				insertText+="<td>"+busJson[i].routeBegin+"</td>";
    				insertText+="<td>"+busJson[i].routeEnd+"</td>";
    				insertText+="<td>"+busJson[i].busLocation+"</td>";
    				insertText+="<td>"+busJson[i].remark+"</td>";
    				insertText+="<td class='td-manage'>";
    				insertText+="<button class='layui-btn  layui-btn-xs' onclick='edit("+busJson[i].id+")'><i class='layui-icon'>&#xe642;</i></button>";
    				insertText+="<button class='layui-btn  layui-btn-xs layui-btn-danger' onclick='del(this,"+busJson[i].id+")'><i class='layui-icon'>&#xe640;</i></button>";
    				insertText+="</td></tr>";
    			}
    			insertText+="</tbody>";
    			document.getElementById("bus").innerHTML = insertText;
      		}
      	});
      }
	  
	  /*打开编辑页面*/
      function edit(id){
		var datajson="";
        var url = "${pageContext.request.contextPath }/selectone";
   	    $.ajax({
       		type : "GET",
       		url : url,
       		data:{
    			id:id,
    			urltype:"bus",
        	},
       		dataType : "json",
       		success : function(data) {
       			var result = eval('(' + data + ')');
       			if(result.code=="0000"){
       				 datajson=JSON.stringify(result);
	       			 layer.open({
	       	  	        type: 2,
	       	  	        area: ['600px', '450px'],
	       	  	        fix: false, //不固定
	       	  	        maxmin: true,
	       	  	        shadeClose: true,
	       	  	        shade:0.4,
	       	  	        title: "编辑",
	       	  	        content: ["${pageContext.request.contextPath}/bus_edit?args="+encodeURIComponent(datajson),"no"]
	       	  	    });
       			}
       		}
   	    });
  	   
     }
	  
     /*删除*/
     function del(obj,id){
       layer.confirm('确认要删除吗？',function(index){
       	   var url = "${pageContext.request.contextPath }/delete";
    	   $.ajax({
        		type : "POST",
        		url : url,
        		data:{
        			id:id,
        			urltype:"bus",
            	},
        		dataType : "json",
        		success : function(data) {
        			var result = eval('(' + data + ')');
					if(result.code=="0000"){
						$(obj).parents("tr").remove();
				        layer.msg('已删除!',{icon:1,time:1000});
   		            	window.location.reload(); //刷新父页面
        			}
        		}
    	   });
       });
     }
    </script>
  </body>

</html>