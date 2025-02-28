<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
 
  <!--google font-->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

    <!--font awesome cdn-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
        integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />

 
   <!-- jQuery-->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>



    <!-- summernote cdn -->
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.js"></script>


    <!-- Kakao Map API -->
    <script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=1aecdde2565bbb75bfd9dd611109d4e0"></script>

    <!-- swiper cdn -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

    <script type="text/javascript">
        window.addEventListener("load", function () {
            var swiper = new Swiper('.test01', {
                // Optional parameters
                direction: 'vertical',
                loop: true,

                // If we need pagination
                pagination: {
                    el: '.swiper-pagination',
                },

                // Navigation arrows
                navigation: {
                    nextEl: '.swiper-button-next',
                    prevEl: '.swiper-button-prev',
                },

                // And if we need scrollbar
                scrollbar: {
                    el: '.swiper-scrollbar',
                },
            });

            var swiper2 = new Swiper(".test02", {
                //기본 옵션
                direction: 'horizontal',//수평(horizontal), 수직(vertical)
                loop: true,//양쪽 끝을 이어서 계속 슬라이드가 가능하도록 설정

                //현재 페이지에 대한 네비게이션 표시 영역
                pagination: {
                    el: '.swiper-pagination',
                },

                //좌우 이동 화살표
                navigation: {
                    nextEl: '.swiper-button-next',
                    prevEl: '.swiper-button-prev',
                },

                //자동재생
                //autoplay: true,//자동재생ON
                autoplay: {
                    delay: 5000,//한장당 5000ms
                    disableOnInteraction: true,//제어중에는 자동재생 OFF
                    pauseOnMouseEnter: true,//마우스 hover시 자동재생 OFF
                },
            });

            var swiper3 = new Swiper(".test03", {
                //기본 옵션
                direction: 'horizontal',//수평(horizontal), 수직(vertical)
                loop: true,//양쪽 끝을 이어서 계속 슬라이드가 가능하도록 설정

                //현재 페이지에 대한 네비게이션 표시 영역
                pagination: {
                    el: '.swiper-pagination',
                    hideOnClick: true,
                    type: "bullets",// bullets, fraction, progressbar, custom
                },

                //좌우 이동 화살표
                navigation: {
                    nextEl: '.swiper-button-next',
                    prevEl: '.swiper-button-prev',
                    hideOnClick: true,
                },

                //전환이펙트
                effect: "fade",//slide, fade, cube, coverflow, flip, creative, cards
                //fadeEffect:{},
                //coverflowEffect:{},
                //cubeEffect:{},
                //flipEffect:{},
                //creativeEffect:{},
                //cardEffect:{},
            });
        });
    </script>


 
 
   <script type="text/javascript">
        $(document).ready(function () {
            var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                mapOption = {
                    center: new kakao.maps.LatLng(37.5514250, 126.988000), // 지도의 중심좌표
                    level: 5, // 지도의 확대 레벨
                    mapTypeId: kakao.maps.MapTypeId.ROADMAP // 지도종류
                };

            // 지도를 생성한다 
            var map = new kakao.maps.Map(mapContainer, mapOption);

            // 지도에 확대 축소 컨트롤을 생성한다
            var zoomControl = new kakao.maps.ZoomControl();

            // 지도의 우측에 확대 축소 컨트롤을 추가한다
            map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

            // 지도 영역 변화 이벤트를 등록한다
            kakao.maps.event.addListener(map, 'bounds_changed', function () {
                var mapBounds = map.getBounds(),
                    message = '지도의 남서쪽, 북동쪽 영역좌표는 ' +
                        mapBounds.toString() + '입니다.';

                console.log(message);
            });

            // 지도 시점 변화 완료 이벤트를 등록한다
            kakao.maps.event.addListener(map, 'idle', function () {
                var message = '지도의 중심좌표는 ' + map.getCenter().toString() + ' 이고,' +
                    '확대 레벨은 ' + map.getLevel() + ' 레벨 입니다.';
                console.log(message);
            });

            // 지도에 마커를 생성하고 표시한다
            var marker = new kakao.maps.Marker({
                position: new kakao.maps.LatLng(37.5514250, 126.988000), // 마커의 좌표
                draggable: true, // 마커를 드래그 가능하도록 설정한다
                map: map // 마커를 표시할 지도 객체
            });

            // 마커 위에 표시할 인포윈도우를 생성한다
            var infowindow = new kakao.maps.InfoWindow({
                content: '<div style="padding:5px;">태스트 </div>' // 인포윈도우에 표시할 내용
            });

            // 인포윈도우를 지도에 표시한다
            infowindow.open(map, marker);

            // 마커에 클릭 이벤트를 등록한다 (우클릭 : rightclick)
            kakao.maps.event.addListener(marker, 'click', function () {
                alert('마커를 클릭했습니다!');
            });



        });
    </script>
     <style>
        textarea {
            resize: none;
            /* 사이즈 조정 비활성화 */
            background: none;
            /* 배경 이미지 제거 */
        }

        .swiper {
            width: 550px;
            height: 300px;
        }
    </style>
 <div class="container w-600">
        <div class="cell center">
            <h1>여행지 상세</h1>
        </div>

        <div class="cell my-50 mt-20">
            <!-- Slider main container -->
            <!-- <div></div> -->
            <div class="swiper test03">
                <!-- Additional required wrapper -->
                <div class="swiper-wrapper">
                    <!-- Slides -->
                    <div class="swiper-slide"><img src="https://picsum.photos/id/11/600/300" width="100%" height="100%">
                    </div>
                    <div class="swiper-slide"><img src="https://picsum.photos/id/12/600/300" width="100%" height="100%">
                    </div>
                    <div class="swiper-slide"><img src="https://picsum.photos/id/13/600/300" width="100%" height="100%">
                    </div>
                    <div class="swiper-slide"><img src="https://picsum.photos/id/14/600/300" width="100%" height="100%">
                    </div>
                    <div class="swiper-slide"><img src="https://picsum.photos/id/15/600/300" width="100%" height="100%">
                    </div>
                </div>
                <!-- If we need pagination -->
                <div class="swiper-pagination"></div>

                <!-- If we need navigation buttons -->
                <div class="swiper-button-prev"></div>
                <div class="swiper-button-next"></div>

            </div>
        </div>
        <div class="cell">
            <label>상세정보</label>
            <hr>
            <textarea class="field w-100 target" rows="7">
            서울 남산타워는 서울의 대표적인 랜드마크로, 남산 정상에 위치해 있어 서울 시내를 한눈에 내려다볼 수 있는 멋진 전망을 제공합니다. 1969년에 개장하여 오랜 역사를 자랑하며, 특히 밤에는 수많은 조명이 켜져 서울의 야경을 더욱 빛나게 합니다. 타워의 전망대는 다양한 층으로 이루어져 있으며, 방문객들에게 한강과 서울 시내를 감상할 수 있는 기회를 제공합니다.

            또한, 남산타워는 ‘사랑의 자물쇠’로 유명합니다. 연인들이 사랑을 영원히 간직하고자 자물쇠를 걸어놓은 곳으로, 이곳은 꼭 방문해야 할 명소 중 하나입니다. 케이블카를 타고 남산타워까지 올라갈 수 있어 접근이 용이하며, 타워 근처에는 다양한 레스토랑과 카페도 있어 여행 중 여유를 즐기기 좋습니다. 남산타워에서의 일출과 일몰을 경험하면 더욱 특별한 여행이 될 것입니다.
            
            서울을 여행할 때 남산타워는 놓칠 수 없는 명소로, 다양한 매력을 가진 이곳은 누구에게나 추천할 만한 장소입니다.
          </textarea>
        </div>
        <div class="cell  center my-20 p-30">
            <div id="map" style="width:530px;height:480px;"></div>
        </div>

        <div class="cell ">
            <label>리뷰</label>
        </div>

        <div class="cell">
            <table class="table table-border table-stripe">
                <thead>
        
                </thead>
                <tbody class="center">
                    <tr>
                        <td>여행자A</td>
                        <td >낭만적인 곳입니다!</td>
                        <td>
                            2025-02-23
                        </td>
                
                    </tr>
                    <tr>
                        <td>여행자B</td>
                        <td >야경이 멋져요!</td>
                        <td>
                            2025-02-23
                        </td>
                
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
