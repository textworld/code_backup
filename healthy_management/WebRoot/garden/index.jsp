<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="rxy.javabean.*" %>
<%@ page import="rxy.data.*" %>
<%@ include file="/garden/header.jsp" %>
<%@ include file="/garden/auth.jsp" %>
<% 
	int _page = 1;
	if(request.getParameter("page") != null){
		_page = Integer.parseInt(request.getParameter("page").toString());
	} 
	System.out.println("Doctor index page: " + _page);
%>
<div class="container">
    <div class="row">
        <div class="col-md-3">
            <!-- 这是左上角的那张图片的框 -->
            <%@ include file="/garden/teacher_info.jsp" %>
            <!-- 这是左侧导航栏  -->
            <%@ include file="/garden/left.jsp" %>
            <!-- 这是日历控件 -->
            <%@ include file="/include/calendar.jsp" %></div>
        <div class="col-md-9">
           <div class="panel panel-primary">
                <div class="panel-heading"> <i class="glyphicon glyphicon-menu-hamburger"></i> 发表信息
                </div>
                <div class="panel-body">
                    <form method="post"  action="AddAnnServlet" style="position:relative">
                        <div class="form-group">
                            <textarea class="form-control" rows="3" name="Contents"></textarea>
                            <% if( session.getAttribute("success") != null){ %>
                            <div id="send_success">
                    			<p>发送成功</p>
                    		</div>
                    		<% session.removeAttribute("success"); %>
                    		<% }else{System.out.println("success is  null");} %>
                        </div>
                        	<div class="pull-right"><button type="submit" class="btn btn-default">提交</button></div>
                    </form>
                    
                </div>
            </div>  <!-- panel end --> 
			
			<h3>特别关注的儿童</h3>
            <% int page_size = 4; %>
            <% List<Information> child_list = new ArrayList<Information>(); %>
            <%child_list = GetInformation.findChildNotHealth(info.getUserID(), _page, page_size); %>
            <%if(child_list != null && child_list.size() > 0){ %>
            	<% for(int j = 0; j < child_list.size(); j ++ ){%>
            		<% Information child = child_list.get(j); %>
            		<div class="panel panel-primary">
		                <div class="panel-heading"> <i class="glyphicon glyphicon-menu-hamburger"></i> <%=child.getChildName() %>
		                </div>
		                <div class="panel-body">
		                	<div class="row">
		                		<div class="col-md-3">
		                			<div class="hc-avatar">
		                				<%if(child.getGender().equals("男")){ %>
		                					<img src="<%=request.getContextPath()%>/public/imgs/boy.jpg" class="img-thumbnail" width="160" height="200"/>
		                				<%}else{ %>
		                					<img src="<%=request.getContextPath()%>/public/imgs/girl.jpg" class="img-thumbnail" width="160" height="200"/>
		                				<%} %>
		                			</div>
		                		</div>
		                		<div class="col-md-9">
		                			<table class="table table-bordered">
			                          	<tr>
				                            <td>姓名：<a href="<%=request.getContextPath()%>/social/child_info.jsp?child_id=<%=child.getUserID() %>"><%=child.getChildName() %></a></td>
				                            <td>性别：<%=child.getGender() %></td>
				                            <td>出生日期：<%=child.getBirthDate() %></td>
			                          	</tr>
			                          	<tr>
				                            <td colspan="2">家庭住址：<%=child.getHomeAddress() %></td>
				                            <td>固定电话：<%=child.getPhone() %></td>
			                          	</tr>
			                       	</table>
			                       	<p>状态：<span style="color: red" class="alert alert-danger"><%=child.getStatus() %></span></p>
		                		</div>
		                	</div>
		                	<%List<Diagnosis> list_diagnosis = GetDiagnosis.find(child.getUserID(), 1); %>
		                	<div class="row" style="margin-top: 15px">
		                		<div class="col-md-12">
		                			<%if(list_diagnosis != null && list_diagnosis.size() > 0){ %>
		                				<% for(int k = 0; k < 1; k ++){ %>
		                					<% Diagnosis d = list_diagnosis.get(k); %>
			                				<table class="table table-bordered">
					                          	<tr>
						                            <td>时间：<%= d.getDiagnosisTime() %></td>
						                            <td>医生：<%= d.getDoctorName() %></td>
					                          	</tr>
					                          	<tr>
						                            <td colspan="2">内容：<%= d.getMemo() %></td>
					                          	</tr>
				                       		</table>	
			                       		<% } %>
		                			<%}else{%>
		                				<p>没有诊断记录</p>
		                			<% } %>
			                		
		                		</div>
		                	</div>
		                </div>
		            </div>
		            <!-- panel end -->
		    	<% } %> <!--  for 循环结束 -->
		    	<% int pages = GetInformation.getUnhealthyChildNum(info.getUserID()); %>
		    	<% int page_num = pages / page_size; %>
		    	<% if(page_num > 0){ %>
		    				<nav style="text-align: center">
		            			<ul  class="pagination"">
		            				<% for(int j = 1; j <= (page_num+1); j++){ %>
		            					<%if(j == _page){ %>
		            						<li  class="active">
		            							<a href="<%=request.getContextPath() %>/garden/index.jsp?page=<%=j %>">
		            								<%=j %>
		            							</a>
		            						</li>
		            					<% }else{ %>
		            						<li><a href="<%=request.getContextPath() %>/garden/index.jsp?page=<%=j %>"><%=j %></a></li>
		            					<%} %>
		            				<%} %>
		            			</ul>
		            		</nav>
		    	<% } %>
            <%}else{ %>
            	<p>没有需要特别关注的儿童</p>
            <%} %>
           
		            


		</div>
    </div>

</div>
    <script>
    	changeNavList(1);
    </script>
<jsp:include page="/include/footer.jsp" />