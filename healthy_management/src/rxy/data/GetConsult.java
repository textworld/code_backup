package rxy.data;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import rxy.db.Connect;
import rxy.javabean.Consult;
import rxy.javabean.Picture;

public class GetConsult {
	public static List<Consult> getConsult(String field, int id, int page, int page_size){
		Connection conn = Connect.getConnection();
		List<Consult> list = new ArrayList<Consult>();
		try {
			PreparedStatement ps = conn.prepareStatement("select top " + page_size +" * from Consult as c join SocialDoctor as s " +
										"on c.DoctorID = s.UserID where c." +  field +" = ? and ConsultID not in "+
										"(select top " + (page-1) * page_size +" c.ConsultID from Consult as c" +
										" where c." +  field +" = ? order by ConsultID DESC) order by ConsultID DESC");
			ps.setInt(1, id);
			ps.setInt(2, id);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				Consult consult = new Consult();
				consult.setConsultID(rs.getInt("ConsultID"));
				consult.setChildID(rs.getInt("ChildID"));
				consult.setContents(rs.getString("Contents"));
				consult.setDoctorID(rs.getInt("DoctorID"));
				consult.setStatus(rs.getInt("Status"));
				consult.setReply(rs.getString("Reply"));
				consult.setTime(rs.getLong("Time"));
				consult.setReplyTime(rs.getLong("ReplyTime"));
				list.add(consult);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("GetConsult");
			e.printStackTrace();
		}
		return list;
	}
	
	public static List<Picture> getPictures(int consultID){
		List<Picture> list = new ArrayList<Picture>();
		Connection conn = Connect.getConnection();
		try {
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM Picture as p join ConsultImg as c " +
					"on p.PictureID = c.ImgID where c.ConsultID = ? ");
			ps.setInt(1, consultID);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				Picture p = new Picture();
				p.setPictureID(rs.getInt("PictureID"));
				p.setFullName(rs.getString("FullName"));
				list.add(p);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	
	public static int getPaing(String field, int id){
		Connection conn = Connect.getConnection();
		PreparedStatement ps;
		int num = 0;
		try {
			ps = conn.prepareStatement("select COUNT(*) from Consult where " +field+ " = ?");
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();

			while(rs.next()){
				num = rs.getInt(1);
			}
			System.out.println("Garden Child num " + num);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return num;
	}
	
	public static Consult getConsutById(int ConsultID){
		Connection conn = Connect.getConnection();
		Consult consult = new Consult();
		try {
			PreparedStatement ps = conn.prepareStatement("select  * from Consult as c join ChildInfo as s " +
										"on c.ChildID = s.UserID where c.ConsultID = ? ");
			ps.setInt(1, ConsultID);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){

				consult.setConsultID(rs.getInt("ConsultID"));
				consult.setChildID(rs.getInt("ChildID"));
				consult.setContents(rs.getString("Contents"));
				consult.setDoctorID(rs.getInt("DoctorID"));
				consult.setStatus(rs.getInt("Status"));
				consult.setReply(rs.getString("Reply"));
				consult.setTime(rs.getLong("Time"));
				consult.setReplyTime(rs.getLong("ReplyTime"));
				consult.setChildName(rs.getString("ChildName"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("GetConsult");
			e.printStackTrace();
		}
		return consult;
	}
	
	public static void readById(int ConsultID){
		Connection conn = Connect.getConnection();
		Consult consult = new Consult();
		try {
			PreparedStatement ps = conn.prepareStatement("UPDATE Consult SET Status = ? where ConsultID = ?");
			ps.setInt(1, Consult.STATUS_VIEWED);
			ps.setInt(2, ConsultID);
			if(ps.executeUpdate() == 0){
				System.out.println("update read failure");
			}else{
				System.out.println("update read " + ConsultID + " success");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("GetConsult");
			e.printStackTrace();
		}
	}
}
