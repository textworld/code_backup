<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="rxy.javabean.Information" %>
<%@ page import="rxy.data.GetInformation" %>
<%@ include file="/garden/header.jsp" %>
<%@ include file="/garden/auth.jsp" %>

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
            </div>
            <div class="panel panel-primary">
                <div class="panel-heading"> <i class="glyphicon glyphicon-menu-hamburger"></i> 公告管理
                </div>
                 <div class="panel-body">
                    	<iframe src="http://localhost:8080/healthy_management/FindAnn" style="border:none;width:100%;height:765px;"></iframe>
                    	
                    </div>
            </div>
            <!-- panel end --> 
            
             
		</div>
    </div>    
    <script>
    	changeNavList(4);
    </script>

</div>
<script>
	setTimeout(function(){
		if(document.getElementById('send_success'))
		$('#send_success').hide();
	}, 1000);
	
</script>
<%@ include file="/include/footer.jsp" %>