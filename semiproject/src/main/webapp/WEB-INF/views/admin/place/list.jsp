<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
/* 카드 리스트 전체 스타일 */
.card-list {
    display: grid;
    grid-template-columns: repeat(4, 1fr);  /* 한 줄에 5개 카드 */
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
    width: 200px;  /* 카드의 최소 너비 설정 */
    height: 250px;  /* 카드의 고정 높이 설정 */
    text-decoration: none;  /* 링크 기본 스타일 제거 */
    color: inherit;  /* 텍스트 색상 유지 */
}
.card a {
    display: block;
    text-decoration: none;  /* 링크 기본 스타일 제거 */
    color: inherit;  /* 텍스트 색상 유지 */
}
/* 카드 이미지 영역 */
.card-image {
    width: 100%;
    height: 65%;  /* 이미지 영역 고정 높이 설정 */
    position: relative;
    overflow: hidden;  /* 이미지가 영역 밖으로 넘치지 않게 함 */
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
    justify-content: space-between;  /* 내용과 하단 정보 배치 */
}
/* 카드 제목 스타일 */
.card-title {
    font-size: 16px;
    font-weight: bold;
    margin: 0;
}
.card-subtitle {
    font-size: 14px;
    margin: 0;
}
/* 카드 하단의 조회수, 좋아요수, 댓글수 영역 */
.card-footer {
    display: flex;
    justify-content: flex-start;  /* 아이콘들을 왼쪽으로 정렬 */
    gap: 10px;  /* 아이콘들 간 간격을 10px로 설정 */
    font-size: 12px;
    color: #777;
    margin-top: 10px;
}
/* 각 아이템의 스타일 */
.card-footer span {
    display: flex;
    align-items: center;
    gap: 5px;
}
</style>

<div class="container w-1000">
	<div class="cell center">
		<h1>관리자-여행지 목록</h1>
	</div>
	
	<div class="cell center">
        <form action="list" method="get">
        	<div class="cell">
        		<select name="region" class="field">
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
	            <select name="type" class="field">
	            	<option value="">선택하세요</option>
	                <option ${param.type == '여행지' ? 'selected' : ''}>여행지</option>
	                <option ${param.type == '음식점' ? 'selected' : ''}>음식점</option>
	                <option ${param.type == '숙박' ? 'selected' : ''}>숙박</option>
	            </select>
        	</div>
            
            <div class="cell">
            	<select name="column" class="field">
            		<option value="placeTitle" ${param.column == '여행지' ? 'placeTitle' : ''}>여행지명</option>
            		<option value="placeWriter" ${param.column == '여행지' ? 'placeWriter' : ''}>작성자</option>
            	</select>
	            <input type="text" name="keyword" value="${keyword}" class="field">
	            <button class="btn btn-positive">검색</button>	
            </div>
            
        </form>
    </div>
	 
	<div class="cell">
	    <div class="card-list">
	    	<c:forEach var="placeDto" items="${list}">
		    	<a href="#" class="card">
		            <div class="card-image">
		                <%-- <img src="/attachment/download?attachmentNo=${placeDto.placeFirstImage}" alt="Card Image"> --%>
		                <img src="/images/defaultBack.png" alt="Card Image">
		            </div>
		            <div class="card-content">
		                <h3 class="card-title">${placeDto.placeTitle}</h3>
		                <p class="card-subtitle">${placeDto.placeRegion}</p>
		                <div class="card-footer">
		                    <!-- <span class="views"><i class="fa-solid fa-eye"></i>: </span> -->
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