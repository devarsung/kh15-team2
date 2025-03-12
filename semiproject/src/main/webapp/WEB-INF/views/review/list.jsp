<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

 <link rel="stylesheet" type="text/css" href="/css/review-list.css">

<div class="container w-1000">
	<div class="cell center">
		<h1>후기 목록</h1>
	</div>
	
	<!-- 검색창 -->

    <div class="cell center my-30">
        <form action="list" method="get">
            <select name="column" class="selectStyle center field">
                <option value="" >선택 ▼</option>
                <option value="review_title" ${param.column == 'review_title' ? 'selected' : ''}>제목</option>
                <option value="member_nickname" ${param.column == 'member_nickname' ? 'selected' : ''}>작성자</option>
            </select>
            <input type="text" name="keyword" value="${param.keyword}" class="field w-50 inputStyle" placeholder="많은 후기들을 찾아보세요!">
            <button class="btn  btnStyle">검색<i class="fa-solid fa-magnifying-glass"></i></button>
        </form>
    </div>

	
	<!-- 테이블 -->
	<div class="cell">
		<table class="table table-border table-hover table-ellipsis tableStyle">
			<thead>
				<tr>
					<th class="w-10">No</th>
					<th style="width:450px; max-width:450px;">제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<c:choose>
				<c:when test="${list.isEmpty()}">
					<tbody>
						<tr height="150">
							<td colspan="6" align="center">
								등록된 게시글이 없습니다
							</td>
						</tr>
					</tbody>
				</c:when>
				<c:otherwise>
					<tbody align="center">
						<c:forEach var="reviewListViewDto" items="${list}">
						<tr>
							<td style="color:rgb(27, 27, 27);">${reviewListViewDto.reviewNo}</td>
							<td align="left">
								
							
								<!-- 게시글 제목 -->
								<a class="aStyle" href="detail?reviewNo=${reviewListViewDto.reviewNo}">
									[${reviewListViewDto.placeTitle}]  ${reviewListViewDto.reviewTitle}
								</a>
								
								<!-- 댓글 표시 -->
								<c:if test="${reviewListViewDto.reviewReply > 0}">
									<span class="ms-20">
										<i class="fa-solid fa-comment-dots" style="color:#F3D0D7;" ></i>
										${reviewListViewDto.reviewReply}
									</span>
								</c:if>
								
								<!-- 좋아요 표시 -->
								<c:if test="${reviewListViewDto.reviewLike > 0}">
									&nbsp;&nbsp;
									<i class="fa-solid fa-heart " style="color:#eea5b3;"></i>
									${reviewListViewDto.reviewLike}
								</c:if>
							</td>
							<td>
								<c:choose>
									<c:when test="${reviewListViewDto.memberNickname == null}">
										(탈퇴한 사용자)
									</c:when>
									<c:otherwise>
										${reviewListViewDto.memberNickname}
									</c:otherwise>
								</c:choose>
							</td>
							<td>${reviewListViewDto.getWtimeString()}</td>
							<td>${reviewListViewDto.reviewRead}</td>
						</tr>
						</c:forEach>
					</tbody>
				</c:otherwise>
			</c:choose>
		</table>
	</div>
	

	<!-- 페이지 네비게이터 -->
	<div class="cell center mt-30">
		<jsp:include page="/WEB-INF/views/template/pagination.jsp"></jsp:include>
	</div>
	
	
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>