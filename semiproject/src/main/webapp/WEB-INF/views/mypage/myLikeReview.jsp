<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" type="text/css" href="/css/myLikeReview.css">
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script type="text/javascript">
$(function(){
	var currentPage =1; 
	var size = 10; //10개씩?
	
	//더보기 클릭 페이지증가
	$(".btn-more").click(function() {
        loadLikedReviews(currentPage++, size);
    });
	
	 loadLikedReviews(currentPage, size);
	
	 
	 function loadLikedReviews(page, size) {
	$.ajax({
		url:"/rest/page/myLikeReview",
		method:"post",
		data:{page : page, size : size},
		 success: function(response) { 
		        console.log(response);
		        if (response == 0) {
		        	var reviewHtml = `
		        		<tr>
                        <td colspan="6" align="center">좋아요한 후기가 없습니다.</td>
                    	</tr>
		        	`;
		        	$("#reviewList").append(reviewHtml);
		            $(".btn-more").hide();
		            return;
		        }
		        $(response).each(function(index, review) {
		        	var myLikeReveiwNo = (currentPage - 1) * size + index + 1; 
		        	
		            // 백틱 리터럴괜히써서
		            var reviewHtml = `
		                <tr>
		                    <td class="center reviewNumber"></td>
		                    <td><a href="/review/detail?reviewNo=${review.reviewNo}" class="titleStyle reviewTitle">${review.reviewTitle}</a></td>
		                    <td class="center reviewWriter">${review.reviewWriter}</td>
		                    <td class="center reviewWtime">${review.reviewWtime}</td>
		                    <td class="center reviewRead">${review.reviewRead}</td>
		                    <td class="center reviewCount">${review.likeCount}</td>
		                </tr>
		            `;

					//제이쿼리 객체로 변환하는방법 DOM으로취급^^
		            var $reviewHtml = $(reviewHtml);

		           
		            $reviewHtml.find(".reviewNumber").text(myLikeReveiwNo);
		            $reviewHtml.find(".reviewTitle").text(review.reviewTitle).attr("href", "/review/detail?reviewNo="+ this.reviewNo);
		            $reviewHtml.find(".reviewWriter").text(review.reviewWriter);
		            $reviewHtml.find(".reviewWtime").text(review.reviewWtime);
		            $reviewHtml.find(".reviewRead").text(review.reviewRead); 
		            $reviewHtml.find(".reviewCount").text(review.likeCount); 


		            $("#reviewList").append($reviewHtml);
		        });
		}
	});
 }	
	
	
});

</script>


<div class="container w-1000">
    <div class="cell center">
        <h1>내가 좋아요한 후기</h1>
    </div>
    
    <jsp:include page="/WEB-INF/views/template/mypage-tab.jsp">
	  	<jsp:param name="menu" value="myLikeReview"/>
	</jsp:include>



    <div class="cell mt-50">
        <table class=" tableStyle">
            <thead>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                	<th>작성일</th>
                    <th>조회수</th>
                    <th>좋아요</th>
                </tr>
            </thead>
            <tbody id="reviewList">  
                  
            </tbody>
        </table>
    </div>
    <div class="cell center">
    	<button class="btn-more">버튼</button>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>