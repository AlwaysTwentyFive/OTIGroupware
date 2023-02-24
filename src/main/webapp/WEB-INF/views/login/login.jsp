<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html lang="en">
	<head>
		<!-- CSS/JS 관련 파일 -->
		<%@ include file="/WEB-INF/views/common/head.jsp" %>
		
		<style>
			.form-group input:focus {
				caret-color: #4B49AC;
			}
		</style>
		
		<script>
	        function popup(){
	            var url = "loginpopup";
	            var name = "login retry";
	            var option = "width = 500, height =250, top = 50, left = 200, location = no, resizable=no, scrollbars=no "
	            window.open(url, name, option);
	        }
        	
	        /* input박스를 클릭하였을 때, 아이콘 색상 변경 */
	        $(document).ready(function(){
		        const $icon1 = $(".mdi-account");
			   	$("#id-input input").focus(function() {
			      $icon1.removeClass("text-secondary").addClass("text-primary");
			    });
			   	$("#id-input input").blur(function() {
			        $icon1.addClass("text-secondary").removeClass("text-primary");

			    const $icon2 = $(".mdi-lock");
			   	$("#pw-input input").focus(function() {
			      $icon2.removeClass("text-secondary").addClass("text-primary");
			    });
	        	});
			   	$("#pw-input input").blur(function() {
			        $icon2.addClass("text-secondary").removeClass("text-primary");
	        	});
		    });
		</script>
	</head>
	<body>
		<div class="container-scroller">
			<div class="container-fluid page-body-wrapper full-page-wrapper">
				<div class="content-wrapper d-flex align-items-center auth px-0">
					<div class="row w-100 mx-0">
						<div class="col-lg-4 mx-auto">
							<div class="grid-margin stretch-card">
		           				<div class="card">
		           					<div class="card-body p-5">
										<!-- 로고 -->
										<div class="brand-logo d-flex justify-content-between align-items-end">
											<div>
												<img src="${pageContext.request.contextPath}/resources/images/oti-logo.png" alt="logo" style="width:110px; height:40px;"/>
			       								<img src="${pageContext.request.contextPath}/resources/images/exa.png" alt="logo" style="width:80px; height:40px;"/>
											</div>
											<h3 class="text-primary font-weight-bold mb-0">GROUPWARE</h3>
										</div>
										<!-- 로그인폼 -->
										<form action="<c:url value='/home'/>" >
											<div id="id-input" class="form-group mb-0">
												<input type="email" class="form-control form-control-lg" id="exampleInputEmail1" placeholder="아이디를 입력해주세요" value="OTIandEXAINT" style="border-radius: 10px;">
												<i class="mdi mdi-account text-secondary" style="position: relative; top:-34px; left:9px;"></i>
											</div>
											<div id="pw-input" class="form-group mb-0">
												<input type="password" class="form-control form-control-lg" id="exampleInputPassword1" placeholder="패스워드를 입력해주세요" value="OTIandEXAINT" style="border-radius: 10px;">
												<i class="mdi mdi-lock text-secondary" style="position: relative; top:-34px; left:9px;"></i>
											</div>
											<div class="mt-3">
												<a class="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn" href="<c:url value='/home'/>">
													<i class="mdi mdi-login-variant"></i>
													<span class="ml-1 h4 font-weight-bold">로그인</span>
												</a>
											</div>
											<div
												class="my-2 d-flex justify-content-between align-items-center">
												<div class="form-check">
													<label class="form-check-label text-muted">
													</label>
												</div>
												<a href="<c:url value='/errorlogin'/>" class="auth-link text-primary">비밀번호 찾기</a>
											</div>
										</form>
		           					</div>
	           					</div>
           					</div>
						</div>
					</div>
				</div>
				<!-- content-wrapper ends -->
			</div>
			<!-- page-body-wrapper ends -->
		</div>
		
	</body>

</html>
