<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="rxy.javabean.Diagnosis" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	if(session.getAttribute("user") == null)
	{
		response.sendRedirect("login.jsp");
	}	
%>

<%
	
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <base href="<%=basePath%>">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>Bootstrap 101 Template</title>

    <!-- Bootstrap -->
    <link href="public/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="public/css/admin.css">
	<link rel="stylesheet" href="public/css/calendar.css"/>
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="public/js/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="public/js/bootstrap.min.js"></script>
</head>

  
  <body style="background: transparent">
   			<table class="table table-striped" style="margin-bottom: 0px;">
				<thead align="center">
					<th><b>负责医生</b></th>
					<th><b>就诊时间</b></th>
					<th><b>诊断结果</b></th>
					
				</thead>
				<tbody>
					<%
						List<Diagnosis> list = (List<Diagnosis>)request.getAttribute("list");
						for(Diagnosis d : list){
					%>
						<tr>
							<td><%=d.getDoctorName()%></td>
							
							<td><%=d.getDiagnosisTime()%></td>
							<td><%=d.getMemo()%></td>
							
						</tr>
					<% 
						} 
					%>
				</tbody>
			</table>
			<nav style="text-align:center">
			<ul class="pagination">
				<%=request.getAttribute("bar")%>
			</ul>
			</nav>
  </body>
</html>
