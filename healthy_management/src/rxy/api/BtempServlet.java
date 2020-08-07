package rxy.api;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import rxy.javabean.DataBean;

public class BtempServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public BtempServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int child_id = Integer.parseInt(request.getParameter("child_id"));
		System.out.println("Child_id :" + child_id);
		int l_time = Integer.parseInt(request.getParameter("time"));
		String data = request.getParameter("data");
		int type = Integer.parseInt(request.getParameter("type"));
		DataBean dbean = new DataBean();
		dbean.setChild_id(child_id);
		dbean.setTime(l_time);
		dbean.setData(data);
		dbean.setType(type);
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		if(dbean.insertToDB()){
			out.println(1);
		}else{
			out.println(0);
		}
		out.flush();
		out.close();
	}


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
