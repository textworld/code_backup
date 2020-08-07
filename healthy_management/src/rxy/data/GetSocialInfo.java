package rxy.data;
import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import rxy.db.Connect;
import rxy.javabean.*;

public class GetSocialInfo {
	public static SocialInfo findOne(int user_id){
		Connection connection = Connect.getConnection();
		String sql = "select a.*,b.SocialName from SocialDoctor a join Social b on a.social_id=b.SocialID where UserID = " + user_id; 
		
		SocialInfo s = new SocialInfo();
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				s.setUserID(rs.getInt("UserID"));
				s.setDoctorName(rs.getString("DoctorName"));
				s.setSocialID(rs.getInt("social_id"));
				s.setSocialName(rs.getString("SocialName"));
				
			}
			rs.close();
			ps.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return s;
	}
	
	
	public static List<SocialInfo> find(int doctor_id,int page){
		Connection connection = Connect.getConnection();
		List<SocialInfo> list = new ArrayList<SocialInfo>();	
		
		PreparedStatement ps = null;
		try {
			ps = connection.prepareStatement("select top " + SocialInfo.PAGE_SIZE +" a.* from ChildInfo " +
												"as a join SocialDoctor  as b on a.SocialDoctorID = b.UserID " + 
												"where b.UserID = ? and a.UserID not in "+ 
												"(select top " + (page-1)*SocialInfo.PAGE_SIZE +" a.UserID from ChildInfo as a join SocialDoctor as b "+ 
												"on b.UserID = a.SocialDoctorID  where b.UserID = ? order by a.UserID DESC) "+
												"order by a.UserID DESC");
			ps.setInt(1, doctor_id);
			ps.setInt(2, doctor_id);
			System.out.println(ps.toString());
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				SocialInfo s = new SocialInfo();
				s.setChildID(rs.getInt("ChildID"));
				s.setChildName(rs.getString("ChildName"));
				list.add(s);
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			System.out.println("GetChildID wrong");
			e.printStackTrace();
		} 
		return list;
	}
	
	
	
	public static int findCount(int doctor_id){
		int count = 0;
		Connection connection = Connect.getConnection();
		PreparedStatement ps = null;
		try {
			ps = connection.prepareStatement("select COUNT(*) from ChildInfo where SocialDoctorID = ?");
			ps.setInt(1, doctor_id);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				count = rs.getInt(1);
			}
			rs.close();
		} catch (SQLException e) {
			System.out.println("ChildID count wrong");
			e.printStackTrace();
		}
		return count;
	}
	

}
