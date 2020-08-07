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
                    <form>
                        <div class="form-group">
                            <textarea class="form-control" rows="3"></textarea></div>
                        	<div class="pull-right"><button type="submit" class="btn btn-default">提交</button></div>
                    </form>
                </div>
            </div>
            <!-- panel end --> 
            
            <div class="panel panel-primary">
                <div class="panel-heading"> <i class="glyphicon glyphicon-menu-hamburger"></i> 每月汇总：
                </div>
                <div class="panel-body">
                	<div id="month_report"></div>
                	
                </div>
            </div>
            <!-- panel end --> 
		</div>
    </div>

</div>     <script src="public/component/morrisjs/morris.min.js"></script>
    <script src="public/component/raphael/raphael-min.js"></script>
 <script>
    
		$(function(){
				Morris.Bar({
					element: 'month_report',
					data: 
					[   		
		 				{"period": "发烧人数", "num": 12},
		 				{"period": "睡眠不足", "num": 24},
		 				{"period": "就诊人数", "num": 43}
					], 
					xkey: 'period',
	    			ykeys: ['num'],
	    			labels: ['统计人数'],
	    			pointSize: 3,
	    			hideHover: false,
	    			resize: true,
	    			parseTime: false,
	    			ymax: 42,
	    			ymin: 0,
		 		});
		});
	</script>
<%@ include file="/include/footer.jsp" %>