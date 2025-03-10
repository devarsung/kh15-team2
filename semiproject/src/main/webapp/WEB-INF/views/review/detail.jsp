<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>



<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="/css/review-detail.css">

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/gh/hiphop5782/score@latest/score.min.js"></script>
<script src="/js/review/reviewStar.js"></script>
<!--   <script src="/js/review/reviewReply.js"></script> -->
<script type="text/javascript">
	$(function() {
		$(".reviewStar").score({
			starColor : "#FFE31A",
			editable : false,//편집 가능하도록 설정
			integerOnly : false,//별을 정수 개수로만 선택하도록 설정
			send : {//전송옵션
				sendable : true,//전송 가능
				name : "reviewStar",//전송될 이름 설정
			},
			display : {
				showNumber : true,
				placeLimit : 1,
				textColor : "#d63031",
			},
		});
	});
	//댓글목록 스크립트
	$(function() {
		//글번호
		var params = new URLSearchParams(location.search);
		var reviewNo = params.get("reviewNo");

		loadList();
		//댓글작성
		$(".btn-reply-write").click(function() {
			var replyContent = $(".reply-writebox").val();

			if (replyContent.length == 0) {
				window.alert("내용을 작성하세요");
				return;
			}
			$.ajax({
				url : "/rest/reply/write",
				method : "post",
				data : {
					replyOrigin : reviewNo,
					replyContent : replyContent
				},
				success : function(response) {
					$(".reply-writebox").val("");//입력값제거
					loadList();
				}
			});
		});

		//댓글삭제
		$(document).on("click", ".delete-btn", function() {
			var choice = window.confirm("정말 댓글을 삭제하겠습니까?");
			if (choice == false)
				return;

			var replyNo = $(this).data("reply-no");

			// 디버깅: replyNo 값이 정상적으로 들어오는지 확인
			console.log("삭제 요청 replyNo 값:", replyNo);

			$.ajax({
				url : "/rest/reply/delete",
				method : "post",
				data : {
					replyNo : replyNo
				},
				success : function(response) {
					console.log("삭제 성공:", response);
					loadList(); // 댓글 목록 새로고침
				},
				error : function(xhr, status, error) {
					console.log("삭제 에러:", xhr.responseText);
				}
			});
		});

		//댓글수정
		$(document).on(
				"click",
				".edit-btn",
				function() {

					//기존에 열려있는 모든 수정화면을 제거
					$(".reply-edit-item").prev(".reply-item").show();
					$(".reply-edit-item").remove();

					//원본은 놔두고 원본 뒤에다 추가
					var template = $("#reply-edit-template").text();
					var html = $.parseHTML(template);

					var replyWriter = $(this).closest(".reply-item").find(
							".reply-writer").text();
					var replyContent = $(this).closest(".reply-item").find(
							".reply-content").text();
					var replyWtime = $(this).closest(".reply-item").find(
							".reply-wtime").text();
					var replyNo = $(this).data("reply-no");

					$(html).find(".reply-writer").text(replyWriter);
					$(html).find(".reply-content").val(replyContent);
					$(html).find(".reply-wtime").text(replyWtime);
					$(html).find(".save-btn").attr("data-reply-no", replyNo);

					$(this).closest(".reply-item").after(html);
					$(this).closest(".reply-item").hide();
				});
		//수정 저장
		$(document).on(
				"click",
				".save-btn",
				function() {
					var replyNo = $(this).data("reply-no");
					var replyContent = $(this).closest(".reply-edit-item")
							.find(".reply-content").val();
					if (replyContent.length == 0) {
						window.alert("내용은 필수입니다");
						return;
					}

					$.ajax({
						url : "/rest/reply/edit",
						method : "post",
						data : {
							replyNo : replyNo,
							replyContent : replyContent
						},
						success : function(response) {
							loadList();
						}
					});
				});
		$(document).on("click", ".cancel-btn", function() {
			//취소를 누르면 현재 수정 영역을 제거하고 앞의 표시 영역을 출력
			var choice = window.confirm("댓글 수정을 취소하시겠습니까?");
			if (choice == false)
				return;

			$(this).closest(".reply-edit-item").prev(".reply-item").show();
			$(this).closest(".reply-edit-item").remove();

		});

		//세션
		var userId = "${sessionScope.userId}";
		var reviewWriter = "${memberDto.memberNickname}";
		//댓글목록
		function loadList() {
			$.ajax({
				url : "/rest/reply/list",
				method : "post",
				data : {
					replyOrigin : reviewNo
				},
				success : function(response) {
					console.log(response);
					$(".reply-wrapper").empty();
					$(response).each(
							function() { //댓글 어떻게 보여줄건지 정합시다..
								var template = $("#reply-template").text();
								var html = $.parseHTML(template);
								var convertTime = moment(this.replyWtime)
										.fromNow();
								//변환
								$(html).find(".reply-no").text(
										"(no." + this.replyNo + ")");
								$(html).find(".reply-writer").text(
										this.replyNickname);
								$(html).find(".reply-content").text(
										this.replyContent);
								$(html).find(".reply-wtime").text(convertTime);
								$(html).find(".delete-btn").attr(
										"data-reply-no", this.replyNo);
								$(html).find(".edit-btn").attr("data-reply-no",
										this.replyNo);

								if (userId.length == 0
										|| this.replyWriter != userId) {
									$(html).find(".edit-btn").remove();
									$(html).find(".delete-btn").remove();
								}

								if (this.replyWriter == null
										|| reviewWriter.length == 0
										|| this.replyWriter != reviewWriter) {
									$(html).find(".owner-badge").remove();
								}

								$(".reply-wrapper").append(html);
							});
					$(".reply-count").text(response.length); //댓글개수 
				}
			});
		}
		;
	});
</script>

<!--댓글 목록/내글이면 수정/삭제btn-->
<script type="text/template" id="reply-template"> 

        <div class="cell flex-box  reply-item"> 
            <div class="w-150 p-10 inline-flex-box" style="min-width: 150px;"> 
                <div  class="reply-tinyfont">
                    <span class="reply-no">댓글번호</span>
                    <span class="reply-wtime">댓글작성일/수정일</span>
                <h3 class="mt-10 reply-writer">닉네임</h3>
            </div>
            </div>
            <div class="w-100 p-10  ">
                <h5 class="m-0 reply-content reply-input">댓글본문</h5>
            </div>
            
          
            <div class="w-150 p-10 btns">
                <button class="edit-btn"  type="button">
                    <i class="fa-solid fa-pen-to-square"></i>수정
                </button>
                <button class="delete-btn" type="button">
                    <i class="fa-regular fa-trash-can"></i>삭제
                </button>
            </div>
        </div>

    </script>
<!--댓글 수정/취소-->
<script type="text/template" id="reply-edit-template">

        <div class="cell flex-box  reply-edit-item">
            <div class="w-150 p-10 inline-flex-box" style="min-width: 150px;"> 
                <div  class="reply-tinyfont">
                    <span class="reply-no">댓글번호</span>
                    <span class="reply-wtime">댓글작성일/수정일</span>
                <h3 class="mt-10 reply-writer">닉네임</h3>
            </div>
			</div>
            
            <div class="p-10">
                <textarea class="save-contentBox reply-content" "></textarea>
            </div>
            
            
            <div class="felx-box btns">
                <button class="save-btn"  type="button">
                    <i class="fa-solid fa-floppy-disk"></i>
                </button>
                <button class="cancel-btn" type="button">
                    <i class="fa-solid fa-xmark"></i>
                </button>
            </div>
        </div>

    </script>
</head>
<div class="container w-1000">

	<div class="cell center">
		<h1>[${reviewDto.reviewWriter}]님의 후기</h1>
	</div>
	<div class="cell right">
		<i class="fa-solid fa-heart"></i>${reviewDto.reviewLike}|<i
			class="fa-solid fa-eye"></i> ${reviewDto.reviewRead}|<span
			class="reply-count"><i class="fa-solid fa-comment-dots"></i>${reviewDto.reviewReply}</span>
	</div>
	<div class="cell right">
		작성일(${reviewDto.reviewWtime})|수정일(${reviewDto.reviewEtime})</div>
	<div class="cell p-20">
		<h1>
			${reviewDto.reviewTitle}<i class="fa-solid fa-pencil"></i>
		</h1>
	</div>
	<div class="cell reviewStar">${reviewDto.reviewStar}</div>
	<div class="cell p-20 content-box">${reviewDto.reviewContent}</div>
	<br>

	<div class="cell left my-0">
		<label>댓글등록</label>
	</div>
	<c:choose>
		<c:when test="${sessionScope.userId != null}">
			<div class="flex-box align-items">
				<div class="cell w-100">
					<textarea class="reply-writebox" placeholder="  댓글을 입력하세요"></textarea>
				</div>
				<div class="cell right inline-flex-box flex-center w-20">
					<button type="button" class=" btn btn-neutral btn-reply-write">등록하기</button>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<div class="flex-box align-items">
				<div class="cell w-100">
					<textarea class="reply-writebox2" placeholder="  로그인후에 작성 가능합니다"></textarea>
				</div>
				<div class="cell right inline-flex-box flex-center w-20">
					<button type="button" class="btn btn-neutral">등록하기</button>
				</div>
			</div>
		</c:otherwise>
	</c:choose>

	<div class="cell left my-0 reply-list">
		<label>댓글목록</label>
	</div>

	<div class="reply-wrapper"></div>

	<div class="cell center">
		<a href="/review/list" class="btn btn-neutral mt-20"
			style="width: 200px">목록으로</a>
	</div>

</div>
</body>

</html>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
