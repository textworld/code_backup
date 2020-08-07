<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="rxy.javabean.*" %>
<div class="panel panel-primary">
    <div class="panel-heading">
        <i class="glyphicon glyphicon-menu-hamburger"></i> 日历
    </div>
    <div class="panel-body">
    	
        <div id="rxy-calendar"></div>
        <%if(((UserBean)session.getAttribute("user")).getType() == 0){%>
    		<p style="text-align:center">红色的表示那天孩子发烧了</p>
    	<%} %>
    </div>
</div>