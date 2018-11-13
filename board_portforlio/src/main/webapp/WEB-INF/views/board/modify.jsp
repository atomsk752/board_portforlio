<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@include file="../includes/header.jsp"%>

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

				<form id='modifyForm' role="form" action="/board/modify" method="post">
				<input type='hidden' name='page' value="${pageObj.page}">
				<input type='hidden' name='bno' value="${board.bno}">
				<input type="hidden" name="display" value="${pageObj.display}">
				<input type='hidden' name='type' value='${pageObj.type}'>	
				<input type='hidden' name='keyword' value='${pageObj.keyword}'>	
			<div class="form-group">
						<label>Title</label> <input class="form-control" name='title' value='<c:out value="${board.title}"/>'>
						<p class="help-block"></p>
					</div>
					<div class="form-group">
						<label>Writer</label> <input class="form-control" name='writer' value='<c:out value="${board.writer}"/>'>
						<p class="help-block"></p>
					</div>

					<div class="form-group">
						<label>Text area</label>
						<textarea class="form-control" name='content' rows="3"><c:out value="${board.content}"/></textarea>
					</div>
<!--					<div class="form-group">
						<label>RegDate</label> <input class="form-control" name='regdate' value='<fmt:formatDate pattern = "yyyy/MM/dd"
						 value='<c:out value="${board.regdate}"/>'>
						<p class="help-block"></p>
					</div>
					<div class="form-group">
						<label>Update Date</label> <input class="form-control" name='updadate' value='<fmt:formatDate pattern = "yyyy/MM/dd"
						 value='<c:out value="${board.updatedate}"/>'>
						<p class="help-block"></p>
					</div>					-->
					<button id='modifyBtn' class="btn btn-default">수정</button>
					</form>
					<form role="form" action="remove" method="post">
						<input type='hidden' name='page' value="${pageObj.page}">
						<input type='hidden' name='bno' value="${board.bno}">
						<input type="hidden" name="display" value="${pageObj.display}">
						<input type='hidden' name='type' value='${pageObj.type}'>	
						<input type='hidden' name='keyword' value='${pageObj.keyword}'>	
						<button id='removeBtn' type="submit" class="btn btn-default">삭제</button>
					</form>
					<form action="/board/get" method="get">
						<input type='hidden' name='page' value="${pageObj.page}">
						<input type="hidden" name="display" value="${pageObj.display}">
						<input type='hidden' name='type' value='${pageObj.type}'>	
						<input type='hidden' name='keyword' value='${pageObj.keyword}'>	
					<button id='cancleBtn' type="submit" class="btn btn-default">취소</button>
					</form>
			</div>
			<!-- /.panel-body -->
		</div>
		<!-- /.panel -->
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="bigPictureWrapper">
	<div class="bigPicture">
	</div>
</div>
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
	width:100%;
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
	background-color: gray;
	z-index: 100;
	background: rgba(255,255,255,0.5);
}
.bigPicture{
	position: relative;
	display:flex;
	justify-content: center;
	align-items: center;
}
.bigPicture img{
	width:600px;
}
</style>
<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Files</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<div class="form-group uploadDiv">
					<input type="file" name='uploadFile' multiple="multiple">
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

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">Modal title</h4>
			</div>
			<div class="modal-body"></div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary">Save changes</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<%@include file="../includes/footer.jsp"%>
<script>
$(document).ready(function(){

	//file modify
	(function(){
		
	var bno = '<c:out value="${board.bno}"/>';
	
	$.getJSON("/board/getAttachList",{bno: bno}, function(arr){
		console.log(arr);

		var str ="";
		
		$(arr).each(function(i, attach){
			
			//image type
			if (attach.fileType) {
				var fileCallPath = encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
				str += "<li data-path='"+attach.uploadPath+"'";
				str +=" data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"'data-type='"+attach.fileType+"'"
				str += "><div>";
				str += "<span> "+ attach.fileName+"</span>";
				str += "<button type='button' data-file=\'"+fileCallPath+"\'data-type='image' ";
				str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<img src='/show?fileName="+fileCallPath+"'>";
				str += "</div>";
				str += "</li>";
			}else{
				
				str += "<li "
				str += "data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"'data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
				str += "<span> "+ attach.fileName +"</span><br/>";
				str += "<button type='button' data-file=\'"+fileCallPath+"\'data-type='file' ";
				str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<img src='/resources/img/attach.jpg'></a>";
				str += "</div>";
				str += "</li>";	
			}
		});
		
		$(".uploadResult ul").html(str);

		});//end get json
	
	})(); //end function
	
	
	var result = '<c:out value="${result}"/>';
	var msg = $("#myModal")
	checkModal(result);
	history.replaceState({},null,null)
	
	function checkModal(result){
		
		if(result === '' || history.state){
			return;
		}
		if(result === 'SUCCESS'){
			$(".modal-body").html("작업 성공");
			msg.modal("show");
		}

	}
	


	//add file
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

	//show image
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
	
	//file click remove
	$(".uploadResult").on("click", "button", function(e){
		
		console.log("delete file");
		
		if (confirm("Remove this file?")){
			
			var targetLi = $(this).closest("li");
			targetLi.remove();
			
		}
		
	});
	//modify button event
	$('#modifyBtn').on("click", function(e) {
		e.preventDefault();
		var str="";
		$(".uploadResult ul li").each(function(i,obj){
			var jobj=$(obj);
			console.log(jobj);
			str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";
			
		})
		
		$("#modifyForm").append(str).submit();
	});

	
});



</script>

</body>

</html>







