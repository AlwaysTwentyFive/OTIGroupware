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
	<style>
	.custom-border-bottom {
		border-bottom: 3px solid #4B49AC;
		opacity: 0.4;
	}
	a {
		color:black;
	}
	a:hover {
		text-decoration: none;
	}
	.swal2-title,
	.swal2-content {
	  font-size: 16px; /* 원하는 폰트 크기로 수정 */
	}
	</style>

	<script>
		//근무상태 변경가능한 셀렉박스
		function getContextPath() {
		   return window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
		}
		function select(item) {
	    	$("#selectbox-btn-name").html(item);
	    }
		function open(){
			swal({
				  title: "초기 비밀번호 입니다.",
				  text: "마이페이지에서 수정 부탁드립니다!",
				  icon: "warning",
				  buttons: {
				  confirm: {
				      text: "수정",
				      value: true,
				      visible: true,
				      className: "",
				      closeModal: true
				    },
				    cancel: {
				      text: "닫기",
				      value: null,
				      visible: true,
				      className: "",
				      closeModal: true,
				    }
				  },
				})
				.then((value) => {
				  if (value) {
					  location.href= getContextPath() + "/employee/mypage/";
				  } else {
				     close();
				  }
			});
		}
		
	</script>
<!-- End plugin css,js for this page -->
</head>

<c:if test="${sessionScope.employee.initialPasswordYN == 'Y'}">
	<body onload="open()">
</c:if>
<c:if test="${sessionScope.employee.initialPasswordYN == 'N'}">
	<body>
</c:if>
	<input type="hidden" value=""/>
	<div class="container-scroller">
		<!-- Navbar -->
		<%@ include file="/WEB-INF/views/common/_navbar.jsp"%>
		<div class="container-fluid page-body-wrapper">
			<!-- Sidebar -->
			<%@ include file="/WEB-INF/views/common/_sidebar.jsp"%>
			<!-- partial -->
			<div class="main-panel">
				<div class="content-wrapper">
					<!-- 사진 / 퀵메뉴 / 프로필 / 출퇴근 / 달력 -->
					<div class="row">
						<div class="col-md-2 grid-margin stretch-card">
							<div class="card">
								<div class="card-body" style="background-color: #e7e7ff;">
									<!-- 사진 -->
									<div class="row justify-content-center px-2">
										<img src="<c:url value='/login/filedownload'/>"
											style="width: 90%; border-radius: 20px; box-shadow: 3px 3px 6px #4747A1;" />
									</div>
									<!-- 프로필 -->
									<div class="row mt-4 pt-2 justify-content-center"
										style="font-family: LeferiPoint-WhiteObliqueA;">
										<div class="ml-1">
											<span class="font-weight-bold text-primary h2">${employee.empName}</span>
											<span class="font-weight-bold h5">${employee.posName}</span>
											<div class="font-weight-bold text-muted h6 mt-2 text-center">${employee.depName}</div>
										</div>
									</div>
									<div class="custom-border-bottom mt-4"></div>
									<!-- 잔여일수 -->
									<div class="row mt-3 pt-2 px-3">
										<div class="col-md p-0">
											<div class="row pr-2"
												style="font-family: LeferiPoint-WhiteObliqueA; font-size: 13px;">
												<div
													class="col-md font-weight-bold text-primary px-0 text-center">잔여연차</div>
												<div
													class="col-md font-weight-bold text-primary px-0 text-center">잔여대체휴무</div>
											</div>
											<div class="row pr-2">
												<div class="col-md font-weight-bold h3 text-center">${employee.empLeaveReserve}</div>
												<div class="col-md font-weight-bold h3 text-center">${employee.empSubstitueReserve}</div>
											</div>
										</div>
									</div>
									<div class="custom-border-bottom mt-2 pt-2"></div>
									<!-- 퀵메뉴 -->
									<div class="row mt-4 pt-2">
										<div
											class="col-md h3 text-primary font-weight-bold text-center"
											style="font-family: LeferiPoint-WhiteObliqueA;">Quick
											menu</div>
									</div>
									<div class="row px-1 pt-3">
										<div class="col-sm px-0">
											<button
												onclick="location.href='<c:url value='/mail/mailwrite'/>'"
												class="btn btn-md btn-inverse-primary d-flex align-items-center mx-auto px-3">
												<span class="h3 mdi mdi-lead-pencil m-0"></span> <span
													class="ml-1">메일<br>쓰기
												</span>
											</button>
										</div>
										<div class="col-sm px-0">
											<button
												onclick="location.href='<c:url value='/approval/approvalwrite'/>'"
												class="btn btn-md btn-inverse-primary d-flex align-items-center mx-auto px-3">
												<span class="h3 mdi mdi-file-document m-0"></span> <span
													class="ml-1">결재<br>신청
												</span>
											</button>
										</div>
									</div>
									<div class="row pt-4 px-1">
										<div class="col-sm px-0">
											<button
												onclick="location.href='<c:url value='/hr/myleave'/>'"
												class="btn btn-md btn-inverse-primary d-flex align-items-center mx-auto px-3">
												<span class="h3 mdi mdi-wallet-travel m-0"></span> <span
													class="ml-1">휴가<br>신청
												</span>
											</button>
										</div>
										<div class="col-sm px-0">
											<button
												onclick="location.href='<c:url value='/employee/mypage'/>'"
												class="btn btn-md btn-inverse-primary d-flex align-items-center mx-auto pl-2 pr-3">
												<span class="h3 mdi mdi-emoticon m-0"></span> <span
													class="ml-1" style="font-size: 12px;">프로필<br>수정
												</span>
											</button>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-10">
							<div class="row">
								<!-- 출/퇴근 -->
								<div class="col-md-8 grid-margin stretch-card">
									<div class="card">
										<div class="card-body">
											<p class="card-title">오늘의 근무</p>
											<div class="row ml-3 mt-3 pt-2">
												<!-- 현재시간 -->
												<div class="col-md-4">
													<div id="now-date" class="font-weight-bold h4 text-muted"></div>
													<div id="now-time" class="font-weight-bold h1"></div>
													<script>
					                        $( document ).ready(function() {
					                           const clock1 = document.getElementById("now-date");
					                           const clock2 = document.getElementById("now-time");
					                  
					                           function getClock(){
					                             const d = new Date();
					                             const y = String(d.getFullYear()).padStart(4);
					                             const M = String(d.getMonth() + 1).padStart(2,"0");
					                             const da = String(d.getDate()).padStart(2,"0");
					                             const h = String(d.getHours()).padStart(2,"0");
					                             const m = String(d.getMinutes()).padStart(2,"0");
					                             const s = String(d.getSeconds()).padStart(2,"0");
					                             clock1.innerText = y + "년 " + M + "월 " + da + "일";
					                             clock2.innerText = h + ":" + m + ":" + s;
					                           }
					                        
					                           getClock(); //맨처음에 한번 실행
					                           setInterval(getClock, 1000); //1초 주기로 새로실행
					                        });
					                     </script>
												</div>
												<!-- 근무상태 -->
												<div class="col-md-7 d-flex align-items-end ml-4">
													<div id="select-btn">
														<!-- 출근버튼 클릭전 or 퇴근버튼 클릭 후 -->
														<c:if
															test="${empty attendance.atdInTime && empty attendance.atdOutTime}">
															<button class="btn btn-lg btn-outline-light"
																type="button"
																style="width: 200%; height: 90%; font-size: 130%; font-weight: bold; border: 1px solid #A3A4A5;">
																<span>미출근</span>
															</button>
														</c:if>
														<!-- 출근버튼 클릭후 -->
														<c:if test="${!empty attendance.atdInTime && empty attendance.atdOutTime && (attendance.atdState ne '연차' && attendance.atdState ne '대체휴무')}">
															<button
																class="btn btn-lg btn-outline-light px-4"
																type="button" id="dropdownMenuButton1"
																data-toggle="dropdown" aria-haspopup="true"
																aria-expanded="true"
																style="width: 300%; height: 90%; font-size: 130%; font-weight: bold; border: 1px solid #A3A4A5;">
																<span id="selectbox-btn-name">근무중</span>
															</button>
														</c:if>
														<!-- 퇴근버튼까지 눌렀을 때 -->
														<c:if test="${!empty attendance.atdOutTime && (attendance.atdState ne '연차' && attendance.atdState ne '대체휴무')}">
															<button class="btn btn-lg btn-outline-light"
																type="button"
																style="width: 200%; height: 90%; font-size: 130%; font-weight: bold; border: 1px solid #A3A4A5;">
																<span>퇴근완료</span>
															</button>
														</c:if>
														<!-- 휴가중일 때 -->
														<c:if test="${!empty attendance.atdInTime && (attendance.atdState eq '연차' || attendance.atdState eq '대체휴무')}">
															<button
																class="btn btn-lg btn-outline-light px-4"
																type="button" id="dropdownMenuButton1"
																data-toggle="dropdown" aria-haspopup="true"
																aria-expanded="true"
																style="width: 300%; height: 90%; font-size: 130%; font-weight: bold; border: 1px solid #A3A4A5;">
																<span id="selectbox-btn-name">휴가중</span>
															</button>
														</c:if>
													</div>
												</div>
											</div>
											<!-- 출퇴근 버튼 -->
											<div class="row mt-2 pt-4">
												<!-- 출근 -->
												<div class="col-md">
													<!-- 출근버튼 클릭 전 -->
													<c:if test="${empty attendance.atdInTime && attendance.atdState ne '연차' && attendance.atdState ne '대체휴무'}">
														<div class="card card-dark-blue">
															<div class="card-body">
																<div class="row">
																	<div class="col-md d-flex align-items-center">
																		<button onclick="location.href='${pageContext.request.contextPath}/hr/intime?nowJsp=home'"
																			class="btn btn-md btn-light text-primary px-3">
																			<h3 class="d-flex align-items-center font-weight-bold mb-0 pt-1">
																				<div class="mdi mdi-alarm-check"></div>
																				<div class="ml-2">출근</div>
																			</h3>
																		</button>
																	</div>
																	<div class="col-md d-flex align-items-center">
																		<h2 class="mb-0">&nbsp;&nbsp;</h2>
																	</div>
																</div>
															</div>
														</div>
													</c:if>
													<!--  출근버튼 클릭 후 -->
													<c:if
														test="${!empty attendance.atdInTime && empty attendance.atdOutTime && attendance.atdState ne '연차' && attendance.atdState ne '대체휴무'}">
														<div class="card bg-secondary">
															<div class="card-body">
																<div class="row">
																	<div class="col-md d-flex align-items-center">
																		<button
																			class="btn btn-md btn-light text-secondary px-3"
																			style="pointer-events: none;">
																			<h3
																				class="d-flex align-items-center font-weight-bold mb-0 pt-1">
																				<div class="mdi mdi-alarm-check"></div>
																				<div class="ml-2">출근</div>
																			</h3>
																		</button>
																	</div>
																	<div class="col-md d-flex align-items-center">
																		<h2 class="mb-0 text-light">
																			<fmt:formatDate pattern="HH:mm"
																				value="${attendance.atdInTime}" />
																		</h2>
																	</div>
																</div>
															</div>
														</div>
													</c:if>
													<!-- 퇴근버튼 클릭 후 -->
													<c:if test="${(!empty attendance.atdInTime && !empty attendance.atdOutTime) || (attendance.atdState eq '연차' || attendance.atdState eq '대체휴무')}">
														<div class="card bg-secondary">
															<div class="card-body">
																<div class="row">
																	<div class="col-md d-flex align-items-center">
																		<button
																			class="btn btn-md btn-light text-secondary px-3"
																			style="pointer-events: none;">
																			<h3
																				class="d-flex align-items-center font-weight-bold mb-0 pt-1">
																				<div class="mdi mdi-alarm-check"></div>
																				<div class="ml-2">출근</div>
																			</h3>
																		</button>
																	</div>
																	<div class="col-md d-flex align-items-center">
																		<c:if
																			test="${attendance.atdState ne '연차' && attendance.atdState ne '대체휴무'}">
																			<h2 class="mb-0 text-light">
																				<fmt:formatDate pattern="HH:mm"
																					value="${attendance.atdInTime}" />
																			</h2>
																		</c:if>
																		<c:if
																			test="${attendance.atdState eq '연차' || attendance.atdState eq '대체휴무'}">
																			<h2 class="mb-0 text-light">
																				휴가<span class="h3 ml-2">中</span>
																			</h2>
																		</c:if>
																	</div>
																</div>
															</div>
														</div>
													</c:if>
												</div>
												<!-- 퇴근 -->
												<div class="col-md">
													<!-- 출근버튼 클릭 전 -->
													<c:if
														test="${empty attendance.atdInTime && attendance.atdState ne '연차' && attendance.atdState ne '대체휴무'}">
														<div class="card bg-secondary">
															<div class="card-body">
																<div class="row">
																	<div class="col-md d-flex align-items-center">
																		<button
																			class="btn btn-md btn-light text-secondary px-3"
																			style="pointer-events: none;">
																			<h3
																				class="d-flex align-items-center font-weight-bold mb-0 pt-1">
																				<div class="mdi mdi-alarm-off"></div>
																				<div class="ml-2">퇴근</div>
																			</h3>
																		</button>
																	</div>
																	<div class="col-md d-flex align-items-center">
																		<h2 class="mb-0 text-light">&nbsp;&nbsp;</h2>
																	</div>
																</div>
															</div>
														</div>
													</c:if>
													<!--  출근버튼 클릭 후 -->
													<c:if test="${!empty attendance.atdInTime && empty attendance.atdOutTime && attendance.atdState ne '연차' && attendance.atdState ne '대체휴무'}">
														<div class="card card-light-danger">
															<div class="card-body">
																<div class="row">
																	<div class="col-md d-flex align-items-center">
																		<button
																			onclick="location.href='${pageContext.request.contextPath}/hr/outtime?nowJsp=home'"
																			class="btn btn-md btn-light text-danger px-3">
																			<h3
																				class="d-flex align-items-center font-weight-bold mb-0 pt-1">
																				<div class="mdi mdi-alarm-off"></div>
																				<div class="ml-2">퇴근</div>
																			</h3>
																		</button>
																	</div>
																	<div class="col-md d-flex align-items-center">
																		<h2 class="mb-0 text-light">&nbsp;&nbsp;</h2>
																	</div>
																</div>
															</div>
														</div>
													</c:if>
													<!-- 퇴근버튼 클릭 후 -->
													<c:if test="${(!empty attendance.atdInTime && !empty attendance.atdOutTime) || (attendance.atdState eq '연차' || attendance.atdState eq '대체휴무')}">
														<div class="card bg-secondary">
															<div class="card-body">
																<div class="row">
																	<div class="col-md d-flex align-items-center">
																		<button
																			class="btn btn-md btn-light text-secondary px-3"
																			style="pointer-events: none;">
																			<h3
																				class="d-flex align-items-center font-weight-bold mb-0 pt-1">
																				<div class="mdi mdi-alarm-off"></div>
																				<div class="ml-2">퇴근</div>
																			</h3>
																		</button>
																	</div>
																	<div class="col-md d-flex align-items-center">
																		<c:if
																			test="${attendance.atdState ne '연차' && attendance.atdState ne '대체휴무'}">
																			<h2 class="mb-0 text-light">
																				<fmt:formatDate pattern="HH:mm"
																					value="${attendance.atdOutTime}" />
																			</h2>
																		</c:if>
																		<c:if
																			test="${attendance.atdState eq '연차' || attendance.atdState eq '대체휴무'}">
																			<h2 class="mb-0 text-light">
																				휴가<span class="h3 ml-2">中</span>
																			</h2>
																		</c:if>
																	</div>
																</div>
															</div>
														</div>
													</c:if>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!-- 달력  -->
								<div class="col-md-4 grid-margin">
									<%@ include
										file="/WEB-INF/views/fullcalendar/home_calendar.jsp"%>
								</div>
							</div>
							<div class="row">
								<!-- 최근메일 -->
								<div class="col-md-6 grid-margin stretch-card">
									<div class="card">
										<div class="card-body">
											<p class="card-title mb-3">최근 받은메일</p>
											<div class="card card-tale mb-2">
												<div class="card-body">
													<div class="row">
														<a href="<c:url value='/mail/receivedmail'/>" class="col-md" style="color:white;">
															받은메일<span class="pl-2 h4 font-weight-bold">${mailCount.receivedCount}</span>
														</a>
														<a href="<c:url value='/mail/receivedmail'/>" class="col-md" style="color:white;">
															안읽음<span class="pl-2 h4 font-weight-bold">${mailCount.notReadCount}</span>
														</a>
														<a href="<c:url value='/mail/importmail'/>" class="col-md" style="color:white;">
															중요메일<span class="pl-2 h4 font-weight-bold">${mailCount.importCount}</span>
														</a>
														<a href="<c:url value='/mail/tempmail'/>" class="col-md" style="color:white;">
															임시저장<span class="pl-2 h4 font-weight-bold">${mailCount.tempCount}</span>
														</a>
													</div>
												</div>
											</div>
											<div class="table-responsive">
												<table class="table table-hover" style="table-layout: fixed">
													<thead>
														<tr>
															<th class="px-0 col-2">발신인</th>
															<th class="px-0 col-6">제목</th>
															<th class="px-0 col-3">날짜</th>
														</tr>
													</thead>
													<tbody>
														<c:if test="${!empty receivedmail}">
															<c:forEach items="${receivedmail}" var="recd">
																<tr class="py-1">
																	<td class="pl-1" style="font-size: 14px;">
																		${recd.empName} ${recd.posName} 
																	</td>
																	<td class="pl-1" width="150"
																		onclick="location.href='<c:url value="/mail/detailmail/received/${recd.sendMailId}"/>'"
																		style="font-size: 13px; text-overflow: ellipsis; overflow: hidden; white-space: nowrap;">
																		${recd.sendMailTitle}
																	</td>
																	<td class="pl-1" style="font-size: 13px;">
																		<fmt:formatDate pattern="MM월 dd일   HH:mm:ss" value="${recd.recdMailDate}"/>
																	</td>
																</tr>
															</c:forEach>
														</c:if>
														<c:if test="${empty receivedmail}">
														<tr></tr>
														<tr><td>메일함이 비었습니다.</td></tr>
														<tr></tr>
														</c:if>
													</tbody>
												</table>
											</div>
										</div>
									</div>
								</div>
								<!-- 최근 결재내역-->
								<div class="col-md-6 grid-margin stretch-card">
									<div class="card">
										<div class="card-body">
											<p class="card-title mb-3">최근 상신 문서</p>
											<div class="card card-light-blue mb-2">
												<div class="card-body">
													<div class="row">
														<div class="col-md"><a class="text-white" href='<c:url value="/approval/draftdocument"/>'>
														승인<span class="pl-2 h4 font-weight-bold">
														<c:if test='${approvalStatistics["승인"] != null}'>${approvalStatistics["승인"]}</c:if>
														<c:if test='${approvalStatistics["승인"] == null}'>0</c:if></span></a>
														</div>
														<div class="col-md"><a class="text-white" href='<c:url value="/approval/returneddocument"/>'>
														반려<span class="pl-2 h4 font-weight-bold">
														<c:if test='${approvalStatistics["반려"] != null}'>${approvalStatistics["반려"]}</c:if>
														<c:if test='${approvalStatistics["반려"] == null}'>0</c:if></span></a>
														</div>
														<div class="col-md"><a class="text-white" href='<c:url value="/approval/draftdocument"/>'>
														진행<span class="pl-2 h4 font-weight-bold">
														<c:if test='${approvalStatistics["진행"] != null}'>${approvalStatistics["진행"]}</c:if>
														<c:if test='${approvalStatistics["진행"] == null}'>0</c:if></span></a>
														</div>
														<div class="col-md"><a class="text-white" href='<c:url value="/approval/draftdocument"/>'>
														열람<span class="pl-2 h4 font-weight-bold">
														<c:if test='${approvalStatistics["열람"] != null}'>${approvalStatistics["열람"]}</c:if>
														<c:if test='${approvalStatistics["열람"] == null}'>0</c:if></span></a>
														</div>
														<div class="col-md"><a class="text-white" href='<c:url value="/approval/draftdocument"/>'>
														회수<span class="pl-2 h4 font-weight-bold">
														<c:if test='${approvalStatistics["회수"] != null}'>${approvalStatistics["회수"]}</c:if>
														<c:if test='${approvalStatistics["회수"] == null}'>0</c:if></span></a>
														</div>
													</div>
												</div>
											</div>
											<div class="table-responsive">
												<table class="table table-hover">
													<thead>
														<tr>
															<th class="px-0" style="width: 25%">결재상태</th>
															<th class="px-0" style="width: 75%">제목</th>
														</tr>
													</thead>
													<tbody>
													<c:if test="${documents != null}">
														<c:forEach items="${documents}" var="document" varStatus="status">
														<tr>
<%-- 														<td class="pl-1" style="font-size: 14px;">${document.docId}</td> --%>
															<c:choose>
															<c:when test="${document.docState == '진행'}">
															<td class="pl-1" style="font-size: 13px;">
															<div class="badge badge-info font-weight-bold d-flex" style="width: fit-content;">
															<i class="mdi mdi-file-document d-flex align-self-center mr-1"></i><span>진행</span></div>
															</td>
															</c:when>
															<c:when test="${document.docState == '열람'}">
															<td class="pl-1" style="font-size: 13px;">
															<div class="badge badge-warning font-weight-bold d-flex" style="width: fit-content;">
															<i class="mdi mdi-file-document d-flex align-self-center mr-1"></i><span>열람</span></div>
															</td>
															</c:when>
															<c:when test="${document.docState == '승인'}">
															<td class="pl-1" style="font-size: 13px;">
															<div class="badge badge-success font-weight-bold d-flex" style="width: fit-content;">
															<i class="mdi mdi-file-document d-flex align-self-center mr-1"></i><span>승인</span></div>
															</td>
															</c:when>
															<c:when test="${document.docState == '반려'}">
															<td class="pl-1" style="font-size: 13px;">
															<div class="badge badge-danger font-weight-bold d-flex" style="width: fit-content;">
															<i class="mdi mdi-file-document d-flex align-self-center mr-1"></i><span>반려</span></div>
															</td>
															</c:when>
															<c:when test="${document.docState == '회수'}">
															<td class="pl-1" style="font-size: 13px;">
															<div class="badge badge-secondary font-weight-bold d-flex" style="width: fit-content;">
															<i class="mdi mdi-file-document d-flex align-self-center mr-1"></i><span>회수</span></div>
															</td>
															</c:when>
															</c:choose>
															<td class="pl-1" style="font-size: 14px;"><a href="<c:url value='/approval/viewdetail/${document.docId}'/>">${document.docTitle}</a></td>
														</tr>
														</c:forEach>
													</c:if>
													<c:if test="${documents == null}">
														<tr>
															<th class="text-center" rowspan="3" colspan="3">최근 상신한 문서가 없습니다.</th>
														</tr>
													</c:if>
													</tbody>
												</table>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- 게시판:start-->
					<div class="row">
						<div class="col-md-12 grid-margin stretch-card">
							<div class="card">
								<div class="card-body">
									<div id="detailedReports"
										class="carousel slide detailed-report-carousel position-static pt-2"
										data-ride="carousel">
										<div class="carousel-inner">
											<div class="carousel-item active">
												<div class="row">
													<div class="col-xl-3 d-flex justify-content-start">
														<div class="ml-xl-4 mt-3">
															<h1 class="text-primary font-weight-bold">사내공지</h1>
															<div
																class="d-flex justify-content-center text-primary mt-2">
																<h1 class="mdi mdi-comment-alert"
																	style="font-size: 90px;"></h1>
															</div>
														</div>
													</div>
													<div class="col-xl-9 pl-0 pr-5">
														<div class="row">
															<div>
																<table class="table table-hover" style="width: 90%; table-layout: fixed">
																	<thead>
																		<tr>
																			<th class="px-0" style="width: 65%">제목</th>
																			<th class="px-0" style="width: 15%">작성자</th>
																			<th class="px-0" style="width: 20%">날짜</th>
																		</tr>
																	</thead>
																	<tbody>
																		<c:if test="${boards != null}">
																		<c:forEach items="${boards}" var="board" varStatus="status">
																		<tr>
																			<td class="pl-1 pr-4" width="50" style="font-size: 13px; text-overflow: ellipsis; overflow: hidden; white-space: nowrap;">
																			<a href="<c:url value='/board/notice'></c:url>">${board.boardTitle}</a></td>
																			<td class="px-1" style="font-size: 14px;">${board.empName}</td>
																			<td class="px-1" style="font-size: 13px;"><fmt:formatDate value="${board.boardDate}" pattern="yyyy-MM-dd"/></td>
																		</tr>
																		</c:forEach>
																		</c:if>
																	</tbody>
																</table>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
										<a class="carousel-control-prev" href="#detailedReports"
											role="button" data-slide="prev"> <span
											class="carousel-control-prev-icon" aria-hidden="true"></span>
											<span class="sr-only">Previous</span>
										</a> <a class="carousel-control-next" href="#detailedReports"
											role="button" data-slide="next"> <span
											class="carousel-control-next-icon" aria-hidden="true"></span>
											<span class="sr-only">Next</span>
										</a>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- 게시판:end-->
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