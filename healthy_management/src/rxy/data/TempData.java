package rxy.data;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;


import rxy.db.Connect;
import rxy.javabean.DataBean;



public class TempData {
	public static List<DataBean> getRecentlyData(long timestamp_start, long timestamp_end, int type){
		Connection conn = Connect.getConnection();
		System.out.println("Start time: " + timestamp_start);
		System.out.println("End time: " + timestamp_end);
		List<DataBean> list = null;
		try{
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM Data where Time > '" + timestamp_start + "' and Time <= '" + timestamp_end + "' and Type = '" + type + "' order by Time");
			System.out.println("SELECT * FROM Data where Time > '" + timestamp_start + "' and Time <= '" + timestamp_end + "' and Type = '" + type + "' order by DataID ");
			list = new ArrayList<DataBean>();
			while(rs.next()){
				DataBean data = new DataBean();
				data.setId(rs.getInt(1));
				data.setChild_id(rs.getInt(2));
				data.setTime(rs.getInt(3));
				data.setData(rs.getString(4));
				data.setType(rs.getInt(5));
				list.add(data);
			}
		}catch(SQLException e){
			System.out.println("got error: " + e.getMessage());
			e.printStackTrace();
		}
		System.out.println("Type :" + type);
		System.out.println("Result Rows :" + list.size());
		return list;
	}
		
	
	public static List<DataBean> getDataYesterday(){
		return getDataYesterday(1);
	}
	
	public static List<DataBean> getDataYesterday(int type){
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.HOUR, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		cal.set(Calendar.AM_PM, 0);
		Timestamp end_ts = new Timestamp(cal.getTimeInMillis());
		cal.add(Calendar.DATE, -1);
		cal.set(Calendar.HOUR, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		cal.set(Calendar.AM_PM, 0);
		Timestamp start_ts = new Timestamp(cal.getTimeInMillis());
		return getRecentlyData((start_ts.getTime())/1000, (end_ts.getTime())/1000, type);
	}
	
	public static List<DataBean> getDataLastWeek(int type){
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.HOUR, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		cal.set(Calendar.AM_PM, 0);
		Timestamp end_ts = new Timestamp(cal.getTimeInMillis());
		cal.add(Calendar.DATE, -7);
		cal.set(Calendar.HOUR, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		cal.set(Calendar.AM_PM, 0);
		Timestamp start_ts = new Timestamp(cal.getTimeInMillis());
		return getRecentlyData((start_ts.getTime())/1000, (end_ts.getTime())/1000, type);
	}
	
	
	
	public static JSONObject getDataOneDay(Calendar cal, int type){
//		cal.set(Calendar.HOUR, 0);
//		cal.set(Calendar.MINUTE, 0);
//		cal.set(Calendar.SECOND, 0);
//		cal.set(Calendar.MILLISECOND, 0);
//		cal.set(Calendar.AM_PM, 0);
		Timestamp end_ts = new Timestamp(cal.getTimeInMillis());
		cal.add(Calendar.DATE, -1);
//		cal.set(Calendar.HOUR, 0);
//		cal.set(Calendar.MINUTE, 0);
//		cal.set(Calendar.SECOND, 0);
//		cal.set(Calendar.MILLISECOND, 0);
//		cal.set(Calendar.AM_PM, 0);
		Timestamp start_ts = new Timestamp(cal.getTimeInMillis());
		System.out.println("GetDataOneDay: start_time " + start_ts.getTime() + " and end_time " + end_ts.getTime());
		return getJSONData(getRecentlyData((start_ts.getTime())/1000, (end_ts.getTime())/1000, type));
	}
	
	public static JSONObject getDataOneWeek(Calendar cal, int type){
		cal.set(Calendar.HOUR, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		cal.set(Calendar.AM_PM, 0);
		Timestamp end_ts = new Timestamp(cal.getTimeInMillis());
		cal.add(Calendar.DATE, -7);
		cal.set(Calendar.HOUR, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		cal.set(Calendar.AM_PM, 0);
		Timestamp start_ts = new Timestamp(cal.getTimeInMillis());
		System.out.println("GetDataOneWeek: start_time " + start_ts.getTime() + " and end_time " + end_ts.getTime());
		return getJSONData(getRecentlyData((start_ts.getTime())/1000, (end_ts.getTime())/1000, type));
	}
	
	public static boolean insertToDB(DataBean bean){
		boolean ret = true;
		Connection conn = Connect.getConnection();
		PreparedStatement ps = null;
		try{
			ps = conn.prepareStatement("INSERT INTO `Data`(ChildID, Time, Data, Type) VALUES (?, ?, ?, ?);");
			ps.setString(1, Integer.toString(bean.getChild_id()));
			ps.setString(2, Integer.toString(bean.getTime()));
			ps.setString(3, bean.getData());
			ps.setString(4, Integer.toString(bean.getType()));
			ps.executeUpdate();
		}catch(Exception e){
			System.out.println("insert body data failed!");
			ret = false;
			e.printStackTrace();
		}
		return ret;
	}
	
	public static JSONObject getJSONData(List<DataBean> list){
		JSONObject jsonobj = new JSONObject();
		JSONArray jsonArr = new JSONArray();
		if(list.size() == 0){
			System.out.println("get " + list.size() + " row data");
			return null;
		}
		for(int i = 0; i < list.size(); i++){
			jsonArr.put(list.get(i).getJSONObject());
		}
		try {
			jsonobj.put("type",list.get(0).getType());
			jsonobj.put("data", jsonArr);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return jsonobj;
	}
}
