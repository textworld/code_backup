<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="rxy.javabean.Information" %>
<%@ page import="rxy.data.GetInformation" %>
<%@ page import="rxy.javabean.*" %>
<%@ page import="rxy.data.TempData" %>
<%@ include file="/social/header.jsp" %>
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
<div class="container">
	<div class="row">
		<div class="col-md-3">
			<%@ include file="/include/calendar.jsp" %></div>
		<div class="col-md-9">
			<div class="panel panel-primary">
				<div class="panel-heading"> <i class="glyphicon glyphicon-menu-hamburger"></i>
					填写诊断
				</div>
				<div class="panel-body">
					<div class="row">
						<div class="col-md-12">
						 	<% SocialInfo so = GetSocialInfo.findOne(((UserBean)session.getAttribute("user")).getId());%>
							<form method="post" action="<%=request.getContextPath() %>/WriteDiagnosis?child_id=<%= child_id%>&doctor_id=<%= so.getUserID()%>">
								<div class="form-group">
									<label for="child_name">名字</label>
									<input type="text" class="form-control" id="child_name" value="<%=info.getChildName() %>" disabled="disabled"></div>
								<div class="form-group">
									<label for="exampleInputEmail1">填写诊断结果:</label>
									<textarea class="form-control" rows="3" name="content"></textarea>
								</div>

								<button type="submit" class="btn btn-default">提交</button>
							</form>
						</div>
					</div>
				</div>
			</div>
			<!-- the end of panel -->

		</div>

	</div>

</div>
<script src="public/component/morrisjs/morris.min.js"></script>
<script src="public/component/raphael/raphael-min.js"></script>

<%@ include file="/include/footer.jsp" %>