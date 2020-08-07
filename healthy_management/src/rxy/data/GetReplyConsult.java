package rxy.data;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import rxy.db.Connect;
import rxy.javabean.Consult;

public class GetReplyConsult {
	public static List<Consult> getConsult(String field, int id, int status){
		Connection conn = Connect.getConnection();
		List<Consult> list = new ArrayList<Consult>();
		try {
			PreparedStatement ps = conn.prepareStatement("select  * from Consult as c join ChildInfo as s " +
										"on c.ChildID = s.UserID where c." +  field +" = ? and c.status = ? order by c.ConsultID DESC");
			System.out.println("select  * from Consult as c join SocialDoctor as s " +
										"on c.DoctorID = s.UserID where c." +  field +" = ? and c.status = ? order by c.ConsultID DESC");
			ps.setInt(1, id);
			ps.setInt(2, status);
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
				consult.setChildName(rs.getString("ChildName"));
				list.add(consult);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("GetConsult");
			e.printStackTrace();
		}
		return list;
	}
}
