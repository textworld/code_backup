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

public class WriteDiagnosis extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public WriteDiagnosis() {
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
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		String p_doctor_id = request.getParameter("doctor_id");
		String p_child_id = request.getParameter("child_id");
		String p_content = request.getParameter("content");
		if( p_doctor_id == null || p_child_id == null || p_content == null){
			out.println("some parameters are null");
			out.flush();
			out.close();
			return;
		}
		int doctor_id = Integer.parseInt(p_doctor_id);
		int child_id = Integer.parseInt(p_child_id);
		
		Connection conn = Connect.getConnection();
		Calendar cal = Calendar.getInstance();
		String time = cal.get(Calendar.YEAR) + "年" + (cal.get(Calendar.MONTH)+1) + "月" + cal.get(Calendar.DATE) + "日" +
						cal.get(Calendar.HOUR) + "点" + cal.get(Calendar.MINUTE) + "分";
		try {
			PreparedStatement ps = conn.prepareStatement("insert into Diagnosis values(?, ?, ?, ?)");
			ps.setInt(1, child_id);
			ps.setInt(2, doctor_id);
			ps.setString(3, time);
			ps.setString(4, p_content);
			ps.executeUpdate();
			request.getSession().setAttribute("success", "发表成功");
			response.sendRedirect(request.getContextPath() + "/social/diagnosis.jsp?child_id=" + child_id);
			return;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("插入诊断书失败!");
			e.printStackTrace();
		}
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
