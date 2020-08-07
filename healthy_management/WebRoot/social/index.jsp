<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/social/header.jsp" %>
<%@ page import="rxy.javabean.*" %>
<%@ page import="rxy.data.*" %>

<% 
	int _page = 1;
	if(request.getParameter("page") != null){
		_page = Integer.parseInt(request.getParameter("page").toString());
	} 
	System.out.println("Doctor index page: " + _page);
%>

<% SocialInfo sfo = GetSocialInfo.findOne(((UserBean)session.getAttribute("user")).getId());%>
   <div class="container">
        <div class="row">
            <div class="col-md-3">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <i class="glyphicon glyphicon-menu-hamburger"></i> 医生个人信息
                    </div>
                    <div class="panel-body">
                        <div class="div-layer">
                             <img src="./public/imgs/socialdoctor.jpg" alt="" class="img-thumbnail">
                        </div>
                        <div class="div-layer">
                            <p>姓名：<span><%=sfo.getDoctorName()%></span></p>
                              <p>单位：<span><%=sfo.getSocialName()%></span></p>
                        </div>
                       
                    </div>
                </div>

				
                <%@ include file="/include/calendar.jsp" %>
            </div>
            <div class="col-md-9">
            			
                    	<%
		            		GetChildren gc = new GetChildren(_page);
		            		List<Information> list = gc.getData(sfo.getUserID());
		            	%> 
		            	<% if(list != null && list.size() > 0){ %>
		            		<%for(int i = 0; i < list.size(); i++){ %>
		            			<% Information info = list.get(i); %>
		            			<div class="panel panel-primary">
				                    <div class="panel-heading">
				                        <i class="glyphicon glyphicon-menu-hamburger"></i> <%=info.getChildName() %>
				                        <div class="pull-right">
				                        	<a href="<%=request.getContextPath() %>/social/check.jsp?child_id=<%=info.getUserID() %>" class="btn btn-default btn-xs">诊断</a>
				                        	<a href="<%=request.getContextPath() %>/social/diagnosis.jsp?child_id=<%=info.getUserID() %>" class="btn btn-default btn-xs">以往的诊断</a>
				                        	<!-- <div class="btn-group">
				  								<button class="btn btn-default btn-xs dropdown-toggle" type="button" data-toggle="dropdown" aria-expanded="false">
				    								Extra small button <span class="caret"></span>
				  								</button>
				  								<ul class="dropdown-menu" role="menu">
				    								<li>
				    									<a href="#">dd</a>
				    								</li>
				  								</ul>
											</div> -->
				                        </div>
				                    </div>
				                    <div class="panel-body">
				                    	<div class="row">
				                    		<div class="col-md-3">
				                    			<div class="child-list-img" style="text-align: center;">
				                    				<%if(info.getGender().equals("男")){ %>
				                    					<img src="./public/imgs/boy.jpg" width="120" height="200" class="img-thumbnail"/>
				                    				<% }else{ %>
				                    					<img src="./public/imgs/girl.jpg" width="120" height="200" class="img-thumbnail"/>
				                    				<%} %>
				                    			</div>                    			
				                    		</div>
				                    		<div class="col-md-9">
				                    			<table class="table table-bordered">
				                    				<tr>
				                    					<td >姓名：<a href="<%=request.getContextPath() %>/social/child_info.jsp?child_id=<%=info.getUserID() %>"><%=info.getChildName() %></a></td>
				                    					<td>性别：<%=info.getGender() %></td>
				                    					<td>年龄：18</td>
				                    				</tr>
				                    				<tr>
				                    					<% String status = GetChildren.getStatus(info.getUserID()); %>
				                    					<td colspan="3">状态：
				                    						<%if(status.equals("健康")){ %>
				                    							<span>健康</span>
				                    						<%}else{ %>
				                    							<span style="color: red"><%=status %></span>
				                    						<%} %>
				                    					</td>
				                    				</tr>
				                    			</table>
				                    			
				                    		</div>
				                    	</div>
				                    </div><!-- panel body end -->
				                </div><!-- panel end -->		
		            		<%} %>
		            		<nav style="text-align: center">
		            			<ul  class="pagination"">
		            				<% int count = gc.getPaging() / gc.getPageSize(); %>
		            				<% for(int j = 1; j <= count; j++){ %>
		            					<%if(j == _page){ %>
		            						<li  class="active">
		            							<a href="<%=request.getContextPath() %>/social/index.jsp?page=<%=j %>">
		            								<%=j %>
		            							</a>
		            						</li>
		            					<% }else{ %>
		            						<li><a href="<%=request.getContextPath() %>/social/index.jsp?page=<%=j %>"><%=j %></a></li>
		            					<%} %>
		            				<%} %>
		            			</ul>
		            		</nav>
		            	<%}else{ %>
		            		没有儿童
		            	<%} %>
          
            </div>
        </div>
        
    </div>
	<jsp:include page="/include/footer.jsp" />