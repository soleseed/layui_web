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
    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/layui.css">
    <script src="${pageContext.request.contextPath }/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
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
        <a href="">信息查看</a>
        <a>
          <cite>上网用户监控</cite></a>
      </span>
      <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
    </div>
    <div class="x-body">
    
    
      <div class="layui-row" align="center">
	      <div class="layui-form-item">
		    <div class="layui-inline">
    			 <input type="text" name="phone"    id="phone" placeholder="手机号码" autocomplete="off" class="layui-input">
		    </div>
		    <div class="layui-inline">
          		 <input type="text" name="isLocal" id="isLocal"   placeholder="是否本地资源" autocomplete="off" class="layui-input">
		    </div>
		    <div class="layui-inline">
	          <button class="layui-btn layui-btn"  data-type="reload"><i class="layui-icon">&#xe615;</i></button>
		    </div>
		  </div>
      </div>
      <xblock>
        <span id="total" class="x-right" style="line-height:40px"></span>
      </xblock>
      <table class="layui-table" id="passenger" lay-filter="demo">
      </table>
    </div>
    <script type="text/html" id="isLocalTpl">
    {{#  if(d.isLocal == 1){ }}
     	网上
    {{#  } else { }}
                          本地
    {{#  } }}	
	</script>
	<script type="text/html" id="indexTpl">
       {{d.LAY_TABLE_INDEX+1}}
	</script>
    <script>
  
	 layui.use('table', function(){ 
		   
         //table加载
       	 var table = layui.table;
			 table.render({
       	      elem: '#passenger'
       	     ,url: '${pageContext.request.contextPath }/show'
       	     ,where: {urltype:"passengerlog"} //如果无需传递额外参数，可不加该参数
             ,page:{prev:['上一页'],next:['下一页'],layout: ['prev', 'page', 'next']}
       	     ,cols: [[
               {field: '',width:'10%', title: '序号', sort: true,align:'center',templet: '#indexTpl'}
       	      ,{field:'phone', width:'15%', sort: true,title: '手机号码'}
       	      ,{field:'flew', width:'15%', sort: true,title: '使用流量(M)'}
       	      ,{field:'url', width:'15%', title: '访问数据',sort: true}
       	      ,{field:'urlTime', width:'15%', sort: true,title: '访问时间',templet: '<div>{{ getDate(d.urlTime) }}</div>'}
       	      ,{field:'isLocal', width:'15%', sort: true,title: '是否本地资源',templet: '#isLocalTpl' }
       	      ,{field:'updateTime', width:'15%', sort: true,title: '记录时间',templet: '<div>{{ getDate(d.updateTime) }}</div>'}
       	     ]]
       	     ,id: 'reload'
   	    	 ,done: function(res, curr, count){
		      			$("#total").text("总共数据："+res.count+" 条");
 	    	        }
       	     
    		 });
			 
			 //监听工具条事件
			 table.on('tool(demo)', function(obj){
			     var data = obj.data;
			     if(obj.event === 'edit'){
			        //编辑
			    	edit(data.id);
			     }else if(obj.event === 'del'){
			    	//删除
			    	del(obj,data.id);
			     } 
			 });
			 
			 //table重载
			 var $ = layui.$, active = {
		        reload: function(){
		        	
		          var phone    =$("#phone").val();
		     	  var isLocal =$("#isLocal").val();
		         		
			  	  
			      //执行重载
			      table.reload('reload', {
			        page: {
			          curr: 1 //重新从第 1 页开始
			        }
			        ,where: {
			        	urltype:"passengerlog",
		      			phone:phone,
		      			isLocal:isLocal,
			        }
			      });
		      }
		 }
		 //监听按钮点击
		 $('.layui-row .layui-btn').on('click', function(){
		    var type = $(this).data('type');
		    active[type] ? active[type].call(this) : '';
		 }); 
     });
	 
	 //时间格式转换
	 function getDate(tm){ 
  	      var tt=new Date(tm).toLocaleString().replace(/\//g, "-"); 
  	      return tt; 
     }

    </script>
  </body>

</html>


























