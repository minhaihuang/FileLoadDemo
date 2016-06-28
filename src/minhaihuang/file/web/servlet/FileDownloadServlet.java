package minhaihuang.file.web.servlet;
/**
 * 这是测试下载文件的servlet
 */
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FileDownloadServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//1，获取需要请求的资源名称
		String fileName=request.getParameter("source");
		//编码文件名，若不编码，如果文件名是中文，就会有错
		fileName = new String(fileName.getBytes("ISO-8859-1"), "UTF-8");
		//2，判断该资源是否存在
		String filePath=getServletContext().getRealPath("WEB-INF/sources/");
		File file=new File(filePath,fileName);
		if(!file.exists()){
			//文件不存在，输出错误信息，返回
			response.setHeader("Content-Type", "text/plain;charset=utf-8");
			response.getWriter().print("该文件不存在或者已经被删除，或者是文件编码的问题");
			return;
		}
		
		//文件存在
		//让用户决定是直接打开还是下载
		response.setContentType("application/x-msdownload");
		//文件名的编码，预防乱码的情况
		fileName=URLEncoder.encode(fileName, "UTF-8");
		response.setHeader("Content-Disposition","attachment;filename="+fileName);
		System.out.println(fileName);
		//输出到控制台
		InputStream in=new FileInputStream(file);
		OutputStream out=response.getOutputStream();//向浏览器发送文件内容
		
		int len=0;
		byte[] b=new byte[1024*10];
		while(-1!=(len=in.read(b))){
			out.write(b, 0, len); 
		 }
		
		in.close();
		out.close();
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
		
	}

}
