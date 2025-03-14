<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<link rel="stylesheet" type="text/css" href="/css/myReply.css">

<style>
.no-list {
	width: 100%;
	height: 300px;
	border: 1px solid gray;
	display : flex;
	flex-direction: column;
  	justify-content : center;
  	align-items : center;
  	font-size: 20px;
}
.aStyle{
   	text-decoration: none;
   	outline: none; 
   	padding:10px;
   	color : black;
   	font-weight : bold;
}
</style>

<script type="text/javascript">
$(function(){
	var currentPage = 1;
	var size = 5;
	
	//목록 불러오기
	function loadList() {
		$.ajax({
			url: "/rest/page/myReply",
			method: "post",
			data: {page: currentPage, size: size},
			success: function(response) {
				if(response.length === 0) {
					if(currentPage === 1) {
						$(".no-list").show();
						$(".reply-list").hide();
						$(".btn-more").hide();
						return;	
					}
				}
				
				$(".btn-more").css("display", response.isLastPage ? "none" : "block");
				$(".no-list").hide();
				$(".reply-list").show();
				$(".reply-count").show().text(response.totalCount + "개");
				
				
				console.log(response.list);
				
				$(response.list).each(function(){
					var template = $("#reply-template").text();
					var html = $.parseHTML(template);
					var wtime = this.replyWtime.slice(0,10);
					$(html).find(".btn-delete").data("reply-no", this.replyNo);
					$(html).find(".reply-wtime").text(wtime);
					$(html).find(".reply-writer").text(this.replyNickname);
					$(html).find(".reply-content").text(this.replyContent);
					$(html).find(".mainText").attr("href","/review/detail?reviewNo="+ this.replyOrigin)
					
					$(".reply-list").append(html);
					
					//원글, 수정삭제 관련 배치 필요(후기 상세의 디자인과는 달라야함)
				});
			}
		});
	}
	
	$(".btn-more").click(function(event){
		currentPage++;
		loadList();
	});
	
	loadList();
    // 댓글 삭제
    $(document).on("click",".btn-delete",function(){
        var choice = window.confirm("정말 댓글을 삭제하시겠습니까?");
        if(choice == false) return;
        var replyNo = $(this).data("reply-no");
        console.log("삭제할 댓글 번호: " + replyNo);
        
        $.ajax({
            url:"/rest/reply/delete",
            method:"post",
            data:{replyNo : replyNo},
            success:function(response){
            	$(".reply-list").empty();
            	currentPage = currentPage;
              	loadList();
            }
        });
    });
	
});
</script>

<script type="text/template" id="reply-template"> 
        <div class="container w-1000">
        <div class="cell flex-box reply-item">
            <div class="w-150 p-10 inline-flex-box" style="min-width: 150px;">
                <div class="reply-tinyfont center">
                    <span class="reply-wtime">댓글작성일/수정일</span>
                    <h3 class="mt-10 reply-writer">닉네임</h3>
                </div>
            </div>
            <div class="flex-box flex-vertical">
                <div class="float-box">
                    <div class="float-left">
                        <a href="/review/detail?reviewNo=" class="mainText">[본문으로 가기]</a>
                    </div>
                    <div class="float-right">
                        <span>댓글삭제  </span><button class="btn-delete" data-reply-no="${replyNo}"><i class="fa-solid fa-xmark"></i></button>
                    </div>
                </div>
                <div class="w-100 p-10">
                    <h5 class="m-0 reply-content">댓글본문</h5>
                </div>
            </div>
        </div>
    </div>
</script>

<div class="container w-1000">
    <div class="cell center">
        <h1>내가 작성한 댓글</h1>
    </div>

    <jsp:include page="/WEB-INF/views/template/mypage-tab.jsp">
	  	<jsp:param name="menu" value="myReply"/>
	</jsp:include>

    <div class="cell mt-50">
    	<div class="cell no-list" style="display:none;">
   			<i class="fa-solid fa-fish"></i>
       		<span>작성한 댓글이 없습니다</span>
       	</div>
    
    	<h3 class="right me-10 my-0 reply-count" style="display:none;"></h3>
    	<div class="reply-list" style="display:none;">
			         
        </div>
    </div>
      <div style="display: flex; justify-content: center;">
    <button class="btn-more" type="button">더보기+</button>
</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
