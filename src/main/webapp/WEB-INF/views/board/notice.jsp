<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
<!-- CSS 관련 파일 -->
	<%@ include file="/WEB-INF/views/common/head.jsp" %>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board.css"/>
	<script src="<c:url value="/resources/vendors/tinymce/tinymce.min.js"></c:url>"></script>
	<script src="<c:url value="/resources/js/tinymce/tinymceinit.js"></c:url>"></script>
	<script src="<c:url value="/resources/vendors/tinymce/themes/silver/theme.min.js"></c:url>"></script>
	<script src="${pageContext.request.contextPath}/resources/vendors/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
	<script>
	$(function(){
		$('#datepicker').datepicker({
		});	
	});
	function popup(){
        var url = "deleteboard";
        var name = "delete board";
        var option = "width = 500, height =250, top = 50, left = 200, location = no, resizable=no, scrollbars=no "
        window.open(url, name, option);
    }
	function requestBoardDetail(boardId) {
		$.ajax({
			url: getContextPath() + '/board/viewdetail/' + boardId,
			success: function(Board) {
				$("#boardTitle").text(Board.boardTitle);
				
				let boardDate = new Date(Board.boardDate);
				
				let year = boardDate.getFullYear();
				let month = boardDate.getMonth() + 1;
				let date = boardDate.getDate();
				
				let hours = boardDate.getHours();
				let minutes = boardDate.getMinutes();
				let seconds = boardDate.getSeconds();
				
				let completedDate = year + '/' + month + '/' + date + ' ' + hours + ':' + minutes + ':' + seconds;
				
				$("#boardDate").text(completedDate);
				tinymce.get("boardContent").setContent(Board.boardContent);
			}
		});
	}
	</script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendors/bootstrap-datepicker/bootstrap-datepicker.min.css" />
	<style>
	.table th, .jsgrid .jsgrid-table th,
	.table td,
	.jsgrid .jsgrid-table td {
	  padding: 0.525rem 1.375rem;
	}
	.dropdown-toggle::after{
		content:none;
	}
	collapse, .collapsing {
		box-shadow: 0px 0px 0px white !important;
	}
	</style>
</head>

<body>
	<div class="container-scroller ">
		<!-- Navbar -->
		<%@ include file="/WEB-INF/views/common/_navbar.jsp"%>
		<div class="container-fluid page-body-wrapper">
			<!-- Sidebar -->
			<%@ include file="/WEB-INF/views/common/_sidebar.jsp"%>

			<!-- 메인 body -->
			<div class="main-panel">
				<div class="content-wrapper">
					<div class="row">
						<div class="col-6 grid-margin stretch-card">
							<div class="card">
								<div class="card-body">
									<div class="row">
										<div class="col-md-12 grid-margin">
											<!-- main title -->
											<div class="d-flex justify-content-between align-items-center mb-4">
												<div class="card-title mb-0">사내 공지</div>
											</div><!-- 메인 title -->
										</div>
									</div>
									
									<!-- Start search box -->
									<form class="card gird-margin shadow-2 p-2" style="background-color: #e7e7ff">
				        				<div class="card-body" style="box-shadow: 0px 0px 0px white; padding-top: 0;">
				        					<div class="row form-inline">
												<div class=" form-group">
													<div class="card" style="border-radius:18px; border: 1px solid #4747A1;">
						        						<div class="input-daterange input-group" id="datepicker" style="border:none; background-color:transparent;">
															<span class="mdi mdi-calendar-clock text-primary" style="position: relative; z-index: 1; top:15px; left: 15px;"></span>
														    <input type="text" class="input-sm form-control" name="start" style="border:0px; text-align: right;"/>
														    <span class="input-group-addon text-primary font-weight-bold d-flex align-self-center mx-2 fs-30">~</span>
															<span class="mdi mdi-calendar-clock text-primary" style="position: relative; z-index: 1; top:15px; left: 15px;"></span>
														    <input type="text" class="input-sm form-control" name="end" style="border-radius:18px;border:0px; text-align: right;"/>
														</div>
													</div>
												</div>
											</div>
			        					</div>
			        					<div class="row form-inline py-0" style="padding: 1.25rem;">
											<div class="form-group" >
												<label class="h3 my-auto mr-1">카테고리</label>
												<div class="btn dropdown-toggle d-flex form-control" id="dropdownMenuButton1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"
													style="font-weight:bold;border-radius: 18px; border: 1px solid #4B49AC; background-color: white;">
													<i class="text-primary mdi mdi-menu-down"></i> 
													<input class="selectmenu my-auto" type="text" value="" style="border:none;width:120px;" readonly>
												</div>
												<div class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
													<h6 class="dropdown-item" id="select-1" onclick="select(1)">전체</h6>
													<h6 class="dropdown-item" id="select-2" onclick="select(2)">제목</h6> 
													<h6 class="dropdown-item" id="select-3" onclick="select(3)">작성자</h6>
												</div>
												<script>
											        function select(No){
											        	var x = document.getElementById("select-" + No).innerText;
											        	$(".selectmenu").val(x);
											        }
												</script>
											</div>
											<div class="form-group">
												<label class="h3 my-auto ml-2 mr-1">검색어</label>
												<input class="form-control p-0" type="text" style="border-radius: 18px; border: 1px solid #4B49AC;">
											</div>
											<div class="form-group">
												<button class="btn btn-md btn-primary ml-4" style="font-family: LeferiBaseType-RegularA; font-weight:700;">
													<span>검색</span>
												</button>
											</div>
										</div>
				        			</form><!-- End search box -->
									<!-- 테이블 -->
									<div class="table-responsive row">
										<table class="table table-hover">
											<thead>
												<tr>
													<th class="col-1">
														<div class="form-check font-weight-bold text-info">
															<label class="form-check-label">
																<input type="checkbox" class="form-check-input" name="optradio">
															</label>
														</div>
													</th>
													<th class="col-1">첨부</th>
													<th class="col-5">제목</th>
													<th class="col-2">작성자</th>
													<th class="col-2">작성날짜</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach items="${boardList}" var="board">
												<tr>
													<td>
														<div class="form-check font-weight-bold text-info">
															<label class="form-check-label">
																<input type="checkbox" class="form-check-input" name="optradio">
															</label>
														</div>
													</td>
													<c:choose>
													<c:when test="${board.boardFileYn == 'Y'}">
													<td><i class="h3 mdi mdi-paperclip text-primary"></i></td>
													</c:when>
													<c:otherwise><td></td></c:otherwise>
													</c:choose>
													<td><span onclick="requestBoardDetail(${board.boardId})">${board.boardTitle}</span></td>
													<td>${board.employee.empName}</td>
													<td><fmt:formatDate value="${board.boardDate}" pattern="yyyy/MM/dd HH:mm:ss"/></td>
												</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>
									<!-- 테이블 끝 -->
									
									<!-- 하단 버튼 -->
									<div class="row d-flex justify-content-end mr-3 my-3">
										<div class="mx-1">
											<button class="btn btn-danger btn-sm" onclick="popup()">선택삭제</button>
										</div>
										<div class="mx-1">
											<a class="btn btn-primary btn-sm" href="<c:url value='/board/write'/>">게시글 쓰기</a>
										</div>
									</div><!-- 하단 버튼 -->

									<!-- 페이징 -->
									<div class="row mt-3 d-flex justify-content-center">
										<ul class="pagination  pb-0 mb-0">
											<li class="page-item disabled"><a class="page-link" href="#">이전</a></li>
											<li class="page-item active" ><a class="page-link" href="#">1</a></li>
											<li class="page-item"><a class="page-link" href="#">2</a></li>
											<li class="page-item"><a class="page-link" href="#">3</a></li>
											<li class="page-item"><a class="page-link" href="#">다음</a></li>
										</ul>
									</div>
								</div>
							</div>
						</div>
						<!-- 게시글 자세히 보기 -->
						<div class="col-lg-6 grid-margin stretch-card">
							<div class="card">
								<div class="card-body">
								
									<div class="d-flex justify-content-between align-items-center mb-4">
										<div id="boardTitle" class="card-title mb-0">제목데이터</div>
										<div class="d-flex">
											<button class="btn btn-md btn-danger mx-2" onclick="popup()">
												<span class="mdi mdi-window-close align-middle"></span> 
												<span>삭제</span>
											</button>
										</div>
									</div>
									<div class="forms-sample">
										<div class="row">
											<div class="col-md-12">
												<div class="form-group row align-items-center">
													<div class="col-sm-2 text-primary">
														<div class="d-flex align-items-center m-1">
															<i class="h3 my-auto mdi mdi-calendar "></i> 
															<span class="font-weight-bold">날짜</span>
														</div>
													</div>
													<div class="col-sm-9" style="border-bottom:1px solid #ced4da;">
														<div id="boardDate" class="from-control" style="font-weight:bold; border:none;">날짜데이터</div>
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-md-12">
												<div class="form-group row align-items-center ">
													<div class="col-sm-3 text-primary">
														<div class="d-flex align-items-center m-1">
															<i class="h3 my-auto mdi mdi-dns"></i> 
															<span class="ml-2 font-weight-bold">카테고리</span>
														</div>
													</div>
													<div class="col-sm-3" style="border-bottom:1px solid #ced4da;">
														<div class="from-control" style="font-weight:bold; border:none;">사내공지</div>
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-md-12">
												<div class="form-group row">
													<textarea class="form-control" id="boardContent" readonly></textarea>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-md-12">
												<div class="form-group row">
													<div class="col-sm-3 text-primary">
														<div class="row d-flex align-items-center m-1">
															<i class="h3 my-auto mdi mdi-cloud-download"></i> 
															<span class="ml-2 font-weight-bold">파일 다운로드</span>
														</div>
													</div>
													<div class="col-sm-8 p-0"> 
														<div class="h3 form-control" style="font-weight:bold; height:120px;"></div>
													</div>
												</div>
											</div>
										</div>
									</div>
									
								</div>
							</div>
						</div><!-- end 게시글 자세히 보기 -->
					</div>
				</div>
				<!-- content-wrapper ends -->
				<!-- partial:partials/_footer.jsp -->
				<%@ include file="/WEB-INF/views/common/_footer.jsp"%>
				<!-- partial -->
			</div>
			<!-- main-panel ends -->
		</div>
		<!-- page-body-wrapper ends -->
	</div>
	<!-- container-scroller -->

</body>

</html>