<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="rxy.javabean.Information" %>
<%@ page import="rxy.data.*" %>
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
						<i class="glyphicon glyphicon-menu-hamburger"></i> 远程诊断
					</div>
					<div class="panel-body">
						<% if(session.getAttribute("success") != null){ %>
							<div class="alert alert-success">
								<%=session.getAttribute("success").toString() %>
								<%session.removeAttribute("success"); %>
							</div>
						<% } %>
						
						<% if(session.getAttribute("error") != null){ %>
							<div class="alert alert-error">
								<%=session.getAttribute("error").toString() %>
								<%session.removeAttribute("error"); %>
							</div>
						<% } %>
						<form action="ImgUpload" method="post" enctype="multipart/form-data" target="file_upload_frame" id="form-imgupload">
							<div class="form-group">
								<label for="input-consult-doctor">医生</label>
    							<input type="text" class="form-control" id="input-consult-doctor" disabled="disabled" value="赵医生">
							</div>
							<div class="form-group">
								<label for="input-consult-contents">上传文件</label>
    							<input type="file" name="fileToUpload" id="fileToUpload">
    							<span class="help-text" id="upload-help"></span>
							</div>
						</form>
						<form action="RemoteCheckServlet" method="post" id="form-remotecheck">
							<input type="hidden" name="ChildID" value="<%=((UserBean)session.getAttribute("user")).getId()%>"/>
							<input type="hidden" name="DoctorID" value="<%=in.getDoctorID()%>" />
							
							
							<div class="form-group">
								<label for="input-consult-contents">病情描述</label>
    							<textarea name="Contents" id="input-consult-contents" class="form-control"></textarea>
							</div>
							<div id="img_preview_box">
								<p></p><label>预览图</label></p>
								
							</div>
							<button type="submit" class="btn btn-default">提交</button>
						</form>
						
						<iframe name="file_upload_frame" id="file_upload_frame" style="display:none"></iframe>
					</div>
				</div>
				
				<div class="panel panel-primary">
                    <div class="panel-heading">
                        <i class="glyphicon glyphicon-menu-hamburger"></i> 诊断信息
                    </div>
                    <div class="panel-body">
                    	<% List<RemoteCheck> list = RemoteAction.getChildAllCheck(((UserBean)(session.getAttribute("user"))).getId(), 1, 5); %>
                    	<%if(list == null || list.size() == 0){ %>
                    		<p>没有远程诊断信息</p>
                    	<%}else{ %>
                    		<table class="table-stripped">
                    			
                    		</table>
                    		<%for(RemoteCheck rc : list){ %>
                    			
                    		<%} %>
                    	<%} // end of else%>
                    </div>
                </div>
                
            </div>
        </div>
        
    </div>
    <script>
    	changeNavList(7);
    </script>
    <script>
    	$(window).ready(function(){
    		$(document).on('change', '#fileToUpload', function(){
    			$('#form-imgupload').submit();
    		});
    	});
    </script>
    <script type="text/javascript">
    	var div_num = 0;
    	var line_div_num = 3;
		function addImg(img_name, img_id)
		{
			var row_div;
			setUploadMessage('');
			
			if(div_num % line_div_num == 0)
			{
				row_div = $('<div class="row"></div>').appendTo('#img_preview_box');
			}else{
				row_div = $('#img_preview_box>.row:last');
			}
			div_num = (div_num + 1) % line_div_num;
			
			row_div.append("<div class=\"col-md-4\"><img src=\"/healthy_management/upload/" + img_name + "\" width=\"200\" class=\"img-thumbnail\"/><button class=\"btn btn-default delete-img\">删除</button></div>");
			
			$('#form-remotecheck').append("<input type=\"hidden\" name=\"Imgs\" value=\""+ img_id +"\"/>");
		}
		function setUploadMessage(m)
		{
			$('#upload-help').text(m);
		}
	</script>
	<%@ include file="/include/footer.jsp" %>