package rxy.data;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class BodyData {
	private static Double[] weight_min = {35.5, 36.6, 38.5, 43.5, 46.4, 48.5, 50.3};
	private static Double[] weight_max = {38.5, 42.6, 45.5, 49.5, 53.4, 58.5, 60.3};
	private static Double[] weight_data = {33.5, 32.5, 39.5, 45.6, 48.6, 57.4, 63.5};
	private static Double[] height_min = {137.5, 143.5, 148.5, 150.3, 153.5, 155.9, 158.0};
	private static Double[] height_max = {146.5, 153.5, 156.5, 159.3, 160.5, 163.9, 166.0};
	private static Double[] height_data = {147.0, 153.6, 156.6, 160.1, 164.6, 165.2, 168.5};
	public static List<HashMap<String, Double>> getWeightData(){
		List<HashMap<String, Double>> list = new ArrayList<HashMap<String, Double>>();
		double year = 3.0;
		for(int i = 0; i < 7; i++){
			HashMap<String, Double> map = new  HashMap<String, Double>();
			map.put("year", year);
			year += 0.5;
			map.put("min", weight_min[i]);
			map.put("max", weight_max[i]);
			map.put("data", weight_data[i]);
			list.add(map);
		}

		return list;
	}
	
	public static List<HashMap<String, Double>> getHeightData(){
		List<HashMap<String, Double>> list = new ArrayList<HashMap<String, Double>>();
		double year = 3.0;
		for(int i = 0; i < 7; i++){
			HashMap<String, Double> map = new  HashMap<String, Double>();
			map.put("year", year);
			year += 0.5;
			map.put("min", height_min[i]);
			map.put("max", height_max[i]);
			map.put("data", height_data[i]);
			list.add(map);
		}

		return list;
	}
	
	public static String getWeightString(){
		List<HashMap<String, Double>> list = getWeightData();
		StringBuffer sb = new StringBuffer();
		sb.append("[");
		for(HashMap<String, Double> map :list){
			sb.append("{\"year\":");
			sb.append(map.get("year"));
			sb.append(",");
			sb.append("\"max\":");
			sb.append(map.get("max"));
			sb.append(",");
			sb.append("\"min\":");
			sb.append(map.get("min"));
			sb.append(",");
			sb.append("\"data\":");
			sb.append(map.get("data"));
			sb.append("},");
		}
		sb.append("]");
		return sb.toString();
	}
	
	public static String getHeightString(){
		List<HashMap<String, Double>> list = getHeightData();
		StringBuffer sb = new StringBuffer();
		sb.append("[");
		for(HashMap<String, Double> map :list){
			sb.append("{\"year\":");
			sb.append(map.get("year"));
			sb.append(",");
			sb.append("\"max\":");
			sb.append(map.get("max"));
			sb.append(",");
			sb.append("\"min\":");
			sb.append(map.get("min"));
			sb.append(",");
			sb.append("\"data\":");
			sb.append(map.get("data"));
			sb.append("},");
		}
		sb.append("]");
		return sb.toString();
	}
	
	public static String getWHString(){
		List<HashMap<String, Double>> list = new ArrayList<HashMap<String, Double>>();
		double year = 3.0;
		DecimalFormat df = new DecimalFormat("0.000");
		for(int i = 0; i < 7; i++){
			HashMap<String, Double> map = new  HashMap<String, Double>();
			map.put("year", year);
			year += 0.5;
			map.put("min", Double.parseDouble(df.format(weight_min[i] / height_min[i])));
			map.put("max", Double.parseDouble(df.format(weight_max[i] / height_max[i])));
			map.put("data", Double.parseDouble(df.format(weight_data[i] / height_data[i])));
			list.add(map);
		}

		StringBuffer sb = new StringBuffer();
		sb.append("[");
		for(HashMap<String, Double> map :list){
			sb.append("{\"year\":");
			sb.append(map.get("year"));
			sb.append(",");
			sb.append("\"max\":");
			sb.append(map.get("max"));
			sb.append(",");
			sb.append("\"min\":");
			sb.append(map.get("min"));
			sb.append(",");
			sb.append("\"data\":");
			sb.append(map.get("data"));
			sb.append("},");
		}
		sb.append("]");
		return sb.toString();
	}
}
