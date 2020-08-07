package rxy.javabean;

public class AnnInfo {
 public static final int PAGE_SIZE = 12;
 private Integer AnnID;
 private Integer GardenDoctorID;
 private String DoctorName;
 private String memo;
 private String time;
public Integer getAnnID() {
	return AnnID;
}
public void setAnnID(Integer annID) {
	AnnID = annID;
}
public Integer getGardenDoctorID() {
	return GardenDoctorID;
}
public void setGardenDoctorID(Integer gardenDoctorID) {
	GardenDoctorID = gardenDoctorID;
}
public String getDoctorName() {
	return DoctorName;
}
public void setDoctorName(String doctorName) {
	DoctorName = doctorName;
}
public String getMemo() {
	return memo;
}
public void setMemo(String memo) {
	this.memo = memo;
}
public String getTime() {
	return time;
}
public void setTime(String time) {
	this.time = time;
}
 
}
