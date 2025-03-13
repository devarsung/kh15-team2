<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" type="text/css" href="/css/myLikeReview.css">
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script type="text/javascript">
$(function(){
	 var params = new URLSearchParams(location.search);
	 var reviewNo = params.get("reviewNo");
	
	var currentPage =1; 
	var size = 10; //10개씩?
	
	 loadLikedReviews(currentPage, size);
	

 	$(".btn-more").click(function() {
         loadLikedReviews(currentPage++, size);
     });

	 function loadLikedReviews() {
	$.ajax({
		url:"/rest/page/myLikeReview",
		method:"post",
		data:{page : currentPage, size : size},
		 success: function(response) { 
			 	
		        var totalcount= $(response.totalCount)[0]; 

			 	var lastPage = response.isLastPage;
		        console.log(response);
		        console.log("현재페이지: "+ currentPage);
		        console.log("개수: "+ response.length);
		        console.log("총 리뷰 개수 :"+totalcount);//총개수..이렇게쓰는거맞니..?
		       	console.log("마지막페이지인가:"+response.isLastPage);
		        console.log("현재 조회목록 수 :" + response.length);
		        console.log("조회목록 : " + response.list);
		        
		        $(".totalLikeReviews").text(totalcount);
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
		        	var myLikeReviewNo = ((currentPage - 1) * size) + index + 1; //페이지게이
		           //백팁실패한 테블릿 그리고 제발 주석추가하지마 오류
		        	var reviewHtml = `
		                <tr>
		                    <td class="center reviewNumber"></td>
		                    <td><a href="/review/detail?reviewNo=" class="titleStyle reviewTitle" ></a></td>
		                    <td class="center reviewWriter"></td>
		                    <td class="center reviewWtime"></td>
		                    <td class="center reviewRead"></td>
		                    <td class="center reviewCount"></td>
		                </tr>
		            `;

					//제이쿼리 객체로 변환하는방법 DOM으로취급^^
		            var $reviewHtml = $(reviewHtml);
		            $reviewHtml.find(".reviewNumber").text(myLikeReviewNo);
		            $reviewHtml.find(".reviewTitle").text(review.reviewTitle).attr("href", "/review/detail?reviewNo="+ this.reviewNo);
		            $reviewHtml.find(".reviewWriter").text(review.reviewWriter);
		            $reviewHtml.find(".reviewWtime").text(review.reviewWtime);
		            $reviewHtml.find(".reviewRead").text(review.reviewRead); 
		            $reviewHtml.find(".reviewCount").text(review.likeCount); 
	

		            $("#reviewList").append($reviewHtml);	//변환후추가
		      
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
<div class="cell my-0 p-10">
<span>TOTAL<i class="fa-solid fa-heart red"></i> <span class="totalLikeReviews">3</span></span>
</div>
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
    	<button class="btn-more">더보기+</button>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>