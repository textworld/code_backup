package rxy.javabean;

import org.apache.commons.fileupload.FileItem;

public class Picture {
	private static String[] img_types = {"image/jpeg", "image/bmp", "image/png"};
	private int PictureID;
	private String OriginFileName;
	private String FileName;
	private String FileType;
	private String FullName;
	private String ext_type;
	private long UploadDate;
	
	private FileItem fi;
	
	public void setData(FileItem item) throws Exception{
		if(item == null) throw new Exception("setData parameter 1 is null pointer");
		this.fi = item;
		setFullName(item.getName());
		setFileType(item.getContentType());
		
		if(getFullName() == null) throw new Exception("item getName equals null");
		if(getFileType() == null) throw new Exception("item getContentType equals null");
	
		if(getFullName().lastIndexOf('.') == -1){
			setOriginFileName(this.FullName);
		}else{
			setOriginFileName(getFullName().substring(0, getFullName().lastIndexOf('.')));
		}
		
		if(!isPicture(this.FileType)) throw new Exception("Picture 需要图片类型");
	}
	
	public String getExt_type() {
		return ext_type;
	}

	public void setExt_type(String extType) {
		ext_type = extType;
	}

	public int getPictureID() {
		return PictureID;
	}
	public void setPictureID(int pictureID) {
		PictureID = pictureID;
	}
	public String getFileName() {
		return FileName;
	}
	public void setFileName(String fileName) {
		FileName = fileName;
	}
	public String getFileType() {
		return FileType;
	}
	public void setFileType(String fileType) {
		FileType = fileType;
	}
	public String getFullName() {
		return FullName;
	}
	public void setFullName(String fullName) {
		FullName = fullName;
	}
	public long getUploadDate() {
		return UploadDate;
	}
	public void setUploadDate(long uploadDate) {
		UploadDate = uploadDate;
	}
	
	public String getOriginFileName() {
		return OriginFileName;
	}
	public void setOriginFileName(String originFileName) {
		OriginFileName = originFileName;
	}
	public static boolean isPicture(String file_type){
		file_type = file_type.toLowerCase();
		for(int i = 0; i < img_types.length; i++){
			if(img_types[i].equals(file_type)){
				return true;
			}
		}
		return false;
	}	
	
}
