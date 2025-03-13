<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 별점 라이브러리 -->
<script src="https://cdn.jsdelivr.net/gh/hiphop5782/score@latest/score.js"></script>

<style>
.search-container {
    display: flex;
    flex-direction: column;
    gap: 10px;
    width: 100%;
    max-width: 800px;
    margin: 0 auto;
    border: 2px solid #D3DDE5;
    padding: 20px;
    border-radius: 5px;
}
.search-row {
    display: flex;
    gap: 10px;
    width: 100%;
}
.half-width {
    flex: 1;
    min-width: 180px;
}
.small-width {
    width: 25%;
    min-width: 150px;
}
.large-width {
    flex: 1;
    min-width: 300px;
}
.etc-group {
	display: flex;
	justify-content: end;
}

/* 카드 리스트 전체 스타일 */
.card-list {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    padding: 10px;
    place-items: center;
    margin: 0 auto;
    gap: 20px;
}
.card {
    background-color: #fff;
    border-radius: 0px;
    overflow: hidden;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    display: flex;
    flex-direction: column;
    width: 200px;
    height: 250px;
    text-decoration: none;
    color: inherit;
}
.card a {
    display: block;
    text-decoration: none;
    color: inherit;
}
/* 카드 이미지 영역 */
.card-image {
    width: 100%;
    height: 65%;
    position: relative;
    overflow: hidden;
}
.card-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;  /* 이미지가 영역을 가득 채우도록 설정 */
}
/* 카드 내용 영역 */
.card-content {
    padding: 10px;
    flex-grow: 1;  /* 남은 공간을 차지하도록 설정 */
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}
/* 카드 제목 스타일 */
.card-title {
    font-size: 16px;
    font-weight: bold;
    display: flex;
    justify-content: space-between; /* 제목 왼쪽, 아이콘 오른쪽 정렬 */
    align-items: center;
    gap: 10px;
    width: 100%;
}
.card-title .title-area {
	margin: 0;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}
.card-title .icon-area {
	margin: 0;
}
.card-subtitle {
    font-size: 14px;
}
/* 카드 하단의 조회수, 좋아요수, 댓글수 영역 */
.card-footer {
    display: flex;
    justify-content: flex-start;  /* 아이콘들을 왼쪽으로 정렬 */
    gap: 10px;  /* 아이콘들 간 간격을 10px로 설정 */
    font-size: 12px;
    color: #777;
    margin-top: 1px;
}
/* 각 아이템의 스타일 */
.card-footer span {
    display: flex;
    align-items: center;
    gap: 5px;
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
.btn {
    border-radius: 5px;
    padding: 0.5em 0.75em;
    font-size: 16px;
    text-align: center;
}
.btn-primary {
    background-color: lightblue;
    color: white;
    border: 1px solid lightblue;
}
.btn-primary:hover {
	brightness(1.05);
}
.btn-secondary {
    background-color: darkgray;
    color: white;
    border: 1px solid darkgray;
}
.btn-secondary:hover {
    brightness(1.05);
}
</style>
<script type="text/javascript">
$(function(){
	$(".review-star").score({
        display:{
        	showNumber:true,
        },
    });
	
	$("[name=order]").change(function(){
		$(".form-check").submit();
	});
	
	$(".btn-search-clean").click(function(){
		$("[name=region]").val("");
		$("[name=type]").val("");
		$("[name=column]").val("place_title");
		$("[name=keyword]").val("");
		$("[name=order]").val("place_wtime");
	});
	
});
</script>

<div class="container w-1000">
	<div class="cell center">
		<h1>여행지 목록</h1>
	</div>
	<form action="list" method="get" class="form-check">
		<div class="search-container">
        	<div class="search-row">
        		<select name="region" class="field half-width">
	                <option value="">선택하세요</option>
	                <option ${param.region == '서울' ? 'selected' : ''}>서울</option>
	                <option ${param.region == '인천' ? 'selected' : ''}>인천</option>
	                <option ${param.region == '대전' ? 'selected' : ''}>대전</option>
	                <option ${param.region == '대구' ? 'selected' : ''}>대구</option>
	                <option ${param.region == '광주' ? 'selected' : ''}>광주</option>
	                <option ${param.region == '부산' ? 'selected' : ''}>부산</option>
	                <option ${param.region == '울산' ? 'selected' : ''}>울산</option>
	                <option ${param.region == '경기' ? 'selected' : ''}>경기</option>
	                <option ${param.region == '강원' ? 'selected' : ''}>강원</option>
	                <option ${param.region == '충북' ? 'selected' : ''}>충북</option>
	                <option ${param.region == '충남' ? 'selected' : ''}>충남</option>
	                <option ${param.region == '경북' ? 'selected' : ''}>경북</option>
	                <option ${param.region == '경남' ? 'selected' : ''}>경남</option>
	                <option ${param.region == '전북' ? 'selected' : ''}>전북</option>
	                <option ${param.region == '전남' ? 'selected' : ''}>전남</option>
	                <option ${param.region == '제주' ? 'selected' : ''}>제주</option>
	                <option ${param.region == '세종' ? 'selected' : ''}>세종</option>
	            </select>
	            <select name="type" class="field half-width">
	            	<option value="">선택하세요</option>
	                <option ${param.type == '여행지' ? 'selected' : ''}>여행지</option>
	                <option ${param.type == '맛집' ? 'selected' : ''}>맛집</option>
	                <option ${param.type == '숙소' ? 'selected' : ''}>숙소</option>
	            </select>
        	</div>
            
            <div class="search-row">
            	<select name="column" class="field small-width">
            		<option value="place_title" ${param.column == 'place_title' ? 'selected' : ''}>여행지명</option>
            	</select>
	            <input type="text" name="keyword" value="${param.keyword}" class="field large-width">
            </div>
            
            <div class="flex-box flex-center mt-10">
            	<button type="submit" class="btn btn-primary mx-10">검색 <i class="fa-solid fa-magnifying-glass"></i></button>
            	<button type="button" class="btn btn-secondary btn-search-clean">초기화 <i class="fa-solid fa-rotate-left"></i></button>
         	</div>
       	</div>
            
        <div class="mt-40 etc-group">
	    	<select name="order" class="field" style="margin-right: 25px;">
		    	<option value="place_wtime" ${param.order == 'place_wtime' ? 'selected' : ''}>최신순</option>
	    		<option value="place_star" ${param.order == 'place_star' ? 'selected' : ''}>평점순</option>
	    		<option value="place_like" ${param.order == 'place_like' ? 'selected' : ''}>좋아요순</option>
	    		<option value="place_review" ${param.order == 'place_review' ? 'selected' : ''}>후기순</option>
	    	</select>
   		</div>
	</form> 
	
	<div class="cell">
	    <div class="card-list">
	    	<c:forEach var="placeDto" items="${list}">
		    	<a href="detail?placeNo=${placeDto.placeNo}" class="card">
		            <div class="card-image">
		                <img src="/attachment/download?attachmentNo=${placeDto.placeFirstImage}" alt="Card Image" 
		                onerror="this.onerror=null; this.src='/images/default-image.png';">
		            </div>
		            <div class="card-content">
		                <div class="card-title">
		                	<h3 class="title-area">
		                		${placeDto.placeTitle}
			                </h3>
			                <h3 class="icon-area">
			                	<c:if test="${placeDto.placeType == '여행지'}">
			                		<i class="fa-solid fa-mountain"></i>
			                	</c:if>
			                	
			                	<c:if test="${placeDto.placeType == '맛집'}">
			                		<i class="fa-solid fa-utensils"></i>
			                	</c:if>
			                	
			                	<c:if test="${placeDto.placeType == '숙소'}">
			                		<i class="fa-solid fa-hotel"></i>
			                	</c:if>
		                	</h3>	
		                </div>
		                <fmt:parseNumber var="placeStar" value="${placeDto.placeStar}"/>
		                <div class="review-star" data-max="5" data-rate="${placeStar}"></div>
		                <div class="card-subtitle">${placeDto.placeRegion}</div>
		                <div class="card-footer">
		                    <span class="views"><i class="fa-solid fa-eye"></i>:  ${placeDto.placeRead}</span>
		                    <span class="likes"><i class="fa-solid fa-heart"></i>: ${placeDto.placeLike}</span>
		                    <span class="comments"><i class="fa-solid fa-comment-dots"></i>: ${placeDto.placeReview}</span>
		                </div>
		            </div>
		        </a>
	    	</c:forEach>
	    </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/pagination.jsp"></jsp:include>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>