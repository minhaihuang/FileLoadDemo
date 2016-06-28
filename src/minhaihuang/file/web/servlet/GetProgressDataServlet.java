package minhaihuang.file.web.servlet;
/**
 * 获取上传数据的servlet，方便创建进度条，该servlet与FileUpLoadJindutiaoServlet关联
 */
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GetProgressDataServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String progress=(String) request.getSession().getAttribute("progress");
		
		response.getWriter().print(progress);
		System.out.println("------"+progress);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);

	}

}
