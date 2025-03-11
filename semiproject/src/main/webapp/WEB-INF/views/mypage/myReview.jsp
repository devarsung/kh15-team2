<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-1000">
    <div class="cell center">
        <h1>내가 작성한 후기</h1>
    </div>

    <jsp:include page="/WEB-INF/views/template/mypage-tab.jsp">
	  	<jsp:param name="menu" value="myReview"/>
	</jsp:include>

    <div class="cell mt-50">
        <table class="table table-border table-hover">
            <thead>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>조회수</th>
                    <th>좋아요</th>
                    <th>댓글 수</th>
                    <th>작성일</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty myReviewList}">
                        <tr>
                            <td colspan="7" align="center">작성한 후기가 없습니다.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="review" items="${myReviewList}" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td><a href="/review/detail?reviewNo=${review.reviewNo}">${review.reviewTitle}</a></td>
                                <td>${review.reviewWriter}</td>
                                <td>${review.reviewRead}</td>
                                <td>${review.reviewLike}</td>
                                <td>${review.reviewReply}</td>
                                <td><fmt:formatDate value="${review.reviewWtime}" pattern="yyyy-MM-dd"/></td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
