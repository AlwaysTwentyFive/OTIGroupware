<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
	<!-- inject css, js common file -->
	<%@ include file="/WEB-INF/views/common/head.jsp" %>
	<!-- endinject css, js common file -->

	<!-- Plugin css,js for this page -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendors/bootstrap-datepicker/bootstrap-datepicker.min.css" />
	<script src="${pageContext.request.contextPath}/resources/vendors/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
	
	
	<script>
		//현재 시간
		$(function() {
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
		
		//datepicker 렌더링
	   	$(function(){ 
		      $('#datepicker').datepicker({
		    	  format: "yyyy-mm",
		    	  startView: "months", 
		    	  minViewMode: "months",
		    	  todayHighlight: true
		      });
		});
		
	   	/* 근무신청내역 상세보기 팝업창 */
		function atdAppDetail(data) {
         	
         	//추후 근무신청서 유형에 따라 다른 팝업창이 열려야함! 매개변수!!! 잊지말자!
         	if(data =='근무시간수정') {
         		//근무시간수정신청서 팝업창
	        	var url = "popup/updatetimedetail";
	         	var name = "";
	         	var option = "width = 800, height = 590, top = 200, left = 400, location = no, resizable=no, scrollbars=no  "
	         	window.open(url, name, option);
         	} else {
         		//추가근무보고서 팝업창
	        	var url = "popup/overtimedetail";
	         	var name = "";
	         	var option = "width = 800, height = 560, top = 200, left = 400, location = no, resizable=no, scrollbars=no  "
	         	window.open(url, name, option);
         	}
		}
	</script>
	<!-- End plugin css,js for this page -->
</head>

<body>
  <div class="container-scroller">
    <!-- Navbar -->
    <%@ include file="/WEB-INF/views/common/_navbar.jsp" %>
    
    <div class="container-fluid page-body-wrapper">
      <!-- Sidebar -->
      <%@ include file="/WEB-INF/views/common/_sidebar.jsp" %>
      
      <!-- partial -->
      <div class="main-panel">
        <div class="content-wrapper">
        	<div class="row">
        		<div class="col-md-3 col-lg-3">
        			<!-- 현재시간 / 출근상태 -->
		           <div class="grid-margin stretch-card">
			           	<div class="card">
			           		<div class="card-body px-5 py-4">
			               		<!-- 현재시간 -->
			               		<div class="row">
									<div class="justify-content-start align-items-center">
										<div id="now-date" class="font-weight-bold h5 text-muted"></div>
										<div id="now-time" class="font-weight-bold h1 mt-3"></div>
									</div>
			               		</div>
			               		<!-- 근무상태 -->
			               		<div class="row mt-3 justify-content-center">
		                  			<button class="btn btn-lg btn-outline-light dropdown-toggle" type="button" id="dropdownMenuButton1" data-toggle="dropdown" 
		                  					aria-haspopup="true" aria-expanded="true" style="width: 200%; font-size: 130%; font-weight: bold;">
		                         		근무중
		                        	</button>
		                        	<div class="dropdown-menu" aria-labelledby="dropdownMenuButton1" style="width:80%;">
			                          <h6 class="dropdown-header">근무중</h6>
			                          <a class="dropdown-item" href="#">출장</a>
			                          <a class="dropdown-item" href="#">외근</a>
			                          <div class="dropdown-divider"></div>
			                          <a class="dropdown-item" href="#">기타</a>
			                        </div>
		                  		</div>
		                  		<!-- 출퇴근 버튼 -->
			               		<div class="row mt-4 justify-content-between">
			               			<button class="btn btn-lg btn-outline-primary p-4" style="font-weight: 700; font-size: 120%;">
		                           		<span class="mdi mdi-alarm-check align-middle"></span>
		                           		<span>출근</span>
		                      	   </button>
		                           <button class="btn btn-lg btn-outline-danger p-4" style="font-weight: 700; font-size: 120%;">
		                           		<span class="mdi mdi-alarm-off align-middle"></span>
		                           		<span>퇴근</span>
		                       	   </button>
			               		</div>
		               		</div>
	               		</div>
               		</div>
               		<!-- 달력에서 원하는 일자를 선택하면, 해당 일자의 출/퇴근 시간이 찍힘 -->
               		<div class="grid-margin stretch-card">
			           	<div class="card card-dark-blue">
			           		<div class="card-body px-5 py-3">
			           			<div class="row justify-content-between my-2">
			           				<div class="card-title text-white pt-1">출근</div>
			           				<div id="today-in-time" class="font-weight-bold h3 m-0"></div>
			           			</div>
			           			<div class="row justify-content-between mt-2">
			           				<div class="card-title text-white m-0 pt-1">퇴근</div>
			           				<div id="today-out-time" class="font-weight-bold h3 m-0"></div>
			           			</div>
			           		</div>
		           		</div>
	           		</div>
               		<!-- 올해 근태 누적 일수 통계 -->
		          	<div class="grid-margin stretch-card">
			           	<div class="card">
			           		<div class="card-body px-5 py-3">
			           			<div class="row justify-content-between my-2">
			           				<div class="card-title text-primary pt-1">지각</div>
			           				<div class="font-weight-bold h3 m-0">1</div>
			           			</div>
			           			<div class="row justify-content-between my-2">
			           				<div class="card-title text-primary pt-1">결근</div>
			           				<div class="font-weight-bold h3 m-0">0</div>
			           			</div>
			           			<div class="row justify-content-between my-2">
			           				<div class="card-title text-primary pt-1">추가근무</div>
			           				<div class="font-weight-bold h3 m-0">1</div>
			           			</div>
			           			<div class="row justify-content-between mt-2">
			           				<div class="card-title text-primary m-0 pt-1">휴일근무</div>
			           				<div class="font-weight-bold h3 m-0">1</div>
			           			</div>
			           		</div>
		           		</div>
	           		</div>
        		</div>
        		<!-- 근무현황(달력) -->
        		<div class="col-md-9 col-lg-9">
					<%@ include file="/WEB-INF/views/fullcalendar/atd_calendar.jsp" %>
        		</div>
        	</div>
	      	<!-- 근무현황(목록) / 근무신청내역 -->
          	<div class="row">
          		<!-- 근무현황(목록):start -->
            	<div class="col-md-6 grid-margin stretch-card">
	              <div class="card">
	                <div class="card-body">
	                  <p class="card-title">이번주 근무현황</p>
	                  <div class="table-responsive">
	                      <table class="table table-hover">
		                        <thead>
		                          <tr>
		                            <th>날짜</th>
		                            <th>출근시간</th>
		                            <th>퇴근시간</th>
		                            <th>총 근무시간</th>
		                            <th>상태</th>
		                          </tr>
		                        </thead>
		                        <tbody>
		                        	<tr>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        		<td><div class="badge badge-success font-weight-bold">정상출근</div></td>
		                        	</tr>
		                        	<tr>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        	</tr>
		                        	<tr>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        	</tr>
		                        	<tr>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        	</tr>
		                        	<tr>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        	</tr>
		                        	<tr>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        	</tr>
		                        	<tr>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        	</tr>
		                        </tbody>
	                    	</table>
	                    </div>
	                </div>
	              </div>
	            </div>
	            <!-- 근무현황(목록):end -->
	            <!-- 근무신청내역:start -->
            	<div class="col-md-6 grid-margin stretch-card">
	              <div class="card">
	                <div class="card-body">
	                  <div class="card-title d-flex align-items-center justify-content-between">
              			<div>근무신청내역</div>
               			<!-- datepicker start -->
		                <div id="datepicker" class="input-daterange input-group w-50">
							<span class="mdi mdi-calendar-clock text-primary" style="position: relative; z-index: 1; top:13px; left: 25px;"></span>
						    <input type="text" class="form-control font-weight-bold text-center form-control-sm" name="start" style="border:2px solid #4B49AC; border-radius:10px; "/>
							<button onclick="" class="btn btn-md btn-primary ml-2">검색</button>
						</div>
			            <!-- datepicker end -->
                   	  </div>
	                  <div class="table-responsive">
	                      <table class="table table-hover">
		                        <thead>
		                          <tr>
		                            <th>신청유형</th>
		                            <th>기안날짜</th>
		                            <th>결재자</th>
		                            <th>결재날짜</th>
		                            <th>결재상태</th>
		                          </tr>
		                        </thead>
		                        <tbody>
		                        	<tr onclick="atdAppDetail('근무시간수정')">
		                        		<td>근무시간수정</td>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        		<td><div class="badge badge-success font-weight-bold">승인</div></td>
		                        	</tr>
		                        	<tr onclick="atdAppDetail('추가근무')">
		                        		<td>추가근무</td>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        	</tr>
		                        	<tr>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        	</tr>
		                        	<tr>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        	</tr>
		                        	<tr>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        		<td>gdgd</td>
		                        	</tr>
		                        </tbody>
	                    	</table>
	                    </div>
	                    <!-- 페이징 -->
						<div class="row mt-5 d-flex justify-content-center">
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
	            <!-- 근무신청내역:end -->
          	</div>
        </div>
        <!-- content-wrapper ends -->
        <!-- partial:partials/_footer.jsp -->
         <%@ include file="/WEB-INF/views/common/_footer.jsp" %>
        <!-- partial -->
      </div>
      <!-- main-panel ends -->
    </div>
    <!-- page-body-wrapper ends -->
  </div>
  <!-- container-scroller -->
  
</body>

</html>