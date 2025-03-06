<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 페이지 네비게이터 : pageVO에 기반하여 처리하도록 구현 -->

	<div class="page-navigator">
	
		<!-- 이전 -->
		<c:if test="${pageVO.hasPrevBlock()}">
			<a href="list?page=${pageVO.prevBlock}&${pageVO.parameters}">&lt;</a>
		</c:if>
		 
		<!-- 숫자 -->
		<c:forEach var="i" begin="${pageVO.startBlock}" end="${pageVO.finishBlock}" step="1">
			<c:choose>
				<c:when test="${pageVO.page == i}">
					<a class="on">${i}</a>
				</c:when>
				<c:otherwise>
					<a href="list?page=${i}&${pageVO.parameters}">${i}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<!-- 다음 -->
		<c:if test="${pageVO.hasNextBlock()}">
			<a href="list?page=${pageVO.nextBlock}&${pageVO.parameters}">&gt;</a>
		</c:if>
	</div>
