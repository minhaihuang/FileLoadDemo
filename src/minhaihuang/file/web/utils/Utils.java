package minhaihuang.file.web.utils;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

/**
 * 文件上传下载的工具类
 * @author 黄帅哥
 *
 */
public class Utils {
	private static DateFormat dateFormat=new SimpleDateFormat("yyyy/MM/dd");
	
	/**
	 * 获取当前的日期，根据日期进行排序
	 * @return
	 */
	public static String getDateString(){
		return dateFormat.format(new Date());
	}
	
	public static void main(String[] args) {
		//System.out.println(getDateString());
		System.out.println(getUUIDFileName("aa.txt"));
	}
	
	/**
	 * 防止文件名重复
	 * @return
	 */
	public static String getUUIDFileName(String fileName) {
		
		String newFileName=UUID.randomUUID().toString()+fileName;
		
		return newFileName;
	}
}
