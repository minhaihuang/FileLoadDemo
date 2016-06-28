<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>多文件上传</title>
<script type="text/javascript">
		var i=1;
		function addFileInput(){
		var str = '<div id="fileInput'+i+'"><input type="file" name="upload'+i+'" /><input type="button" name="hh'+i+'" onclick="deleteFileInput('+i+')" value="删除"/><br/></div>';
		var uploadDiv = document.getElementById("divALl");
		uploadDiv.innerHTML += str; 
		i++;
		};
		
		function deleteFileInput(index){
		var fileDiv = document.getElementById("fileInput"+index);
		fileDiv.parentNode.removeChild(fileDiv);
		};
</script>
</head>
<body>
	<form action="FileUpLoadServlet" method="post" enctype="multipart/form-data">
		<input type="file" name="upload0"/>
		<input type="button" name="moreFile" onclick="addFileInput()" value="更多文件"/><br/>
	<div id=divALl></div><!-- 注意，一定要是空白的div才能添加多个项 -->
	<input type="submit" value="上传">
	</form>
</body>
</html>