package rxy.javabean;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import rxy.db.Connect;
public class UserBean {
	private int id;
	private String mail;
	private String psw;
	private int type;
	public static int GARDEN_DOC = 2;
	
	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getMail() {
		return mail;
	}


	public void setMail(String mail) {
		this.mail = mail;
	}


	public String getPsw() {
		return psw;
	}


	public void setPsw(String psw) {
		this.psw = psw;
	}



	public int getType() {
		return type;
	}


	public void setType(int type) {
		this.type = type;
	}

	public void fillField(HttpServletRequest request) throws Exception{
		String mail = request.getParameter("mail");
		String psw = request.getParameter("psw");
		String type = request.getParameter("type");
		if(mail == null || psw == null || type == null){
			throw new Exception("鏌愪釜瀛楁娌℃湁鍊�");
		}
		setMail(mail);
		setPsw(psw);
		setType(Integer.parseInt(type));
	}
	
	public boolean loginOK(){
		    Connection connect = Connect.getConnection();
		
		    if(connect == null) { 
		    	System.out.println("connect == null");

		    	}
		    else{
		    	System.out.println("yes");
		    }

		    boolean login=false;
			PreparedStatement ps=null;
			ResultSet rs=null;
			try {
				
				System.out.println(mail); 
				System.out.println(psw);
				System.out.println(type);
				ps=connect.prepareStatement("select * from UserPeople where mail=? and password=? and type=?");
				
				ps.setString(1,mail);
				ps.setString(2,psw);
				ps.setInt(3,type);
				rs=ps.executeQuery();
				if (rs.next()){
					login=true;
					setId(rs.getInt("UserID"));
					}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			return login;
	}
		


}
