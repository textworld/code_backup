package rxy.data;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import rxy.db.Connect;
import rxy.javabean.Information;

public class GetGardenChildren {
	public static List<Information> getData(int garden_doctor_id, int page, int page_size){
		Connection conn = Connect.getConnection();
		List<Information> list = new ArrayList<Information>();
		try {
			PreparedStatement ps = conn.prepareStatement("select top " + page_size +"* from ChildInfo where GardenDoctorID = ? and UserID not in "+
														"(select top " + (page-1) * page_size +" UserID from ChildInfo where GardenDoctorID = ? )");
			ps.setInt(1, garden_doctor_id);
			ps.setInt(2, garden_doctor_id);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				Information info = new Information();
				info.setChildInfo(rs);
				list.add(info);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("GetGardenChild");
			e.printStackTrace();
		}
		return list;
	}
	
	public static int getPaing(int garden_doctor_id){
		Connection conn = Connect.getConnection();
		PreparedStatement ps;
		int num = 0;
		try {
			ps = conn.prepareStatement("select COUNT(*) from ChildInfo where GardenDoctorID = ?");
			ps.setInt(1, garden_doctor_id);
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
}
