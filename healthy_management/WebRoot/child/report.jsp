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
				<%@ include file="/child/left.jsp" %>
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
							  		<li><a href="#" id="temp-day-yesterday">昨天</a></li>
							    	<li><a href="#" id="temp-day-2">前天</a></li>
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
							    	<li><a href="#" id="heart-day-yesterday">昨天</a></li>
							    	<li><a href="#" id="heart-day-2">前天</a></li>
							    	<li><a href="#">选择日期</a></li>
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
							    	<li><a href="#" id="sleep-day-yesterday">昨天</a></li>
							    	<li><a href="#" id="sleep-day-2">前天</a></li>
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
     <script src="public/component/morrisjs/morris.js"></script>
    <script src="public/component/raphael/raphael-min.js"></script>


	<script src="public/js/chartData.js"></script>
	<script>
		var temp_chart = new Chart("temp-chart", {"child_id": 2, "type" : 1});
		temp_chart.init();
		$('#temp-day-2').click(function(e){
			e.preventDefault()
			temp_chart.getDataIndex(-1);
			return false;
		});
		$('#temp-day-yesterday').click(function(e){
			e.preventDefault();
			temp_chart.getDataIndex(0);
			return false;
		});
		var heart_chart = new Chart("heart-chart", {"child_id": 2, "type" : 2});
		heart_chart.init();
		$('#heart-day-2').click(function(e){
			e.preventDefault()
			heart_chart.getDataIndex(-1);
			return false;
		});
		$('#heart-day-yesterday').click(function(e){
			e.preventDefault();
			heart_chart.getDataIndex(0);
			return false;
		});
		var sleep_chart = new Chart("sleep-chart", {"child_id": 2, "type": 3, "week": 1});
		sleep_chart.init();
		$('#sleep-day-2').click(function(e){
			e.preventDefault()
			sleep_chart.getDataIndex(-7);
			return false;
		});
		$('#sleep-day-yesterday').click(function(e){
			e.preventDefault();
			sleep_chart.getDataIndex(-1);
			return false;
		});
	</script>
	<script>
    	changeNavList(2);
    </script>
	<%@ include file="/include/footer.jsp" %>