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
						
						<form action="ConsultServlet" method="post" id="form-remotecheck">
							<input type="hidden" name="ChildID" value="<%=((UserBean)session.getAttribute("user")).getId()%>"/>
							<input type="hidden" name="DoctorID" value="<%=in.getDoctorID()%>" />

							<div class="form-group" style="position:relative">
								<label for="input-consult-contents">描述</label>
    							<textarea name="Contents" id="input-consult-contents" class="form-control"></textarea>
    							<% if( session.getAttribute("success") != null){ %>
	                            <div id="send_success">
	                    			<p>发送成功</p>
	                    		</div>
	                    		<% session.removeAttribute("success"); %>
	                    		<% }else{System.out.println("success is  null");} %>
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
						<i class="glyphicon glyphicon-menu-hamburger"></i> 诊断历史
					</div>
					<div class="panel-body">
						<% int page_size = 8; %>
						<% List<Consult> consult_list = GetConsult.getConsult("ChildID", ((UserBean)session.getAttribute("user")).getId(), _page, page_size); %>
						<% if(consult_list != null && consult_list.size() > 0){ %>
							<table class="table table-striped">
								<thead>
									<th>提问时间</th>
									<th>我的描述</th>
									<th>医生诊断</th>
									<th>回答时间</th>
								</thead>
								<tbody>
									<%for(Consult s : consult_list){ %>
										<tr>
											<td><%=s.getFormatTime() %></td>
											<td><a href="child/view_consult.jsp?ConsultID=<%=s.getConsultID() %>"><%=s.getContents() %></a></td>
											<td><%if(s.getStatus() == Consult.STATUS_NOT_ANSWER){ %>还未回答<%}else{ %><%=s.getReply() %><%} %></td>
											<td><%=s.getFormatReplyTime() %></td>
										</tr>
									<% } %>
								</tbody>
							</table>
							<%int pages = GetConsult.getPaing("ChildID",((UserBean)session.getAttribute("user")).getId() ); %>
							<% int page_num = pages / page_size; %>
							<% int ys = 0; %>
							<%if(pages % page_size > 0) ys = 1; %>
							<% if(page_num > 0){ %>
		    				<nav style="text-align: center">
		            			<ul  class="pagination"">
		            				<% for(int j = 1; j <= (page_num+ys); j++){ %>
		            					<%if(j == _page){ %>
		            						<li  class="active">
		            							<a href="<%=request.getContextPath() %>/child/consult.jsp?page=<%=j %>">
		            								<%=j %>
		            							</a>
		            						</li>
		            					<% }else{ %>
		            						<li><a href="<%=request.getContextPath() %>/child/consult.jsp?page=<%=j %>"><%=j %></a></li>
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
    <script>
    	changeNavList(6);
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
			
			row_div.append("<div class=\"col-md-4\"><img style=\"width: 200px;height:200px\"  src=\"/healthy_management/upload/" + img_name + "\" width=\"200\" class=\"img-thumbnail\"/></div>");
			
			$('#form-remotecheck').append("<input type=\"hidden\" name=\"Imgs\" value=\""+ img_id +"\"/>");
		}
		function setUploadMessage(m)
		{
			$('#upload-help').text(m);
		}
		setTimeout(function(){
			if($('#send_success').length > 0)
			{
				$('#send_success').hide();
			}
		}, 3000);
	</script>
	<%@ include file="/include/footer.jsp" %>