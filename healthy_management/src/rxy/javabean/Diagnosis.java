package rxy.javabean;

public class Diagnosis {
	public static final int PAGE_SIZE = 5;
	private String doctorName;
	private String diagnosisTime;
	private String memo;
	public String getDoctorName() {
		return doctorName;
	}
	public void setDoctorName(String doctorName) {
		this.doctorName = doctorName;
	}
	public String getDiagnosisTime() {
		return diagnosisTime;
	}
	public void setDiagnosisTime(String diagnosisTime) {
		this.diagnosisTime = diagnosisTime;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	

}
