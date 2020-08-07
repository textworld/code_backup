<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="rxy.javabean.Information" %>
<%@ page import="rxy.data.GetInformation" %>
<%@ page import="rxy.javabean.*" %>
<%@ include file="/child/header.jsp" %>
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
				<%@ include file="/child/child_info.jsp" %>
                <!-- 这是左侧导航栏  -->
				<%@ include file="/child/left.jsp" %>
				<!-- 这是日历控件 -->
                <%@ include file="/include/calendar.jsp" %>
            </div>
            <div class="col-md-9">
                <%@ include file="/include/carousel.jsp" %>

                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <i class="glyphicon glyphicon-menu-hamburger"></i> 公告
                    </div>
                    <div class="panel-body">
                    	<% int page_size = 6; %>
                       	<%List<Announcement> list_ann = GetAnnounce.getAnnouncements(info.getGardenID(), _page, page_size); %>
                       
                       	<%if(list_ann != null && list_ann.size() > 0){ %>
                       		<table class="table table-bordered">
                       			<thead>
                       				<tr>
                       					<th>
                       						发布者
                       					</th>
                       					<th>
                       						发布时间
                       					</th>
                       					<th>
                       						发布内容
                       					</th>
                       				</tr>
                       			</thead>
                       			<tbody> 
		                       		<% for(int i = 0; i < list_ann.size(); i++){ %>
		                       			<% Announcement ann = list_ann.get(i); %>
		                       			<tr>
		                       				<td>
		                       					<%=ann.getDoctorName() %>
		                       				</td>
		                       				<td>
		                       					<%=ann.getTime() %>
		                       				</td>
		                       				<td>
		                       					<%=ann.getContents() %>
		                       				</td>
		                       			</tr>
		                       		<% } %> <!-- for语句的结束 -->
                       			</tbody>
                       		</table>
                       		<% int pages = GetAnnounce.GetAnnCount(info.getGardenID()); %>
					    	<% int page_num = pages / page_size; %>
					    	<% int need_plus = ((pages % page_size) == 0) ? 0 : 1; %>
					    	<% if(page_num > 0){ %>
					    				<nav style="text-align: center">
					            			<ul  class="pagination"">
					            				<% for(int j = 1; j <= (page_num+need_plus); j++){ %>
					            					<%if(j == _page){ %>
					            						<li  class="active">
					            							<a href="<%=request.getContextPath() %>/child/announcement.jsp?page=<%=j %>">
					            								<%=j %>
					            							</a>
					            						</li>
					            					<% }else{ %>
					            						<li><a href="<%=request.getContextPath() %>/child/announcement.jsp?page=<%=j %>"><%=j %></a></li>
					            					<%} %>
					            				<%} %>
					            			</ul>
					            		</nav>
					    	<% } %>
                       	<% } else{ %><!-- 判断list_ann 是否为null的else -->
                       	
                       	<% } %>
                    </div>
                </div><!-- panel end -->
				
            </div>
        </div>
        
    </div>
    <script>
    	changeNavList(5);
    </script>
	<%@ include file="/include/footer.jsp" %>