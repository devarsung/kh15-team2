<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- summernote cdn -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.js"></script>

<!-- kakao post api -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!-- kakaomap cdn + services 라이브러리 불러오기 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=bb3ee3a13bf05ba14dafda342aa87cd1&libraries=services"></script>

<style>
	.preview-detailImages {
		display: grid;
        grid-template-columns: repeat(4, 1fr); 
        padding: 10px;
        place-items: center;
        margin: 0 auto;
        gap: 20px;
	}
    .img-container {
        position: relative;
        display: inline-block;
        width: 200px;
        height: 200px;
    }
    .img-container img {
        width: 100%;
        height: 100%;
        /* object-fit: cover; */
        /* 이미지 비율 유지하면서 꽉 채우기 */
    }
    .btn-close {
        position: absolute;
        top: 10px;
        right: 10px;
        background: rgba(0, 0, 0, 0.5);
        color: white;
        border: none;
        width: 30px;
        height: 30px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 18px;
        cursor: pointer;
        transition: background 0.3s;
    }
    .btn-close:hover {
        background: rgba(0, 0, 0, 0.8);
    }
    #map {
    	display: none;
   	 	width: 100%; height: 300px; 
    }
    .btn-submit {
    	height: 3.5em;
    }
</style>

<script type="text/javascript" src="/js/place/add.js"></script>

<script type="text/template" id="imgTag">
    <div class="img-container">
        <img src="" alt="">
        <button class="btn-close">&times;</button>
    </div>
</script>
<form class="form-check" action="add" method="post" autocomplete="off" enctype="multipart/form-data">
	<div class="container w-1000">
	    <div class="cell center">
	        <h1>여행지 등록</h1>
	    </div>
	
	    <div class="cell">
	        <h2><i class="fa-solid fa-grip-vertical"></i> 여행지명</h2>
	        <input type="text" name="placeTitle" class="field w-100">
	        <div class="fail-feedback">여행지명을 작성해주세요</div>
	    </div>
	
	    <div class="cell">
	        <h2><i class="fa-solid fa-grip-vertical"></i> 대표이미지</h2>
	        <div class="preview-firstImage">
	            <img src="/images/defaultBack.png" width="500px;" height="300px;">
	            <span class="first-name"></span>
	        </div>
	        <input type="file" name="firstImage" class="firstImage field" style="display:none;">
	        <button type="button" class="btn btn-neutral btn-add-first">사진선택</button>
	        <button type="button" class="btn btn-neutral btn-clean-first">&times;</button>
	        <div class="fail-feedback">대표이미지를 선택해주세요</div>
	    </div>
	
	    <div class="cell">
	        <h2><i class="fa-regular fa-pen-to-square"></i> 주소</h2>
	    </div>
	    <div class="cell">
	        <input type="text" name="placePost" class="field" placeholder="우편번호" readonly>
	        <button type="button" class="btn btn-neutral btn-address-search">
	            <i class="fa-solid fa-magnifying-glass"></i>
	        </button>
	        <button type="button" class="btn btn-negative btn-address-clear" style="display: none;">
	            <i class="fa-solid fa-trash"></i>
	        </button>
	    </div>
	    <div class="cell">
	        <input type="text" name="placeAddress1" class="field w-100" placeholder="기본주소" readonly>
	        <div class="fail-feedback">주소를 작성해주세요</div>
	        <div class="fail2-feedback">주소를 먼저 작성해주세요</div>
	    </div>
	    <div class="cell">
	        <input type="text" name="placeAddress2" class="field w-100" placeholder="상세주소(선택)">
	    </div>
	    
	    <div class="cell flex-box" style="flex-wrap: wrap;">
	    	<div class="w-25">
	    		<h2><i class="fa-solid fa-square-pen"></i> 위도/경도</h2>
	    		<input type="text" name="placeLat" class="field w-100" placeholder="위도" readonly>
	    		<div class="fail-feedback">위도/경도 정보를 설정해주세요</div>
    		</div>
	    	<div class="w-25 mx-10">
	    		<h2>&nbsp;</h2>
	    		<input type="text" name="placeLng" class="field w-100" placeholder="경도" readonly>
	    	</div>
	    	<div class="w-25">
	    		<h2>&nbsp;</h2>
	    		<button type="button" class="btn btn-neutral btn-search-xy">구하기</button>
    		</div>
	    </div>
	    
	    <div class="cell map-area">
	    	<div id="map"></div>
	    </div>
	
	    <div class="cell flex-box" style="flex-wrap: wrap;">
	    	<div class="w-25">
		    	<h2><i class="fa-solid fa-square-pen"></i> 지역</h2>
		        <select name="placeRegion" class="field w-100">
		        	<option value="">선택하세요</option>
		            <option>서울</option>
		            <option>인천</option>
		            <option>대전</option>
		            <option>대구</option>
		            <option>광주</option>
		            <option>부산</option>
		            <option>울산</option>
		            <option>경기</option>
		            <option>강원</option>
		            <option>충북</option>
		            <option>충남</option>
		            <option>경북</option>
		            <option>경남</option>
		            <option>전북</option>
		            <option>전남</option>
		            <option>제주</option>
		            <option>세종</option>
		        </select>
	    		<div class="fail-feedback">지역을 선택해주세요</div>
	    	</div>
	    	
	    	<div class="w-25 mx-10">
				<h2><i class="fa-solid fa-square-pen"></i> 타입</h2>
				<select name="placeType" class="field w-100">
					<option value="">선택하세요</option>
					<option>여행지</option>
					<option>음식점</option>
					<option>숙박</option>
				</select>
				<div class="fail-feedback">여행지타입을 선택해주세요</div>
			</div>
	    </div>
		
	    <div class="cell">
	        <h2><i class="fa-solid fa-grip-vertical"></i> 개요</h2>
	        <textarea name="placeOverview" class="field w-100" rows="10"></textarea>
	        <div class="fail-feedback">개요를 작성해주세요</div>
	    </div>
	
	    <div class="cell">
	        <h2><i class="fa-solid fa-grip-vertical"></i> 상세이미지</h2>
	        <div class="preview-detailImages">
	        	<!-- <div class="img-container">
			        <img src="/images/defaultBack.png" alt="">
			        <button class="btn-close">&times;</button>
			    </div> -->
	        </div>
	        <input type="file" name="detailImages" class="detailImages" multiple>
	    </div>
	    
	    <div class="cell mt-50">
			<button type="submit" class="btn btn-positive w-100 btn-submit">등록하기</button>
		</div>
	</div>
	
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>   