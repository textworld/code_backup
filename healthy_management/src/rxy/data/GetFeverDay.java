package rxy.data;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import rxy.db.Connect;
import rxy.javabean.DataBean;

public class GetFeverDay {
	public static List<Integer> getFeverDay(int child_id){
		Connection conn = Connect.getConnection();
		Calendar cal = Calendar.getInstance();
		Long time_now = cal.getTimeInMillis() / 1000;
		cal.set(Calendar.DATE, 1);
		cal.set(Calendar.HOUR, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		Long time_month = cal.getTimeInMillis() / 1000;
		List<Integer> list = new ArrayList<Integer>();
		try {
			PreparedStatement ps = conn.prepareStatement("select * from Data where ChildID = ? and "+
													"Time >= ? and Time <= ? and Type = ? and Status <> '健康'");
			ps.setInt(1, child_id);
			ps.setLong(2, time_month);
			ps.setLong(3, time_now);
			ps.setInt(4, DataBean.TYPE_TEMP);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				cal.setTimeInMillis(rs.getLong("Time")*1000);
				if(!list.contains(cal.get(Calendar.DATE))){
					list.add(cal.get(Calendar.DATE));
				}
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
}
