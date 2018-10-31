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


					<div class="form-group">
						<label>Title</label> <input class="form-control" name='title' value='<c:out value="${board.title}"/>' readonly="readonly">
						<p class="help-block"></p>
					</div>
					<div class="form-group">
						<label>Writer</label> <input class="form-control" name='writer' value='<c:out value="${board.writer}"/>' readonly="readonly">
						<p class="help-block"></p>
					</div>

					<div class="form-group">
						<label>Text area</label>
						<textarea class="form-control" name='content' rows="3" readonly="readonly"><c:out value="${board.content}"/></textarea>
					</div>

					<form role="form" action="modify" method="get">
						<input type='hidden' name='page' value="${pageObj.page}">
						<input type='hidden' name='bno' value="${board.bno}">
						<input type="hidden" name="display" value="${pageObj.display}">
						<input type='hidden' name='type' value='${pageObj.type}'>	
						<input type='hidden' name='keyword' value='${pageObj.keyword}'>			
						<button type="submit" class="btn btn-default">수정</button>
					</form>
					<form role="form" action="list" method="get">
					<input type="hidden" name="page" value="${pageObj.page}">
					<input type="hidden" name="display" value="${pageObj.display}">
					<input type='hidden' name='type' value='${pageObj.type}'>	
					<input type='hidden' name='keyword' value='${pageObj.keyword}'>			
					<button type="submit" class="btn btn-default">목록으로</button>
					</form>
				
			</div>
			<!-- /.panel-body -->
		</div>
		<!-- /.panel -->
	</div>
	<!-- /.col-lg-6 -->



</div>
<!-- /.row -->
<script type="text/javascript" src="/resources/js/reply.js"></script>

<script type="text/javascript">

console.log("=========");
console.log("JS TEST");

var bnoValue = '<c:out value="${board.bno}"/>';

//add test
/* replyService.add(
		{reply:"JS Test", replyer:"tester", bno:bnoValue},
		function(result){
			alert("RESULT: " + result);
		}
); */
//list test
/* replyService.getList({bno:bnoValue, page:1}, function(list){
	
	for (var i = 0, len = list.length||0; i<len; i++) {
		console.log(list[i]);
	}
}); */
/* replyService.remove(23, fuction(count){
	console.log(count);
	if(count==="success"){
		alert("REMOVED");
		}
	},function(err){
		alert('ERROR...');
	}); */ //코드가 이상함 확인점
	
	





</script>

<%@include file="../includes/footer.jsp"%>
</body>


</html>







