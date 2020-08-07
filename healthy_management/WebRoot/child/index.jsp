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
				<jsp:include page="/child/left.jsp" />
				<!-- 这是日历控件 -->
                <%@ include file="/include/calendar.jsp" %>
            </div>
            <div class="col-md-9">
                <%@ include file="/include/carousel.jsp" %>

                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <i class="glyphicon glyphicon-menu-hamburger"></i> 基本信息
                    </div>
                    <div class="panel-body">
                        <table class="table table-bordered">
                          <tr>
                            <td>姓名：<%= info.getChildName() %></td>
                            <td>性别：<%= info.getGender() %></td>
                            <td>出生日期：<%= info.getBirthDate() %></td>
                          </tr>
                          <tr>
                            <td colspan="2">家庭住址：<%= info.getHomeAddress() %></td>
                            <td>固定电话：<%= info.getPhone() %></td>
                          </tr>
                          <tr>
                            <td>父亲：<%= info.getFatherName() %></td>
                            <td>工作：<%= info.getFatherJob() %></td>
                            <td>电话：<%= info.getFatherPhone() %></td>
                          </tr>
                          <tr>
                            <td>母亲：<%= info.getMatherName() %></td>
                            <td>工作：<%= info.getMatherJob() %></td>
                            <td>电话：<%= info.getMatherPhone() %></td>
                          </tr>
                        </table>
                    </div>
                </div><!-- panel end -->

            </div>
        </div>
        
    </div>
    <script>
    	changeNavList(1);
    </script>
	<%@ include file="/include/footer.jsp" %>