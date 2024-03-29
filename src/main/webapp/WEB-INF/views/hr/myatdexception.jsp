<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<!-- inject css, js common file -->
<%@ include file="/WEB-INF/views/common/head.jsp"%>
<!-- endinject css, js common file -->

<!-- Plugin css,js for this page -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/vendors/bootstrap-datepicker/bootstrap-datepicker.min.css" />
<script
	src="${pageContext.request.contextPath}/resources/vendors/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>

<style>
.custom-border-left {
	border-left: 1px solid rgb(206, 212, 218);
}

.custom-border-right {
	border-right: 1px solid rgb(206, 212, 218);
}
</style>

<script>
	//datepicker 렌더링
	$(function() {
		$('#datepicker').datepicker({
			format : "yyyy-mm",
			startView : "months",
			minViewMode : "months",
			todayHighlight : true
		});

		$('#datepicker-application').datepicker({
			todayHighlight : true
		});
	});
	
	/* AJAX통신 -근무신청내역 상세보기*/
	function atdExcpDetail(id, category) {
		$.ajax({
           type: "GET",
           url: "../hr/atdexcpapprovaldetail?atdExcpId=" + id + "&atdExcpCategory=" + category,
           error: function () {
        	   swal({
    				  title: "조회실패",
    				  text: "조회실패 하였습니다.",
    				  icon: "error",
    				  button: "닫기",
   				});
           },
           success: function (data) {
               //작성폼 숨기기
               $("#atd-excp-write-form").hide();
			   //AJAX 통신에 의해 상세조회 내용 넣기
//                $("#atd-excp-detail").hide().fadeIn(500);
               $('#atd-excp-detail').html(data);
               $('#atd-excp-detail').show();
           }
   		});
	}
	
	/* 근무신청서 자세히보기에서 X버튼 누르면 다시 목록 커짐 */
	function backAtdList() {
// 		$("#atd-excp-detail").hide().fadeOut(400);
		$("#atd-excp-detail").hide();
		//숨겨놓은 휴가신청내역 목록 보이기
//        $("#atd-excp-write-form").hide().fadeIn(600);
       $("#atd-excp-write-form").show();
	}

	//근무시간수정, 추가근무신청서 양식 변경
	function applicationChange(data) {
		if (data == '근무시간수정') { //근무시간수정을 선택했을 경우
			$("#change-title").html("근무시간수정 신청");
		} else { //추가근무를 선택했을 경우
			$("#change-title").html("추가근무 보고");
		}

		$.ajax({
			type : 'GET',
			url : "../hr/atdapplicationform",
			data : {
				category : data
			},
			error : function() {
				swal({
	   				  title: "변경실패",
	   				  text: "작성폼 변경실패하였습니다.",
	   				  icon: "error",
	   				  button: "닫기",
   				});
			},
			success : function(data) {
				$("#change-form").html(data);
			}
		});
	}
</script>
<!-- End plugin css,js for this page -->
</head>

<body>
	<div class="container-scroller">
		<!-- Navbar -->
		<%@ include file="/WEB-INF/views/common/_navbar.jsp"%>

		<div class="container-fluid page-body-wrapper">
			<!-- Sidebar -->
			<%@ include file="/WEB-INF/views/common/_sidebar.jsp"%>

			<!-- partial -->
			<div class="main-panel">
				<div class="content-wrapper">
					<div class="row">
						<div class="col-md-6 grid-margin stretch-card">
							<div class="card">
								<div class="card-body">
									<!-- 근무신청목록 -->
									<div class="d-flex justify-content-between align-items-center mb-4">
										<div class="card-title mb-0">근무신청내역</div>
										<div class="d-flex justify-content-end" style="width: 70%;">
											<form action="<c:url value='/hr/myatdexception?pageNo=1'/>" method="POST">
												<div class="d-flex justify-content-end">
													<!-- datepicker start -->
													<div id="datepicker"
														class="input-daterange input-group text-primary"
														style="border: 2px solid #4B49AC; border-radius: 15px; width: 70%;">
														<span class="mdi mdi-calendar-clock"
															style="position: relative; z-index: 1; top: 12px; left: 15px;"></span>
														<input type="text"
															class="form-control-sm form-control font-weight-bold"
															name="startDate" style="border: 0px; text-align: center;">
														<span
															class="input-group-addon font-weight-bold d-flex align-self-center mx-2 fs-30">~</span>
														<span class="mdi mdi-calendar-clock"
															style="position: relative; z-index: 1; top: 12px; left: 15px;"></span>
														<input type="text"
															class="form-control-sm form-control font-weight-bold"
															name="endDate"
															style="border: 0px; border-radius: 15px; text-align: center;">
													</div>
													<!-- datepicker end -->
													<button type="submit" class="btn btn-md btn-primary ml-2">
														<span>검색</span>
													</button>
												</div>
											</form>
										</div>
									</div>
									<!-- 근무신청통계 -->
									<div class="card card-light-blue mb-4">
										<div class="card-body">
											<div class="row text-center"
												style="font-size: 13px; font-weight: bold;">
												<div class="col-md px-0">근무시간수정</div>
												<div class="col-md px-0">추가근무보고</div>
											</div>
											<div class="row text-center font-weight-bold h3 mb-0">
												<div class="col-md">${atdExcpStats['근무시간수정']}</div>
												<div class="col-md">${atdExcpStats['추가근무보고']}</div>
											</div>
										</div>
									</div>
									<!-- 근무신청내역 -->
									<div class="table-responsive">
										<table class="table table-hover">
											<thead>
												<tr>
													<th>신청유형</th>
													<th>신청날짜</th>
													<th>결재자</th>
													<th>진행상태</th>
												</tr>
											</thead>
											<tbody>
												<c:if test="${!empty atdExcpList}">
													<c:forEach var="atdExcp" items="${atdExcpList}">
														<tr onclick="atdExcpDetail('${atdExcp.atdExcpId}', '${atdExcp.atdExcpCategory}')">
															<td class="py-3"><small>${atdExcp.atdExcpCategory}</small></td>
															<td class="py-3"><small><fmt:formatDate value="${atdExcp.atdExcpDate}" pattern="yyyy/MM/dd" /></small></td>
															<td class="py-3">${atdExcp.atdExcpApprovalEmpName}</td>
															<td class="py-3">
																<!-- 결재상태 -->
																<c:if test="${atdExcp.atdExcpProcessState == '신청'}">
																	<div class="badge badge-secondary font-weight-bold text-white">${atdExcp.atdExcpProcessState}</div>
																</c:if>
																<c:if test="${atdExcp.atdExcpProcessState == '승인'}">
																	<div class="badge badge-success font-weight-bold">${atdExcp.atdExcpProcessState}</div>
																</c:if>
																<c:if test="${atdExcp.atdExcpProcessState == '반려'}">
																	<div class="badge badge-danger font-weight-bold">${atdExcp.atdExcpProcessState}</div>
																</c:if>
															</td>
														</tr>
													</c:forEach>
												</c:if>
												<c:if test="${empty atdExcpList}">
													<tr>
														<td></td>
														<td></td>
														<td></td>
														<td></td>
														<td></td>
													</tr>
												</c:if>
											</tbody>
										</table>
										<c:if test="${empty atdExcpList}">
											<div class="row mx-0 justify-content-center">해당 날짜의 목록이 없습니다.</div>
										</c:if>
									</div>
									<!-- 페이징 -->
									<c:if test="${!empty pager}">
										<div class="row mt-5 d-flex justify-content-center">
											<ul class="pagination pb-0 mb-0">
												<!-- 이전 -->
												<c:if test="${pager.groupNo > 1}">
													<li class="page-item disabled"><a class="page-link"
														href="<c:url value='/hr/myatdexception?pageNo=${pager.startPageNo-5}&startDate=${startDate}&endDate=${endDate}'/>">이전</a>
													</li>
												</c:if>
												<c:forEach var="i" begin="${pager.startPageNo}"
													end="${pager.endPageNo}" step="1">
													<!-- 선택할 페이지 -->
													<c:if test="${pager.pageNo != i}">
														<li class="page-item"><a class="page-link"
															href="<c:url value='/hr/myatdexception?pageNo=${i}&startDate=${startDate}&endDate=${endDate}'/>">${i}</a>
														</li>
													</c:if>
													<!-- 현재페이지 -->
													<c:if test="${pager.pageNo == i}">
														<li class="page-item active"><a class="page-link">${i}</a></li>
													</c:if>
												</c:forEach>
												<c:if test="${pager.groupNo < pager.totalGroupNo}">
													<li class="page-item"><a class="page-link"
														href="<c:url value='/hr/myatdexception?pageNo=${pager.startPageNo+5}&startDate=${startDate}&endDate=${endDate}'/>">다음</a></li>
												</c:if>
											</ul>
										</div>
									</c:if>
								</div>
							</div>
						</div>
						<!-- 상세보기 -->
						<div id="atd-excp-detail" class="col-md-6" style="display:none"></div>
						<!-- 근무신청폼 -->
						<div id="atd-excp-write-form" class="col-md-6 grid-margin stretch-card">
							<div class="card">
								<div class="card-body">
									<form>
										<div id="change-title" class="card-title">근무신청</div>
										<!-- 라디오 버튼을 통해 근무신청폼 바뀜 -->
										<div class="form-check">
				                            <label class="form-check-label">
				                            	<input type="radio" class="form-check-input" name="optionsRadios" id="optionsRadios1" onclick="applicationChange('근무시간수정')" value="">
				                              	근무시간수정 신청
				                            <i class="input-helper"></i></label>
				                        </div>
										<div class="form-check">
				                            <label class="form-check-label">
				                            	<input type="radio" class="form-check-input" name="optionsRadios" id="optionsRadios2" onclick="applicationChange('추가근무')" value="">
				                              	추가근무 보고
				                            <i class="input-helper"></i></label>
				                        </div>
										<!-- AJAX 작성폼이 바뀌는 부분 -->
										<div id="change-form">
											<div class="table-responsive px-3 py-2 mt-3">
												<!-- 고정 내용 -->
												<table class="table">
													<tbody>
														<tr class="custom-border-left custom-border-right">
															<td class="custom-border-right"><h4
																	class="font-weight-bold text-center m-0">작성자</h4></td>
															<td></td>
															<td></td>
															<td></td>
															<td class="custom-border-left custom-border-right"><h4
																	class="font-weight-bold text-center m-0">근무날짜</h4></td>
															<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
															<td></td>
														</tr>
														<tr class="custom-border-left custom-border-right">
															<td class="custom-border-right"><h4
																	class="font-weight-bold text-center m-0">결재자</h4></td>
															<td></td>
															<td></td>
															<td></td>
															<td></td>
															<td></td>
															<td></td>
														</tr>
														<tr>
															<td></td>
															<td></td>
															<td></td>
															<td></td>
															<td></td>
															<td></td>
															<td></td>
														</tr>
													</tbody>
												</table>
											</div>
											<!-- 변경내용-->
											<div class="container-fluid">
												<div class="row mt-3 justify-content-center">
													<div
														style="border: 1px solid #a3a4a5; opacity: 0.5; width: 90%;"></div>
												</div>
												<br><br><br><br><br><br><br>
												<br><br><br><br><br><br><br>
												<div class="row justify-content-center mt-3">
													<div style="border-bottom: 2px solid #4B49AC; width: 90%;"></div>
												</div>
											</div>
											<!-- 버튼 -->
											<div class="row px-5 mt-3 justify-content-end">
												<br>
												<br>
											</div>
											<!-- 변경내용:end -->
										</div>
									</form>
								</div>
								<!-- card:end -->
							</div>
						</div>
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