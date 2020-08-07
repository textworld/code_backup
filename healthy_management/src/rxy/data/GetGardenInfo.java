package rxy.data;
import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import rxy.db.Connect;
import rxy.javabean.GardenInfo;
import rxy.javabean.Information;
public class GetGardenInfo {
	public static GardenInfo findOne(int user_id){
		Connection connection = Connect.getConnection();
		String sql = "select a.*,b.GardenName from GardenDoctor a join Garden b on a.GardenID=b.GardenID where UserID = " + user_id; 
		
		GardenInfo g = new GardenInfo();
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				g.setUserID(rs.getInt("UserID"));
				g.setDoctorName(rs.getString("DoctorName"));
				g.setGardenID(rs.getInt("GardenID"));
				g.setGardenName(rs.getString("GardenName"));
				
			}
			rs.close();
			ps.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return g;
	}

}
