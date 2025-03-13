<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 

<!-- kakaomap cdn -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=bb3ee3a13bf05ba14dafda342aa87cd1"></script>

<!-- swiper cdn -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

<!-- 별점 라이브러리 -->
<script src="https://cdn.jsdelivr.net/gh/hiphop5782/score@latest/score.js"></script>

<link rel="stylesheet" type="text/css" href="/css/place.css">
<link rel="stylesheet" type="text/css" href="/css/review-list.css">

<style>
    .swiper {
        width: 100%;
        height: 500px;
    }
    #map {
  	 	width: 100%;
		height: 500px;
    }
	.div-title {
		position: relative;
	    display: flex;
	    justify-content: center;
	    align-items: center;
	}
	.left-btns {
		position: absolute;
	    left: 0;
	    gap: 10px;
	}
	.reactions {
		font-size: 30px;
	}
	
</style>

<script type="text/javascript">
$(function() {
 	$(".review-star").score({
        display:{
        	showNumber:true,
        },
    });
	 
	var swiper = new Swiper('.place-image-swiper', {
        //기본 옵션
        direction: 'horizontal',
        loop: true,
        
        //현재 페이지에 대한 네비게이션 표시 영역
        pagination: {
            el: '.swiper-pagination',
        },

        //좌우 이동 화살표
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },
    });
	
    var container = $('#map')[0];
	var lat = $(container).data("lat");
	var lng = $(container).data("lng");
    var options = {
        center: new kakao.maps.LatLng(lat, lng),
        level: 8
    };

    var map = new kakao.maps.Map(container, options);
    
    var location = new kakao.maps.LatLng(lat, lng);
    var marker = new kakao.maps.Marker({
        position: location//마커의 위치
    });
    marker.setMap(map);
});
</script>

<div class="container w-1000">
    <div class="cell div-title">
    	<div class="left-btns">
	    	<a class="btn btn-neutral" href="edit?placeNo=${placeDto.placeNo}">수정하기</a>
	    	<a class="btn btn-neutral" href="delete?placeNo=${placeDto.placeNo}">삭제하기</a>
    	</div>
        <h1 class="m-0">${placeDto.placeTitle}</h1>
    </div>

    <div class="cell center reactions">
    	<div class="review-star" data-max="5" data-rate="${placeStar}"></div><br>
    	<span class="views"><i class="fa-solid fa-eye"></i> :  ${placeDto.placeRead}</span>
    	<span class="likes"><i class="fa-solid fa-heart"></i> : ${placeDto.placeLike}</span>
        <span class="comments"><i class="fa-solid fa-comment-dots"></i> : ${placeDto.placeReview}</span>
    </div>

	<!-- 이미지 스와이퍼 영역 -->
    <div class="cell my-20">
        <!-- Slider main container -->
        <div class="swiper place-image-swiper" style="--swiper-navigation-color: #fff; --swiper-pagination-color: #fff">
            <!-- Additional required wrapper -->
            <div class="swiper-wrapper">
                <!-- Slides -->
                	
                	<div class="swiper-slide">
                		<!-- 기본 이미지 처리 여기서 했는데 attachmentService load 에서 할지 말지 생각 좀 -->
                		<img class="place-img" src="/attachment/download?attachmentNo=${placeDto.placeFirstImage}" width="100%" height="100%" 
                		onerror="this.onerror=null; this.src='/images/default-image.png';">
                	</div>
                <c:forEach var="attachmentNo" items="${attachmentNos}">
                	<div class="swiper-slide">
                		<!-- 기본 이미지 처리 여기서 했는데 attachmentService load 에서 할지 말지 생각 좀 -->
                		<img class="place-img" src="/attachment/download?attachmentNo=${attachmentNo}" width="100%" height="100%" 
                		onerror="this.onerror=null; this.src='/images/default-image.png';">
                	</div>
                </c:forEach>
            </div>
            <!-- If we need pagination -->
            <div class="swiper-pagination"></div>

            <!-- If we need navigation buttons -->
            <div class="swiper-button-prev"></div>
            <div class="swiper-button-next"></div>
        </div>
    </div>
    
    <!-- 개요 영역 -->
    <div class="cell my-20">
        <h2><i class="fa-solid fa-hand-point-right"></i> 개요</h2>
        <div class="overview-content">
        	<div class="overview-text">${placeDto.placeOverview}</div>
        </div>
    </div>
    
    <!-- 지도 영역 -->
    <div class="cell my-20">
    	<h2><i class="fa-solid fa-hand-point-right"></i> 지도</h2>
        <div id="map" data-lat="${placeDto.placeLat}" data-lng="${placeDto.placeLng}"></div>
    </div>
    
    
    <!-- 기본 정보 영역 -->
    <div class="cell my-20">
	    <h2><i class="fa-solid fa-hand-point-right"></i> 정보</h2>
	    <div class="info-container">
	        <div class="info-content">
	            <div class="info-item">
	                <div class="info-title"><i class="fa-solid fa-location-pin"></i> 주소</div>
	                <div class="info-detail">
	                	${placeDto.placePost}<br>
	                	${placeDto.placeAddress1}, ${placeDto.placeAddress2}
                	</div>
	            </div>
	
	            <c:if test="${placeDto.placeTel != null}">
	                <div class="info-item">
	                    <div class="info-title"><i class="fa-solid fa-phone-alt"></i> 문의전화</div>
	                    <div class="info-detail">${placeDto.placeTel}</div>
	                </div>
	            </c:if>
	            
	            <c:if test="${placeDto.placeWebsite != null}">
	                <div class="info-item">
	                    <div class="info-title"><i class="fa-solid fa-link"></i> 홈페이지</div>
	                    <div class="info-detail"><a href="${placeDto.placeWebsite}" target="_blank">${placeDto.placeWebsite}</a></div>
	                </div>
	            </c:if>
	            
	            <c:if test="${placeDto.placeParking != null}">
	                <div class="info-item">
	                    <div class="info-title"><i class="fa-solid fa-parking"></i> 주차가능여부</div>
	                    <div class="info-detail">${placeDto.placeParking == 'Y' ? '가능' : '불가능'}</div>
	                </div>
	            </c:if>
	            
	            <c:if test="${placeDto.placeOperate != null}">
	                <div class="info-item">
	                    <div class="info-title"><i class="fa-solid fa-cogs"></i>운영정보</div>
	                    <div class="info-detail">
	                    	<span class="textarea-content">${placeDto.placeOperate}</span>
                    	</div>
	                </div>
	            </c:if>
	        </div>
	    </div>
	</div>
    
	<!-- 리뷰 영역 (있으면 보여주기) -->
	<c:if test="${fn:length(reviews) > 0}">
	    <div class="cell">
	    	<h2><i class="fa-solid fa-hand-point-right"></i> 베스트 리뷰</h2>
	        <table class="table table-border table-hover table-ellipsis tableStyle">
	            <thead></thead>
	            <tbody class="center">
	            	<c:forEach var="review" items="${reviews}">
	            		<tr>
	            			<td>
			            		<c:choose>
									<c:when test="${review.memberNickname == null }">(탈퇴한 사용자)</c:when>
									<c:otherwise>${review.memberNickname}</c:otherwise>
								</c:choose>
							</td>
		                    <td class="left">
		                    	<a class="aStyle" href="/review/detail?reviewNo=${review.reviewNo}">${review.reviewTitle}</a>
		                    	<!-- 댓글 표시 -->
								<c:if test="${review.reviewReply > 0}">
									<span class="ms-20">
										<i class="fa-solid fa-comment-dots" style="color:#F3D0D7;" ></i>
										${review.reviewReply}
									</span>
								</c:if>
								
								<!-- 좋아요 표시 -->
								<c:if test="${review.reviewLike > 0}">
									&nbsp;&nbsp;
									<i class="fa-solid fa-heart " style="color:#eea5b3;"></i>
									${review.reviewLike}
								</c:if>	
	                    	</td>
		                    <td>${review.wtimeString}</td>
	                	</tr>
	            	</c:forEach>
	            </tbody>
	        </table>
	    </div>
    </c:if>
    
    <div class="cell right">
       <a href="/review/list?placeNo=${placeDto.placeNo}" class="btn btn-neutral end">후기 더보기</a>
   </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>   
