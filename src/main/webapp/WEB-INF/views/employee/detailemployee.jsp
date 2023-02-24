<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="row">
	<div class="col-md-12 grid-margin">
		<div class="row  d-flex justify-content-between align-items-start">
			<h3 class="card-title">임직원 조회</h3>
			<a type="submit" class="btn btn-md btn-primary mx-2" style="font-family: LeferiBaseType-RegularA; font-weight: 700;" href="<c:url value='/writeboard'/>">
				<span class="mdi mdi-lead-pencil align-middle"></span> 
				<span>수정</span>
			</a>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-3">
		<img src="${pageContext.request.contextPath}/resources/images/faces/face10.jpg" style="width:200px; height:240px;border-radius:20px;"/>
	</div> <!-- End image card -->
	<!-- start information -->
	<div class="col-9">
		<div class="form-sample">
			<div class="row">
				<div class="col-md-6">
					<div class="form-group row align-items-center">
						<div class="col-sm-6 text-primary">
							<div class="d-flex align-items-center m-1">
								<i class="h3 my-auto mdi mdi-account"></i> 
								<span class="ml-2 font-weight-bold">이름</span>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="h3" style="font-weight:bold;"></div>
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="form-group row align-items-center">
						<div class="col-sm-6 text-primary">
							<div class="d-flex align-items-center m-1">
								<span class="h3 my-auto mdi mdi-clipboard-account"></span> 
								<span class="ml-2 font-weight-bold">사번</span>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="h4" style="font-weight:bold;"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-6">
					<div class="form-group row align-items-center">
						<div class="col-sm-6 text-primary">
							<div class="d-flex align-items-center m-1">
								<i class="h3 my-auto mdi mdi-cake"></i> 
								<span class="ml-2 font-weight-bold">생년월일</span>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="h3" style="font-weight:bold;"></div>
						</div>
					</div>
				</div>
				<div class="col-md-5">
					<div class="form-group row align-items-center">
						<div class="col-sm-6 text-primary">
							<div class="d-flex align-items-center m-1">
								<i class="h3 my-auto mdi mdi-clipboard-check"></i> 
								<span class="ml-2 font-weight-bold">채용일</span>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="h3" style="font-weight:bold;"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-6">
					<div class="form-group row align-items-center">
						<div class="col-sm-6 text-primary">
							<div class="d-flex align-items-center m-1">
								<i class="h3 my-auto mdi mdi-human-male-female"></i> 
								<span class="ml-2 font-weight-bold">성별</span>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="h3" style="font-weight:bold;"></div>
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="form-group row align-items-center">
						<div class="col-sm-6 text-primary">
							<div class="d-flex align-items-center m-1">
								<i class="h3 my-auto mdi mdi-email"></i> 
								<span class="ml-2 font-weight-bold">메일ID</span>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="h3" style="font-weight:bold;"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-6">
					<div class="form-group row align-items-center">
						<div class="col-sm-6 text-primary">
							<div class="d-flex align-items-center m-1">
								<i class="h3 my-auto mdi mdi-heart"></i> 
								<span class="ml-2 font-weight-bold">결혼여부</span>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="h3" style="font-weight:bold;"></div>
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="form-group row align-items-center">
						<div class="col-sm-6 text-primary">
							<div class="d-flex align-items-center m-1">
								<i class="h3 my-auto mdi mdi-incognito"></i> 
								<span class="ml-2 font-weight-bold">재직상태</span>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="h3" style="font-weight:bold;"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-6">
					<div class="form-group row align-items-center">
						<div class="col-sm-6 text-primary">
							<div class="d-flex align-items-center m-1">
								<i class="h3 my-auto mdi mdi-pocket"></i> 
								<span class="ml-2 font-weight-bold">병역</span>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="h3" style="font-weight:bold;"></div>
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="form-group row align-items-center">
						<div class="col-sm-6 text-primary">
							<div class="d-flex align-items-center m-1">
								<i class="h3 my-auto mdi mdi-flower"></i> 
								<span class="ml-2 font-weight-bold">근무년수</span>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="h3" style="font-weight:bold;"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-6">
					<div class="form-group row align-items-center">
						<div class="col-sm-6 text-primary">
							<div class="d-flex align-items-center m-1">
								<i class="h3 my-auto mdi mdi-book-open-page-variant"></i> 
								<span class="ml-2 font-weight-bold">전공</span>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="h3" style="font-weight:bold;"></div>
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="form-group row align-items-center">
						<div class="col-sm-6 text-primary">
							<div class="d-flex align-items-center m-1">
								<i class="h3 my-auto mdi mdi-cellphone"></i> 
								<span class="ml-2 font-weight-bold">개인TEL</span>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="h3" style="font-weight:bold;"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-6">
					<div class="form-group row align-items-center">
						<div class="col-sm-6 text-primary">
							<div class="d-flex align-items-center m-1">
								<i class="h3 my-auto mdi mdi-school"></i> 
								<span class="ml-2 font-weight-bold">최종학력</span>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="h3" style="font-weight:bold;"></div>
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="form-group row align-items-center">
						<div class="col-sm-6 text-primary">
							<div class="d-flex align-items-center m-1">
								<i class="h3 my-auto mdi mdi-phone-classic"></i> 
								<span class="ml-2 font-weight-bold">사내TEL</span>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="h3" style="font-weight:bold;"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-12">
					<div class="form-group row align-items-center">
						<div class="col-sm-3 text-primary">
							<div class="d-flex align-items-center m-1">
								<span class="ml-2 font-weight-bold">비밀번호 초기화</span>
							</div>
						</div>
						<div class="col-sm-4">
							<button onclick=""
								class="btn btn-md btn-inverse-primary btn-icon-text d-flex align-items-center m-1">
								<i class="h3 my-auto mdi mdi-key"></i> <span
									class="ml-2 font-weight-bold">초기화</span>
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div><!-- End information box -->
</div>
<!-- 테이블 -->
<div class="table-responsive">
	<table class="table">
		<thead>
			<tr>
				<th class="text-primary h3">발령일</th>
				<th class="text-primary h3">만기일</th>
				<th class="text-primary h3">직급</th>
				<th class="text-primary h3">부서</th>
				<th class="text-primary h3">근무지</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td></td>
			</tr>
		</tbody>
	</table>
</div>
<!-- 테이블 끝 -->