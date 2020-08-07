package rxy.javabean;

public class ReportBean {
	public static final String TEMP_STATUS = "发烧";
	public static final String SLEEP_STATUS = "睡眠质量差";
	
	private double weight;
	private double height;
	private double head;
	private double body;
	private int num_temp;
	private int num_sleep;
	private int gender;
	
	public int getGender() {
		return gender;
	}
	public void setGender(int gender) {
		this.gender = gender;
	}
	public int getNum_temp() {
		return num_temp;
	}
	public void setNum_temp(int numTemp) {
		num_temp = numTemp;
	}
	public int getNum_sleep() {
		return num_sleep;
	}
	public void setNum_sleep(int numSleep) {
		num_sleep = numSleep;
	}
	public double getWeight() {
		return weight;
	}
	public void setWeight(double weight) {
		this.weight = weight;
	}
	public double getHeight() {
		return height;
	}
	public void setHeight(double height) {
		this.height = height;
	}
	public double getHead() {
		return head;
	}
	public void setHead(double head) {
		this.head = head;
	}
	public double getBody() {
		return body;
	}
	public void setBody(double body) {
		this.body = body;
	}
	public String getWeightStatus(){
		if(gender == 1){
			if(weight >17.5){
				return "偏胖";
			}else 
			if(weight < 14.1){
				return "偏瘦";
			}else{
				return "正常";
			}
		}else{
			if(weight > 17.2){
				return "偏胖";
			}else
			if(weight < 13.2){
				return "偏瘦";
			}else{
				return "正常";
			}
		}
	}
	public String getHeadStatus(){
		if(gender == 1){
			if(head > 49.9){
				return "脑积水";
			}else
			if(head < 49.1){
				return "发育不良";
			}else{
				return "正常";
			}
		}else{
			if(head > 48.7){
				return "脑积水";
			}else
			if(head < 47.5){
				return "发育不良";
			}else{
				return "正常";
			}
		}
	}
	
	public String getBodyStatus(){
		if(gender == 1){
			if(head > 54.2){
				return "胸围过大";
			}else
			if(head < 51.3){
				return "发育不良";
			}else{
				return "正常";
			}
		}else{
			if(head > 53.3){
				return "胸围过大";
			}else
			if(head < 50.2){
				return "发育不良";
			}else{
				return "正常";
			}
		}
	}
	
	public String getSleepStatus(){
		if(num_sleep > 1){
			return "睡眠质量差";
		}else{
			return "睡眠质量好";
		}
	}
	
	public String getTempStatus(){
		if(num_temp > 1){
			return "体质差";
		}else{
			return "体质好";
		}
	}
	
	public String toString(){
		return getTempStatus() + ";" + getSleepStatus() + ";" + getBodyStatus() + ";" + getHeadStatus() + ";" + getWeightStatus();
	}
}
