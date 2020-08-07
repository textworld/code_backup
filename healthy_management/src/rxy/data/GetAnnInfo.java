package rxy.data;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import rxy.db.Connect;
import rxy.javabean.*;

public class GetAnnInfo {
	
	public static List<AnnInfo> find(int child_id,int page){
		Connection connection = Connect.getConnection();
		List<AnnInfo> list = new ArrayList<AnnInfo>();	
		
		PreparedStatement ps = null;
		try {
			ps = connection.prepareStatement("select top " + AnnInfo.PAGE_SIZE +" a.Contents,a.Time,a.AnnounceID,b.DoctorName from Announce " +
												"as a join GardenDoctor  as b on b.UserID = a.GardenDoctorID " + 
												"where a.GardenDoctorID = ? and a.AnnounceID not in "+ 
												"(select top " + (page-1)*AnnInfo.PAGE_SIZE +" a.AnnounceID from Announce as a join GardenDoctor "+ 
												"on b.UserID = a.GardenDoctorID  where a.GardenDoctorID = ? order by a.AnnounceID DESC) "+
												"order by a.AnnounceID DESC");
			ps.setInt(1, child_id);
			ps.setInt(2, child_id);
			System.out.println(ps.toString());
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				AnnInfo a = new AnnInfo();
				a.setAnnID(rs.getInt("AnnounceID"));
				a.setDoctorName(rs.getString("DoctorName"));
				a.setMemo(rs.getString("Contents"));
				a.setTime(rs.getString("Time"));
				list.add(a);
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			System.out.println("GetAnnounce wrong");
			e.printStackTrace();
		} 
		return list;
	}
	
	
	
	public static int findCount(int doctor_id){
		int count = 0;
		Connection connection = Connect.getConnection();
		PreparedStatement ps = null;
		try {
			ps = connection.prepareStatement("select COUNT(*) from Announce where GardenDoctorID = ?");
			ps.setInt(1, doctor_id);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				count = rs.getInt(1);
			}
			rs.close();
		} catch (SQLException e) {
			System.out.println("Announce count wrong");
			e.printStackTrace();
		}
		return count;
	}

}
