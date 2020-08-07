package rxy.data;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import rxy.db.Connect;
import rxy.javabean.Picture;

public class UploadAction {
	private Picture target;
	public UploadAction(Picture img){
		this.target = img;
	}
	
	public void upload() throws Exception{
		if(this.target != null){
			Connection conn = Connect.getConnection();
			try {
				PreparedStatement ps = conn.prepareStatement("insert into Picture values(?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
				ps.setString(1, this.target.getFileName());
				ps.setLong(2, this.target.getUploadDate());
				ps.setString(3, this.target.getFileType());
				ps.setString(4, this.target.getFullName());
				System.out.println("insert update row " + ps.executeUpdate());
				ResultSet rs = ps.getGeneratedKeys();
				while(rs.next()){
					target.setPictureID(rs.getInt(1));
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				throw new Exception("UploadAction insert into Data failure");
			}
		}else{
			throw new Exception("UploadAction target is null pointer");
		}
		
	}
	
	public Picture getPicture(){
		return target;
	}
	
	
}
