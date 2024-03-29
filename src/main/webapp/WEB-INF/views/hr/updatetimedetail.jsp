<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!-- Plugin css,js for this page -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendors/clockpicker/bootstrap-clockpicker.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendors/clockpicker/jquery-clockpicker.css">
<script src="${pageContext.request.contextPath}/resources/vendors/clockpicker/bootstrap-clockpicker.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendors/clockpicker/jquery-clockpicker.js"></script>

<style>
	.custom-border-left {
		border-left: 1px solid rgb(206, 212, 218);
	}
	
	.custom-border-right {
		border-right: 1px solid rgb(206, 212, 218);
	}
</style>

<script>
	
</script>
<!-- End plugin css,js for this page -->


<div class="grid-margin stretch-card">
	<div class="card">
		<div class="card-body">
			<div class="d-flex justify-content-between align-items-baseline">
				<div class="card-title">근무시간수정 신청서 </div>
				<button type="button" onclick="backAtdList()" class="btn btn-sm"><h3 class="mdi mdi-window-close text-primary mt-1 mb-0"></h3></button>
			</div>
			<div class="table-responsive px-3 py-2 mt-4">
				<!-- 고정 내용 -->
				<table class="table">
					<tbody>
						<tr class="custom-border-left custom-border-right">
							<td class="custom-border-right"><h4
									class="font-weight-bold text-center m-0">작성자</h4></td>
							<td>${atdExcp.empName}</td>
							<td></td>
							<td></td>
							<td class="custom-border-left custom-border-right">
								<h4 class="font-weight-bold text-center m-0">근무날짜</h4></td>
							<td><fmt:formatDate value="${atdExcp.atdExcpDate}" pattern="yyyy-MM-dd" /></td>
							<td></td>
						</tr>
						<tr class="custom-border-left custom-border-right">
							<td class="custom-border-right"><h4
									class="font-weight-bold text-center m-0">결재자</h4></td>
							<td>${atdExcp.atdExcpApprovalEmpName}</td>
							<td></td>
							<td></td>
							<td class="custom-border-left custom-border-right"><h4
									class="font-weight-bold text-center m-0">진행상태</h4></td>
							<td>
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
				<div class="row justify-content-around">
					<div class="col-md"></div>
					<div class="col-md">
						<h4 class="font-weight-bold">기존 근무시간</h4>
					</div>
					<div class="col-md">
						<h4 class="font-weight-bold">수정 근무시간</h4>
					</div>
				</div>
				<div class="row justify-content-center mb-3">
					<div style="border: 1px solid #a3a4a5; opacity: 0.5; width: 90%;"></div>
				</div>
				<!-- 출근부분 -->
				<c:if test="${!empty atdExcp.atdExcpInTime}">
					<div class="row px-5 py-2 mt-2">
						<div class="col-md">
							<h4 class="mx-4 mb-0 text-primary font-weight-bold">출근</h4>
						</div>
						<div class="col-md d-flex align-items-center pr-0">
							<div class="h5 mb-0 ml-3 text-muted"><fmt:formatDate value="${atdExcp.atdOriginInTime}" pattern="HH:mm" /></div>
						</div>
						<div class="col-md d-flex align-items-center pl-0">
							<h6 class="ml-5 mb-0 text-primary font-weight-bold">${atdExcp.atdExcpInTime}</h6>
						</div>
					</div>
				</c:if>
				<!-- 퇴근부분 -->
				<c:if test="${!empty atdExcp.atdExcpOutTime}">
					<div class="row px-5 py-2">
						<div class="col-md">
							<h4 class="mx-4 mb-0 text-primary font-weight-bold">퇴근</h4>
						</div>
						<div class="col-md d-flex align-items-center pr-0">
							<div class="h5 mb-0 ml-3 text-muted"><fmt:formatDate value="${atdExcp.atdOriginOutTime}" pattern="HH:mm" /></div>
						</div>
						<div class="col-md d-flex align-items-center pl-0">
							<h6 class="ml-5 mb-0 text-primary font-weight-bold">${atdExcp.atdExcpOutTime}</h6>
						</div>
					</div>
				</c:if>
				<!-- 사유 -->
				<div class="row px-5 py-2 mt-5">
					<div class="col-md">
						<h4 class="mx-4 mb-0 text-dark font-weight-bold">사유</h4>
					</div>
				</div>
				<div class="row px-5 my-3 mx-1">
					<div class="col-md">
						<h6 class="ml-5 mb-5 text-primary">${atdExcp.atdExcpReason}</h6>
					</div>
				</div>
				<div class="row justify-content-center mt-3 mb-4">
					<div style="border-bottom: 2px solid #4B49AC; width: 90%;"></div>
				</div>
				<!-- 반려사유 조회 -->
				<c:if test="${!empty atdExcp.atdExcpOpinion}">
					<div class="row px-5 mt-3 justify-content-start">
						<h4 class="mx-4 mb-0 font-weight-bold text-danger">반려 사유</h4>
					</div>
					<div class="row px-5 mt-3 ml-1">
						<h6 class="ml-1 mb-0 text-danger">${atdExcp.atdExcpOpinion}</h6>
					</div>
				</c:if>
				<!-- 반려사유 작성 -->
				<div id="refuse-reason" class="row px-5 mt-4 justify-content-center"
					style="display: none;">
					<div class="form-group">
						<label class="ml-1" for="reason"><div class="h5 m-0 font-weight-bold text-danger">반려사유</div></label>
						<textarea class="form-control" id="textarea-reason" rows="5"
							cols="68"></textarea>
					</div>
				</div>
			</div>
			<!-- 일반 임직원일 경우의 버튼 -->
			<c:if test="${(sessionScope.employee.empId ne atdExcp.atdExcpApprovalEmpId) && (atdExcp.atdExcpProcessState eq '신청')}">
				<div class="row px-5 mt-3 justify-content-end">
					<a class="btn btn-danger mr-2" href="${pageContext.request.contextPath}/hr/overtimecancel?atdExcpId=${atdExcp.atdExcpId}">신청취소</a>
				</div>
			</c:if>
			<!-- 부서장일 경우의 버튼 - 미처리 결재인 경우 -->
			<c:if test="${(sessionScope.employee.empId eq atdExcp.atdExcpApprovalEmpId) && (atdExcp.atdExcpProcessState eq '신청') }">
				<div class="row px-5 mt-4 mb-3 justify-content-end">
					<button id="approve-btn" onclick="atdExcpAprv('승인', '${atdExcp.atdExcpId}', '${atdExcp.atdExcpCategory}')" type="button" class="btn btn-primary mr-2">승인</button>
					<button id="first-refuse-btn" onclick="refuseBtn()" type="button" class="btn btn-danger mr-2">반려</button>
					<!-- 반려사유 작성 후 -->
					<button id="cancel-btn" onclick="cancel()" type="button" class="btn btn-inverse-primary mr-2" style="display: none">취소</button>
					<button id="second-refuse-btn" onclick="atdExcpAprv('반려', '${atdExcp.atdExcpId}', '${atdExcp.atdExcpCategory}')" type="button" class="btn btn-danger mr-2" style="display: none">반려</button>
				</div>
			</c:if>
			<!-- 변경내용:end -->
		</div>
		<!-- card-body:end -->
	</div>
</div>