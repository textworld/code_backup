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
				<jsp:include page="/child/left.jsp" %>
				<!-- 这是日历控件 -->
                <%@ include file="/include/calendar.jsp" %>
            </div>
            <div class="col-md-9">
                <%@ include file="/include/carousel.jsp" %>

                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <i class="glyphicon glyphicon-menu-hamburger"></i> 请先输入数据
                    </div>
                    <div class="panel-body">
                        <form method="post" action="InputBodyData">
	                        <% if( session.getAttribute("success") != null){ %>
	                            <!-- <div class="alert alert-warning">
	                            	<%=session.getAttribute("success") %>
	                            </div>-->
	                    		<% session.removeAttribute("success"); %>
	                    		<% }else{System.out.println("success is  null");} %>
	                    	<input type="hidden" name="child_id" value="<%= ((UserBean)session.getAttribute("user")).getId()%>" />
  							<div class="form-group">
    							<label for="data_height">身高</label>
    							<input type="text" class="form-control" id="data_height" name="data_height" placeholder="米">
  							</div>
  							<div class="form-group">
    							<label for="">体重</label>
    							<input type="text" class="form-control" id="data_weight" name="data_weight"  placeholder="千克">
  							</div>
  							<div class="form-group">
    							<label for="">头围</label>
    							<input type="text" class="form-control" id="data_head" name="data_head"  placeholder="厘米">
  							</div>
  							<div class="form-group">
    							<label for="">胸围</label>
    							<input type="text" class="form-control" id="data_body" name="data_body"  placeholder="厘米">
  							</div>
  							

  							<button type="submit" class="btn btn-default">保存</button>
						</form>
                    </div>
                </div><!-- panel end -->
                
               
            </div>
        </div>
        
    </div>
	<%@ include file="/include/footer.jsp" %>