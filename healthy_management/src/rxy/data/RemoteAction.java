package rxy.data;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import rxy.db.Connect;
import rxy.javabean.RemoteCheck;

public class RemoteAction {
	private RemoteCheck rc;
	
	
	
	public RemoteCheck getRc() {
		return rc;
	}

	public void setRc(RemoteCheck rc) {
		this.rc = rc;
	}

	public void save() throws Exception{
		Connection conn = Connect.getConnection();
		if(conn == null){
			throw new Exception("数据库连接失败");
		}
		PreparedStatement ps = conn.prepareStatement("INSERT INTO RemoteCheck VALUES(?, ?, ?, 0)", Statement.RETURN_GENERATED_KEYS);
		ps.setInt(1, rc.getChildID());
		ps.setInt(2, rc.getDoctorID());
		ps.setString(3, rc.getContents());
		if(ps.executeUpdate()!= 1){
			throw new Exception("插入RemoteCheck 失败");
		}
		ResultSet rs = ps.getGeneratedKeys();
		while(rs.next()){
			rc.setRemoteID(rs.getInt(1));
		}
		List<Integer> img_list = rc.getImgID();
		for(int i = 0; i < img_list.size(); i ++){
			saveImg(img_list.get(i));
		}	
	}
	
	public void saveImg(int img_id) throws Exception{
		Connection conn = Connect.getConnection();
		if(conn == null){
			throw new Exception("数据库连接失败");
		}
		PreparedStatement ps = conn.prepareStatement("INSERT INTO RemoteImg VALUES(?, ?)");
		if(rc.getRemoteID() != 0){
			ps.setInt(1, rc.getRemoteID());
			ps.setInt(2, img_id);
			int row = ps.executeUpdate();
			if(row != 1){
				throw new Exception("插入 Remote img 失败");
			}
		}else{
			throw new Exception("Remote ID NULL");
		}
	}
	
	public static List<RemoteCheck> getChildAllCheck(int childID, int page, int page_size){
		Connection conn = Connect.getConnection();
		
		try {
			PreparedStatement ps = conn.prepareStatement("SELECT TOP " + page_size +" * FROM RemoteCheck as r join SocialDoctor as s" +
					"on r.DoctorID = s.UserID where r.ChildID = ? and r.RemoteID not in " +
					"(SELECT TOP " + page_size * (page - 1) + " RemoteID FROM RemoteCheck as r where r.ChildID = ?)");
			List<RemoteCheck> list = new ArrayList<RemoteCheck>();
			ps.setInt(1, childID);
			ps.setInt(2, childID);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				RemoteCheck rc = new RemoteCheck();
				rc.setRemoteID(rs.getInt("RemoteID"));
				rc.setContents(rs.getString("Contents"));
				rc.setDoctor(GetSocialInfo.findOne(rs.getInt("DoctorID")));
				rc.setChild(GetInformation.findOne(rs.getInt("ChildID")));
				list.add(rc);
			}
			return list;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}
	
	public static int getChildCheckPageNum(int childID){
		Connection conn = Connect.getConnection();
		
		try {
			PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM RemoteCheck as r where ChildID = ?");
			ps.setInt(1, childID);
			ResultSet rs = ps.executeQuery();
			int num = 0;
			while(rs.next()){
				num = rs.getInt(1);
			}
			return num;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return 0;
		}
	}
}
