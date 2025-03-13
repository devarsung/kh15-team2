<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<link rel="stylesheet" type="text/css" href="/css/notice-list.css">
<script src="/js/notice/list.js"></script>
<script type="text/javascript">
	$(function() {
		$(".form-delete").submit(function() {
			var checkItems = $(".check-item:checked");
			if (checkItems.length == 0) {
				window.alert("항목을 먼저 선택해야 합니다");
				return false;
			}
			return window.confirm("정말 삭제하시겠습니까?");
		});
	});
</script>

<style>
.a-control {
	text-decoration: none;
	color: black;
}
.text-decoration-line{
text-decoration-line:none;
}
.icon-all,
.icon{
cursor: pointer;
}

</style>

<div class="container w-1000">
	<div class="cell center">
		<h1>관리자 - 공지목록</h1>
	</div>



	<form class="form-delete" action="deleteAll" method="post">


		<div class="cell right">
			<a href="add" class="btn btn-neutral">글쓰기</a>
			<button type="submit" class="btn btn-negative">체크항목 삭제</button>
		</div>

		<!-- 테이블 -->
		<div class="cell mt-50">
			<div class="notice-list">
							<div  class="notice-all">
							<label >
							<i class="fa-regular fa-square icon-all"></i>
							</label>
						<input type="checkbox" class="check-all"><label>전체항목선택</label>
							</div>
				<c:choose>
					<c:when test="${list.isEmpty()}">
					등록된 게시글이 없습니다.
				</c:when>
					<c:otherwise>
						<c:forEach var="noticeListViewDto" items="${list}">
							<div class="notice-item"> 
					<!-- <i class="fa-regular fa-square-check icon"></i> -->				
					<label class="ww">
							<i class="fa-regular fa-square icon me-10"></i>
					</label>
	<a href="/admin/notice/detail?noticeNo=${noticeListViewDto.noticeNo}" class="text-decoration-line">
	<input type="checkbox" class="check-item" name="noticeNo" value="${noticeListViewDto.noticeNo}" >				
								<span class="notice-icon"><i class="fa-solid fa-bullhorn"></i></span> <span class="notice-title">"${noticeListViewDto.noticeTitle}"</span>
								<span class="notice-date">${noticeListViewDto.wtimeString}</span>
	</a>
							</div>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</form>





	<!-- 페이지 네비게이터 -->
	<div class="cell center">
		<jsp:include page="/WEB-INF/views/template/pagination.jsp"></jsp:include>
	</div>

	<!-- 검색창 -->
	<div class="cell center">
		<form action="list" method="get">
			<select name="column" class="field">
				<option value="notice_title"
					${param.column == 'notice_title' ? 'selected' : ''}>제목</option>
				<option value="member_nickname"
					${param.column == 'member_nickname' ? 'selected' : ''}>작성자</option>
			</select> <input type="text" name="keyword" value="${param.keyword}"
				class="field">
			<button class="btn btn-positive">검색</button>
		</form>
	</div>



</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>