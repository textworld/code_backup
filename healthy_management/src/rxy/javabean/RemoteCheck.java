package rxy.javabean;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

public class RemoteCheck {
	private int RemoteID;
	private int ChildID;
	private int DoctorID;
	private List<Integer> ImgID;
	private String Contents;
	
	private Information child;
	private SocialInfo doctor;
	
	public RemoteCheck(){
		this.RemoteID = 0;
		this.ImgID = new ArrayList<Integer>();
	}
	
	public Information getChild() {
		return child;
	}

	public void setChild(Information child) {
		this.child = child;
	}

	public SocialInfo getDoctor() {
		return doctor;
	}

	public void setDoctor(SocialInfo doctor) {
		this.doctor = doctor;
	}

	public int getRemoteID() {
		return RemoteID;
	}
	public void setRemoteID(int remoteID) {
		RemoteID = remoteID;
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
	public List<Integer> getImgID() {
		return ImgID;
	}
	public void setImgID(List<Integer> imgID) {
		ImgID = imgID;
	}
	public String getContents() {
		return Contents;
	}
	public void setContents(String contents) {
		Contents = contents;
	}
	public void setData(HttpServletRequest req) throws Exception{
		String ct = req.getParameter("Contents");
		if(ct == null){
			throw new Exception("contents null");
		}
		String[] imgs = req.getParameterValues("Imgs");
		if(imgs == null || imgs.length == 0){
			throw new Exception("parameter imgs null");
		}
		for(int i = 0; i < imgs.length; i++){
			this.ImgID.add(Integer.parseInt(imgs[i]));
		}
		String childid = req.getParameter("ChildID");
		if(childid == null){
			throw new Exception("childid null");
		}
		String doctorid = req.getParameter("DoctorID");
		if(doctorid == null){
			throw new Exception("doctorid null");
		}
		
		this.setContents(ct);
		this.setChildID(Integer.parseInt(childid));
		this.setDoctorID(Integer.parseInt(doctorid));

	}
	public String toString(){
		return "ChildID:" + this.ChildID + ";DoctorID:"+this.DoctorID + ";Contents:"+this.Contents;
	}
	
	
}
