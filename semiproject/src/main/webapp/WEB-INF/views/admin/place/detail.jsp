<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

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
                <c:forEach var="attachmentNo" items="${attachmentNos}">
                	<div class="swiper-slide">
                		<img src="/attachment/download?attachmentNo=${attachmentNo}" width="100%" height="100%">
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
    
    <!-- 소개 영역 -->
    <div class="cell my-20">
        <h2><i class="fa-solid fa-hand-point-right"></i> 소개</h2>
        <div class="div-place-content">
        	${placeDto.placeOverview}
        </div>
    </div>
    
    <!-- 지도 영역 -->
    <div class="cell my-20">
    	<h2><i class="fa-solid fa-hand-point-right"></i> 지도</h2>
        <div id="map" data-lat="${placeDto.placeLat}" data-lng="${placeDto.placeLng}"></div>
    </div>

	<!-- 리뷰 영역 -->
    <div class="cell">
    	<h2><i class="fa-solid fa-hand-point-right"></i> 리뷰</h2>
        <table class="table table-border table-stripe">
            <thead></thead>
            <tbody class="center">
                <tr>
                    <td>여행자A</td>
                    <td><a href="/review/detail?reviewNo=">낭만적인 곳입니다!</a></td>
                    <td>2025-02-23</td>
                </tr>
                <tr>
                    <td>여행자B</td>
                    <td><a href="/review/detail?reviewNo=">야경이 멋져요!</a></td>
                    <td>2025-02-23</td>
                </tr>
                <tr>
                    <td>여행자B</td>
                    <td><a href="/review/detail?reviewNo=">야경이 멋져요!</a></td>
                    <td>2025-02-23</td>
                </tr>
                <tr>
                    <td>여행자B</td>
                    <td><a href="/review/detail?reviewNo=">야경이 멋져요!</a></td>
                    <td>2025-02-23</td>
                </tr>
                <tr>
                    <td>여행자B</td>
                    <td><a href="/review/detail?reviewNo=">야경이 멋져요!</a></td>
                    <td>2025-02-23</td>
                </tr>
            </tbody>
        </table>
    	
    	<div class="cell right">
	       <a href="/review/list?placeNo=" class="btn btn-neutral end">후기 더보기</a>
	   </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>   
