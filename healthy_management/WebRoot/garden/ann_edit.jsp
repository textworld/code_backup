<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="rxy.javabean.Information" %>
<%@ page import="rxy.data.GetInformation" %>
<%@ page import="rxy.data.GetAnnounce" %>
<%@ include file="/garden/header.jsp" %>
<%@ include file="/garden/auth.jsp" %>
<% 	
	if(request.getParameter("AnnID") == null){
		response.sendRedirect(request.getContextPath() + "/garden/ann_manage.jsp");
		return;
	}
	System.out.println(request.getParameter("AnnID").toString());
	int ann_id = Integer.parseInt(request.getParameter("AnnID").toString());
	System.out.println(ann_id);
	Announcement ann = GetAnnounce.findOne(ann_id);
	if(ann == null){
		response.sendRedirect(request.getContextPath() + "/garden/ann_manage.jsp");
		return;
	}
	
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
                <div class="panel-heading"> <i class="glyphicon glyphicon-menu-hamburger"></i> 编辑信息
                </div>
                <div class="panel-body">
                    <form method="post"  action="AnnEdit" style="position:relative">
                        <div class="form-group">
                        	<input type="hidden" name="ann_id" value="<%=ann.getAnnounce()%>"/>
                            <textarea class="form-control" rows="3" name="ann_content"><%=ann.getContents() %></textarea>
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

</div>
<script>
	setTimeout(function(){
		if(document.getElementById('send_success'))
		$('#send_success').hide();
	}, 1000);
	
</script>
<%@ include file="/include/footer.jsp" %>