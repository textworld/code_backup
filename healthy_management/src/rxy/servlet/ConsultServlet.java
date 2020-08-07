package rxy.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import rxy.db.Connect;
import rxy.javabean.Consult;

public class ConsultServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public ConsultServlet() {
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
		Consult consult = new Consult();
		try {
			consult.setData(request, Consult.TYPE_CONSULT);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("ConsultServlet: 传数据不全");
			e.printStackTrace();
			
			return;
		}
		
		Connection conn = Connect.getConnection();
		try {
			PreparedStatement ps = conn.prepareStatement("INSERT INTO Consult VALUES(?, ?, ?,  ?, '',?,0)", Statement.RETURN_GENERATED_KEYS);
			ps.setInt(1, consult.getChildID());
			ps.setInt(2, consult.getDoctorID());
			ps.setString(3, consult.getContents());
			ps.setInt(4, consult.getStatus());
			ps.setLong(5, consult.getTime());
			if(ps.executeUpdate() == 0){
				request.getSession().setAttribute("error", "插入失败");
				
			}else{
				ResultSet rs = ps.getGeneratedKeys();
				int remote_id = 0;
				while(rs.next()){
					remote_id = rs.getInt(1);
				}
				String[] imgs = request.getParameterValues("Imgs");
				if(imgs != null){
					for(int i = 0; i < imgs.length; i++){
						try {
							saveImg(remote_id, Integer.parseInt(imgs[i]));
						} catch (NumberFormatException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
							request.getSession().setAttribute("error", e.getMessage());
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
							request.getSession().setAttribute("error", e.getMessage());
						}
					}
				}
				request.getSession().setAttribute("success", "发表成功");
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			request.getSession().setAttribute("error", e.getMessage());
		}
		
		response.sendRedirect("child/consult.jsp");
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}
	
	public void saveImg(int remote_id, int img_id) throws Exception{
		Connection conn = Connect.getConnection();
		if(conn == null){
			throw new Exception("数据库连接失败");
		}
		PreparedStatement ps = conn.prepareStatement("INSERT INTO ConsultImg VALUES(?, ?)");
		if(remote_id != 0){
			ps.setInt(1, remote_id);
			ps.setInt(2, img_id);
			int row = ps.executeUpdate();
			if(row != 1){
				throw new Exception("插入 Remote img 失败");
			}
		}else{
			throw new Exception("Remote ID NULL");
		}
	}

}
