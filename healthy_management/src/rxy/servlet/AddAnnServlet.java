package rxy.servlet;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Calendar;
import java.io.IOException;
import java.io.PrintWriter;
import rxy.javabean.*;
import rxy.data.*;
import rxy.db.Connect;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AddAnnServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public AddAnnServlet() {
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
		request.setCharacterEncoding("utf-8");
		String p_ann_id = request.getParameter("ann_id");
		
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

		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		GardenInfo ginfo = GetGardenInfo.findOne(((UserBean)request.getSession().getAttribute("user")).getId());
		Integer doctorID=ginfo.getUserID();
		String memo=request.getParameter("Contents");
		Calendar now = Calendar.getInstance();
		String year=(now.get(Calendar.YEAR)+"-");  
        String month=(now.get(Calendar.MONTH) + 1+"-");  
        String day=( now.get(Calendar.DAY_OF_MONTH)+" ");  
        String hour=( now.get(Calendar.HOUR_OF_DAY)+":");  
        String min=(  now.get(Calendar.MINUTE)+":");  
        String sec=( now.get(Calendar.SECOND)+" "); 
		String time=year+month+day+hour+min+sec;
		Connection connection = Connect.getConnection();
		PreparedStatement ps=null;
		try {
			ps = connection.prepareStatement("insert into Announce values(?,?,?)");
			ps.setInt(1, doctorID);
			ps.setString(2, memo);
			ps.setString(3,time);
			
			ps.executeUpdate();
			System.out.println("�����ɹ�");
			
			request.getSession().setAttribute("success", "����ɹ�");
			//out.println("<a href=\"" + request.getHeader("Referer") + "\">���������һҳ</a>");
			response.sendRedirect("garden/ann_manage.jsp");
			//request.getRequestDispatcher("titleManger.jsp").forward(request, response);
			
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
