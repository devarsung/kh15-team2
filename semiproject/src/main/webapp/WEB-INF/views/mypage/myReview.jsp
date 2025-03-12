<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/css/myLikeReview.css">
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script type="text/javascript">
	$(function(){
		var currentPage = 1;
		var size = 10;
			
			
		
		
		loadMyReviews(currentPage,size);
		
		function loadMyReviews(page,size){
			$.ajax({
				url:"/rest/page/myReview",
				method:"post",
				data:{page : page, size : size},
				success:function(response){
					console.log(response);
					if (response.length == 0) {
			        	var reviewHtml = `
			        		<tr>
	                        <td colspan="6" align="center">작성한 후기가 없습니다.</td>
	                    	</tr>
			        	`;
			        	$("#reviewList").append(reviewHtml);
			            $(".btn-more").hide();
			            return;
			        }
					
					$(".btn-more").click(function() {
				        loadMyReviews(currentPage++, size);
				    });
					
			        $(response).each(function(index, review) {
			        	
			        	var myReviewNo = (currentPage - 1) * size + index + 1; 
			            var reviewHtml = `
			                <tr>
				            	<td class="reviewNo"></td>
	                            <td class="reviewTitle"></td>
	                            <td class="reviewRead"></td>
	                            <td class="reviewLike"></td>
	                            <td class="reviewReply"></td>
	                            <td class="reviewWtime"></td>
			                </tr>
			            `;
						var $reviewHtml = $(reviewHtml);
						$reviewHtml.find(".reviewNo").text(myReviewNo);
						$reviewHtml.find(".reviewTitle").text(review.reviwTitle)//attr추가;
						$reviewHtml.find(".reviewRead").text(review.reviewRead);
						$reviewHtml.find(".reviewLike").text(review.reviewLike);
						$reviewHtml.find(".reviewReply").text(review.reviewReply);
						$reviewHtml.find(".reviewWtime").text(review.reviewWtime);
					$("#reviewList").append($reviewHtml);
			    	});
				}
			});
		}
	});
</script>



<div class="container w-1000">
    <div class="cell center">
        <h1>내가 작성한 후기</h1>
    </div>

    <jsp:include page="/WEB-INF/views/template/mypage-tab.jsp">
	  	<jsp:param name="menu" value="myReview"/>
	</jsp:include>

    <div class="cell mt-50">
        <table class="tableStyle">
            <thead>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>조회수</th>
                    <th>좋아요</th>
                    <th>댓글수</th>
                    <th>작성일</th>
                </tr>
            </thead>
            <tbody id="reviewList">
            
            </tbody>
        </table>
    </div>
   <div class="cell center">
    	<a href="#" class="btn-more">더보기+</a>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
