<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="rxy.javabean.*" %>
<%@page import="rxy.data.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	if(session.getAttribute("user") == null)
	{
		response.sendRedirect(path + "/login.jsp");
		return;
	}	
%>


<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <base href="<%=basePath%>">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>儿童医疗健康管理系统</title>

    <!-- Bootstrap -->
    <link href="public/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="public/css/site.css"/>
    <link rel="stylesheet" href="public/css/admin.css">
	<link rel="stylesheet" href="public/css/calendar.css"/>
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    
    <link rel="stylesheet" href="public/component/morrisjs/morris.css" />

    
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="public/js/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="public/js/bootstrap.min.js"></script>
    <script>
    	(function(global){
    		global.changeNavList = function(index){
    			if(global.document.getElementById("nav-list")){
    				$("#nav-list li:nth-child(" + index + ")").addClass("active");
    			}
    		};
    	})(window);
    </script>
</head>


<body>
	<%String su = ""; %>
	<% 
		if(session.getAttribute("user") == null){ %>
	<%}else{ su = session.getAttribute("user").toString();}%>
    <nav class="navbar navbar-default">
        <div class="container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->    
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#">Health Case System</a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->    
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li class="active">
                        <a href="child/index.jsp">
                            首页
                            <span class="sr-only">(current)</span>
                        </a>
                    </li>
                </ul>
                
                <ul class="nav navbar-nav navbar-right">

                    <% List<Consult> c_list = GetReplyConsult.getConsult("ChildID", ((UserBean)session.getAttribute("user")).getId(), Consult.STATUS_NOT_VIEW); %>
                    <li class="dropdown">
                    <% SocialInfo so = GetSocialInfo.findOne(((UserBean)session.getAttribute("user")).getId());%>
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
                     		消息<%if(c_list.size() > 0){ %><span class="badge badge-red"><%=c_list.size() %></span><%} %>
                            <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu" role="menu">
                        	<%if(c_list.size() > 0){ %>
                        		<%for(Consult c : c_list){ %>
                        			<li>
                                		<a href="child/view_consult.jsp?ConsultID=<%=c.getConsultID() %>">赵医生回答了您的提问：<%=c.getContents() %></a>
                            		</li>
                        		<%} %>
                        	<%}else{ %>
                        		<li>
                                	<a href="javascript: void(0);">没有新消息</a>
                            	</li>
                        	<%} %>
                            
                            <li class="divider"></li>
                            <li>
                                <a href="child/consult.jsp">查看所有消息</a>
                            </li>
                        </ul>
                    </li>
                    <li class="dropdown">
                   <% Information in = GetInformation.findOne(((UserBean)session.getAttribute("user")).getId());%>
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
                      <%=in.getChildName()%> 家长 
                            <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu" role="menu">
                            <li>
                                <a href="#">用户中心</a>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <a href="LogoutServlet">退出</a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div><!-- /.navbar-collapse --> 
    </nav><!-- /.container-fluid --> 