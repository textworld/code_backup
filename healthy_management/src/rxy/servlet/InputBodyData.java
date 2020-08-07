package rxy.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import rxy.db.Connect;
import rxy.javabean.DataBean;

public class InputBodyData extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public InputBodyData() {
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

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out
				.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
		out.println("  <BODY>");
		out.print("    This is ");
		out.print(this.getClass());
		out.println(", using the GET method");
		out.println("  </BODY>");
		out.println("</HTML>");
		out.flush();
		out.close();
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
		String p_child_id = request.getParameter("child_id");
		String data_head = request.getParameter("data_head");
		String data_body = request.getParameter("data_body");
		String data_height = request.getParameter("data_height");
		String data_weight = request.getParameter("data_weight");
		if(p_child_id == null || data_head == null || data_body == null || data_height == null || data_weight == null){
			request.getSession().setAttribute("error", "参数错误");
			response.sendRedirect("child/input.jsp");
			
			return;
		}
		
		int child_id = Integer.parseInt(p_child_id);
		Connection conn = Connect.getConnection();
		try {
			Calendar cal = Calendar.getInstance();
			Long time_now = cal.getTimeInMillis() / 1000;
			PreparedStatement ps = conn.prepareStatement("insert into Data values(?, ?, ?, ?, '')");
			ps.setInt(1, child_id);
			ps.setLong(2, time_now);
			ps.setString(3, data_head);
			ps.setInt(4, DataBean.TYPE_HEAD);
			ps.executeUpdate();
			ps.close();
			ps = conn.prepareStatement("insert into Data values(?, ?, ?, ?, '')");
			ps.setInt(1, child_id);
			ps.setLong(2, time_now);
			ps.setString(3, data_body);
			ps.setInt(4, DataBean.TYPE_BODY);
			ps.executeUpdate();
			ps.close();
			ps = conn.prepareStatement("insert into Data values(?, ?, ?, ?, '')");
			ps.setInt(1, child_id);
			ps.setLong(2, time_now);
			ps.setString(3, data_height);
			ps.setInt(4, DataBean.TYPE_HEIGHT);
			ps.executeUpdate();
			ps.close();
			ps = conn.prepareStatement("insert into Data values(?, ?, ?, ?, '')");
			ps.setInt(1, child_id);
			ps.setLong(2, time_now);
			ps.setString(3, data_weight);
			ps.setInt(4, DataBean.TYPE_WEIGHT);
			ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("insert body data wrong");
		}
		request.getSession().setAttribute("success", "发表成功");
		response.sendRedirect("child/health_report.jsp");
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
