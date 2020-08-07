<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="rxy.javabean.UserBean" %>
<% 
	/* 这里是为了判断用户的type，如果不是type 1的用户就不能访问，措施是暂时跳到登录页 */
	/* 这段代码，child的每个页面都需要include */
	{UserBean _user = (UserBean)session.getAttribute("user");
	if(_user== null || _user.getType() != UserBean.GARDEN_DOC)
	{
		System.out.println("Auth: usertype is not fit!");
		response.sendRedirect(request.getContextPath() + "/login.jsp");
		return;
	}}	
%>