package rxy.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import rxy.data.GetDiagnosis;
import rxy.javabean.Diagnosis;
import rxy.javabean.UserBean;

import java.util.List;


public class FindDiag extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public FindDiag() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		UserBean user = (UserBean)request.getSession().getAttribute("user");
		int currPage = 1; 		
		if(request.getParameter("page") != null){
			currPage = Integer.parseInt(request.getParameter("page"));
		}
		System.out.println("currentPage :" + currPage);
		System.out.println("userid :" + user.getId());
		List<Diagnosis> list = GetDiagnosis.find(user.getId(),currPage);
		request.setAttribute("list", list);
		int pages ; 		
		int count = GetDiagnosis.findCount(user.getId());	
		if(count % Diagnosis.PAGE_SIZE == 0){
			pages = count / Diagnosis.PAGE_SIZE; 
		}else{
			pages = count / Diagnosis.PAGE_SIZE + 1; 
		}
		StringBuffer sb = new StringBuffer();
		for(int i=1; i <= pages; i++){
			if(i == currPage){
				sb.append("<li class=\"active\"><a href='FindDiag?page=" + i + "'>" + i + "</a></li>");
			}else{
				sb.append("<li><a href='FindDiag?page=" + i + "'>" + i + "</a></li>");
			}
			sb.append("  ");
		}
		request.setAttribute("bar", sb.toString());
		request.getRequestDispatcher("/child/newDiag.jsp").forward(request, response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out
				.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
		out.println("  <BODY>");
		out.print("    This is ");
		out.print(this.getClass());
		out.println(", using the POST method");
		out.println("  </BODY>");
		out.println("</HTML>");
		out.flush();
		out.close();
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
