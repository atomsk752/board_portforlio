<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>Upload with Ajax</h1>

<div class="uploadDiv">
	<input type="file" name="uploadFile" multiple>
</div>

<button id="uploadBtn">Upload</button>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
$(document).ready(function(){
	
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242800; //5MB
	
	function checkExtension(fileName, fileSize){
		
		if (fileSize>= maxSize) {
			alert("It's Over 9000!(5MB max)");
			return false;
		}
		
		if (regex.test(fileName)) {
			alert("해당 종류의 파일은 안사요 안사");
			return false;
		}
		return true;
	}
	
	
	$("#uploadBtn").on("click", function(e){
		
		var formData = new FormData();
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files;
		
		console.log(files);
		
		for (var i = 0; i < files.length; i++) {
			
			if (!checkExtension(files[i].name, files[i].size)) {
				return false;
			}
			
			formData.append("uploadFile", files[i]);
			
		}
		
		$.ajax({
			url: '/uploadAjaxAction',
			processData: false,
			contentType: false,
			data: formData,
			type: 'POST',
			dataType: 'json',
			success: function(result){
				console.log(result);
			}
		}); //ajax
		
	});
});

</script>
</body>
</html>