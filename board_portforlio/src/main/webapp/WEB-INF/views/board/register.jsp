<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@include file="../includes/header.jsp"%>



<style>
.uploadResult{
	width:100%;
	background-color: gray;
}
.uploadResult ul{
display:flex;
flex-flow: row;
justify-content: center;
align-items: center;
}
.uploadResult ul li{
list-style: none;
padding: 10px;
align-content: center;
text-align: center;
}
.uploadResult ul li img{
width: 100px;
}
.uploadResult ul li span{
color:white;
}
.bigPictureWrapper{
position: absolute;
display: none;
justify-content: center;
align-items: center;
top:0%;
width:100%;
height:100%;
background:rgba(255,255,255,0.5);
}
.bigPicture{
position: relative;
display: flex;
justify-content: center;
align-items: center;
}
.bigPicture img{
width:600px;
}
</style>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Register</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Board Register</div>
			<!-- /.panel-heading -->
			<div class="panel-body">

				<form role="form" action="/board/register" method="post">
					<div class="form-group">
						<label>Title</label> <input class="form-control" name='title' value='Sample Title'>
						<p class="help-block">Example block-level help text here.</p>
					</div>
					<div class="form-group">
						<label>Writer</label> <input class="form-control" name='writer' value='sampleUser'>
						<p class="help-block">Example block-level help text here.</p>
					</div>

					<div class="form-group">
						<label>Text area</label>
						<textarea class="form-control" name='content' rows="3">Sample Text</textarea>
					</div>

					<button type="submit" class="btn btn-default">등록</button>
					</form>
					<form action="/board/list" method="get">
					<button type="submit" class="btn btn-default">취소</button>
					</form>
				
			</div>
			<!-- /.panel-body -->
		</div>
		<!-- /.panel -->
	</div>
	<!-- /.col-lg-6 -->



</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">File Attach</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<div class="form-group uploadDiv">
					<input type="file" name="uploadFile" multiple>
				</div>
				
				<div class="uploadResult">
				<ul>
				
				</ul>
				</div>
				
			</div>
			<!-- /.panel-body -->
		</div>
		<!-- /.panel -->
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<script type="text/javascript">
$(document).ready(function(e){
	var formObj = $("form[role='form']");
	$("button[type='submit']").on("click", function(e){
		e.preventDfault();
		
		console.log("submit clicked");
		
	});
	
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880; //5mb
	
	function checkExtension(fileName, fileSize){
		
		if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
		if(regex.test(fileName)){
			alert("해당 종류의 파일은 업로드 불가");
			return false;
		}
		return true;
	}
	
	$("input[type='file']").change(function(e){
		
		var formData = new FormData();
		
		var inputFile = $("input[name='uploadFile']");
		
		var files = inputFile[0].files;
		
		for (var i = 0; i < files.length; i++) {
			if (!checkExtension(files[i].name, files[i].size)) {
				return false;
				
			}
			formData.append("uploadFile", files[i]);
		}
		
		$.ajax({
			url: '/uploadAjaxAction',
			processData: false,
			contentType: false,data:
			formData, type: 'POST',
			dataType: 'json',
			success: function(result){
				console.log(result);
				showUploadResult(result); //업로드 결과 처리
			}
			
		}); //$.ajax
		
	});
});

function showUploadResult(uploadResultArr){
	
	if (!uploadResultArr || uploadResultArr.length == 0){return;}
	
	var uploadUL = $(".uploadResult ul");
	
	var str = "";
	
	$(uploadResultArr).each(function(i, obj){
	
		//image type
		if (obj.image) {
			var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
			str += "<li data-path='"+obj.uploadPath+"'";
			str +=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"'data-type='"+obj.image+"'"
			str += "><div>";
			str += "<span> "+ obj.fileName+"</span>";
			str += "<button type='button' data-file=\'"+fileCallPath+"\' "
			str += "data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
			str += "<img src='/show?fileName="+fileCallPath+"'>";
			str += "</div>";
			str += "</li>";
			
		}else{
			var fileCallPath = encodeURIComponent( obj.uploadPath + "/"+obj.uuid +"_"+obj.fileName);
			var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
			
			str += "<li "
			str += "data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"'data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
			str += "<span> "+ obj.fileName +"</span>";
			str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file'"
			str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
			str += "<img src='/resources/img/attach.jpg'></a>";
			str += "</div>";
			str += "</li>";
			
		}
		
	});
	
	uploadUL.append(str);
	
}

$(".uploadResult").on("click", "button", function(e){
	
	console.log("delete file");
	
	var targetFile = $(this).data("file");
	var type = $(this).data("type");
	
	var targetLi = $(this).closest("li");
	
	$.ajax({
		url: '/deleteFile',
		data: {fileName: targetFile, type:type},
		dataType: 'text',
		type: 'POST',
		success: function(result){
			alert(result);
			targetLi.remove();
		}		
	});
	
});

var formObj = $("form[role='form']");
$("button[type='submit']").on("click", function(e){
	
	e.preventDefault();
	
	console.log("submit clicked");
	
	var str = "";
	
	$(".uploadResult ul li").each(function(i, obj){
		
		var jobj = $(obj);
		
		console.dir(jobj);
		
		str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
		str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
		str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
		str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";
		
	});
	
	formObj.append(str).submit();
	
});


</script>
<%@include file="../includes/footer.jsp"%>
</body>

</html>







