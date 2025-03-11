<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
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
    border-radius: 5px;
    overflow: hidden;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    display: flex;
    flex-direction: column;
    width: 220px;
    height: 270px;
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
    object-fit: cover;
}
.heart-btn {
	position: absolute;
	top: 5px;
	right: 0px;
	text-align: center;
	border: none;
	background: none;
	cursor: pointer;
}
.heart-btn i {
	font-size: 30px;
}
/* 카드 내용 영역 */
.card-content {
    padding: 10px;
    flex-grow: 1;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}
/* 카드 제목 스타일 */
.card-title {
    font-size: 16px;
    font-weight: bold;
    display: flex;
    justify-content: space-between;
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
/* 카드 하단의 좋아요 수 영역 */
.card-footer {
    display: flex;
    justify-content: flex-start;
    gap: 10px;
    font-size: 12px;
    color: #777;
    margin-top: 1px;
}
/* 아이콘 스타일 */
.card-footer span {
    display: flex;
    align-items: center;
    gap: 5px;
}

.no-list {
	width: 100%;
	height: 300px;
	border: 1px solid gray;
	display : flex;
	flex-direction: column;
  	justify-content : center;
  	align-items : center;
  	font-size: 20px;
}
</style>

<script type="text/javascript">
$(function(){
	
	var currentPage = 1;
	var size = 16;
	
	//목록 불러오기
	function loadList() {
		$.ajax({
			url: "/rest",
			method: "post",
			data: {page: currentPage++, size: 16},
			success: function(response) {
				if(response.length === 0) {
					if(currentPage === 0) {
						//좋아요 목록이 아예 없는 경우
						$(".no-list").show();
						$(".card-list").hide();
						$(".btn-more").hide();
						return;
					}
					else {
						//더 이상의 없는 경우
						$(".btn-more").hide();
						return;
					}
				}
				
				$(".no-list").hide();
				$(".card-list").show();
				$(".btn-more").show();
				
				$(response).each(function(){
					var template = $("#place-template").text();
					var html = $.parseHTML(template);
					
					$(html).find(".place-link").attr("href", "/place/detail?placeNo=" + this.placeNo);
					$(html).find(".first-image").attr("src", "/attachment/download?attachmentNo=" + this.placeFirstImage);
					$(html).find(".first-image").attr("alt", this.placeTitle + " 대표이미지");
					$(html).find(".title-area").text(this.placeTitle);
					$(html).find(".heart-btn").data("no", this.placeNo);
					$(html).find(".card-subtitle").text(this.placeRegion);
					
					var iconHtml = "";
					if (this.placeType == "여행지") {
					    iconHtml = '<i class="fa-solid fa-mountain"></i>';
					} else if (this.placeType == "맛집") {
					    iconHtml = '<i class="fa-solid fa-utensils"></i>';
					} else if (this.placeType == "숙소") {
					    iconHtml = '<i class="fa-solid fa-hotel"></i>';
					}
					$(html).find(".icon-area").html(iconHtml);

					$(".card-list").append(html);
				});
			}
		});
	}
	
	//하트버튼
	//작동 안되면 document에 걸어야함
	$(".heart-btn").click(function(){
		var me = $(this);
		var placeNo = $(this).data("no");
		
		$.ajax({
			url: "/rest/place/action",
			method: "post",
			data: {placeNo : placeNo},
			success: function(response) {
				console.log(response);
				
				$(me).find("i").removeClass("fa-solid fa-regular")
					.addClass(response.done ? "fa-solid" : "fa-regular");
			}
		});
		
		/* console.log("하트클릭"); */
		/* e.stopPropagation(); */
		return false;
	});
});
</script>

<script type="text/template" id="place-template">
<a href="#" class="card place-link">
	<div class="card-image">
        <img class="first-image" src="" alt="Card Image"
             onerror="this.onerror=null; this.src='/images/default-image.png';">
        <button type="button" class="heart-btn">
			<i class="fa-solid fa-heart red"></i>
		</button>
	</div>
	<div class="card-content">
		<div class="card-title">
			<h3 class="title-area">${place.placeTitle}</h3>
			<h3 class="icon-area">
            	
            </h3>
        </div>
        <div class="card-subtitle">${place.placeRegion}</div>
		<div class="card-footer">
			
		</div>
	</div>
</a>
</script>

<div class="container w-1000">
    <div class="cell center">
        <h1>내가 좋아요한 여행지</h1>
    </div>
    
    <jsp:include page="/WEB-INF/views/template/mypage-tab.jsp">
  		<jsp:param name="menu" value="myLikePlace"/>
	</jsp:include>
    
    <div class="cell mt-50">
   		<!-- <div class="cell no-list">
   			<i class="fa-solid fa-fish"></i>
       		<span>목록이 없습니다</span>
       	</div> -->
        <div class="card-list">
        
            <c:choose>
                <c:when test="${placeLikeList.isEmpty()}">
                    <p style="text-align: center; width: 100%;">좋아요한 여행지가 없습니다.</p>
                </c:when>
                <c:otherwise>
                    <c:forEach var="place" items="${placeLikeList}">
                        <a href="/place/detail?placeNo=${place.placeNo}" class="card">
                            <div class="card-image">
                                <img src="/attachment/download?attachmentNo=${place.placeFirstImage}" alt="Card Image"
                                    onerror="this.onerror=null; this.src='/images/default-image.png';">
                                    <button type="button" class="heart-btn" data-no="${place.placeNo}">
                                    	<i class="fa-solid fa-heart red"></i>
                                   	</button>
                            </div>
                            <div class="card-content">
                                <div class="card-title">
                                    <h3 class="title-area">${place.placeTitle}</h3>
                                    <h3 class="icon-area">
                                        <c:if test="${place.placeType == '여행지'}">
                                            <i class="fa-solid fa-mountain"></i>
                                        </c:if>
                                        <c:if test="${place.placeType == '맛집'}">
                                            <i class="fa-solid fa-utensils"></i>
                                        </c:if>
                                        <c:if test="${place.placeType == '숙소'}">
                                            <i class="fa-solid fa-hotel"></i>
                                        </c:if>
                                    </h3>
                                </div>
                                <div class="card-subtitle">${place.placeRegion}</div>
                                <div class="card-footer">
                                    <span class="likes"><i class="fa-solid fa-heart"></i> ${place.likeCount}</span>
                                </div>
                            </div>
                        </a>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
        
        <div class="cell">
        	<button type="button" style="display:none;" class="btn btn-neutral w-100 btn-more">더 보기</button>
        </div>
        
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
