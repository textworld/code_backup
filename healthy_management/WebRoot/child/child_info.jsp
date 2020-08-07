<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="rxy.javabean.*" %>
<%@ page import="rxy.data.GetInformation" %>

<% Information info = GetInformation.findOne(((UserBean)session.getAttribute("user")).getId());%>

				<div class="panel panel-primary">
                    <div class="panel-heading">
                        <i class="glyphicon glyphicon-menu-hamburger"></i> 儿童
                    </div>
                    <div class="panel-body">
                        <div class="div-layer">
						     <% String imagetype="boy"; %>
						     <%if(info.getGender().equals("女")){imagetype="girl";} %>
                             <img src="./public/imgs/<%=imagetype %>.jpg" alt="" class="img-thumbnail">
                        </div>
                        <div class="div-layer">
                            <p>姓名：<span><%=info.getChildName() %></span></p>
                            <p>性别：<span><%=info.getGender() %></span></p>
                           
                            <p>出生年月：<span><%=info.getBirthDate() %></span></p>
                        </div>
                       
                    </div>
                </div>