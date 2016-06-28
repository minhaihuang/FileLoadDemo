<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>多文件上传</title>
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

<form action="FileUploadServlet1"  method="post" enctype="multipart/form-data">
	<input type="file" name="upload0" /><a href="javascript:void(0)" onclick="addFileInput()">继续添加文件表单项</a><br/>
	<div id="uploadDiv"></div>
	<input type="submit" value="上传" />
</form>

</body>
</html>