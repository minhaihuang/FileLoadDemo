<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="js/jquery-1.8.3.js" language="JavaScript"></script>
</head>
<body>

<script type="text/javascript">
	var i = 1;
	function addFileInput(){
		var str = '<div id="fileInput'+i+'"><input type="file" name="upload'+i+'" /><a href="javascript:void(0)" onclick="deleteFileInput('+i+')">删除</a><br/></div>';
		var uploadDiv = document.getElementById("uploadDiv");
		uploadDiv.innerHTML += str; 
		i++;
	}
	function deleteFileInput(index){
		var fileDiv = document.getElementById("fileInput"+index);
		fileDiv.parentNode.removeChild(fileDiv);
	}
</script>
<script type="text/javascript">
	
</script>
<form action="FileUpLoadJindutiaoServlet"  method="post" enctype="multipart/form-data">
	<input type="file" name="upload0" /><a href="javascript:void(0)" onclick="addFileInput()">继续添加文件表单项</a><br/>
	<div id="uploadDiv"></div>
	<input type="submit" value="上传" onclick="updateProgress()"/>
</form>
<div id="bar1" style="display:none">
	<div id="bar2" style="width:300px;height:30px;background-color: #eeeeee;">
			<div id="bar3" style="width: 0%;height: 30px;background-color: blue;"></div><div id="percent"></div>
	</div>
</div>

<script type="text/javascript">
	//设置第一次访问的时间
	var lastTime=new Date().getTime();
	//定义一开始上传的字节数为0
	var lastUploadBytes=0;
	
	function updateProgress(){
		$("#bar1").css("display","block");//低级错误竟然把display写成了dispaly.靠
		setInterval("getData()", 200);
	}
	
	function getData(){
		//注意，是new Date().getTime().不是new Date.getTime(),少了一对括号，调了一个小时
		$.get("GetProgressDataServlet?"+new Date().getTime(),function(data){
			//获得当前访问的时间
			var currentTime=new Date().getTime();
			//计算公用了多长时间
			var useTime=currentTime-lastTime;
			//将当前时间设置为上一次访问的时间
			lastTime=currentTime;
			
			//将上传的数据获取到，然后切割，此数据从GetProgressDataServlet获取得到
			var datas=data.split(",");
			//获取到当前共上了多少数据
			var currentUploadBytes=parseFloat(datas[0]);
			//计算距离上一次又上传了多少的数据
			var addUploadBytes=currentUploadBytes-lastUploadBytes;
			//将当前上传了多少数据设置为上一次上传了多少数据
			lastUploadBytes=currentUploadBytes;
			
			//计算上传速度
			var speed=(addUploadBytes/1024/1024)/(useTime/1000.0);//单位是兆每秒
			
			//获得上传文件的总大小
			var totalSize=parseFloat(datas[1]);
			
			//计算当前上传的百分比
			var percent=currentUploadBytes/totalSize*100;
			
			//改变进度条的长度
			$("#bar3").css("width",percent+"%");
			alert(qwr432r);
			//显示上传进度
			$("#percent").html(percent.toFixed(2)+"%  速度:"+speed.toFixed(2)+" Mb/秒");
		});
	

		
	}
</script>
</body>
</html>