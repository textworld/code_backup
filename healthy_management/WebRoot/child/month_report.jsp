<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="rxy.javabean.Information" %>
<%@ page import="rxy.data.GetInformation" %>
<%@ page import="rxy.javabean.*" %>
<%@ page import="rxy.data.TempData" %>
<%@ include file="/child/header.jsp" %>
   <div class="container">
        <div class="row">
            <div class="col-md-3">
            	<!-- 这是左上角的那张图片的框 -->
				<%@ include file="/child/child_info.jsp" %>
                <!-- 这是左侧导航栏  -->
				<jsp:include page="/child/left.jsp" >
				<!-- 这是日历控件 -->
                <%@ include file="/include/calendar.jsp" %>
            </div>
            <div class="col-md-9">
                <%@ include file="/include/carousel.jsp" %>

                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <i class="glyphicon glyphicon-menu-hamburger"></i> 昨日体温
                        <div class="pull-right">
                        <!-- Single button -->
							<div class="btn-group">
							  	<button type="button" class="btn btn-default dropdown-toggle btn-xs" data-toggle="dropdown" aria-expanded="false">
							    	查看以往数据 <span class="caret"></span>
							  	</button>
							  	<ul class="dropdown-menu" role="menu">
							  		<li><a href="#">昨天</a></li>
							    	<li><a href="#" id="data-day-1">前天</a></li>
							    	<li><a href="#">选择日期</a></li>
							    	<li class="divider"></li>
							    	<li><a href="#">查看一个月的</a></li>
							  </ul>
							</div>
                        </div>
                    </div>
                    <div class="panel-body">
						<div id="temp-chart">
							<p>正在加载中</p>
						</div>
                            
                    </div>
                </div><!-- panel end -->
                
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <i class="glyphicon glyphicon-menu-hamburger"></i> 昨日心跳
                        <div class="pull-right">
                        <!-- Single button -->
							<div class="btn-group">
							  	<button type="button" class="btn btn-default dropdown-toggle btn-xs" data-toggle="dropdown" aria-expanded="false">
							    	查看以往数据 <span class="caret"></span>
							  	</button>
							  	<ul class="dropdown-menu" role="menu">
							    	<li><a href="#">前天</a></li>
							    	<li><a href="#">选择日期</a></li>
							    	<li class="divider"></li>
							    	<li><a href="#">查看一个月的</a></li>
							  </ul>
							</div>
                        </div>
                    </div>
                    <div class="panel-body">
						<div id="heart-chart">
							<p>正在加载中</p>
						</div>
                            
                    </div>
                </div><!-- panel end -->
                
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <i class="glyphicon glyphicon-menu-hamburger"></i> 一周睡眠时间
                        <div class="pull-right">
                        <!-- Single button -->
							<div class="btn-group">
							  	<button type="button" class="btn btn-default dropdown-toggle btn-xs" data-toggle="dropdown" aria-expanded="false">
							    	查看以往数据 <span class="caret"></span>
							  	</button>
							  	<ul class="dropdown-menu" role="menu">
							    	<li><a href="#">前天</a></li>
							    	<li><a href="#">选择日期</a></li>
							    	<li class="divider"></li>
							    	<li><a href="#">查看一个月的</a></li>
							  </ul>
							</div>
                        </div>
                    </div>
                    <div class="panel-body">
						<div id="sleep-chart">
							<p>正在加载中</p>
						</div>
                            
                    </div>
                </div><!-- panel end -->

            </div>
        </div>
        
    </div>
     <script src="public/component/morrisjs/morris.min.js"></script>
    <script src="public/component/raphael/raphael-min.js"></script>


	<script src="public/js/chartData.js"></script>
	<script>
		var temp_chart = new Chart("temp-chart", {"child_id": 2, "type" : 1});
		temp_chart.init();
		$('#data-day-1').click(function(e){
			e.preventDefault()
			temp_chart.getDataIndex(-2);
			return false;
		});
		var heart_chart = new Chart("heart-chart", {"child_id": 2, "type" : 2});
		heart_chart.init();
		var sleep_chart = new Chart("sleep-chart", {"child_id": 2, "type": 3});
		sleep_chart.init();
	</script>
	<%@ include file="/include/footer.jsp" %>