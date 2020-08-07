package rxy.javabean;

public class SocialInfo {
public static final int PAGE_SIZE = 3;	
private Integer UserID;
private String DoctorName;
private Integer SocialID;
private String SocialName;
private Integer ChildID;
private String ChildName;

private Integer DiagnosisID;
public Integer getUserID() {
	return UserID;
}
public void setUserID(Integer userID) {
	UserID = userID;
}
public String getDoctorName() {
	return DoctorName;
}
public void setDoctorName(String doctorName) {
	DoctorName = doctorName;
}
public Integer getSocialID() {
	return SocialID;
}
public void setSocialID(Integer socialID) {
	SocialID = socialID;
}
public String getSocialName() {
	return SocialName;
}
public void setSocialName(String socialName) {
	SocialName = socialName;
}
public Integer getChildID() {
	return ChildID;
}
public void setChildID(Integer childID) {
	ChildID = childID;
}

public String getChildName() {
	return ChildName;
}
public void setChildName(String childName) {
	ChildName = childName;
}
public Integer getDiagnosisID() {
	return DiagnosisID;
}
public void setDiagnosisID(Integer diagnosisID) {
	DiagnosisID = diagnosisID;
}


}
