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

<style>
    .swiper {
        width: 100%;
        height: 500px;
    }
    #map {
  	 	width: 100%;
		height: 500px;
    }
    .div-place-content {
    	border: 1px solid gray;
    	padding: 0.5em;
    }
</style>

<script type="text/javascript">
$(function() {
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
    <div class="cell center">
        <h1>${placeDto.placeTitle}</h1>
    </div>
    
    <div class="cell">
    	<i class="fa-heart fa-regular red"></i>
    	<span class="heart-count">${placeDto.placeLike} 개(관리자 화면에선 그냥 보여주기만)</span>
    </div>
    
    <div class="cell">
    	<a class="btn btn-neutral" href="edit?placeNo=${placeDto.placeNo}">수정하기</a>
    	<a class="btn btn-neutral" href="delete?placeNo=${placeDto.placeNo}">삭제하기</a>
    </div>

	<!-- 이미지 스와이퍼 영역 -->
    <div class="cell my-20">
        <!-- Slider main container -->
        <div class="swiper place-image-swiper">
            <!-- Additional required wrapper -->
            <div class="swiper-wrapper">
                <!-- Slides -->
                	
                	<div class="swiper-slide">
                		<!-- 기본 이미지 처리 여기서 했는데 attachmentService load 에서 할지 말지 생각 좀 -->
                		<img class="place-img" src="/attachment/download?attachmentNo=${placeDto.placeFirstImage}" width="100%" height="100%" 
                		onerror="this.onerror=null; this.src='/images/defaultBack.png';">
                	</div>
                <c:forEach var="attachmentNo" items="${attachmentNos}">
                	<div class="swiper-slide">
                		<!-- 기본 이미지 처리 여기서 했는데 attachmentService load 에서 할지 말지 생각 좀 -->
                		<img class="place-img" src="/attachment/download?attachmentNo=${attachmentNo}" width="100%" height="100%" 
                		onerror="this.onerror=null; this.src='/images/defaultBack.png';">
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
        <div class="div-place-content">
			<pre>${placeDto.placeOverview}</pre>     	
        </div>
    </div>
    
    <!-- 지도 영역 -->
    <div class="cell my-20">
    	<h2><i class="fa-solid fa-hand-point-right"></i> 지도</h2>
        <div id="map" data-lat="${placeDto.placeLat}" data-lng="${placeDto.placeLng}"></div>
    </div>
    
    <c:if test="${placeDto.hasInfo}">
	    <!-- 기본 정보 영역 -->
	    <div class="cell my-20">
	        <h2><i class="fa-solid fa-hand-point-right"></i> 정보</h2>
	        <div class="" style="background-color:#E2E2E2;">
	        	<ul>
					<c:if test="${placeDto.placeTel != null}">
						<li>문의전화 : ${placeDto.placeTel}</li>
					</c:if>
					
					<c:if test="${placeDto.placeWebsite != null}">
						<li>홈페이지 : <a href="${placeDto.placeWebsite}">${placeDto.placeWebsite}</a></li>
					</c:if>
					
					<c:if test="${placeDto.placeParking != null}">
						<li>주차가능여부 : ${placeDto.placeParking == 'Y' ? '가능' : '불가능'}</li>
					</c:if>
					
					<c:if test="${placeDto.placeOperate != null}">
						<li style="white-space: pre-line;">운영정보 : <br>${placeDto.placeOperate}</li>
					</c:if>
	        	</ul>
	        </div>
	    </div>
    </c:if>
    
	<!-- 리뷰 영역 (있으면 보여주기) -->
	<c:if test="${fn:length(reviews) > 0}">
	    <div class="cell">
	    	<h2><i class="fa-solid fa-hand-point-right"></i> 베스트 리뷰</h2>
	        <table class="table table-border table-stripe">
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
		                    <td><a href="/review/detail?reviewNo=${review.reviewNo}">${review.reviewTitle}</a></td>
		                    <td>${review.reviewWtime}</td>
	                	</tr>
	            	</c:forEach>
	            </tbody>
	        </table>
	    	
	    	<div class="cell right">
		       <a href="/review/list?placeNo=${placeDto.placeNo}" class="btn btn-neutral end">이 여행지의 후기 더보기</a>
		   </div>
	    </div>
    </c:if>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>   
