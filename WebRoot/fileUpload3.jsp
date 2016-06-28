<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>演示进度条</title>
<script src="js/jquery-1.8.3.js" language="JavaScript"></script>

</head>
<body>
<script type="text/javascript">
	var i = 1;
	function addItem(){
		var str ="<div id='upload"+i+"'><input type='file' name='upload"+i+"' /><a href='javascript:void(0);'   onclick='deleteItem("+i+")' >删除</a></div>";
		document.getElementById("files").innerHTML += str;
		i++;
	}
	function deleteItem(index){
		var itemDiv = document.getElementById("upload"+index);
		itemDiv.parentNode.removeChild(itemDiv);
	}
</script>
<div style="float: right;"><a href="index.jsp">返回首页</a>   --  <a href="ListFileServlet">查看上传</a></div>
<form id="form" action="FileUpLoadJindutiaoServlet" method="post" enctype="multipart/form-data">
	<div id="files">
	<div><input type="file" name="upload0" /><a href="javascript:void(0);"  onclick="addItem()" >继续添加上传项</a></div>
	</div>
	<br/>
	<input type="submit" value="上传" onclick="displayProgress()">
</form>
<div id="progressBar"  style="display: none;">
	<div id="bar1" style="width: 500px;height: 20px;background-color: #eeeeee;">
		<div id="bar2" style="width: 0%;height: 20px;background-color: blue;"></div><div id="percent"></div>
	</div>
</div>
<script type="text/javascript">
	var lastTime = new Date().getTime();
	var lastUploadBytes = 0;
	
	function displayProgress(){
		$("#progressBar").css("display","block");
		setInterval("updateProgress()",200);
	}
	
	function updateProgress(){
		
		$.get("GetProgressDataServlet?"+new Date().getTime(), function(data){
			
			var currentTime = new Date().getTime();
  			var useTime = currentTime - lastTime;//本次计算距上次的时间
  			lastTime =  currentTime;
  			
  			
  			var datas = data.split(",");
  			var currentUploadBytes = parseFloat(datas[0]);
  			var uploadBytes = currentUploadBytes - lastUploadBytes;//又上传了多少字节
  			lastUploadBytes = currentUploadBytes;
  			var totalSize = parseFloat(datas[1]);
  			
  			
  			var speed = (uploadBytes/1024/1024) / (useTime/1000.0);//上传速度
  			var percent = currentUploadBytes/totalSize*100;//上传进度百分比
  			
  			$("#bar2").css("width",percent+"%");
  			$("#percent").html(percent.toFixed(2)+"%  速度:"+speed.toFixed(2)+" Mb/秒");
		});
	}
</script>
</body>
</html>