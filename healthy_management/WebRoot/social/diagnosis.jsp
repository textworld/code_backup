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
	int _page = 1;
	if(request.getParameter("page") != null){
		_page = Integer.parseInt(request.getParameter("page").toString());
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
                </div>
			</div>
			<div class="panel-body">
				<div class="row">
					<div class="col-md-3">
						<div class="child-list-img" style="text-align:center">
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
								<td>年龄：18</td>
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
				以前的诊断书
			</div>
			<div class="panel-body">
				
					<% List<Diagnosis> list_d = GetDiagnosis.find(child_id, _page);%>
					<% if(list_d != null && list_d.size() > 0){ %>
						<table class="table table-bordered">
							<thead align="center">
								<th><b>负责医生</b></th>
								<th><b>就诊时间</b></th>
								<th><b>诊断结果</b></th>
								
							</thead>
							<tbody>
						<%for(int i = 0; i < list_d.size(); i++){ %>
							<% Diagnosis d = list_d.get(i); %>
							<tr>
								<td><%=d.getDoctorName()%></td>
								
								<td><%=d.getDiagnosisTime()%></td>
								<td><%=d.getMemo()%></td>
							</tr>
						<%} %>
							</tbody>
						</table>
							<nav style="text-align: center">
		            			<ul  class="pagination"">
		            				<% int count = GetDiagnosis.findCount(child_id) / Diagnosis.PAGE_SIZE; %>
		            				<% for(int j = 1; j <= (count+1); j++){ %>
		            					<%if(j == _page){ %>
		            						<li  class="active">
		            							<a href="<%=request.getContextPath() %>/social/diagnosis.jsp?child_id=<%=child_id %>&page=<%=j %>">
		            								<%=j %>
		            							</a>
		            						</li>
		            					<% }else{ %>
		            						<li><a href="<%=request.getContextPath() %>/social/diagnosis.jsp?child_id=<%=child_id %>&page=<%=j %>"><%=j %></a></li>
		            					<%} %>
		            				<%} %>
		            			</ul>
		            		</nav>
				<% }else{ %>
				没有诊断记录
				<% } %>

			</div>
		</div>
		<!-- panel end -->		

		
	<% if(session.getAttribute("success") != null ){ %>
	<script>
		$(window).ready(function(){
			alert("<%= session.getAttribute("success").toString()%>");
		});
		
	</script>
	<%session.removeAttribute("success"); %>
<% } %>
<%@ include file="/include/footer.jsp" %>