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
</style>

<div class="container w-1000">
    <div class="cell center">
        <h1>내가 좋아요한 여행지</h1>
    </div>
    
    <div class="cell">
        <div class="card-list">
            <c:choose>
                <c:when test="${empty placeLikeList}">
                    <p style="text-align: center; width: 100%;">좋아요한 여행지가 없습니다.</p>
                </c:when>
                <c:otherwise>
                    <c:forEach var="place" items="${placeLikeList}">
                        <a href="/place/detail?placeNo=${place.placeNo}" class="card">
                            <div class="card-image">
                                <img src="/attachment/download?attachmentNo=${place.placeFirstImage}" alt="Card Image"
                                    onerror="this.onerror=null; this.src='/images/default-image.png';">
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
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
