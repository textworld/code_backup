package rxy.javabean;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;

import org.json.JSONException;
import org.json.JSONObject;

import rxy.db.Connect;


public class DataBean implements Serializable{
	private int id;
	private int child_id;
	private int time;
	private String data;
	private int type;
	
	public static final int TYPE_TEMP = 1;
	public static final int TYPE_HEAD = 4;
	public static final int TYPE_BODY = 5;
	public static final int TYPE_HEIGHT = 6;
	public static final int TYPE_WEIGHT = 7;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getChild_id() {
		return child_id;
	}
	public void setChild_id(int childId) {
		child_id = childId;
	}
	public int getTime() {
		return time;
	}
	public void setTime(int time) {
		this.time = time;
	}
	public String getData() {
		return data;
	}
	public void setData(String data) {
		this.data = data;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	
	public String getMillTime(){
		return Integer.toString(time) + "000";
	}
	
	public boolean insertToDB(){
		boolean ret = true;
		Connection conn = Connect.getConnection();
		PreparedStatement ps = null;
		try{
			ps = conn.prepareStatement("INSERT INTO Data (ChildID, Time, Data, Type, Status) VALUES ( ?, ?, ?, ?, '');");
			ps.setString(1, Integer.toString(child_id));
			ps.setInt(2, time);
			ps.setString(3, data);
			ps.setString(4, Integer.toString(type));
			ps.execute();
		}catch(Exception e){
			System.out.println("insert body data failed!");
			System.out.println("child_id_" + child_id );
			System.out.println("data_" + data );
			System.out.println("type_" + type );
			ret = false;
			e.printStackTrace();
		}
		if(ret){
			System.out.println("insert data success");
			System.out.println("child_id_" + child_id );
			System.out.println("data_" + data );
			System.out.println("type_" + type );
		}
		return ret;
	}
	
	public JSONObject getJSONObject(){
		JSONObject jsonobj = new JSONObject();
		try {
			jsonobj.put("time", time);
			jsonobj.put("data", data);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return jsonobj;
	}
}
