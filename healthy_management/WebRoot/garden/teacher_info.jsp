<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="rxy.javabean.*" %>
<%@ page import="rxy.data.GetGardenInfo" %>

<% GardenInfo gfo = GetGardenInfo.findOne(((UserBean)session.getAttribute("user")).getId());%>
				<div class="panel panel-primary">
                    <div class="panel-heading">
                        <i class="glyphicon glyphicon-menu-hamburger"></i> 老师
                    </div>
                    <div class="panel-body">
 						<div class="div-layer">
						    
                             <img src="./public/imgs/gardendoctor.jpg" alt="" class="img-thumbnail">
                        </div>
                        <div class="div-layer">
                            <p>姓名：<span><%=gfo.getDoctorName()%></span></p>
                            <p>幼儿园：<span><%=gfo.getGardenName()%></span></p>
                           
                        </div>
                    </div>
                </div>