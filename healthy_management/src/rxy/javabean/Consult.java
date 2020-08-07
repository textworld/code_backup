package rxy.javabean;

import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;

public class Consult {
	public final static int TYPE_REPLY = 1;
	public final static int TYPE_CONSULT = 2;
	public final static int STATUS_NOT_ANSWER = 1;
	public final static int STATUS_NOT_VIEW = 2;
	public final static int STATUS_VIEWED = 3;
	private int ConsultID;
	private int ChildID;
	private int DoctorID;
	private String Contents;
	private String Reply;
	private long Time;
	private long ReplyTime;
	private int Status;
	private String DoctorName;
	private String ChildName;
	
	
	public String getChildName() {
		return ChildName;
	}
	public void setChildName(String childName) {
		ChildName = childName;
	}
	public String getDoctorName() {
		return DoctorName;
	}
	public void setDoctorName(String doctorName) {
		DoctorName = doctorName;
	}
	public int getConsultID() {
		return ConsultID;
	}
	public void setConsultID(int consultID) {
		ConsultID = consultID;
	}
	public int getChildID() {
		return ChildID;
	}
	public void setChildID(int childID) {
		ChildID = childID;
	}
	public int getDoctorID() {
		return DoctorID;
	}
	public void setDoctorID(int doctorID) {
		DoctorID = doctorID;
	}
	public String getContents() {
		return Contents;
	}
	public void setContents(String contents) {
		Contents = contents;
	}
	public String getReply() {
		return Reply;
	}
	public void setReply(String reply) {
		Reply = reply;
	}
	public long getTime() {
		return Time;
	}
	public void setTime(long time) {
		Time = time;
	}
	public long getReplyTime() {
		return ReplyTime;
	}
	public void setReplyTime(long replyTime) {
		ReplyTime = replyTime;
	}
	
	public int getStatus() {
		return Status;
	}
	public void setStatus(int status) {
		Status = status;
	}
	public void setData(HttpServletRequest request, int type) throws Exception {
		if(type == TYPE_CONSULT){
			String p_doctor_id = request.getParameter("DoctorID");
			String p_contents = request.getParameter("Contents");
			String p_child_id = request.getParameter("ChildID");
			
			if(p_doctor_id == null || p_contents == null || p_child_id == null){
				throw new Exception("ConsultBean: 参数错误");
			}
			
			int child_id = Integer.parseInt(p_child_id);
			int doctor_id = Integer.parseInt(p_doctor_id);
			this.setContents(p_contents);
			this.setChildID(child_id);
			this.setDoctorID(doctor_id);
			
			this.setStatus(STATUS_NOT_ANSWER);
			
			Calendar cal = Calendar.getInstance();
			long time_n = cal.getTimeInMillis() / 1000;
			this.setTime(time_n);
		}else{
			String p_consult_id = request.getParameter("ConsultID");
			String p_reply = request.getParameter("Reply");
			
			if(p_consult_id == null ||  p_reply == null ){
				throw new Exception("ConsultBean: 参数错误");
			}
			
			this.setReply(p_reply);
			
			this.setStatus(STATUS_NOT_VIEW);
			
			Calendar cal = Calendar.getInstance();
			long time_n = cal.getTimeInMillis() / 1000;
			this.setReplyTime(time_n);
		}		
	}
	
	public String getFormatTime(){
		if(getTime() == 0){
			return "";
		}
		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(getTime()*1000);
		return cal.get(Calendar.YEAR) + "年" + cal.get(Calendar.MONTH) + "月" + cal.get(Calendar.DATE) +
				"日" + cal.get(Calendar.HOUR) + "点" + cal.get(Calendar.MINUTE) + "分";
	}
	
	public String getFormatReplyTime(){
		if(getReplyTime() == 0){
			return "";
		}
		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(getReplyTime()*1000);
		return cal.get(Calendar.YEAR) + "年" + cal.get(Calendar.MONTH) + "月" + cal.get(Calendar.DATE) +
				"日" + cal.get(Calendar.HOUR) + "点" + cal.get(Calendar.MINUTE) + "分";
	}
}
