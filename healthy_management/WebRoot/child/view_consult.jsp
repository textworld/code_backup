<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="rxy.javabean.Information" %>
<%@ page import="rxy.data.GetInformation" %>
<%@ include file="/child/header.jsp" %>
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
				<%Consult cs = GetConsult.getConsutById(Integer.parseInt(request.getParameter("ConsultID"))); %>
				
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <i class="glyphicon glyphicon-menu-hamburger"></i> 远程诊断历史
                    </div>
                    <div class="panel-body">
                       	<div class="row">
                       		<div class="col-md-12">
                       			<%if(cs.getStatus() == Consult.STATUS_NOT_ANSWER){ %>
                       				<p>您在<%=cs.getFormatTime() %>写的描述<span style="font-weight:bold">”<%=cs.getContents() %>“</span>还没有被赵医生回答</p>
                       			<%}else { %>
                       			<%GetConsult.readById(Integer.parseInt(request.getParameter("ConsultID"))); %>
                       			<p>您在<%=cs.getFormatTime() %>写的描述<span style="font-weight:bold">”<%=cs.getContents() %>“</span>被赵医生回答了</p>
                       			<div class="well">
                       				<%=cs.getReply() %>
                       			</div>
                       			<%} %>
                       		</div>
                       	</div>
                       	<% List<Picture> list = GetConsult.getPictures(Integer.parseInt(request.getParameter("ConsultID"))); %>
                       	<% if(list == null || list.size() == 0){ %>
                       		<3>没有 图片</h3>
                       	<%}else{ %>
                       		<h3>您上传的图片</h3>
                       		
                       		<% int _i = 0; %>
                       		<%for(Picture p : list){ %>
                       			<%if(_i++ % 3 == 0){ %>
                       			<div class="row">
                       			<div class="col-md-3">
                       				<a target="_blank" href="<%=request.getContextPath()%>/upload/<%=p.getFullName()%>"><img class="img-thumbnail" src="<%=request.getContextPath()%>/upload/<%=p.getFullName()%>" /></a>
                       			</div>
                       			<%}else if(_i % 3 == 2){ %>
                       			<div class="col-md-3">
                       				<a target="_blank" href="<%=request.getContextPath()%>/upload/<%=p.getFullName()%>"><img class="img-thumbnail" src="<%=request.getContextPath()%>/upload/<%=p.getFullName()%>" /></a>
                       			</div>
                       			</div>
                       			<%}else{ %>
                       			<div class="col-md-3">
                       				<a target="_blank" href="<%=request.getContextPath()%>/upload/<%=p.getFullName()%>"><img class="img-thumbnail" src="<%=request.getContextPath()%>/upload/<%=p.getFullName()%>" /></a>
                       			</div>
                       			<%} %>
                       		<%} %>
                       		<%if(_i % 3 != 2){ %>
                       			</div>
                       		<%} %>
                       		</div>
                       	<% } %>
                    </div>
                </div><!-- panel end -->

            </div>
        </div>
        
    </div>
    <script>
    	changeNavList(6);
    </script>
	<jsp:include page="/include/footer.jsp" />