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
                <div class="panel-heading"> <i class="glyphicon glyphicon-menu-hamburger"></i> 发烧人数：
                </div>
                <div class="panel-body">
                	<div id="week_report_num"></div>
                	
                </div>
            </div><!-- panel end -->
            
            <div class="panel panel-primary">
                <div class="panel-heading"> <i class="glyphicon glyphicon-menu-hamburger"></i> 发烧率：
                <div class="pull-right">
                	<i class="glyphicon glyphicon-exclamation-sign"></i> 发烧率已经超过红色警戒线
                </div>
                </div>
                <div class="panel-body">
                	<div id="week_temp_percent"></div>
                	
                </div>
            </div><!-- panel end -->  
            
            <div class="panel panel-primary">
                <div class="panel-heading"> <i class="glyphicon glyphicon-menu-hamburger"></i> 就诊人数：
                <div class="pull-right">
                	<i class="glyphicon glyphicon-exclamation-sign"></i> 就诊人数有逐渐上升的趋势
                </div>
                </div>
                <div class="panel-body">
                	<div id="week_check_num"></div>
                	
                </div>
            </div><!-- panel end -->
            
            <div class="panel panel-primary">
                <div class="panel-heading"> <i class="glyphicon glyphicon-menu-hamburger"></i> 就诊率：
                </div>
                <div class="panel-body">
                	<div id="week_check_percent"></div>
                	
                </div>
            </div><!-- panel end -->  

		</div>
    </div>
        <script>
    	changeNavList(2);
    </script>

</div>     <script src="public/component/morrisjs/morris.js"></script>
    <script src="public/component/raphael/raphael-min.js"></script>
 <script>
    
		$(function(){
				Morris.Bar({
					element: 'week_report_num',
					data: 
					[   		
		 				{"period": "周一", "num": 2},
		 				{"period": "周二", "num": 0},
		 				{"period": "周三", "num": 1},
		 				{"period": "周四", "num": 3},
		 				{"period": "周五", "num": 4},
		 				{"period": "周六", "num": 3},
		 				{"period": "周日", "num": 5},
					], 
					xkey: 'period',
	    			ykeys: ['num'],
	    			labels: ['发烧人数'],
	    			pointSize: 3,
	    			hideHover: false,
	    			resize: true,
	    			parseTime: false,
	    			barColors: ['#d55731'],
	    			ymax: 30,
	    			ymin: 0,
		 		});
		 		
		 		Morris.Line({
		 			element: 'week_temp_percent',
		 			data:
		 			[
		 				{"period": "周一", "num": 6.7},
		 				{"period": "周二", "num": 0},
		 				{"period": "周三", "num": 3.3},
		 				{"period": "周四", "num": 10},
		 				{"period": "周五", "num": 13.3},
		 				{"period": "周六", "num": 10},
		 				{"period": "周日", "num": 16.7},
		 			],
		 			xkey: "period",
		 			ykeys: ['num'],
	    			labels: ['发烧率'],
		 			pointSize: 3,
		 			hideHover: false,
		 			resize: true,
		 			parseTime: false,
		 			ymax: 30,
		 			ymin: 0,
		 			goals: [10],
		 			goalStrokeWidth: 2,
		 			lineColors: ['#ff8519'],
					yLabelFormat: function(y){
						return y.toString() + "%";
					}
		 		});
		 		
		 		Morris.Bar({
					element: 'week_check_num',
					data: 
					[   		
		 				{"period": "周一", "num": 4},
		 				{"period": "周二", "num": 2},
		 				{"period": "周三", "num": 4},
		 				{"period": "周四", "num": 6},
		 				{"period": "周五", "num": 7},
		 				{"period": "周六", "num": 4},
		 				{"period": "周日", "num": 7},
					], 
					
					barColors: ['#d55731'],
					xkey: 'period',
	    			ykeys: ['num'],
	    			labels: ['就诊人数'],
	    			pointSize: 3,
	    			hideHover: false,
	    			resize: true,
	    			parseTime: false,
	    			ymax: 30,
	    			ymin: 0,
		 		});
		 		
		 		Morris.Line({
		 			element: 'week_check_percent',
		 			data:
		 			[
		 				{"period": "周一", "num": 10},
		 				{"period": "周二", "num": 13},
		 				{"period": "周三", "num": 12},
		 				{"period": "周四", "num": 12},
		 				{"period": "周五", "num": 15},
		 				{"period": "周六", "num": 18},
		 				{"period": "周日", "num": 21},
		 			],
		 			xkey: "period",
		 			ykeys: ['num'],
	    			labels: ['发烧率'],
	    			lineColors: ['#3d3d3d'],
		 			pointSize: 3,
		 			hideHover: false,
		 			resize: true,
		 			parseTime: false,
		 			ymax: 30,
		 			ymin: 0,
					yLabelFormat: function(y){
						return y.toString() + "%";
					}
		 		});
		});
	</script>
<%@ include file="/include/footer.jsp" %>