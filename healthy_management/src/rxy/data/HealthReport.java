package rxy.data;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.HashMap;

import rxy.db.Connect;
import rxy.javabean.DataBean;
import rxy.javabean.Information;
import rxy.javabean.ReportBean;

public class HealthReport {
	public static ReportBean getHealthStatus(int child_id){
		System.out.println("ChildID:" + child_id);
		Connection conn = Connect.getConnection();
		ReportBean rb = new ReportBean();
		try {
			Information info = GetInformation.findOne(child_id);
			if(info == null){
				System.out.println("Report: info null");
				return null;
			}
			if(info.getGender() == "男"){
				rb.setGender(1);
			}else{
				rb.setGender(2);
			}
			PreparedStatement ps = conn.prepareStatement("select top 3 * from Data where ChildID = ? and type > 3 order by DataID DESC");
			ps.setInt(1, child_id);
			ResultSet rs = ps.executeQuery();
			boolean has_data = false;
			while(rs.next()){
				has_data = true;
				switch(rs.getInt("Type")){
				case DataBean.TYPE_BODY:
					rb.setBody(Double.parseDouble(rs.getString("Data")));
					break;
				case DataBean.TYPE_HEAD:
					rb.setHead(Double.parseDouble(rs.getString("Data")));
					break;
				case DataBean.TYPE_HEIGHT:
					rb.setHeight(Double.parseDouble(rs.getString("Data")));
					break;
				case DataBean.TYPE_WEIGHT:
					rb.setWeight(Double.parseDouble(rs.getString("Data")));
					break;
				default:
					break;
				}
			}
			if(has_data == false){
				System.out.println("Report: has_data null");
				return null;
			}
			Calendar cal = Calendar.getInstance();
			Long time_now = cal.getTimeInMillis();
			cal.add(Calendar.DATE, -7);
			cal.set(Calendar.HOUR, 0);
			cal.set(Calendar.MINUTE, 0);
			cal.set(Calendar.SECOND, 0);
			Long time_week = cal.getTimeInMillis() / 1000;
			ps.close();
			rs.close();
			ps = conn.prepareStatement("select * from Data where ChildID = ? and Time >= ? and Time < ? and Status <> '健康'");
			rs = ps.executeQuery();
			HashMap<String, Integer> map = new HashMap<String, Integer>();
			while(rs.next()){
				String status = rs.getString("Status");
				if( map.get(status) != null){
					int i = map.get(status);
					map.put(status, i++);
				}else{
					map.put(status, 1);
				}
			}
			rb.setNum_temp(map.get(ReportBean.TEMP_STATUS));
			rb.setNum_sleep(map.get(ReportBean.SLEEP_STATUS));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rb;
	}
}
