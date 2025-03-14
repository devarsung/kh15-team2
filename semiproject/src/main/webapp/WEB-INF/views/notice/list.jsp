<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<link rel="stylesheet" type="text/css" href="/css/notice-list.css">

<div class="container w-800">
	<div class="cell center">
		<h1>공지사항</h1>
	</div>
	
	<div class="cell mt-50">
		<div class="notice-list">
			<c:choose>
				<c:when test="${list.isEmpty()}">
					등록된 게시글이 없습니다.
				</c:when>
				<c:otherwise>
					<c:forEach var="noticeListViewDto" items="${list}">
			           	<a href="/notice/detail?noticeNo=${noticeListViewDto.noticeNo}" class="notice-item">
		                   <span class="notice-icon"><i class="fa-solid fa-bullhorn"></i></span>
		                   <span class="notice-title">"${noticeListViewDto.noticeTitle}"</span>
		                   <span class="notice-date">${noticeListViewDto.wtimeString}</span>
		              	</a>
		          	</c:forEach>
				</c:otherwise>
			</c:choose>
         </div>
	
	</div>

	
	<div class="cell center">
		<jsp:include page="/WEB-INF/views/template/pagination.jsp"></jsp:include>
	</div>
	
	<!-- 검색창 -->
	<div class="cell center">
		<form action="list" method="get">
			<select name="column" class="field">
				<option value="notice_title" ${param.column == 'notice_title' ? 'selected' : ''}>제목</option>
				<option value="member_nickname" ${param.column == 'member_nickname' ? 'selected' : ''}>작성자</option>
			</select>
			<input type="text" name="keyword" value="${param.keyword}" class="field">
			<button class="btn btn-positive">검색</button>
		</form>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>