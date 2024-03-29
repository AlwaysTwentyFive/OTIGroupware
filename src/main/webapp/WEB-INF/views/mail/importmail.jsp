<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

	<head>
	<!-- CSS 관련 파일 -->
		<%@ include file="/WEB-INF/views/common/head.jsp" %>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mail.css"/>
		<script>
        function popup(){
        	swal({
			  title: "중요 메일입니다.",
			  text: "휴지통으로 보내기 하시겠습니까?",
			  icon: "warning",
			  buttons: {
			  confirm: {
			      text: "확인",
			      value: true,
			      visible: true,
			      className: "",
			      closeModal: true
			    },
			    cancel: {
			      text: "취소",
			      value: null,
			      visible: true,
			      className: "",
			      closeModal: true,
			    }
			  },
			})
			.then((value) => {
			  if (value) {
			    onclick=pager(-2);
			  } else {
			     close();
			  }
			});
        }
        function pager(No){
        	var result;
			if(No == -2){
				result = 'delete';
				No = $('#pageBtn').val();
			}else if(No == -3){
				No = $('#pageBtn').val();
			}
			//paging number 지정
			var startRowNo = ${pager.startRowNo};
			var endRowNo =  ${pager.endRowNo};
			if(No <= startRowNo ){
				No = 1;
			}else if (No > endRowNo){
				No = endRowNo;
			}
			
			var star = $('#star').val();
			var mailArray = [];
			$('input[name="optradio"]:checked').each(function(i){//체크된 리스트 저장
				mailArray.push($(this).val());
	        });
			if(No == ''){
				No='1';
			}
			if(star == ''){
				star = '0';
			}
			if(mailArray == ''){
				mailArray[0]='0';
			}
			if(result == null){
				result = 'stay';
			}
			var data = {mailId : star, mailList : mailArray, page : No, result : result};
			console.log(data);
			jQuery.ajax({
				type : 'post',
				url : '../mail/importsearch',
				dataType : 'html',
				data : JSON.stringify(data),
				contentType:"application/json;charset=UTF-8",
				async: false,
				success : function(data){
					$('#import_container').html(data);
					$('#pageBtn').val(No);
				 }
			});
		}
		function star(id){
			$('#star').val(id);
			onclick=pager(-3);
		}
		function checkSelectAll()  {
			  // 전체 체크박스
			  const checkboxes 
			    = document.querySelectorAll('input[name="optradio"]');
			  // 선택된 체크박스
			  const checked 
			    = document.querySelectorAll('input[name="optradio"]:checked');
			  // select all 체크박스
			  const selectAll 
			    = document.querySelector('input[name="selectall"]');
			  
			  if(checkboxes.length === checked.length)  {
			    selectAll.checked = true;
			  }else {
			    selectAll.checked = false;
			  }

			}

		function selectAll(selectAll)  {
		  const checkboxes 
		     = document.getElementsByName('optradio');
		  
		  checkboxes.forEach((checkbox) => {
		    checkbox.checked = selectAll.checked
		  })
		}
		
		function submitForm(){
			var search = $('#searchBar').val();
			log.info(search);
			jQuery.ajax({
				type : 'get',
				url : '../mail/titlesearch/import/',
				dataType : 'html',
				data : {search:search},
				 contentType:"application/json;charset=UTF-8",
				success : function(data){
					$('#msendail_container').html(data);
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
					<!-- import and send mail -->
					<div class="row">
						<div class="col-lg-12 grid-margin stretch-card" id="import_container">
							<%@ include file="/WEB-INF/views/mail/importmailinfo.jsp"%>
						</div>
					</div>
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
