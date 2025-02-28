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
    
  
       <script type="text/javascript">
              $(function(){
      
                  //지도를 표시할 영역 선택
                  var container = document.querySelector("#map");//JS
                  //var container = $("#map")[0];//jQuery
      
                  //지도 표시 옵션 설정(center : 중심좌표 , level : 확대수준)
                  //- 지도의 좌표는 위도(latitude)와 경도(longitude)로 이루어져 있다.
                  //- 위도나 경도는 일반적으로 소수점 6자리까지 표기
                  //- 카카오에서는 위도경도를 합쳐서 위치정보(LatLng)로 사용
                  //- 지도는 상황에 따라 다양한 배율(level)을 가진다
                  //- 1부터 14까지 설정 가능
                  var options = {
                      center: new kakao.maps.LatLng(37.566395, 126.987778),
                      level: 3
                  };
      
                  var map = new kakao.maps.Map(container, options);
                  
                  //목표 : 검색버튼 누르면 입력창의 주소를 검색하여 지도에 표시
                  $(".btn-address-search").click(function(){
                      var address = $(".address-input").val();
                      var regex = /^(?=.*?[가-힣]+).+$/;
                      if(regex.test(address) == false) return;
                      
                      //주소-좌표 변환도구 생성
                      var geocoder = new kakao.maps.services.Geocoder();
      
                      //도구를 이용해서 좌표를 검색
                      //geocoder.addressSearch(주소, 콜백함수);
                      geocoder.addressSearch(address, function(result, status){
                          //console.log(arguments);//함수에 전달되는 모든 인자를 확인
                          //if(status == "OK") {//검색 성공
                          if(status === kakao.maps.services.Status.OK) {//검색 성공
                              //console.log(result[0].x, result[0].y);//경도, 위도
                              
                              //마커 생성
                              var location = new kakao.maps.LatLng(result[0].y, result[0].x);
                              var marker = new kakao.maps.Marker({
                                  map: map,//지도 설정
                                  position: location,//위치 설정
                              });
      
                              //인포윈도우 생성
                              var content = "<div>위도 : "+location.getLat().toFixed(6)+" <br> 경도 : "+location.getLng().toFixed(6)+"</div>";
                              var infowindow = new kakao.maps.InfoWindow({
                                  content: content,
                                  removable: true,
                              });
                              infowindow.open(map, marker);
                              //지도 이동
                              map.setCenter(location);
                          }
                          // else if(status == "ZERO_RESULT") {//검색 결과 없음
                          // }
                      });
                  });
      
              });
          </script>
  <!-- 스타일 -->
    <style>
         .preview-container {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 10px;
        }

     
        .preview-container img {
            width: 200px;
            height: 200px;
            object-fit: cover;
            border-radius: 10px;
            border: 1px solid #ddd;
            padding: 5px;
        }
        #map {
            width: 100%;
            height: 300px;
        } 
        </style>
  
    <!-- 스크립트 예시 이미지 띄우기 -->
    <script>
       $(document).ready(function() {
            const $previewContainer = $('#preview');

            // 기본 이미지 추가 (초기 상태)
            const defaultImg = $('<img>').attr('src', 'https://placehold.co/300x300') 
                .css({
                    'width': '200px',
                    'height': '200px',
                    'object-fit': 'cover',
                    'border-radius': '10px',
                    'border': '1px solid #ddd',
                    'padding': '5px'
                });
            $previewContainer.append(defaultImg);

            $('#imageUpload').on('change', function(event) {
                const files = event.target.files;

                // 기존 미리보기 초기화
                $previewContainer.empty();

                if (files.length > 0) {
                    $.each(files, function(index, file) {
                        const reader = new FileReader();
                        reader.onload = function(e) {
                            const $imgElement = $('<img>').attr('src', e.target.result);
                            $previewContainer.append($imgElement);
                        };
                        reader.readAsDataURL(file);
                    });
                } else {
                    // 파일이 없으면 다시 기본 이미지 표시
                    $previewContainer.append(defaultImg);
                }
            });
        });
    </script>




<script type="text/javascript">
    $(function () {
        $("[name=boardContent]").summernote({
            height:250,//높이(px)
            minHeight:200,//최소 높이(px)
            maxHeight:400,//최대 높이(px)



            placeholder:"타인에 대한 무분별한 비방시 예고 없이 삭제될 수 있습니다",

            //메뉴(toolbar)설정
            toolbar:[
                //['메뉴명',['버튼명','버튼명',...]]
                ["font",["style","fontname","fontsize","forecolor" ,"backcolor"]],
                ["style",["bold","italic","underline","strikethrough"]],
                ["attach",["picture"]],
                ["tool",["ol","ul","table","hr","fullscreen"]],
                // ["acion",["undo","redo"]]
            ],

            //상황에 맞는 callback 함수들
            callback:{
                onlmageUpload:function(files){
                    //예상 시나리오
                    //1.서버로 사용자가 선택한 이미지를 업로드
                    //- 이미지는 multipart/form-data형태여야 한다
                    //- 상황상 form을 쓸 수가 없으므로 ajax를 써야 한다
                    //2.업로드한 이미지에 접근할 수 있는 정보 획득
                    //3.획득한 정보로 <img> 생성
                    //4.에디터에 추가
                    //-$("[name=boardContent]").summernote("insertNode",이미지 태그 객체);
                    // console.log(files);
                    if(files.length !=1)return;

                    var form=new FormData();//form을 대신할 도구
                        form.append("attach",files[0]);

                        $.ajax({
                            processData:false,//파일업로드를 위해 반드시 필요한 설정
                            contentType:false,//파일업로드를 위해 반드시 필요한 설정
                            url:"http://localhost:8080/rest/board/upload",
                            method:"post",
                            data:form,
                            success:function(response){//첨부파일번호(attachmentNo)
                                //첨부파일 번호를 이용해서 src생성
                                //http://localhost:8080/attachment/download?attachmentNo=번호
                                var tag=$("<img>").attr("src","http://localhost:8080/attachment/download?attachmentNo="+response)
                          
                                .addClass("summernote-img");
                                $("[name=boardContent]").summernpte("insertNode",tag[0]);
                            }
                   });
                },
            },
        });
    });
</script>
  
  <div class="container w-800">
        <div class="cell center">
            <h2>여행지 등록</h2>
        </div>

        <div class=" class">
            <div class="cell">
                <label>주소 검색</label>
            </div>
            <div class="cell flex-box">
                <input type="text" class="field w-100 address-input">
                <button type="button" class="btn btn-positive btn-address-search">
                    <i class="fa-solid fa-magnifying-glass"></i>
                </button>
            </div>
            <div class="cell">
                <div id="map"></div>
            </div>
        <div class="cell">
            <input class="field w-50 p-10"  type="file" id="imageUpload" multiple accept="image/*">
            <div class="preview-container" id="preview"></div>
        </div>
        <div>

            <form enctype="application/x-www-form-urlencoded"></form>
            <div class="cell">
                <div class="cell">

                    <label>머릿글</label>
                </div>
                <input class="field w-75 -p10">
            </div>
            <div class="cell my-20">
                <form action="" method="post">
                    <div class="cell">
                        <textarea name="boardContent"></textarea>
                    </div>
                    
                    <div class="cell center mt-20">
                        <button type="submit" class="btn btn-positive w-100">여행지 등록</button>
                    </div>
                </form>
            </div>
        
        </div>
     
    </div>
</div>
