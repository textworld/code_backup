<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="rxy.javabean.Information" %>
<%@ page import="rxy.data.*" %>
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
				<div class="panel panel-primary">
					<div class="panel-heading">
						<i class="glyphicon glyphicon-menu-hamburger"></i> 咨询
					</div>
					<div class="panel-body">
						<form action="Consult" method="post">
							<div class="form-group">
								<label for="input-consult-doctor">医生</label>
    							<input type="text" class="form-control" id="input-consult-doctor" disabled="disabled" value="赵医生">
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">咨询内容</label>
    							<textarea name="Contents" id="input-consult-contents" class="form-control"></textarea>
							</div>
							<button type="submit" class="btn btn-default">提交</button>
						</form>
					</div>
				</div>
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <i class="glyphicon glyphicon-menu-hamburger"></i> 诊断信息
                    </div>
                    <div class="panel-body">
                    	<iframe src="http://localhost:8080/healthy_management/FindDiag" style="border:none;width:100%;height:340px;"></iframe>
                    	
                    </div>
                </div><!-- panel end -->

            </div>
        </div>
        
    </div>
    <script>
    	changeNavList(3);
    </script>
	<%@ include file="/include/footer.jsp" %>