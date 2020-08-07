<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ page import="rxy.data.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <base href="<%=basePath%>">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title><%=SiteInformation.get_site_name() %></title>

    <!-- Bootstrap -->
    <link href="public/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="public/css/login.css">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>


<body class="login-bg">
   	<div id="login_box">
   		<div id="login_form">
   			<form class="form-horizontal" action="LoginServlet" method="post">
   				<div class="row">
   					<div class="col-md-8">
   						<div class="form-group">
		   					<label for="input-email" class="col-md-4 control-label">邮箱：</label>
						    <div class="col-md-8">
						      <input type="email" name="mail" class="form-control" id="input-email" placeholder="">
						    </div>
		   				</div>
		   				<div class="form-group">
		   					<label for="input-pwd" class="col-md-4 control-label">密码：</label>
						    <div class="col-md-8">
						      <input type="password" name="psw" class="form-control" id="input-pwd" placeholder="">
						    </div>
		   				</div>
		   				<div class="form-group">
		   					<label for="input-pwd" class="col-md-4 control-label">角色：</label>
						    <div class="col-md-8">
						      	<div class="radio radio-inline">
  									<label>
    									<input type="radio" name="type" id="optionsRadios1" value="0" checked>
    									家长
  									</label>
								</div>
								<div class="radio radio-inline">
  									<label>
    									<input type="radio" name="type" id="optionsRadios1" value="1">
    									社区医生
  									</label>
								</div>
								<div class="radio radio-inline">
  									<label>
    									<input type="radio" name="type" id="optionsRadios1" value="2">
    									老师
  									</label>
								</div>
						    </div>
		   				</div>
		   				
   					</div>
   					<div class="col-md-4">
   						<button type="submit" class="btn btn-default btn-lg btn-login">登 录</button>
   					</div>
   				</div>
   			</form>
   			
   			<div id="logo">
   				<h2>Children Health-Care System</h2>
   			</div>
   			
   			<div id="login-child">
   			
   			</div>
   		</div>
   	</div>
<%if(session.getAttribute("error") != null){ %>
		   					<script>alert("<%=session.getAttribute("error").toString() %>");</script>
		   					<%session.removeAttribute("error"); %>
		   				<%} %>
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="public/js/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="public/js/bootstrap.min.js"></script>
</body>
</html>
