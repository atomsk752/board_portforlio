<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>

            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">게씨파안</h1>
                    		<h2>
			<a href="/board/register">Register</a>
		</h2>
                </div>
                <!-- /.col-lg-12 -->
            </div>
       	 <script>
         function change(obj) {
             //alert("change")
             var sizeValue = obj.options[obj.selectedIndex].value;
             console.log(sizeValue);
             self.location = "list?page=1&display="+sizeValue;
         }
   		 </script>
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                        <select onchange="change(this)">
                        <option value="10"${pageObj.display==10?"selected":""}"><c:out value="${pageObj.display}"></c:out></option>          
                        <option value="10"${pageObj.display==10?"selected":""}">10</option>
                        <option value="20"${pageObj.display==10?"selected":""}">20</option>
                        <option value="50"${pageObj.display==10?"selected":""}">50</option>
                        <option value="100"${pageObj.display==10?"selected":""}">100</option>
                    	</select>
                    	개 씩 모아보기
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
                                            <td><a href="${board.bno}" class="board">
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
                    <form id="actionForm">
						<input type='hidden' name='page' id='page' value='${pageObj.page}'>
						<input type='hidden' name='display' id='display' value='${pageObj.display}'>						
					</form>
							<div class="dataTables_paginate paging_simple_numbers" id="dataTables-example_paginate">
								<ul class="pagination">
								<c:if test="${pageObj.prev}">
									<li class="paginate_button previous" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_previous">
									<a href="${pageObj.start-1}">Previous</a></li>
								</c:if>
								<c:forEach begin="${pageObj.start}" end="${pageObj.end}" var="page">
									<li class="paginate_button" data-page="${page}"  aria-controls="dataTables-example" tabindex="0">
									<a href="${page}"><c:out value="${page}"></c:out></a></li>
								</c:forEach>
								<c:if test="${pageObj.next}">
									<li class="paginate_button next" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_next">
									<a href="${pageObj.end+1}">Next</a></li>
								</c:if>
								</ul>
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
	
	
	var actionForm = $("#actionForm");
	var pagination = $(".pagination li a");
	var pageNum = ${pageObj.page};
	
	
	$(".board").on("click", function(e){
		e.preventDefault();
		var bno = $(this).attr("href");
		actionForm.append("<input type='hidden' name='bno' value='"+bno+"'>");			
		actionForm.attr("action","/board/get").attr("method", "get").submit();
	});
	
	
	pagination.on("click", function(e){
		e.preventDefault();
		var target = $(this).attr("href");
		actionForm.find("input[name='page']").val(target);
		actionForm.attr("action", "/board/list").attr("method","get").submit();
	});
	$('.pagination li[data-page='+pageNum+']').addClass("active");
	

	
});



</script>



</body>

</html>
