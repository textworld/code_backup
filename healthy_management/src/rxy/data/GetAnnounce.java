package rxy.data;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import rxy.db.Connect;
import rxy.javabean.Announcement;
public class GetAnnounce {
	public static List<Announcement> getAnnouncements(int garden_id, int page, int page_size){
		Connection conn = Connect.getConnection();
		List<Announcement> list_ann = new ArrayList<Announcement>();
		try {
			PreparedStatement ps = conn.prepareStatement("select top " + page_size +" * from Announce as a join GardenDoctor as g "  +
					"on a.GardenDoctorID = g.UserID where a.GardenDoctorID in "+
					"(select g.UserID from GardenDoctor where GardenID = ?) " +
					"and AnnounceID not in "+
					"(select top "+page_size * (page - 1) + " AnnounceID from Announce as a "+
					"join GardenDoctor as g on a.GardenDoctorID = g.UserID where a.GardenDoctorID in "+
					"(select g.UserID from GardenDoctor where GardenID = ? ) order by a.AnnounceID DESC) " +
					"order by a.AnnounceID DESC");
			ps.setInt(1, garden_id);
			ps.setInt(2, garden_id);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				Announcement ann = new Announcement();
				ann.setDoctorName(rs.getString("DoctorName"));
				ann.setContents(rs.getString("Contents"));
				ann.setTime(rs.getString("Time"));
				list_ann.add(ann);
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("get Announce wrong");
		}

		return list_ann;
	}
	
	public static int GetAnnCount(int child_id){
		Connection conn = Connect.getConnection();
		try {
			PreparedStatement ps = conn.prepareStatement("select COUNT(*) from Announce as a join GardenDoctor as g "  +
						"on a.GardenDoctorID = g.UserID where a.GardenDoctorID in "+
						"(select g.UserID from GardenDoctor where GardenID = ?) ");
			ps.setInt(1, child_id);
			ResultSet rs = ps.executeQuery();
			int count = 0;
			while(rs.next()){
				count = rs.getInt(1);
			}
			return count;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("Ann count failure");
			e.printStackTrace();
		}
		return 0;
	}
	
	public static Announcement findOne(int ann_id){
		Connection conn = Connect.getConnection();
		Announcement ann = new Announcement();
		try {
			PreparedStatement ps = conn.prepareStatement("select * from Announce as a join GardenDoctor as g on a.GardenDoctorID = g.UserID where a.AnnounceID = ?");
			ps.setInt(1, ann_id);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				ann.setAnnounce(rs.getInt("AnnounceID"));
				ann.setContents(rs.getString("Contents"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("Announcement findOne Exception");
			e.printStackTrace();
		}
		return ann;
	}
	
}
