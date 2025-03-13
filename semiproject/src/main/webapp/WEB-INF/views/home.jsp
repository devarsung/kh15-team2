<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<!-- Swiper JS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

<!-- 별점 라이브러리 -->
<script src="https://cdn.jsdelivr.net/gh/hiphop5782/score@latest/score.js"></script>

<!-- 공지 디자인 -->
<link rel="stylesheet" type="text/css" href="/css/notice-list.css">

<style>
/* 공지 리스트 max-width 덮어쓰기 */
.notice-list {
    max-width: 600px;
}

/* 리뷰 리스트 */
.review-list {
    width: 100%;
    max-width: 600px;
    margin: 20px auto;
}
.review-item {
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    min-height: 120px;
    max-height: 120px;
    padding: 16px;
    margin-bottom: 8px;
    border-radius: 8px;
    box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.1);
    text-decoration: none;
    overflow: hidden;
    background: #fffaf0;
}
.review-item:hover {
    background: #f5f5f5;
}
.review-info {
    font-size: 15px;
}
.review-writer {
    font-weight: bold;
    color: #333333;
}
.review-place {
    color: #e67e22;
}
.review-title {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    font-size: 20px;
    font-weight: bold;
    color: #222222;
}
.review-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
}
.review-likes {
    font-weight: bold;
}
.review-date {
    text-align: right;
    color: #888888;
    font-size: 14px;
}

.overlay {
    position: absolute;
    bottom: 20px;
    left: 20px;
    color: white;
    padding: 10px;
}
.place-name {
    font-size: 30px;
    font-weight: bold;
    margin-bottom: 5px;
}
.location {
    font-size: 18px;
    margin-bottom: 0px;
}
.review-star {
    margin-bottom: 5px;
}
.reaction {
    display: flex;
    font-size: 15px;
    justify-content: space-between;
    align-items: end;
}
/* 스와이퍼 디자인 */
.swiper {
    width: 100%;
    height: 100%;
}
.swiper-slide {
    width: 100%;
    height: 300px;
    font-size: 18px;
    display: flex;
    justify-content: center;
    align-items: center;
    background-size: cover;
    position: relative;
    cursor: pointer;
}
.swiper-slide img {
    display: block;
    width: 100%;
    height: 100%;
    object-fit: cover;
}
</style>

<script type="text/javascript">
$(function () {
    var swiper = new Swiper(".swiper", {
        loop: true,
        slidesPerView: 3,
        spaceBetween: 30,
        freeMode: true,
        navigation: {
            nextEl: ".swiper-button-next",
            prevEl: ".swiper-button-prev",
        },
        pagination: {
            el: ".swiper-pagination",
        },
    });
    
    $(".swiper-slide").click(function(){
    	var url = $(this).data("url");
        window.location.href = url;
    });
    
    $(".review-star").score({
        display:{
        	showNumber:true,
        },
    });
});
</script>

<div class="container w-1200">
    <div class="cell flex-box flex-vertical">
        <div class="cell center">
            <h1 class="mb-0">여행지 top5</h1>
            <p>많은 사람들에게 사랑받은 여행지</p>
        </div>
        <div class="cell flex-box flex-center">
            <div class="swiper" style="--swiper-navigation-color: #fff; --swiper-pagination-color: #fff">
                <div class="swiper-wrapper">
                	<c:forEach var="place" items="${places}">
	               		<div class="swiper-slide" data-url="/place/detail?placeNo=${place.placeNo}">
	               			<img src="/attachment/download?attachment_no=${place.placeFirstImage}"
	               			onerror="this.onerror=null; this.src='/images/default-image.png';">
	                        <div class="overlay">
	                            <div class="place-name">${place.placeTitle}</div>
	                            <div class="location">
	                            	${place.placeRegion} 
	                            	<c:if test="${place.placeType == '여행지'}">
			                			<i class="fa-solid fa-mountain"></i>
				                	</c:if>
				                	
				                	<c:if test="${place.placeType == '맛집'}">
				                		<i class="fa-solid fa-utensils"></i>
				                	</c:if>
				                	
				                	<c:if test="${place.placeType == '숙소'}">
				                		<i class="fa-solid fa-hotel"></i>
				                	</c:if>
                            	</div>
                            	<fmt:parseNumber value="${place.placeStar}" var="reviewStar"/>
	                            <div class="review-star" data-max="5" data-rate="${reviewStar}"></div>
	                            <div class="reaction">
	                            	<span><i class="fa-solid fa-eye"></i> : ${place.placeRead}</span>
	                                <span><i class="fa-solid fa-heart"></i> : ${place.placeLike}</span>
	                                <span><i class="fa-solid fa-comment-dots"></i> : ${place.placeReview}</span>
	                            </div>
	                        </div>
	                    </div>
                	</c:forEach>
               
                </div>
                <div class="swiper-pagination"></div>
                <div class="swiper-button-prev"></div>
                <div class="swiper-button-next"></div>
            </div>
        </div>
    </div>

    <div class="cell flex-box">
        <div class="cell w-50 ms-10 me-10">
            <div class="cell">
                <h1>베스트 리뷰</h1>
            </div>
            <div class="cell">
                <div class="review-list">
                	<c:forEach var="review" items="${reviews}">
	                	<a href="/review/detail?reviewNo=${review.reviewNo}" class="review-item">
	                        <div class="review-info">
	                            <span class="review-writer">${review.memberNickname}</span> ·
	                            <span class="review-place">OOO 레스토랑</span>
	                        </div>
	                        <div class="review-title">"${review.reviewTitle}"</div>
	                        <div class="review-footer">
	                            <span class="review-likes red"><i class="fa-solid fa-heart"></i> ${review.reviewLike}</span>
	                            <span class="review-date">${review.wtimeString}</span>
	                        </div>
	                    </a>
                	</c:forEach>
                </div>
            </div>
            <div class="cell right">
                <a href="/review/list" class="btn btn-neutral"><i class="fa-solid fa-plus"></i> 더보기</a>
            </div>
        </div>

        <div class="cell w-50 ms-10 me-10">
            <div class="cell">
                <h1>공지사항</h1>
            </div>
            <div class="cell">
                <div class="notice-list">
                	<c:forEach var="notice" items="${notices}">
	                	<a href="/notice/detail?noticeNo=${notice.noticeNo}" class="notice-item">
	                        <span class="notice-icon"><i class="fa-solid fa-bullhorn"></i></span>
	                        <span class="notice-title">"${notice.noticeTitle}"</span>
	                        <span class="notice-date">${notice.wtimeString}</span>
	                    </a>
                	</c:forEach>
                </div>
            </div>
            <div class="cell right">
                <a href="/notice/list" class="btn btn-neutral"><i class="fa-solid fa-plus"></i> 더보기</a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>