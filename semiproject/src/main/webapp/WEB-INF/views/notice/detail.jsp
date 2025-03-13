<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="/css/notice-detail.css">
<style>

</style>



<div class="container w-1200">
	<div class="cell center my-30">
		<h2 style="color: #1A1A1D">관리자 공지 사항</h2>
	</div>
	<hr>

	<input type="hidden" name="noticeNo" value="${noticeDto.noticeNo}">


	<div class="cell flex-box">
		<div class="cell flex-box flex-vertical flex-fill left-section">
			<h2 style="color: #1A1A1D">${noticeDto.noticeTitle}</h2>

		</div>
		<div class="cell flex-box flex-vertical right-section">
			<div>
				<i class="fa-solid fa-eye"></i> ${noticeDto.noticeRead}
			</div>
			<div>작성일(${noticeDto.getWtimeString()}) |
				수정일(${noticeDto.getEtimeString()})</div>
		</div>
	</div>

	<div class="cell p-20 content-box">${noticeDto.noticeContent}</div>
	<div class="cell right">
		<c:if test="${sessionScope.userId != null}">
			<a href="/notice/list" class="changebtn mt-20">목록</a>
		</c:if>
	</div>
	<div></div>




</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

