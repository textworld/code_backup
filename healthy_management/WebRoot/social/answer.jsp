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
            <%Consult c = GetConsult.getConsutById(Integer.parseInt(request.getParameter("ConsultID")));%>
            <div class="col-md-9">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<i class="glyphicon glyphicon-menu-hamburger"></i> 回答咨询
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-md-12">
								<p><a href="social/child_info.jsp?child_id=<%=c.getChildID() %>"><%=c.getChildName() %></a> 的家长在<%=c.getFormatTime() %>向您咨询：</p>
								<div class="well"><%=c.getContents() %></div>
							</div>
						</div>
							<% List<Picture> list = GetConsult.getPictures(Integer.parseInt(request.getParameter("ConsultID"))); %>
                       	<% if(list == null || list.size() == 0){ %>
                       		
                       	<%}else{ %>
                       		<h3>家长上传的图片</h3>
                       		
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
                
                       	<% } %>
						
						<div class="row">
							<div class="col-md-12">
								<form class="form" action="AnswerServlet" method="post">
									<input type="hidden" name="ConsultID" value="<%=Integer.parseInt(request.getParameter("ConsultID")) %>"/>
									<div class="form-group">
										<label>答复</label>
										<textarea class="form-control" name="Reply"></textarea>
									</div>
									<button type="submit" class="btn btn-default">提交</button>
								</form>
							</div>
						</div>
					</div>
				</div>
          
            </div>
        </div>
        
    </div>
	<jsp:include page="/include/footer.jsp" />