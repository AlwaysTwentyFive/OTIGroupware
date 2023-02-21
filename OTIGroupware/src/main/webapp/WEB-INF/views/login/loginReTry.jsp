<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html lang="en">
	<head>
		<!-- CSS 관련 파일 -->
		<%@ include file="/WEB-INF/views/common/head.jsp" %>
	</head>

	<body>
		<div class="container-fluid" >
			<div class="row mt-5 p-2" >
				<h3 style="text-align: center;">서면 요청하셨습니까?</h3>
			</div>
			<div class="row mb-3" >
				<div class="col"></div>
				<button class="col btn btn-primary btn-sm col mt-1 mx-3" onclick="retry()">확인</button>
				<button class="col btn btn-outline-info btn-sm mt-1 mx-3" onclick="window.close()">취소</button>
				<div class="col"></div>
			</div>
			
		</div>
	</body>

</html>