<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<link rel="stylesheet" type="text/css" href="/css/review-detail.css">

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
				
				currentPage++;
				
				console.log(response.list);
				
				$(response.list).each(function(){
					var template = $("#reply-template").text();
					var html = $.parseHTML(template);
					$(html).find(".reply-wtime").text(this.replyWtime);
					$(html).find(".reply-writer").text(this.replyNickname);
					$(html).find(".reply-content").text(this.replyContent);
					
					$(".reply-list").append(html);
					
					//원글, 수정삭제 관련 배치 필요(후기 상세의 디자인과는 달라야함)
				});
			}
		});
	}
	
	$(".btn-more").click(function(event){
		event.preventDefault();
		loadList();
	});
	
	loadList();
	
	
});
</script>

<script type="text/template" id="reply-template"> 
    <div class="cell flex-box reply-item"> 
        <div class="w-150 p-10 inline-flex-box" style="min-width: 150px;"> 
            <div class="reply-tinyfont">
                <span class="reply-wtime">댓글작성일/수정일</span>
                <h3 class="mt-10 reply-writer">닉네임</h3>
            </div>
        </div>
        <div class="w-100 p-10">
            <h5 class="m-0 reply-content reply-input">댓글본문</h5>
        </div>
        <div class="w-150 p-10 btns">
            <button class="edit-btn"  type="button">
                <i class="fa-solid fa-pen-to-square"></i>
            </button>
            <button class="delete-btn" type="button">
                <i class="fa-regular fa-trash-can"></i>
            </button>
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
    
    	<h3 class="right me-10 my-0 card-count" style="display:none;"></h3>
    	<div class="reply-list" style="display:none;">
			         
        </div>
        <div class="cell center mt-50">
        	<a href="#" class="aStyle btn-more">더보기+</a>
        </div>
    
        <table class="table table-border table-hover">
            <thead>
                <tr>
                    <th>번호</th>
                    <th>후기 제목</th>
                    <th>댓글 내용</th>
                    <th>작성일</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty myReplyList}">
                        <tr>
                            <td colspan="4" align="center">작성한 댓글이 없습니다.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="reply" items="${myReplyList}" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td><a href="/review/detail?reviewNo=${reply.replyOrigin}">${reply.reviewTitle}</a></td>
                                <td>${reply.replyContent}</td>
                                <td><fmt:formatDate value="${reply.replyWtime}" pattern="yyyy-MM-dd"/></td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
