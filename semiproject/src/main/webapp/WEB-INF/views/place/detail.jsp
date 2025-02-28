<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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
	
	//지도를 표시할 영역 선택
    var container = document.querySelector('#map');//JS
    var options = {
        center: new kakao.maps.LatLng(37.566395, 126.987778),
        level: 8
    };

    var map = new kakao.maps.Map(container, options);
    
    //서울역을 마커로 만들어서 표시
    var location = new kakao.maps.LatLng(37.555753, 126.971268);
    var marker = new kakao.maps.Marker({
        position: location//마커의 위치
    });
    marker.setMap(map);
});
</script>

<div class="container w-1000">
    <div class="cell center">
        <h1>여행지 상세</h1>
    </div>

	<!-- 이미지 스와이퍼 영역 -->
    <div class="cell my-20">
        <!-- Slider main container -->
        <div class="swiper place-image-swiper">
            <!-- Additional required wrapper -->
            <div class="swiper-wrapper">
                <!-- Slides -->
                <div class="swiper-slide"><img src="https://picsum.photos/id/11/600/300" width="100%" height="100%"></div>
                <div class="swiper-slide"><img src="https://picsum.photos/id/12/600/300" width="100%" height="100%"></div>
                <div class="swiper-slide"><img src="https://picsum.photos/id/13/600/300" width="100%" height="100%"></div>
                <div class="swiper-slide"><img src="https://picsum.photos/id/14/600/300" width="100%" height="100%"></div>
                <div class="swiper-slide"><img src="https://picsum.photos/id/15/600/300" width="100%" height="100%"></div>
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
        	서울 남산타워는 서울의 대표적인 랜드마크로, 남산 정상에 위치해 있어 서울 시내를 한눈에 내려다볼 수 있는 멋진 전망을 제공합니다. 1969년에 개장하여 오랜 역사를 자랑하며, 특히 밤에는 수많은 조명이 켜져 서울의 야경을 더욱 빛나게 합니다. 타워의 전망대는 다양한 층으로 이루어져 있으며, 방문객들에게 한강과 서울 시내를 감상할 수 있는 기회를 제공합니다.
        	또한, 남산타워는 ‘사랑의 자물쇠’로 유명합니다. 연인들이 사랑을 영원히 간직하고자 자물쇠를 걸어놓은 곳으로, 이곳은 꼭 방문해야 할 명소 중 하나입니다. 케이블카를 타고 남산타워까지 올라갈 수 있어 접근이 용이하며, 타워 근처에는 다양한 레스토랑과 카페도 있어 여행 중 여유를 즐기기 좋습니다. 남산타워에서의 일출과 일몰을 경험하면 더욱 특별한 여행이 될 것입니다.
        	서울을 여행할 때 남산타워는 놓칠 수 없는 명소로, 다양한 매력을 가진 이곳은 누구에게나 추천할 만한 장소입니다.
        </div>
    </div>
    
    <!-- 지도 영역 -->
    <div class="cell my-20">
    	<h2><i class="fa-solid fa-hand-point-right"></i> 지도</h2>
        <div id="map"></div>
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