<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">

	<head>
	<!-- CSS 관련 파일 -->
		<%@ include file="/WEB-INF/views/common/head.jsp" %>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mail.css"/>
		<script src="${pageContext.request.contextPath}/resources/vendors/tinymce/tinymce.min.js"></script>
		<script src="${pageContext.request.contextPath}/resources/js/write-template.js"></script>
		<script src="${pageContext.request.contextPath}/resources/vendors/tinymce/themes/silver/theme.min.js"></script>
		<style>
		.empBtn{
			border-radius: 10px;
			background-color: #4b49ac;
			color:white;
			padding-right :10px;
			padding-left:10px;
			padding-top:2px;
			padding-bottom:2px;
			display: inline-block;
  			width: max-content;
  			margin-bottom: 1px;
		}
		</style>
		<script>
		function getContextPath() {
			   return window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
			}
		//tiny
		$(document).ready(function(){
			tinymce.init({
				language: 'ko_KR',
				selector: '#read_write',
				width: '100%',
				height: '200mm',
				theme: 'silver',
				toolbar1: 'fullscreen print',
				content_style: 'body { font-family:Helvetica,Arial,sans-serif; font-size:14px }',
				plugins: [
					'noneditable'
				],
				menubar : '',
				readonly: 1
			});
		});
		function sendtrash(i){
			console.log("1");
			var mailId= i;
			swal({
				  title: "휴지통",
				  text: "휴지통으로 보내시겠습니까?",
				  icon: "warning",
				  buttons: {
				    cancel: {
				      text: "취소",
				      value: null,
				      visible: true,
				      className: "",
				      closeModal: true,
				    },
				    confirm: {
				      text: "확인",
				      value: true,
				      visible: true,
				      className: "",
				      closeModal: true
				    }
				  },
				})
				.then((value) => {
				  if (value) {
					  location.href= getContextPath() + "/mail/trash/send/"+mailId;
				  } else {
				     close();
				  }
			});
		}
		function receivedtrash(i){
			console.log("2");
			var mailId= i;
			swal({
				  title: "휴지통",
				  text: "휴지통으로 보내시겠습니까?",
				  icon: "warning",
				  buttons: {
				    cancel: {
				      text: "취소",
				      value: null,
				      visible: true,
				      className: "",
				      closeModal: true,
				    },
				    confirm: {
				      text: "확인",
				      value: true,
				      visible: true,
				      className: "",
				      closeModal: true
				    }
				  },
				})
				.then((value) => {
				  if (value) {
					  location.href= getContextPath() + "/mail/trash/received/"+mailId;
				  } else {
				     close();
				  }
			});
		}
		function sendtrashdelete(i){
			console.log("3");
			var mailId= i;
			swal({
				  title: "메일 삭제",
				  text: "휴지통의 메일은 삭제시 복구할 수 없습니다.",
				  icon: "error",
				  buttons: {
				    cancel: {
				      text: "취소",
				      value: null,
				      visible: true,
				      className: "",
				      closeModal: true,
				    },
				    confirm: {
				      text: "확인",
				      value: true, 
				      visible: true,
				      className: "",
				      closeModal: true
				    }
				  },
				})
				.then((value) => {
				  if (value) {
					  location.href= getContextPath() + "/mail/completetrash/send/"+mailId;
				  } else {
				     close();
				  }
				});
		}
		function receivedtrashdelete(i){
			console.log("4");
			var mailId= i;
			swal({
				  title: "메일 삭제",
				  text: "휴지통의 메일은 삭제시 복구할 수 없습니다.",
				  icon: "error",
				  buttons: {
				    cancel: {
				      text: "취소",
				      value: null,
				      visible: true,
				      className: "",
				      closeModal: true,
				    },
				    confirm: {
				      text: "확인",
				      value: true,
				      visible: true,
				      className: "",
				      closeModal: true
				    }
				  },
				})
				.then((value) => {
				  if (value) {
					  location.href= getContextPath() + "/mail/completetrash/received/"+mailId;
				  } else {
				     close();
				  }
				});
		}
		</script>
	</head>

<body>
	<div class="container-scroller">
		<!-- Navbar -->
		<%@ include file="/WEB-INF/views/common/_navbar.jsp"%>
		<div class="container-fluid page-body-wrapper">
			<!-- Sidebar -->
			<%@ include file="/WEB-INF/views/common/_sidebar.jsp"%>

			<!-- 메인 body -->
			<div class="main-panel">
				<div class="content-wrapper">
					<div class="row">
						<!-- 받은 메일 col -->
						<div class="col-lg-12 grid-margin stretch-card">
							<div class="card">
								<form class="card-body">
									<!-- main title and submit button -->
									<div class="d-flex justify-content-between align-items-center mb-4">
										<c:if test="${!empty sendMail}">
											<div class="card-title mb-0">${sendMail.sendMailTitle}</div>
										</c:if>
										<c:if test="${!empty receivedMail}">
											<div class="card-title mb-0">${receivedMail.sendMailTitle}</div>
										</c:if>
										<div class="d-flex">
												<c:if test="${!empty receivedMail}">
													<a href='<c:url value="/mail/reply/${receivedMail.sendMailId}"/>' class="btn btn-md btn-warning mx-2">
														<span class="mdi mdi-telegram align-middle"></span> 
														<span>답장</span>
													</a>
											</c:if>
											<c:if test="${category == 'trash'}">
												<c:if test="${!empty sendMail}">
													<a class="btn btn-md btn-danger mx-2" onclick="sendtrashdelete(${sendMail.sendMailId})">
														<span class="mdi mdi-archive align-middle"></span> 
														<span>삭제</span>
													</a>
												</c:if>
												<c:if test="${!empty receivedMail}">
													<a class="btn btn-md btn-danger mx-2" onclick="receivedtrashdelete(${receivedMail.sendMailId})">
														<span class="mdi mdi-archive align-middle"></span> 
														<span>삭제</span>
													</a>
												</c:if>
											</c:if>
											<c:if test="${category != 'trash'}">
												<c:if test="${!empty sendMail}">
													<a class="btn btn-md btn-danger mx-2" onclick="sendtrash(${sendMail.sendMailId})">
														<span class="mdi mdi-archive align-middle"></span> 
														<span>휴지통</span>
													</a>
												</c:if>
												<c:if test="${!empty receivedMail}">
													<a class="btn btn-md btn-danger mx-2" onclick="receivedtrash(${receivedMail.sendMailId})">
														<span class="mdi mdi-archive align-middle"></span> 
														<span>휴지통</span>
													</a>
												</c:if>
											</c:if>
										</div>
									</div><!-- end main title and submit button -->
									<!-- mail data -->
									<div class="forms-sample my-5">
										<!-- send mail -->
										<div class="row">
											<div class="col-md-12">
												<div class="form-group row align-items-center">
													<div class="col-sm-1 text-primary">
														<div class="d-flex justify-content-end m-1">
															<span class=" font-weight-bold">발신인</span>
															<i class="h3 my-auto mdi mdi-arrow-right-bold text-success"></i> 
														</div>
													</div>
													<div class="col-sm-5 form-inline">
														<div class="from-control" style="border:none;">
															<c:if test="${!empty receivedMail}">
																<span style="font-weight:bold;">
																	(${receivedMail.depName}) ${receivedMail.empName} ${receivedMail.posName}
																</span>
															</c:if>
															<c:if test="${!empty sendMail}">
																<span style="font-weight:bold;">
																	${employee.empName}
																</span>
															</c:if>
														</div>
													</div>
												</div>
											</div>
										</div>
										<!-- receive mail -->
										<div class="row">
											<div class="col-md-12">
												<div class="form-group row align-items-center">
													<div class="col-sm-1 text-primary">
														<div class="d-flex justify-content-end m-1">
															<span class="font-weight-bold">수신인</span>
															<i class="h3 my-auto mdi mdi-arrow-left-bold text-danger"></i> 
														</div>
													</div>
													<div class="col-sm">
														<c:if test="${!empty receivedMail}">
															<div class="empBtn mr-2">
																<span style="width:auto;">${employee.empName}</span>
															</div>
														</c:if>
														<c:if test="${!empty sendMail}">
															<c:forEach items="${sendMail.empList}" var="emp">
																<div class="empBtn mr-2">
																	<span style="width:auto;">(${emp.depName}) ${emp.empName}${emp.posName}</span>
																</div>
															</c:forEach>
														</c:if>
													</div>
												</div>
											</div>
										</div>
										<!-- title -->
										<div class="row">
											<div class="col-md-12">
												<div class="py-2 px-5" style=" font-weight:bold;">
													<c:if test="${!empty sendMail}">
														<fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss" value="${sendMail.sendMailDate}"/>
													</c:if>
													<c:if test="${!empty receivedMail}">
														<fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss" value="${receivedMail.recdMailDate}"/>
													</c:if>
												</div>
											</div>
										</div>
										<!-- file upload -->
										<div class="row">
											<div class="px-5 pt-2 pb-1 text-primary">
												<div class="row d-flex align-items-center m-1">
													<i class="h3 my-auto mdi mdi-cloud-download"></i> 
													<span class="ml-2 font-weight-bold">파일 다운로드</span>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-sm-6 px-5 pb-3"> 
												<div class="form-control" style="font-weight:bold; height:120px;">
													<c:if test="${!empty mailFile}">
														<c:forEach items="${mailFile}" var="mfile">
															<div class="row">
																<a class="text-black" href="<c:url value="/mail/filedownload/${mfile.mailFileId}"></c:url>">
																	<i class="h4 mdi mdi-file-check text-primary"></i>
																	${mfile.mailFileName}
																</a>
															</div>
														</c:forEach>
													</c:if>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-md-12">
												<div class="form-group row px-5 py-2">
													<textarea id="read_write" name="write">
														<c:if test="${!empty sendMail}">
															${sendMail.sendMailContent}
														</c:if>
														<c:if test="${!empty receivedMail}">
															${receivedMail.sendMailContent}
														</c:if>
													</textarea>
												</div>
											</div>
										</div>
									</div>
								</form>
								
								
							</div>
						</div><!-- end 받은 메일 -->
					</div>
				</div>
				<!-- content-wrapper ends -->
				<!-- partial:partials/_footer.jsp -->
			</div>
			<!-- main-panel ends -->
		</div>
		<!-- page-body-wrapper ends -->
	</div>
	<!-- container-scroller -->
</body>

</html>
