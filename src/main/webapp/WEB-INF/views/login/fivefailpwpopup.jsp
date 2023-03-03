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
	<script>
	 function retry(){
     	window.opener.top.location.href="<c:url value='login/'/>";
         window.close();
     }
	</script>
	<style>
		.container-fluid{
			padding:0px;
			margin:0px;
		}
		.main-panel-popup {
		  transition: width 0.25s ease, margin 0.25s ease;
		  width: 100%;
		  min-height: 100vh;
		  display: -webkit-flex;
		  display: flex;
		  -webkit-flex-direction: column;
		  flex-direction: column;
		}
	</style>
	<!-- End plugin css,js for this page -->
	</head>

	<!-- 5회 로그인 오류시 뜨는 팝업창 -->
	<body>
		<div class="main-panel-popup">
			<div class="content-wrapper">
				<!-- Start information -->
				<div class="row">
					<div class="col-12 grid-margin stretch-card">
						<div class="card">
							<div class="card-body row m-0">
								<div class="container-fluid d-flex justify-content-center">
									<div class="mt-1 row ">로그인 5회 실패하셨습니다.</div>
									<div class="mt-1 row">경영지원부에 비밀번호 초기화 요청 후</div>
									<div class="mt-1 row">다시 시도 부탁드립니다.</div>
									<div class="row mb-1" >
										<div class="col"></div>
										<button class="col-3 btn btn-primary btn-md mt-1 mx-3" onclick="window.close()">닫기</button>
										<div class="col"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
			</div>
		</div>
		<!-- container-scroller -->
	</body>
	
</html>