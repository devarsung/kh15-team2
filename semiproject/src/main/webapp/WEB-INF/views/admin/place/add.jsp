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
        gap: 15px;
	}
    .img-container {
        position: relative;
        display: inline-block;
        width: 150px;
        height: 150px;
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
    
    .first-image-area {
    	position: relative;
	    display: flex;
	    flex-direction: column;
	    align-items: center;
    }
    .btn-group {
	    position: absolute;
	    bottom: -45px;
	    right: 43px;
	    display: flex;
	    gap: 5px;
	}
	
	.coord-container {
		display: flex;
	    align-items: center;
	    justify-content: space-between;
	    gap: 5px;
	    width: 100%;
	}
	.coord-input {
		flex: 1;
		flex-direction: column;
	}
	.coord-btn {
		flex-direction: column;
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
	<div class="container w-800">
	    <div class="cell center">
	        <h1>여행지 등록</h1>
	    </div>
	    
	    <div class="cell flex-box" style="flex-wrap: nowrap;">
	    	<div class="w-50">
		    	<h2><i class="fa-solid fa-square-pen"></i> 지역 <i class="fa-solid fa-asterisk red"></i></h2>
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
	    	
	    	<div class="w-50 ms-10">
				<h2><i class="fa-solid fa-square-pen"></i> 타입 <i class="fa-solid fa-asterisk red"></i></h2>
				<select name="placeType" class="field w-100">
					<option value="">선택하세요</option>
					<option>여행지</option>
					<option>맛집</option>
					<option>숙소</option>
				</select>
				<div class="fail-feedback">여행지타입을 선택해주세요</div>
			</div>
	    </div>
	
	    <div class="cell">
	        <h2><i class="fa-solid fa-square-pen"></i> 여행지명 <i class="fa-solid fa-asterisk red"></i></h2>
	        <input type="text" name="placeTitle" class="field w-100">
	        <div class="fail-feedback">여행지명을 작성해주세요</div>
	    </div>
	
	    <div class="cell">
	        <h2><i class="fa-solid fa-square-pen"></i> 대표이미지 <i class="fa-solid fa-asterisk red"></i></h2>
	        <div class="flex-box flex-vertical">
	        	<div class="first-image-area">
			        <div class="preview-firstImage flex-box flex-center">
			            <img src="/images/defaultBack.png" width="100%" height="400px;">
			        </div>
			        <div class="btn-group">
				        <button type="button" class="btn btn-secondary btn-add-first">사진선택</button>
			       		<button type="button" class="btn btn-secondary btn-clean-first">&times;</button>
			        </div>
	        	</div>
		        
		        <input type="file" name="firstImage" class="firstImage field" style="display:none;" accept=".jpg, .jpeg, .png">
		        <div class="fail-feedback center">대표이미지를 선택해주세요</div>
		        <span class="first-name center"></span>
	        </div>
	    </div>
	
	    <div class="cell mt-50">
	        <h2><i class="fa-solid fa-square-pen"></i> 주소 <i class="fa-solid fa-asterisk red"></i></h2>
	    </div>
	    <div class="cell">
	        <input type="text" name="placePost" class="field" placeholder="우편번호" readonly>
	        <button type="button" class="btn btn-secondary btn-address-search">
	            <i class="fa-solid fa-magnifying-glass"></i>
	        </button>
	        <button type="button" class="btn btn-danger btn-address-clear" style="display: none;">
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
	    
	    <div class="cell coord-container">
	    	<div class="coord-input">
	    		<h2><i class="fa-solid fa-square-pen"></i> 위도/경도 <i class="fa-solid fa-asterisk red"></i></h2>
	    		<input type="text" name="placeLat" class="field w-100" placeholder="위도" readonly>
	    		<div class="fail-feedback" style="height: 0;">위도/경도 정보를 설정해주세요</div>
    		</div>
	    	<div class="coord-input">
	    		<h2>&nbsp;</h2>
	    		<input type="text" name="placeLng" class="field w-100" placeholder="경도" readonly>
	    	</div>
	    	<div class="coord-btn">
	    		<h2>&nbsp;</h2>
	    		<button type="button" class="btn btn-secondary btn-search-xy">구하기</button>
    		</div>
	    </div>
	    
	    <div class="cell map-area">
	    	<div id="map"></div>
	    </div>
	    
	    <div class="cell mt-40">
	        <h2><i class="fa-solid fa-square-pen"></i> 개요 <i class="fa-solid fa-asterisk red"></i></h2>
	        <textarea name="placeOverview" class="field w-100" rows="10"></textarea>
	        <div class="fail-feedback">개요를 작성해주세요</div>
	    </div>
	    
	    <div class="cell">
	    	<h2><i class="fa-solid fa-square-pen"></i> 문의전화</h2>
	        <input type="text" name="placeTel" class="field w-100" placeholder="8~12자 숫자로입력하세요">
	        <div class="fail-feedback">미입력 or 8~12자로 입력하세요</div>
	    </div>
	    
	    <div class="cell">
	    	<h2><i class="fa-solid fa-square-pen"></i> 홈페이지</h2>
	        <input type="text" name="placeWebsite" class="field w-100" maxlength="255">
	        <div class="fail-feedback">255자 이내로 입력하세요</div>
	    </div>
	    
	    <div class="cell">
	    	<h2><i class="fa-solid fa-square-pen"></i> 주차가능여부</h2>
	        <select name="placeParking" class="field w-100">
				<option value="">선택하세요</option>
				<option value="Y">가능</option>
				<option value="N">불가능</option>
			</select>
	    </div>
	    
	    <div class="cell">
	    	<h2><i class="fa-solid fa-square-pen"></i> 운영</h2>
	    	<textarea name="placeOperate" class="field w-100" rows="5"
	    	placeholder="운영일, 운영시간 관련해 200자 이내로 자유롭게 적어주세요"></textarea>
	    	<div class="fail-feedback">200자 이내로 입력하세요</div>
	    </div>
	
	    <div class="cell">
	        <h2><i class="fa-solid fa-square-pen"></i> 상세이미지(여러장 가능)</h2>
	        <div class="preview-detailImages">
	        	<!-- <div class="img-container">
			        <img src="/images/defaultBack.png" alt="">
			        <button class="btn-close">&times;</button>
			    </div> -->
	        </div>
	        <button type="button" class="btn btn-secondary btn-add-detail mt-20">사진선택</button>
	        <input type="file" name="detailImages" class="detailImages" multiple style="display:none;" accept=".jpg, .jpeg, .png">
	    </div>
	    
	    <div class="cell mt-50">
			<button type="submit" class="btn btn-primary w-100 btn-submit">등록하기</button>
		</div>
	</div>
	
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>   