<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="rxy.javabean.AnnInfo" %>
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
  <div class="">
   			<table class="table table-bordered" style="margin-bottom: 0px;">
				<thead>
							<tr>
								<th width="12%">发布者</th>
								<th width="55%">内容</th>
								<th>发布时间</th>
								<th width="12%">操作</th>
							</tr>					
						</thead>
				<tbody>
					<%
						List<AnnInfo> list = (List<AnnInfo>)request.getAttribute("list");
						for(AnnInfo a : list){
					%>
						<tr>
							<td><%=a.getDoctorName()%></td>
							
							<td><%=a.getMemo()%></td>
							<td><%=a.getTime()%></td>
							<td class="ann-operation">
									<script>
										function del_confirm(){
											if (!confirm("确认要删除？")) {
            									window.event.returnValue = false;
        									}
										}
									</script>
									<a href="garden/ann_edit.jsp?AnnID=<%=a.getAnnID() %>" target="_blank"><i class="glyphicon glyphicon-edit"></i></a>
									<a href="<%=request.getContextPath() %>/AnnRemoveServlet?AnnID=<%=a.getAnnID() %>" onClick="del_confirm()"><i class="glyphicon glyphicon-remove"></i></a>
							</td>
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
			</nav></div>
  </body>
</html>
