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
import rxy.javabean.Consult;

public class AnswerServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public AnswerServlet() {
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
		request.setCharacterEncoding("UTF-8");
		
		String p_consult_id = request.getParameter("ConsultID");
		String p_reply = request.getParameter("Reply");
		if(p_consult_id == null || p_reply == null){
			request.getSession().setAttribute("error", "参数错误");
			return;
		}
		int consult_id = Integer.parseInt(p_consult_id);
		long time_n = Calendar.getInstance().getTimeInMillis() / 1000;
		Connection conn = Connect.getConnection();
		try {
			PreparedStatement ps = conn.prepareStatement("UPDATE Consult SET Reply = ? , ReplyTime = ?, " +
					" Status = ? where ConsultID = ?");
			ps.setString(1, p_reply);
			ps.setLong(2, time_n);
			ps.setInt(3, Consult.STATUS_NOT_VIEW);
			ps.setInt(4, consult_id);
			
			if( ps.executeUpdate() > 0){
				request.getSession().setAttribute("success", "答复成功");
				response.sendRedirect("social/consult.jsp");
				return;
			}else{
				request.getSession().setAttribute("error", "答复失败");
				response.sendRedirect("social/answer.jsp?ConsultID=" + consult_id);
				return;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
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
