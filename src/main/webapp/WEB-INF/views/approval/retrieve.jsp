<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>

<head>
	<!-- CSS, JS 관련 파일 -->
	<%@ include file="/WEB-INF/views/common/head.jsp" %>
	<!-- Custom js for this page-->
	<style>
	#overflow {
		overflow: auto;
	}
	.highlight:hover {
		font-weight: bold;
		color: #4747A1;
	}
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
	<script>
	function requestRetrieve() {
		let approvalLineState = $("#approvalLineState").val();
		
		let sendData = {
			attached: false,
			approvalLineState : approvalLineState
		}
		
		opener.postMessage(sendData);
		window.close();
	}
	
	function cancel() {
		window.close();
	}
	</script>
</head>

<body>
	<div class="main-panel-popup">
		<div class="content-wrapper">
			<!-- Start information -->
			<div class="row">
				<div class="col-12 grid-margin stretch-card">
					<div class="card">
						<form class="card-body row justify-content-center m-0">
							<input id="approvalLineState" type="hidden" value="${approvalLineState}">
							<div class="row card-title box"><div>문서를 회수하시겠습니까?</div></div>
							<div class="row box">
								<button class="btn btn-primary btn-md mr-2" onclick="requestRetrieve()">회수하기</button>
								<button class="btn btn-inverse-primary btn-md ml-2" onclick="cancel()">취소하기</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

</html>