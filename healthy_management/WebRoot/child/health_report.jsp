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
				<%@ include file="/child/left.jsp" %>
				<!-- 这是日历控件 -->
                <%@ include file="/include/calendar.jsp" %>
            </div>
            <div class="col-md-9">
                <%@ include file="/include/carousel.jsp" %>

                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <i class="glyphicon glyphicon-menu-hamburger"></i> 体重（单位：千克）
                    </div>
                    <div class="panel-body">
                    	<div id="body-weight">
                    	</div>
                    </div>
                </div><!-- panel end -->
                
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <i class="glyphicon glyphicon-menu-hamburger"></i> 身高（单位：厘米）
                    </div>
                    <div class="panel-body">
                    	<div id="body-height">
                    	</div>
                    </div>
                </div><!-- panel end -->
                
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <i class="glyphicon glyphicon-menu-hamburger"></i> 体重身高比
                    </div>
                    <div class="panel-body">
                    	<div id="body-wh">
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
		var weight_data = <%=BodyData.getWeightString()%>;
		Morris.LineArea({
			element: "body-weight",
			data: weight_data, 
			xkey: 'year',
    			ykeys: ['min', 'max', 'data'],
    			labels: ['下限', '上限', '体重'],
    			pointSize: 2,
    			hideHover: false,
    			resize: true,
    			areaColor: '#ffd084',
    			lineColors: ['','','#d55731'],
    			ymax: 70,
    			ymin: 30,
    			behaveLikeLine: true,
    			parseTime: false,
    			areaLine: ['min', 'max'],
    			dateFormat: function(x){
    				//var tt_date = new Date(x);
    				//var month = tt_date.getMonth() + 1;
    				//return month + "月" + tt_date.getDate() + "日 " + tt_date.getHours() + "点" + tt_date.getMinutes() + "分";
    				return x;
    			},
    			xLabelFormat: function(x){
    				return x.label + "岁";
    			},
    			hoverCallback: function(index, options, content, row){
    				//var _content = $(content);
    				if(row.data > row.max){
    					content += "<div>您的孩子身高超过平均水平</div>";
    				}else 
    				if(row.data < row.min){
    					content += "<div>您的孩子身高没有超过平均水平,请增加营养</div>";
    				}
    				return content;
    			}
        });
        
        var height_data = <%=BodyData.getHeightString()%>;
		Morris.LineArea({
			element: "body-height",
			data: height_data, 
			xkey: 'year',
    			ykeys: ['min', 'max', 'data'],
    			labels: ['下限', '上限', '身高'],
    			pointSize: 2,
    			hideHover: false,
    			resize: true,
    			areaColor: '#ffd084',
    			lineColors: ['','','#d55731'],
    			ymax: 170,
    			ymin: 130,
    			parseTime: false,
    			behaveLikeLine: true,
    			areaLine: ['min', 'max'],
    			dateFormat: function(x){
    				//var tt_date = new Date(x);
    				//var month = tt_date.getMonth() + 1;
    				//return month + "月" + tt_date.getDate() + "日 " + tt_date.getHours() + "点" + tt_date.getMinutes() + "分";
    				return x;
    			},
    			xLabelFormat: function(x){
    				return x.label + "岁";
    			},
    			hoverCallback: function(index, options, content, row){
    				//var _content = $(content);
    				if(row.data > row.max){
    					content += "<p>您的孩子身高超过平均水平</p>";
    				}else 
    				if(row.data < row.min){
    					content += "<p>您的孩子身高没有超过平均水平,请增加营养</p>";
    				}
    				return content;
    			},
    			
        });
		
		var wh_data = <%=BodyData.getWHString()%>;
		Morris.LineArea({
			element: "body-wh",
			data: wh_data, 
			xkey: 'year',
    			ykeys: ['min', 'max', 'data'],
    			labels: ['下限', '上限', '体重身高比'],
    			pointSize: 2,
    			hideHover: false,
    			resize: true,
    			areaColor: '#ffd084',
    			lineColors: ['','','#d55731'],
    			ymax: 0.5,
    			ymin: 0,
    			parseTime: false,
    			behaveLikeLine: true,
    			areaLine: ['min', 'max'],
    			dateFormat: function(x){
    				//var tt_date = new Date(x);
    				//var month = tt_date.getMonth() + 1;
    				//return month + "月" + tt_date.getDate() + "日 " + tt_date.getHours() + "点" + tt_date.getMinutes() + "分";
    				return x;
    			},
    			xLabelFormat: function(x){
    				return x.label + "岁";
    			},
    			hoverCallback: function(index, options, content, row){
    				//var _content = $(content);
    				if(row.data > row.max){
    					content += "<p>您的孩子BMI指数超过平均水平</p>";
    				}else 
    				if(row.data < row.min){
    					content += "<p>您的孩子BMI指数没有超过平均水平,请增加营养</p>";
    				}
    				return content;
    			}
        });
	</script>
	<script>
    	changeNavList(4);
    </script>
	<%@ include file="/include/footer.jsp" %>