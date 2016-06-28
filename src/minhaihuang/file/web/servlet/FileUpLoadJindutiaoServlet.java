package minhaihuang.file.web.servlet;
/**
 * 编程实现文件上传时的进度条
 */
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import minhaihuang.file.web.utils.Utils;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.ProgressListener;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class FileUpLoadJindutiaoServlet extends HttpServlet {

	public void doGet(final HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//1,创建文件项目工厂
		DiskFileItemFactory fileItemFactory=new DiskFileItemFactory();
		//1-1设置工厂对象的参数
		fileItemFactory.setSizeThreshold(1024*10);//设置阀数的大小
		String tempFilePath=getServletContext().getRealPath("/temp");//获取临时文件存储的目录
		fileItemFactory.setRepository(new File(tempFilePath));	//设置临时文件的目录
		
		//2,判断是否是上传文件的请求
		if(ServletFileUpload.isMultipartContent(request)){
			//3，创建文件上传对象
			ServletFileUpload fileUpload=new ServletFileUpload(fileItemFactory);
			
			//中文乱码 servletFileUpload.setHeaderEncoding("utf-8");
				fileUpload.setHeaderEncoding("UTF-8");
				
			//将上传了多少数据设置进入会话（session）对象中，方便创建进度条，需创建一个新的servlet来访问设置的内容
			fileUpload.setProgressListener(new ProgressListener() {
				
				public void update(long pBytesRead, long pContentLength, int pItems) {
					request.getSession().setAttribute("progress", pBytesRead+","+pContentLength+","+pItems);
				}
			});
			try {
				//4，获取上传文件列表
				List<FileItem> fileItems=fileUpload.parseRequest(request);
				
				//5,遍历列表，取出自己想要的文件类型
				for (FileItem fileItem : fileItems) {
					//不是表单项
					if(!fileItem.isFormField()){
						//获取文件名
						String fileName=fileItem.getName();
						
						if(fileName==null ||fileName.length()==0){
							continue;//跳过空文件
						}
						
						//获取文件的大小
						long size=fileItem.getSize();
						
						System.out.println("文件的大小为："+size);
						//获取文件内容，用输入流
						InputStream in=fileItem.getInputStream();
						
						//设置上传到的文件夹
						String filePath=getServletContext().getRealPath("/WEB-INF/upLoad/");
						
						//文件存放位置 按类型 , 按日期 , 按用户(排序)
						String dateString=Utils.getDateString();
						filePath+=dateString;
						
						//判断文件夹是否已经存在
						File file=new File(filePath);
						
						if(!file.exists()){
							//如果文件夹不存在，创建文件夹
							file.mkdirs();
						}
						
						//防止文件名重复
						fileName=Utils.getUUIDFileName(fileName);
						//设置输出流
						OutputStream out=new FileOutputStream(new File(filePath,fileName));
						
						//开始上传文件
						byte[] buff=new byte[1024];
						int len=0;
						while(-1!=(len=in.read(buff))){
							out.write(buff, 0, len);
						}
						
						out.flush();
						//关闭流
						out.close();
						in.close();	
						//一定要先关闭in.close
						fileItem.delete();//是否删除临时文件，一定要放在最后才有效果
					}
				}
			} catch (FileUploadException e) {
				
				e.printStackTrace();
			}
		}
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);

	}

}
