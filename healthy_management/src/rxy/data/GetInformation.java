package rxy.data;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import rxy.db.Connect;
import rxy.javabean.Information;
public class GetInformation {
	
	public  static  List<Information> find(){
		List<Information> list = new ArrayList<Information>();	
		Connection connection = Connect.getConnection();
		String sql = "select ChildName,Gender ,BirthDate ,HomeAddress ,Phone,b.*  from Children as a join Children_Parent as b on a.ChildrenID=b.ChildID where mail = '1159312973@qq.com'";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				Information i = new Information();
				i.setChildName(rs.getString("ChildName"));
				i.setGender(rs.getString("Gender"));
				list.add(i);
				
			
			}
			rs.close();
			ps.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public static Information findOne(int user_id){
		Connection connection = Connect.getConnection();
		String sql = "select * from ChildInfo where UserID = " + user_id;  
		Information i = new Information();
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				i.setChildName(rs.getString("ChildName"));
				i.setGender(rs.getString("Gender"));
				i.setBirthDate(rs.getString("Birthdate"));
				i.setHomeAddress(rs.getString("FamilyAddress"));
				i.setPhone(rs.getString("Phone"));
				i.setFatherName(rs.getString("FatherName"));
				i.setFatherJob(rs.getString("FatherJob"));
				i.setFatherPhone(rs.getString("FatherTel"));
				i.setMatherName(rs.getString("MotherName"));
				i.setMatherJob(rs.getString("MotherJob"));
				i.setMatherPhone(rs.getString("MotherTel"));
				i.setGardenID(rs.getInt("GardenID"));
				i.setSocialID(rs.getInt("SocialID"));
				i.setDoctorID(rs.getInt("SocialDoctorID"));
			}
			rs.close();
			ps.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return i;
	}
	
	
	private static Long t_now;
	private static Long t_yes;
	public static List<Information> findChildNotHealth(int garden_doctor_id, int page, int page_size){
		Connection conn = Connect.getConnection();
		Calendar cal = Calendar.getInstance();
		long time_now = cal.getTimeInMillis() / 1000;
		t_now = time_now;
		cal.add(Calendar.DATE, -1);
		cal.set(Calendar.HOUR, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		long time_yesterday = cal.getTimeInMillis() / 1000;
		t_yes = time_yesterday;
		List<Information> list = new ArrayList<Information>();
		try {
			PreparedStatement ps = conn.prepareStatement("select distinct top "+ page_size +" c.UserID,ChildName,Gender , Birthdate,FamilyAddress,Phone from Data as d join ChildInfo as c on d.ChildID = c.UserID " +
									"where c.GardenDoctorID = ? and d.Time >= ? and d.Time <= ? and d.Status <> '健康' and DataID not in " + 
									"(select distinct top " + (page-1) * page_size +" d.DataID from Data as d join ChildInfo as c on d.ChildID = c.UserID "+
									"where c.GardenDoctorID = ? and d.Time >= ? and d.Time <= ? and d.Status <> '健康') order by c.UserID ");
			System.out.println("select top "+ page_size +" * from Data as d join ChildInfo as c on d.ChildID = c.UserID " +
					"where c.GardenDoctorID = ? and d.Time >= ? and d.Time <= ? and d.Status <> '健康' and DataID not in " + 
					"(select top " + (page-1) * page_size +" d.DataID from Data as d join ChildInfo as c on d.ChildID = c.UserID "+
					"where c.GardenDoctorID = ? and d.Time >= ? and d.Time <= ? and d.Status <> '健康') order by c.UserID ");
			System.out.println("yesterday:" + time_yesterday);
			System.out.println("now:" + time_now);
			ps.setInt(1, garden_doctor_id);
			ps.setLong(2, time_yesterday);
			ps.setLong(3, time_now);
			ps.setInt(4, garden_doctor_id);
			ps.setLong(5, time_yesterday);
			ps.setLong(6, time_now);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				Information i = new Information();
				PreparedStatement ps_status = conn.prepareStatement("select  distinct Status from Data " +
																	"where ChildID = ? and Time >= ? " +
																	"and Time <= ? and Status <> '健康' ");
				ps_status.setInt(1, rs.getInt("UserID"));
				ps_status.setLong(2, time_yesterday);
				ps_status.setLong(3, time_now);
				ResultSet rs_status = ps_status.executeQuery();
				StringBuffer sb = new StringBuffer();
				while(rs_status.next()){
					sb.append(rs_status.getString(1));
					sb.append("；");
				}
				i.setUserID(rs.getInt("UserID"));
				i.setChildName(rs.getString("ChildName"));
				i.setGender(rs.getString("Gender"));
				i.setBirthDate(rs.getString("Birthdate"));
				i.setHomeAddress(rs.getString("FamilyAddress"));
				i.setPhone(rs.getString("Phone"));
				i.setStatus(sb.toString());
				list.add(i);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("findChildNotHealth failure");
			e.printStackTrace();
		}
		return list;
	}
	
	public static int getUnhealthyChildNum(int garden_doctor_id){
		Connection conn = Connect.getConnection();
		int num = 0;
		try {
			PreparedStatement ps = conn.prepareStatement("select COUNT(distinct d.ChildID) from Data as d join ChildInfo as c on d.ChildID = c.UserID " +
														" where c.GardenDoctorID = ?  and d.Time >= ? and d.Time <= ? and d.Status <> '健康'");
			ps.setInt(1, garden_doctor_id);
			ps.setLong(2, t_yes);
			ps.setLong(3, t_now);
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()){
				num = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("getUnhealthyChildNum");
			e.printStackTrace();
			
		}
		return num;
	}
	
}
