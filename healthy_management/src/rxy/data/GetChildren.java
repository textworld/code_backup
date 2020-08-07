package rxy.data;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import rxy.db.Connect;
import rxy.javabean.Diagnosis;
import rxy.javabean.Information;

public class GetChildren {
	private int page;
	private int page_size = 3;
	private int doctor_id;
	
	public GetChildren(int page){
		this.page = page;
	}
	
	public GetChildren(){
		this(1);
	}
	
	public List<Information> getData(int doctor_id){
		Connection conn = Connect.getConnection();
		this.doctor_id = doctor_id;
		try{
			PreparedStatement ps = conn.prepareStatement("select top " + this.page_size +" a.* from  ChildInfo " +
					"as a where a.SocialDoctorID = ? and a.UserID not in "+ 
					"(select top " + (page-1)*this.page_size +" a.UserID from ChildInfo as a "+ 
					" where a.SocialDoctorID = ? order by a.UserID ) "+
					"order by a.UserID ");
			ps.setInt(1, doctor_id);
			ps.setInt(2, doctor_id);
			ResultSet rs = ps.executeQuery();
			List<Information> list = new ArrayList<Information>();
			while(rs.next()){
				Information info = new Information();
				info.setField(rs);
				list.add(info);
			}
			ps.close();
			rs.close();
			return list;
		}catch(SQLException e){
			e.printStackTrace();
			return null;
		}
	}
	
	public int getPaging(){
		Connection conn = Connect.getConnection();
		try{
			PreparedStatement ps = conn.prepareStatement("select count(*) from ChildInfo where SocialDoctorID = ?");
			ps.setInt(1, doctor_id);
			ResultSet rs = ps.executeQuery();
			int count = 0;
			if(rs.next()){
				count = rs.getInt(1);
			}
			rs.close();
			ps.close();
			return count;				
		}catch(SQLException e){
			e.printStackTrace();
			return 0;
		}
	}
	
	public int getPageSize(){
		return page_size;
	}
	
	public static String getStatus(int child_id){
		Connection conn = Connect.getConnection();
		Calendar cal = Calendar.getInstance();
		Long t_now = cal.getTimeInMillis() / 1000;
		cal.add(Calendar.DATE, -1);
		cal.set(Calendar.HOUR, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		Long t_yesterday = cal.getTimeInMillis() / 1000;
		try {
			PreparedStatement ps = conn.prepareStatement("select DISTINCT Status from Data where Time >= ? and Time < ? " +
														"and ChildID = ? and Status <> '健康'");
			ps.setLong(1, t_yesterday);
			ps.setLong(2, t_now);
			ps.setInt(3, child_id);
			System.out.println("select DISTINCT Status from Data where Time >= " +t_yesterday +" and Time < " + t_now+
														"and ChildID = " + child_id);
			ResultSet rs = ps.executeQuery();
			StringBuffer sb = new StringBuffer();
			boolean has_data = false;
			while(rs.next()){
				has_data = true;
				sb.append(rs.getString(1) + ";");
			}
			if(has_data){
				return sb.toString();
			}else{
				return "健康";
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "健康";
	}
	
}
