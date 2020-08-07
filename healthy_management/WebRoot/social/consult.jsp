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
				<div class="panel panel-primary">
					<div class="panel-heading">
						<i class="glyphicon glyphicon-menu-hamburger"></i> 咨询过的问题
					</div>
					<div class="panel-body">
						<% int page_size = 8; %>
						<% List<Consult> consult_list = GetConsult.getConsult("DoctorID", ((UserBean)session.getAttribute("user")).getId(), _page, page_size); %>
						<% if(consult_list != null && consult_list.size() > 0){ %>
							<table class="table table-striped">
								<thead>
									<th>提问时间</th>
									<th>儿童</th>
									<th>收到的问题</th>
									<th>我的回答</th>
									<th>回答时间</th>
								</thead>
								<tbody>
									<%for(Consult s : consult_list){ %>
										<tr>
											<td><%=s.getFormatTime() %></td>
											<% Information child = GetInformation.findOne(s.getChildID()); %>
											<td><a href="social/child_info.jsp?child_id=<%=s.getChildID() %>"><%=child.getChildName() %></a></td>
											<td><%=s.getContents() %></td>
											<td>
												<%if(s.getStatus() == Consult.STATUS_NOT_ANSWER){ %>
													<a href="social/answer.jsp?ConsultID=<%=s.getConsultID() %>">前去回答</a>
												<%}else{ %>
													<%=s.getReply() %>
												<%} %>
											</td>
											<td><%=s.getFormatReplyTime() %></td>
										</tr>
									<% } %>
								</tbody>
							</table>
							<%int pages = GetConsult.getPaing("DoctorID",((UserBean)session.getAttribute("user")).getId() ); %>
							<% int page_num = pages / page_size; %>
							<% int ys = 0; %>
							<%if(pages % page_size > 0) ys = 1; %>
							<% if(page_num > 0){ %>
		    				<nav style="text-align: center">
		            			<ul  class="pagination"">
		            				<% for(int j = 1; j <= (page_num+ys); j++){ %>
		            					<%if(j == _page){ %>
		            						<li  class="active">
		            							<a href="<%=request.getContextPath() %>/social/consult.jsp?page=<%=j %>">
		            								<%=j %>
		            							</a>
		            						</li>
		            					<% }else{ %>
		            						<li><a href="<%=request.getContextPath() %>/social/consult.jsp?page=<%=j %>"><%=j %></a></li>
		            					<%} %>
		            				<%} %>
		            			</ul>
		            		</nav>
		    				<% } %>
						<%} %>
					</div>
				</div>
          
            </div>
        </div>
        
    </div>
	<jsp:include page="/include/footer.jsp" />