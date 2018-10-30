<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>

            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Tables</h1>
                    		<h2>
			<a href="/board/register">Register</a>
		</h2>
                </div>
                <!-- /.col-lg-12 -->
            </div>

            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            	게시판
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>글번호</th>
                                            <th>제목</th>
                                            <th>글쓴이</th>
                                            <th>작성시간</th>
                                            <th>수정일</th>
                                            <th>삭제여부</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${list}" var ="board">
                                        <tr>
                                            <td><c:out value="${board.bno}"></c:out></td>
                                            <td><a href='/board/get?bno=${board.bno}'>
                                            <c:out value="${board.title}"/></a></td>
                                            <td><c:out value="${board.writer}"></c:out></td>
                                            <td><fmt:formatDate value="${board.regdate}"
											pattern="MM-dd / HH:mm"></fmt:formatDate></td>
                                            <td><fmt:formatDate value="${board.updatedate}"
											pattern="MM-dd / HH:mm"></fmt:formatDate></td>
											<td><c:out value="${board.del}"></c:out></td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
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
