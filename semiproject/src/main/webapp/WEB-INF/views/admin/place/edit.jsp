<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
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
	
	.field {
	 	border: 1px solid #ccc;
	    border-radius: 5px;
	    padding: 0.5em;
	    font-size: 16px;
	    background-color: #fff;
	    transition: all 0.3s ease-in-out;
	}
	.field:hover {
	    border-color: #007bff;
	    box-shadow: 0 0 8px rgba(0, 123, 255, 0.2);
	}
</style>

<script type="text/javascript" src="/js/place/edit.js"></script>

<script type="text/template" id="imgTag">
    <div class="img-container">
        <img src="" alt="">
        <button class="btn-close">&times;</button>
    </div>
</script>

<form class="form-check" action="edit" method="post" autocomplete="off" enctype="multipart/form-data">
	<div class="container w-800">
	    <div class="cell center">
	        <h1>여행지 수정</h1>
	    </div>
	    
	    <input type="hidden" name="placeNo" value="${placeDto.placeNo}">
	    
	    <div class="cell flex-box" style="flex-wrap: nowrap;">
	    	<div class="w-50">
		    	<h2><i class="fa-solid fa-square-pen"></i> 지역 <i class="fa-solid fa-asterisk red"></i></h2>
		        <select name="placeRegion" class="field w-100">
		        	<option value="">선택하세요</option>
		            <option ${placeDto.placeRegion=='서울'?'selected':'' }>서울</option>
		            <option ${placeDto.placeRegion=='인천'?'selected':'' }>인천</option>
		            <option ${placeDto.placeRegion=='대전'?'selected':'' }>대전</option>
		            <option ${placeDto.placeRegion=='대구'?'selected':'' }>대구</option>
		            <option ${placeDto.placeRegion=='광주'?'selected':'' }>광주</option>
		            <option ${placeDto.placeRegion=='부산'?'selected':'' }>부산</option>
		            <option ${placeDto.placeRegion=='울산'?'selected':'' }>울산</option>
		            <option ${placeDto.placeRegion=='경기'?'selected':'' }>경기</option>
		            <option ${placeDto.placeRegion=='강원'?'selected':'' }>강원</option>
		            <option ${placeDto.placeRegion=='충북'?'selected':'' }>충북</option>
		            <option ${placeDto.placeRegion=='충남'?'selected':'' }>충남</option>
		            <option ${placeDto.placeRegion=='경북'?'selected':'' }>경북</option>
		            <option ${placeDto.placeRegion=='경남'?'selected':'' }>경남</option>
		            <option ${placeDto.placeRegion=='전북'?'selected':'' }>전북</option>
		            <option ${placeDto.placeRegion=='전남'?'selected':'' }>전남</option>
		            <option ${placeDto.placeRegion=='제주'?'selected':'' }>제주</option>
		            <option ${placeDto.placeRegion=='세종'?'selected':'' }>세종</option>
		        </select>
	    		<div class="fail-feedback">지역을 선택해주세요</div>
	    	</div>
	    	
	    	<div class="w-50 ms-10">
				<h2><i class="fa-solid fa-square-pen"></i> 타입 <i class="fa-solid fa-asterisk red"></i></h2>
				<select name="placeType" class="field w-100">
					<option value="">선택하세요</option>
					<option ${placeDto.placeType=='여행지'?'selected':''}>여행지</option>
					<option ${placeDto.placeType=='맛집'?'selected':''}>맛집</option>
					<option ${placeDto.placeType=='숙소'?'selected':''}>숙소</option>
				</select>
				<div class="fail-feedback">여행지타입을 선택해주세요</div>
			</div>
	    </div>
	
	    <div class="cell">
	        <h2><i class="fa-solid fa-square-pen"></i> 여행지명 <i class="fa-solid fa-asterisk red"></i></h2>
	        <input type="text" name="placeTitle" class="field w-100" value="${placeDto.placeTitle}">
	        <div class="fail-feedback">여행지명을 작성해주세요</div>
	    </div>
	
	    <div class="cell">
	        <h2><i class="fa-solid fa-square-pen"></i> 대표이미지 <i class="fa-solid fa-asterisk red"></i></h2>
	        <div class="flex-box flex-vertical">
		        <div class="first-image-area">
			        <div class="preview-firstImage flex-box flex-center">
			            <img src="/attachment/download?attachmentNo=${placeDto.placeFirstImage}" width="100%" height="400px;">
			        </div>
			        <div class="btn-group">
			        	<button type="button" class="btn btn-secondary btn-add-first">사진선택</button>
	        			<button type="button" class="btn btn-secondary btn-clean-first">&times;</button>
			        </div>
		        </div>
		    	
		    	<input type="file" name="firstImage" class="firstImage field" style="display:none;">    
		    	<div class="fail-feedback center">대표이미지를 선택해주세요</div>    
		        <span class="first-name center"></span>
	        </div>
	    </div>
	
	    <div class="cell mt-50">
	        <h2><i class="fa-solid fa-square-pen"></i> 주소 <i class="fa-solid fa-asterisk red"></i></h2>
	    </div>
	    <div class="cell">
	        <input type="text" name="placePost" class="field" placeholder="우편번호" readonly value="${placeDto.placePost}">
	        <button type="button" class="btn btn-secondary btn-address-search">
	            <i class="fa-solid fa-magnifying-glass"></i>
	        </button>
	        <button type="button" class="btn btn-danger btn-address-clear">
	            <i class="fa-solid fa-trash"></i>
	        </button>
	    </div>
	    <div class="cell">
	        <input type="text" name="placeAddress1" class="field w-100" placeholder="기본주소" readonly value="${placeDto.placeAddress1}">
	        <div class="fail-feedback">주소를 작성해주세요</div>
	        <div class="fail2-feedback">주소를 먼저 작성해주세요</div>
	    </div>
	    <div class="cell">
	        <input type="text" name="placeAddress2" class="field w-100" placeholder="상세주소(선택)" value="${placeDto.placeAddress2}">
	    </div>
	    
	    <div class="cell coord-container">
	    	<div class="coord-input">
	    		<h2><i class="fa-solid fa-square-pen"></i> 위도/경도 <i class="fa-solid fa-asterisk red"></i></h2>
	    		<input type="text" name="placeLat" class="field w-100" placeholder="위도" readonly value="${placeDto.placeLat}">
	    		<div class="fail-feedback" style="height: 0;">위도/경도 정보를 설정해주세요</div>
    		</div>
	    	<div class="coord-input">
	    		<h2>&nbsp;</h2>
	    		<input type="text" name="placeLng" class="field w-100" placeholder="경도" readonly value="${placeDto.placeLng}">
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
	        <textarea name="placeOverview" class="field w-100" rows="10">${placeDto.placeOverview}</textarea>
	        <div class="fail-feedback">개요를 작성해주세요</div>
	    </div>
	    
	    <div class="cell">
	    	<h2><i class="fa-solid fa-square-pen"></i> 문의전화</h2>
	        <input type="text" name="placeTel" class="field w-100" value="${placeDto.placeTel}" placeholder="10~11자 숫자로입력하세요">
	        <div class="fail-feedback">미입력 or 10~11자로 입력하세요</div>
	    </div>
	    
	    <div class="cell">
	    	<h2><i class="fa-solid fa-square-pen"></i> 홈페이지</h2>
	        <input type="text" name="placeWebsite" class="field w-100" maxlength="255" value="${placeDto.placeWebsite}">
	        <div class="fail-feedback">255자 이내로 입력하세요</div>
	    </div>
	    
	    <div class="cell">
	    	<h2><i class="fa-solid fa-square-pen"></i> 주차가능여부</h2>
	        <select name="placeParking" class="field w-100">
				<option value="" ${placeDto.placeParking == '' ? 'selected' : ''}>선택하세요</option>
				<option value="Y" ${placeDto.placeParking == 'Y' ? 'selected' : ''}>가능</option>
				<option value="N" ${placeDto.placeParking == 'N' ? 'selected' : ''}>불가능</option>
			</select>
	    </div>
	    
	    <div class="cell">
	    	<h2><i class="fa-solid fa-square-pen"></i> 운영</h2>
	    	<textarea name="placeOperate" class="field w-100" rows="5"
	    	placeholder="운영일, 운영시간 관련해 200자 이내로 자유롭게 적어주세요">${placeDto.placeOperate}</textarea>
	    	<div class="fail-feedback">200자 이내로 입력하세요</div>
	    </div>
	
	    <div class="cell">
	        <h2><i class="fa-solid fa-square-pen"></i> 상세이미지(여러장 가능)</h2>
	        <div class="preview-detailImages">
	        	<c:forEach var="detailImageNo" items="${detailImagesNos}">
	        		<div class="img-container">
				        <img src="/attachment/download?attachmentNo=${detailImageNo}" alt="여행지 상세이미지"
				        	data-old-no="${detailImageNo}">
				        <button class="btn-close">&times;</button>
				    </div>
	        	</c:forEach>
	        </div>
	        <button type="button" class="btn btn-secondary btn-add-detail mt-20">사진선택</button>
	        <input type="file" name="detailImages" class="detailImages" multiple style="display:none;">
	    </div>
	    
	    <input type="hidden" name="firstImageChange">
	    <input type="hidden" name="deletedOldNos">
	    
	    <div class="cell mt-50">
			<button type="submit" class="btn btn-primary w-100 btn-submit">등록하기</button>
		</div>
	</div>
	
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>   