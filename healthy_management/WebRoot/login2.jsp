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


<body>
   <div class="container">
    	<div class="row">
    		<div class="logo logo-big">
				儿童健康管理系统
			</div>
    	</div>
    	<div class="row">
    		<div class="col-md-6 col-md-offset-3">
	    		<div role="tabpanel">
			        <!-- Nav tabs -->
			        <ul class="nav nav-tabs nav-tabs-login" role="tablist">
			            <li role="presentation" class="active"><a href="#login-prnt" aria-controls="login-prnt" role="tab" data-toggle="tab">家长</a></li>
			            <li role="presentation"><a href="#login-comm" aria-controls="login-comm" role="tab" data-toggle="tab">社区医生</a></li>
			            <li role="presentation"><a href="#login-doc" aria-controls="login-doc" role="tab" data-toggle="tab">幼儿园负责人</a></li>
			        </ul>

			        <!-- Tab panes -->
			        <div class="tab-content">
			            <div role="tabpanel" class="tab-pane active" id="login-prnt">
							<form class="form-horizontal pd-t-10" name="logForm1" action="LoginServlet?type=0" method="post">
								<div class="form-group">
									<label for="inputEmail3" class="col-sm-2 control-label">邮箱</label>
									<div class="col-sm-10">
										<input type="email" name="mail" class="form-control" id="inputEmail1" placeholder="Email" value="child@qq.com"></div>
								</div>
								<div class="form-group">
									<label for="inputPassword3" class="col-sm-2 control-label">密码</label>
									<div class="col-sm-10">
										<input type="password" name="psw" class="form-control" id="inputPassword1" placeholder="Password" value="123456"></div>
								</div>
								<div class="form-group">
									<div class="col-sm-offset-2 col-sm-10">
										<button type="submit" name="submit" class="btn btn-default">登录</button>
										<button type="reset" name="reset" class="btn btn-default">重置</button>
									</div>
								</div>
							</form>
			            </div>
			            <div role="tabpanel" class="tab-pane" id="login-comm">
			            	<form class="form-horizontal pd-t-10" name="logForm2" action="LoginServlet?type=1" method="post">
								<div class="form-group">
									<label for="inputEmail3" class="col-sm-2 control-label">邮箱</label>
									<div class="col-sm-10">
										<input type="email" name="mail" class="form-control" id="inputEmail2" placeholder="Email" value="responser@qq.com"></div>
								</div>
								<div class="form-group">
									<label for="inputPassword3" class="col-sm-2 control-label">密码</label>
									<div class="col-sm-10">
										<input type="password" name="psw" class="form-control" id="inputPassword2" placeholder="Password" value="123456"></div>
								</div>
								<div class="form-group">
									<div class="col-sm-offset-2 col-sm-10">
										<button type="submit" name="submit" class="btn btn-default">登录</button>
										<button type="reset" name="reset" class="btn btn-default">重置</button>
									</div>
								</div>
							</form>
			            </div>
			            <div role="tabpanel" class="tab-pane" id="login-doc">
			            	<form class="form-horizontal pd-t-10" name="logForm3" action="LoginServlet?type=2" method="post">
								<div class="form-group">
									<label for="inputEmail3" class="col-sm-2 control-label">邮箱</label>
									<div class="col-sm-10">
										<input type="email" name="mail" class="form-control" id="inputEmail3" placeholder="Email" value="gardendoc@qq.com"></div>
								</div>
								<div class="form-group">
									<label for="inputPassword3" class="col-sm-2 control-label">密码</label>
									<div class="col-sm-10">
										<input type="password" name="psw"  class="form-control" id="inputPassword3" placeholder="Password" value="123456"></div>
								</div>
								<div class="form-group">
									<div class="col-sm-offset-2 col-sm-10">
										<button type="submit"  name="submit" class="btn btn-default">登录</button>
										<button type="reset" name="reset" class="btn btn-default">重置</button>
									</div>
								</div>
							</form>
			            </div>
			        </div>

			    </div>
		    </div>
    	</div>
    	
    </div>


    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="public/js/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="public/js/bootstrap.min.js"></script>
</body>
</html>
