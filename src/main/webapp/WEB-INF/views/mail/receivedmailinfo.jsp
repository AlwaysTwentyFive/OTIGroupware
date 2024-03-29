<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script src="${pageContext.request.contextPath}/resources/js/template.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/settings.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/todolist.js"></script>
<style>
	.table th, .jsgrid .jsgrid-table th, 
	.table td, 
	.jsgrid .jsgrid-table td { 
  		padding: 0.125rem 2.375rem; 
	} 
</style>
<div class="card">
	<div class="card-body">
		<h4 class="card-title">받은 메일</h4>
		<!-- 검색 태그 -->
		<div class="row justify-content-between px-5 py-3">
			<div class="form-inline" style="border-bottom:1px solid #e9ecef;">
				<div class="px-3 py-1 ahover">
					<button id="searchInput5" onclick="search(5)" style="color:grey;">전체</button>
				</div>
				<div class="px-3 py-1 ahover">
					<button id="searchInput1" onclick="search(1)" style="color:grey;">읽은메일</button>
				</div>
				<div class="px-3 py-1 ahover">
					<button id="searchInput2" onclick="search(2)" style="color:grey;">읽지않은메일</button>
				</div>
				<div class="px-3 py-1 ahover">
					<button id="searchInput3" onclick="search(3)" style="color:grey;">중요메일</button>
				</div>
				<div class="px-3 py-1 ahover">
					<button id="searchInput4" onclick="search(4)" style="color:grey;">중요표시안한메일</button>
				</div>
			</div>
			<input type="hidden" id="searchBtn"/>
			<div class="d-flex justify-content-end">
				<div id="searchForm" class="d-flex" >
     				<div style="border-radius:18px; border:1px solid #e9ecef;display: flex;">
						<div class="input-group-prepend hover-cursor mx-3">
							<span class="input-group-text" id="search" style="background: transparent; border: 0; color: #000; padding: 0;">
								<i class="icon-search" style="font-size: 1.25rem; color: #6C7383;"></i>
							</span>
						</div>
						<input type="text" id="searchBar" class="align-self-center" style="border:none;width:100%;">
					</div>
					<button onclick="submitForm()" class="font-weight-bold btn btn-md btn-warning ml-2">검색</button>
				</div>
       		</div>
		</div><!-- 검색 태그 -->
		<!-- 테이블 -->
		<div class="table-responsive p-4">
			<table class="table table-hover">
				<thead>
					<tr>
						<th class=" form-inline col-1" style="border:none;">
							<div class="form-check font-weight-bold text-info">
								<label class="form-check-label">
									<input type="checkbox" class="form-check-input" name='selectall' onclick="selectAll(this)">
								</label>
							</div>
						</th>
						<th class="col-1 pb-3" style="font-size:15px;">첨부</th>
						<th class="col-1 pb-3" style="font-size:15px;">발신인</th>
						<th class="col-7 pb-3" style="font-size:15px;">제목</th>
						<th class="col-2 pb-3" style="font-size:15px;">날짜</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${!empty receivedmail}">
						<c:forEach items="${receivedmail}" var="recd">
							<c:if test="${recd.recdMailReadReceiptYN == 'Y'}">
								<tr style="color:#a2a2a3;">
							</c:if>
							<c:if test="${recd.recdMailReadReceiptYN == 'N'}">
								<tr>
							</c:if>
								<td class="form-inline pr-0 p1-2">
									<div class="form-check font-weight-bold text-info">
										<label class="form-check-label">
											<input type="checkbox" class="form-check-input" name="optradio" onclick="checkSelectAll()" value="${recd.sendMailId}">
										</label>
										<input type="hidden" id="import" value="${recd.recdMailImportanceYN}"/>
									</div>
									<c:if test="${recd.recdMailImportanceYN == 'Y'}">
										<button onclick="star(${recd.sendMailId})"><i class="h3 mdi mdi-star text-warning"></i></button>
									</c:if>
									<c:if test="${recd.recdMailImportanceYN == 'N'}">
										<button onclick="star(${recd.sendMailId})"><i class="h3 mdi mdi-star-outline text-warning"></i></button>
									</c:if>
									<input type="hidden" id="star"/>
								</td>
								<td>
									<c:if test="${recd.fileYN == 'Y'}">
										<i class="h3 mdi mdi-paperclip text-info"></i>
									</c:if>
								</td>
								<td><i class="mdi mdi-arrow-left-bold text-danger"></i>${recd.empName} ${recd.posName} </td>
								<td onclick="location.href='<c:url value="/mail/detailmail/received/${recd.sendMailId}/received"/>'" style="font-weight:bold;">${recd.sendMailTitle}</td>
								<td>
									<fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss" value="${recd.recdMailDate}"/>
								</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty receivedmail}">
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td  class="p-5" style="font-size:20px;">받은 메일함이 비었습니다.</td>
							<td></td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
		<!-- 테이블 끝 -->
		<!-- 하단 버튼 -->
		<div class="row form-inline m-3 d-flex justify-content-end">
			<button class="btn btn-danger btn-sm mx-1" onclick="pager(-5)">선택삭제</button>
		</div><!-- 하단 버튼 -->

		<!-- 페이징 -->
		<c:if test="${!empty receivedmail}">
			<div class="row mt-5 d-flex justify-content-center">
				<ul class="pagination pb-0 mb-0">
					<!-- 이전 -->
					<c:if test="${pager.groupNo > 1}">
						<li class="page-item disabled">
							<button class="page-link" onclick="pager(${i-5})">이전</button>
						</li>
					</c:if>
					<c:forEach var="i" begin="${pager.startPageNo}" end="${pager.endPageNo}" step="1">
						<!-- 선택할 페이지 -->
						<c:if test="${pager.pageNo != i}">
							<li class="page-item">
								<button class="page-link" onclick="pager(${i})">${i}</button>
								<input type="hidden" id="pageBtn"/>
							</li>
						</c:if>
						<!-- 현재페이지 -->
						<c:if test="${pager.pageNo == i}">
							<li class="page-item active">
								<button id="nowPage" class="page-link" onclick="pager(${i})">${i}</button>
							</li>
						</c:if>
					</c:forEach>
					<c:if test="${pager.groupNo < pager.totalGroupNo}">
						<li class="page-item">
							<button class="page-link" onclick="pager(${i+5})">다음</button>
						</li>
					</c:if>
				</ul>
			</div>
		</c:if>
	</div>
</div>