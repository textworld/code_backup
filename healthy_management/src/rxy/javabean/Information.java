package rxy.javabean;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
public class Information {
    private String mail;
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	private int UserID;
	private String ChildName;
	private String Gender;
	private String BirthDate;
	private String HomeAddress;
	private String Phone;
	private int DoctorID;
	private String ResponerID;
	private String FatherName;
	private String FatherPhone;
	private String FatherJob;
	private String MatherName;
	private String MatherPhone;
	private String MatherJob;
	private String Status;
	private int GardenID;
	private int SocialID;
	public int getGardenID() {
		return GardenID;
	}
	public void setGardenID(int gardenID) {
		GardenID = gardenID;
	}
	public int getSocialID() {
		return SocialID;
	}
	public void setSocialID(int socialID) {
		SocialID = socialID;
	}
	public String getStatus() {
		return Status;
	}
	public void setStatus(String status) {
		Status = status;
	}
	public int getUserID() {
		return UserID;
	}
	public void setUserID(int userID) {
		UserID = userID;
	}
	public String getChildName() {
		return ChildName;
	}
	public void setChildName(String childName) {
		ChildName = childName;
	}
	public String getGender() {
		return Gender;
	}
	public void setGender(String gender) {
		Gender = gender;
	}
	public String getBirthDate() {
		return BirthDate;
	}
	public void setBirthDate(String birthDate) {
		BirthDate = birthDate;
	}
	public String getHomeAddress() {
		return HomeAddress;
	}
	public void setHomeAddress(String homeAddress) {
		HomeAddress = homeAddress;
	}
	public String getPhone() {
		return Phone;
	}
	public void setPhone(String phone) {
		Phone = phone;
	}
	public int getDoctorID() {
		return DoctorID;
	}
	public void setDoctorID(int doctorID) {
		DoctorID = doctorID;
	}
	public String getResponerID() {
		return ResponerID;
	}
	public void setResponerID(String responerID) {
		ResponerID = responerID;
	}
	public String getFatherName() {
		return FatherName;
	}
	public void setFatherName(String fatherName) {
		FatherName = fatherName;
	}
	public String getFatherPhone() {
		return FatherPhone;
	}
	public void setFatherPhone(String fatherPhone) {
		FatherPhone = fatherPhone;
	}
	public String getFatherJob() {
		return FatherJob;
	}
	public void setFatherJob(String fatherJob) {
		FatherJob = fatherJob;
	}
	public String getMatherName() {
		return MatherName;
	}
	public void setMatherName(String matherName) {
		MatherName = matherName;
	}
	public String getMatherPhone() {
		return MatherPhone;
	}
	public void setMatherPhone(String matherPhone) {
		MatherPhone = matherPhone;
	}
	public String getMatherJob() {
		return MatherJob;
	}
	public void setMatherJob(String matherJob) {
		MatherJob = matherJob;
	}
	
	public void setField(ResultSet rs){
		try {
			setUserID(rs.getInt("UserID"));
			setChildName(rs.getString("ChildName"));
			setGender(rs.getString("Gender"));
			setHomeAddress(rs.getString("FamilyAddress"));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public void setChildInfo(ResultSet rs){
		try{
			setUserID(rs.getInt("UserID"));
			setChildName(rs.getString("ChildName"));
			setPhone(rs.getString("Phone"));
			setBirthDate(rs.getString("BirthDate"));
			setGender(rs.getString("Gender"));
			setFatherName(rs.getString("FatherName"));
			setFatherJob(rs.getString("FatherJob"));
			setFatherPhone(rs.getString("FatherTel"));
			setMatherName(rs.getString("MotherName"));
			setMatherJob(rs.getString("MotherJob"));
			setMatherPhone(rs.getString("MotherTel"));
			setHomeAddress(rs.getString("FamilyAddress"));
		}catch(SQLException e){
			e.printStackTrace();
			System.out.println("setChildInfo failure");
		}
		
	}
	
	
}
