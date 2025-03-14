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
		
		$(".btn-more").click(function() {
	         loadMyReviews(currentPage++, size);
	     });
		
		function loadMyReviews(){
			$.ajax({
				url:"/rest/page/myReview",
				method:"post",
				data:{page : currentPage, size : size},
				success:function(response){
					
					    var totalcount= response.totalCount;
					 	var lastPage = response.isLastPage;
				        console.log(response);
				        console.log("현재페이지: "+ currentPage);
				        console.log("개수: "+ response.length);
				        console.log("총 리뷰 개수 :"+totalcount);//총개수..이렇게쓰는거맞니..?
				       	console.log("마지막페이지인가:"+response.isLastPage);
				        console.log("현재 조회목록 수 :" + response.length);
				        console.log("조회목록 : " + response.list);
					
					
				        $(".totalCount").text(totalcount);
				        if (response.length == 0) { //조회목록이 0개고
				        	if(currentPage==1) { //1페이지라면
				        	var reviewNone = `
				        		<tr>
		                        <td colspan="6" align="center">좋아요한 후기가 없습니다.</td>
		                    	</tr>
				        	`;
				        	$("#reviewList").append(reviewNone); //얘추가하고
				            $(".btn-more").hide(); //버튼숨기고
				            return;	
				        	}   
				        }
				    	if(lastPage){
			        		$(".btn-more").hide();
			        		}
			        	else{
			        		$(".btn-more").show();
			        	}
			        $(response.list).each(function(index, review) {	
			        	var myReviewNo = ((currentPage - 1) * size) + index + 1;
			        	var wtime = review.reviewWtime.slice(0, 10); // .......ㅋ

			            var reviewHtml = `
			                <tr>
				            	<td class="reviewNumber center"></td>
	                            <td><a href="/review/detail?reviewNo="  class="reviewTitle titleStyle aStyle"></a></td>
	                            <td class="reviewRead center"></td>
	                            <td class="reviewLike center"></td>
	                            <td class="reviewReply center"></td>
	                            <td class="reviewWtime center"></td>
			                </tr>
			            `;
						var $reviewHtml = $(reviewHtml);
						$reviewHtml.find(".reviewNumber").text(myReviewNo);
						$reviewHtml.find(".reviewTitle").text(review.reviewTitle).attr("href","/review/detail?reviewNo="+ review.reviewNo);
						$reviewHtml.find(".reviewRead").text(review.reviewRead);
						$reviewHtml.find(".reviewLike").text(review.reviewLike);
						$reviewHtml.find(".reviewReply").text(review.reviewReply);
						$reviewHtml.find(".reviewWtime").text(wtime);
					
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
            <div class="p-10">등록글 수 : <span class="totalCount"></span></div>
        <table class="tableStyle">
            <thead class="index-item">
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>조회수</th>
                    <th>좋아요</th>
                    <th>댓글수</th>
                    <th>작성일</th>
                </tr>
            </thead>
            <tbody id="reviewList" >
            
            </tbody>
        </table>
    </div>
   <div class="cell center">
    	<button class="btn-more" type="button">더보기+</button>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
