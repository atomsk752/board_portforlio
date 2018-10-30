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

				<form role="form" action="/board/modify" method="post">
				<input type='hidden' name='page' value="${pageObj.page}">
				<input type='hidden' name='bno' value="${board.bno}">
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
					</div>					
  -->
					<button type="submit" data-oper='modify' class="btn btn-default">수정</button>
					</form>
					<form role="form" action="remove" method="post">
						<input type='hidden' name='page' value="${pageObj.page}">
						<input type='hidden' name='bno' value="${board.bno}">
						<button type="submit" class="btn btn-default">삭제</button>
					</form>
					<form action="/board/list" method="get">
						<input type='hidden' name='page' value="${pageObj.page}">
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
	
});



</script>

</body>

</html>







