<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- 
<c:forEach var="review" items="${reviews}">
	<p>${review.memberNickname }</p>
	<c:if test="${review.memberNickname==null}">
	<p>null</p>
	</c:if>
</c:forEach>
		
		
<br>
<c:forEach var="notice" items="${notices}">
	<p>${notice.noticeWriter }</p>
	<c:if test="${notice.memberNickname==null}">
	<p>null</p>
	</c:if>
</c:forEach> -->
<br>
<c:forEach var="place" items="${places}">
	<p>${place.placeNo}</p>
	<p>${place.placeTitle}</p>
	<p>${place.placeFirstImage}</p>
	<p>${place.placeOverview}</p>
	
</c:forEach>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>