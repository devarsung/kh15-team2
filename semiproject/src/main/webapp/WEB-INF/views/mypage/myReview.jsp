<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<jsp:include page="/WEB-INF/views/template/mypage-tab.jsp">
	<jsp:param name="menu" value="myReview" />
</jsp:include>

<div class="container w-1000">
	<div class="cell center">
		<h1>내가 작성한 리뷰</h1>
	</div>

	<div class="cell">
		<table class="table table-border table-hover">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성일</th>
					<th>조회수</th>
					<th>좋아요</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${list.isEmpty()}">
						<tr>
							<td colspan="5" align="center">작성한 리뷰가 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="review" items="${list}">
							<tr>
								<td>${review.reviewNo}</td>
								<td>${review.reviewTitle}</td>
								<td><fmt:formatDate value="${review.reviewWtime}"
										pattern="yyyy-MM-dd" /></td>
								<td>${review.reviewRead}</td>
								<td>${review.reviewLike}</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>