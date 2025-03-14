<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 별점 라이브러리 -->
<script src="https://cdn.jsdelivr.net/gh/hiphop5782/score@latest/score.js"></script>

<link rel="stylesheet" type="text/css" href="/css/place.css">

<style>
.etc-group {
	display: flex;
	justify-content: space-between;
}

.check-btn {
	position: absolute;
	top: -3px;
	right: 3px;
	text-align: center;
	border: none;
	background: none;
	cursor: pointer;
	font-size: 35px;
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
	
	$(".check-btn").click(function(){
		var checked = $(this).next().prop("checked");
		if(checked) {
			//체크 되어있다면 -> 체크해제 
			$(this).find("i").removeClass("fa-solid fa-square-check fa-regular fa-square")
							.addClass("fa-regular fa-square");
		}
		else {
			//안되어있다면 -> 체크하기
			$(this).find("i").removeClass("fa-solid fa-square-check fa-regular fa-square")
							.addClass("fa-solid fa-square-check");
		}
		
		$(this).next().prop("checked", !checked);
		
		/* e.stopPropagation(); */
		return false;
	});
	
	$(".check-delete").click(function(){
		var deleteNos = [];
		$(".checkbox:checked").each(function(){
			console.log($(this).val());
			deleteNos.push($(this).val());
		});
		
		
		if(deleteNos.length === 0) {
			alert("삭제할 항목을 선택해주세요");
			return false;
		}
		
		var form = $("<form>", {
			method: "post",
			action: "/admin/place/deleteAll"
		});
		
		var input = $("<input>", {
			type: "hidden",
			name: "placeNoList",
			value: deleteNos.join(",")
		});
		
		form.append(input);
		$("body").append(form);
		form.submit();
		
		return false;
	});
});

</script>

<!-- 
	<i class="fa-solid fa-square-check"></i>
	<i class="fa-regular fa-square"></i>
 -->

<div class="container w-1000">
	<div class="cell flex-box flex-center">
		<h1>관리자-여행지 목록</h1>
	</div>

	<form action="list" method="get" class="form-check">
		<div class="search-container">
        	<div class="search-row">
        		<select name="region" class="field half-width">
	                <option value="">지역을 선택하세요</option>
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
	            	<option value="">타입을 선택하세요</option>
	                <option ${param.type == '여행지' ? 'selected' : ''}>여행지</option>
	                <option ${param.type == '맛집' ? 'selected' : ''}>맛집</option>
	                <option ${param.type == '숙소' ? 'selected' : ''}>숙소</option>
	            </select>
        	</div>
            
            <div class="search-row">
            	<select name="column" class="field small-width">
            		<option value="place_title"  ${param.column == 'place_title' ? 'selected' : ''}>여행지명</option>
            		<option value="place_writer" ${param.column == 'place_writer' ? 'selected' : ''}>작성자</option>
            	</select>
	            <input type="text" name="keyword" value="${param.keyword}" class="field large-width">
            </div>
            
            <div class="flex-box flex-center mt-10">
            	<button type="submit" class="btn btn-primary mx-10">검색 <i class="fa-solid fa-magnifying-glass"></i></button>
	            <button type="button" class="btn btn-secondary btn-search-clean">초기화 <i class="fa-solid fa-rotate-left"></i></button>
            </div>
   		</div>
   		
   		<div class="mt-40 etc-group">
   			<div style="margin-left: 25px;">
   				<a href="add" class="btn btn-neutral"><i class="fa-solid fa-plus"></i> 등록</a>
   				<a href="#" class="btn btn-neutral check-delete" style="margin-left: 3px;"><i class="fa-solid fa-plus"></i> 체크삭제</a>
   			</div>
   		
	    	<select name="order" class="field" style="margin-right: 25px;">
	    		<option value="place_wtime" ${param.order == 'place_wtime' ? 'selected' : ''}>최신순</option>
	    		<option value="place_star" ${param.order == 'place_star' ? 'selected' : ''}>평점순</option>
	    		<option value="place_like" ${param.order == 'place_like' ? 'selected' : ''}>좋아요순</option>
	    		<option value="place_review" ${param.order == 'place_review' ? 'selected' : ''}>후기순</option>
	    	</select>
	    </div>
	</form>
   	 
	<div class="cell">
		<c:choose>
			<c:when test="${list.isEmpty()}">
				<div class="cell no-list">
		   			<i class="fa-solid fa-fish"></i>
		       		<span>목록이 없습니다</span>
		       	</div>
			</c:when>
			
			<c:otherwise>
				<div class="card-list">
			    	<c:forEach var="placeDto" items="${list}">
				    	<a href="detail?placeNo=${placeDto.placeNo}" class="card">
				            <div class="card-image">
				                <img src="/attachment/download?attachmentNo=${placeDto.placeFirstImage}" alt="Card Image" 
				                onerror="this.onerror=null; this.src='/images/default-image.png';">
				                <button type="button" class="check-btn">
									<i class="fa-regular fa-square"></i>
								</button>
								<input type="checkbox" class="checkbox" style="display:none;" value="${placeDto.placeNo}"/>
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
			</c:otherwise>
		</c:choose>
	
	
	    
    </div>
</div>

<c:if test="${list.isEmpty() eq false}">
	<jsp:include page="/WEB-INF/views/template/pagination.jsp"></jsp:include>
</c:if>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>