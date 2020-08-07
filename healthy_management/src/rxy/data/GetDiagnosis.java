package rxy.data;
import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import rxy.db.Connect;
import rxy.javabean.Diagnosis;
public class GetDiagnosis {
	public static List<Diagnosis> find(int child_id,int page){
		Connection connection = Connect.getConnection();
		List<Diagnosis> list = new ArrayList<Diagnosis>();	
		
		PreparedStatement ps = null;
		try {
			ps = connection.prepareStatement("select top " + Diagnosis.PAGE_SIZE +" a.*,b.DoctorName from Diagnosis " +
												"as a join SocialDoctor  as b on b.UserID = a.DoctorID " + 
												"where a.ChildID = ? and a.DiagnosisID not in "+ 
												"(select top " + (page-1)*Diagnosis.PAGE_SIZE +" a.DiagnosisID from Diagnosis as a join SocialDoctor "+ 
												"on SocialDoctor.UserID = a.DoctorID  where a.ChildID = ? order by a.DiagnosisID DESC) "+
												"order by a.DiagnosisID DESC");
			ps.setInt(1, child_id);
			ps.setInt(2, child_id);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				Diagnosis d = new Diagnosis();
				d.setDoctorName(rs.getString("DoctorName"));
				d.setDiagnosisTime(rs.getString("Time"));
				d.setMemo(rs.getString("Memo"));
				list.add(d);
			}
			System.out.println("Diagnosis row num: " + list.size());
			rs.close();
			ps.close();

		} catch (SQLException e) {
			System.out.println("GetDiagnosis wrong");
			e.printStackTrace();
		} 
		return list;
	}
	
	
	
	public static int findCount(int child_id){
		int count = 0;
		Connection connection = Connect.getConnection();
		PreparedStatement ps = null;
		try {
			ps = connection.prepareStatement("select COUNT(*) from Diagnosis where ChildID = ?");
			ps.setInt(1, child_id);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				count = rs.getInt(1);
			}
			rs.close();
		} catch (SQLException e) {
			System.out.println("Diagnosis count wrong");
			e.printStackTrace();
		}
		return count;
	}


}
