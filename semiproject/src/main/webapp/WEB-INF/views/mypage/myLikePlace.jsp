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
.aStyle{
   	text-decoration: none;
   	outline: none; 
   	padding:10px;
   	color : black;
   	font-weight : bold;
}
</style>

<script type="text/javascript">
$(function(){
	
	var currentPage = 1;
	var size = 4;//테스트 위해 임시로 줄여둠
	
	//목록 불러오기
	function loadList() {
		$.ajax({
			url: "/rest/page/myLikePlace",
			method: "post",
			data: {page: currentPage, size: size},
			success: function(response) {
				if(response.length === 0) {
					if(currentPage === 1) {
						//좋아요 목록이 아예 없는 경우
						$(".no-list").show();
						$(".card-list").hide();
						$(".btn-more").hide();
						return;
					}
					else {
						//마지막 페이지면 더보기 버튼 안보이게 처리하니
						//애초에 여기는 실행 되지 않음
						//더 이상의 없는 경우
						$(".btn-more").hide();
						return;
					}
				}
				$(".btn-more").css("display", response.isLastPage ? "none" : "block");
				$(".no-list").hide();
				$(".card-list").show();
				$(".card-count").show().text(response.totalCount + "개");
				
				currentPage++;
				
				$(response.list).each(function(){
					var template = $("#place-template").text();
					var html = $.parseHTML(template);
					
					var url = "/place/detail?placeNo=" + this.placeNo;
					
					$(html).filter(".place-link").attr("href", url);
					$(html).find(".first-image").attr("src", "/attachment/download?attachmentNo=" + this.placeFirstImage);
					$(html).find(".first-image").attr("alt", this.placeTitle + " 대표이미지");
					$(html).find(".title-area").text(this.placeTitle);
					$(html).find(".heart-btn").attr("data-no", this.placeNo);
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
	
	$(".btn-more").click(function(event){
		event.preventDefault();
		loadList();
	});
	
	//하트버튼
	$(document).on("click", ".heart-btn", function(){
		var me = $(this);
		var placeNo = $(this).data("no");
		
		$.ajax({
			url: "/rest/page/action",
			method: "post",
			data: {placeNo : placeNo},
			success: function(response) {
				$(me).find("i").removeClass("fa-solid fa-regular")
					.addClass(response.done ? "fa-solid" : "fa-regular");
				$(".card-count").text(response.myCount + "개");
			}
		});
		
		/* console.log("하트클릭"); */
		/* e.stopPropagation(); */
		return false;
	});
	
	loadList();
});
</script>

<script type="text/template" id="place-template">
<a class="place-link card" href="#">
	<div class="card-image">
        <img class="first-image" src="" alt="Card Image"
             onerror="this.onerror=null; this.src='/images/default-image.png';">
        <button type="button" class="heart-btn">
			<i class="fa-solid fa-heart red"></i>
		</button>
	</div>
	<div class="card-content">
		<div class="card-title">
			<h3 class="title-area"></h3>
			<h3 class="icon-area">
            	
            </h3>
        </div>
        <div class="card-subtitle"></div>
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
   		<div class="cell no-list" style="display:none;">
   			<i class="fa-solid fa-fish"></i>
       		<span>목록이 없습니다</span>
       	</div>
       	
       	<h3 class="right me-10 my-0 card-count" style="display:none;"></h3>
        <div class="card-list" style="display:none;">
			         
        </div>
        <div class="cell center mt-50">
        	<a href="#" class="aStyle btn-more">더보기+</a>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
