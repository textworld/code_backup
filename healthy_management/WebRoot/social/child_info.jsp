<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="rxy.javabean.Information" %>
<%@ page import="rxy.data.GetInformation" %>
<%@ page import="rxy.javabean.*" %>
<%@ page import="rxy.data.TempData" %>
<% int child_id;
	if( request.getParameter("child_id") == null){
		response.getWriter().println("no child_id");
		return;
	}else{
		child_id = Integer.parseInt(request.getParameter("child_id"));
	} 
%>
<% Information info = GetInformation.findOne(child_id); %>
<% 
	if(info == null){
		response.getWriter().println("no child");
		return;
	}
%>
<%@ include file="/social/header.jsp" %>
<div class="container">
	<div class="row">
		<div class="panel panel-primary">
			<div class="panel-heading"> <i class="glyphicon glyphicon-menu-hamburger"></i>
				基本信息
				<div class="pull-right">
                   	<a href="<%=request.getContextPath() %>/social/check.jsp?child_id=<%=child_id %>" class="btn btn-default btn-xs">诊断</a>
                   	<a href="<%=request.getContextPath() %>/social/diagnosis.jsp?child_id=<%=child_id %>" class="btn btn-default btn-xs">以往的诊断</a>
                </div>
			</div>
			<div class="panel-body">
				<div class="row">
					<div class="col-md-3">
						<div class="child-list-img" style="text-align: center;">
							<%if(info.getGender().equals("男")){ %>
								<img src="./public/imgs/boy.jpg" width="120" height="200" class="img-thumbnail"/>
							<%}else{ %>
								<img src="./public/imgs/girl.jpg" width="120" height="200" class="img-thumbnail"/>
							<%} %>
						</div>
					</div>
					<div class="col-md-9">
						<table class="table table-bordered">
							<tr>
								<td>
									姓名：
									<a href="<%= request.getContextPath()%>/social/child_info.jsp?child_id=<%=child_id %>"><%=info.getChildName() %></a>
								</td>
								<td>性别：<%=info.getGender() %></td>
								<td>年龄：3</td>
							</tr>
							<tr>
								<td colspan="2">家庭住址：<%=info.getHomeAddress() %></td>
								<td>联系电话：<%=info.getPhone() %></td>
							</tr>
						</table>
						
						<table class="table table-bordered">
							<tr>
								<td>
									父亲姓名：
									<%=info.getFatherName() %>
								</td>
								<td>父亲电话：<%=info.getFatherPhone() %></td>
								<td>父亲工作：<%=info.getFatherJob() %></td>
							</tr>
							<tr>
								<td>
									母亲姓名：<%=info.getMatherName() %>
								</td>
								<td>母亲电话：<%=info.getMatherPhone() %></td>
								<td>母亲工作：<%=info.getMatherJob() %></td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
		<!-- the end of panel -->

		<div class="panel panel-primary">
			<div class="panel-heading"> <i class="glyphicon glyphicon-menu-hamburger"></i>
				昨日体温
				<div class="pull-right">
					<!-- Single button -->		
					<div class="btn-group">
						<button type="button" class="btn btn-default dropdown-toggle btn-xs" data-toggle="dropdown" aria-expanded="false">
							查看以往数据
							<span class="caret"></span>
						</button>
						<ul class="dropdown-menu" role="menu">
							<li>
								<a href="#" id="temp-day-yesterday">昨天</a>
							</li>
							<li>
								<a href="#" id="temp-day-2">前天</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<div class="panel-body">
				<div id="temp-chart">
					<p>正在加载中</p>
				</div>

			</div>
		</div>
		<!-- panel end -->		

		<div class="panel panel-primary">
			<div class="panel-heading"> <i class="glyphicon glyphicon-menu-hamburger"></i>
				昨日心跳
				<div class="pull-right">
					<!-- Single button -->		
					<div class="btn-group">
						<button type="button" class="btn btn-default dropdown-toggle btn-xs" data-toggle="dropdown" aria-expanded="false">
							查看以往数据
							<span class="caret"></span>
						</button>
						<ul class="dropdown-menu" role="menu">
							<li>
								<a href="#" id="heart-day-yesterday">昨天</a>
							</li>
							<li>
								<a href="#" id="heart-day-2">前天</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<div class="panel-body">
				<div id="heart-chart">
					<p>正在加载中</p>
				</div>

			</div>
		</div>
		<!-- panel end -->		

		<div class="panel panel-primary">
			<div class="panel-heading">
				<i class="glyphicon glyphicon-menu-hamburger"></i>
				一周睡眠时间
				<div class="pull-right">
					<!-- Single button -->		
					<div class="btn-group">
						<button type="button" class="btn btn-default dropdown-toggle btn-xs" data-toggle="dropdown" aria-expanded="false">
							查看以往数据
							<span class="caret"></span>
						</button>
						<ul class="dropdown-menu" role="menu">
							<li>
								<a href="#" id="sleep-day-yesterday">昨天</a>
							</li>
							<li>
								<a href="#" id="sleep-day-2">前天</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<div class="panel-body">
				<div id="sleep-chart">
					<p>正在加载中</p>
				</div>

			</div>
		</div>

	</div>

</div>
<script src="public/component/morrisjs/morris.js"></script>
    <script src="public/component/raphael/raphael-min.js"></script>


	<script src="public/js/chartData.js"></script>
	<script>
		var temp_chart = new Chart("temp-chart", {"child_id": <%=child_id%>, "type" : 1});
		temp_chart.init();
		$('#temp-day-2').click(function(e){
			e.preventDefault()
			temp_chart.getDataIndex(-2);
			return false;
		});
		$('#temp-day-yesterday').click(function(e){
			e.preventDefault();
			temp_chart.getDataIndex(-1);
			return false;
		});
		var heart_chart = new Chart("heart-chart", {"child_id": <%=child_id%>, "type" : 2});
		heart_chart.init();
		$('#heart-day-2').click(function(e){
			e.preventDefault()
			heart_chart.getDataIndex(-2);
			return false;
		});
		$('#heart-day-yesterday').click(function(e){
			e.preventDefault();
			heart_chart.getDataIndex(-1);
			return false;
		});
		var sleep_chart = new Chart("sleep-chart", {"child_id": <%=child_id%>, "type": 3, "week": 1});
		sleep_chart.init();
		$('#sleep-day-2').click(function(e){
			e.preventDefault()
			sleep_chart.getDataIndex(-7);
			return false;
		});
		$('#sleep-day-yesterday').click(function(e){
			e.preventDefault();
			sleep_chart.getDataIndex(-1);
			return false;
		});
	</script>
	<% if(session.getAttribute("success") != null ){ %>
	<script>
		$(window).ready(function(){
			alert("<%= session.getAttribute("success").toString()%>");
		});
		
	</script>
	<%session.removeAttribute("success"); %>
<% } %>
<%@ include file="/include/footer.jsp" %>