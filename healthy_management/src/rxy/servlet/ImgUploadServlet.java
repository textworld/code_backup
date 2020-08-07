package rxy.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import rxy.data.UploadAction;
import rxy.javabean.Picture;

public class ImgUploadServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html;charset=utf-8");
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setRepository(new File("c:/Temp/"));
		ServletFileUpload sfu = new ServletFileUpload(factory);
		sfu.setFileSizeMax(3*800*600);
		List<Picture> p_list = new ArrayList<Picture>();
		try {
			List<FileItem> list = sfu.parseRequest(req);
			for(int i = 0; i < list.size(); i++){
				FileItem fi = list.get(i);
				if(!fi.isFormField()){
					System.out.println("fileItem not formfield");
					System.out.println(fi);
					ServletContext ctx = getServletContext();
					String path = ctx.getRealPath("/upload");
					System.out.println("upload path: " + path);
					String fileName = fi.getName();
					System.out.println("fileName " + fi.getContentType());
					fileName = fileName.substring(fileName.lastIndexOf("/")+1); 
					
					StringBuffer sb = new StringBuffer();
					long d = Calendar.getInstance().getTimeInMillis();
					sb.append(d);
					String new_name = sb.toString();
					String ext_type = fileName.substring(fileName.lastIndexOf('.') + 1, (fileName.length()));
					String new_path = path + "\\" + new_name + "." + ext_type;
                    File file = new File(new_path);  
                    if(!file.exists() && Picture.isPicture(fi.getContentType())){  
                        fi.write(file);  
                        Picture p = new Picture();
                        p.setData(fi);
                        p.setFileName(new_name);
                        p.setExt_type(ext_type);
                        p.setFullName(new_name + "." + ext_type);
                        p.setUploadDate(d / 1000);
                        UploadAction ua = new UploadAction(p);
                        ua.upload();
                        p_list.add(ua.getPicture());
                    }  
				}else{
					System.out.println("fileItem  formfield");
					System.out.println(fi);
				}
			}
		} catch (FileUploadException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("FileUploadException");
			PrintWriter out = resp.getWriter();
			out.println("<script>");
			out.println("parent.setUploadMessage(\"" + e.getMessage() + "\");");
			out.println("</script>");
			out.flush();
			out.close();
		} catch (Exception e){
			e.printStackTrace();
			PrintWriter out = resp.getWriter();
			out.println("<script>");
			out.println("parent.setUploadMessage(\"" + e.getMessage() + "\");");
			out.println("</script>");
			out.flush();
			out.close();
			
		}
		
		PrintWriter out = resp.getWriter();
		out.println("<script>");
		for(Picture p : p_list){
			//out.println(p.getPictureID() + ";");
			out.println("parent.addImg(\"" + p.getFullName() + "\", "+p.getPictureID() +");");
		}
		out.println("</script>");
		out.flush();
		out.close();		
	}

	
	
	
	
}
