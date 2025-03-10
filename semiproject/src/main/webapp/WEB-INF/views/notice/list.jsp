<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
.a-control{
  text-decoration: none;
  color: black;
		}
</style>
<div class="container w-1000">
	<div class="cell center">
		<h1>공지사항</h1>
	</div>
	
	<div class="cell">
		<table class="table table-border table-hover table-ellipsis">
			<thead>
				<tr>
					<th>번호</th>
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
						<c:forEach var="noticeListViewDto" items="${list}">
						<tr>
							<td>${noticeListViewDto.noticeNo}</td>
							<td align="left">
								<!-- 게시글 제목 -->
								<a class="a-control" href="detail?noticeNo=${noticeListViewDto.noticeNo}">
									${noticeListViewDto.noticeTitle}
								</a>
								
							</td>
							<td>
								<c:choose>
									<c:when test="${noticeListViewDto.memberNickname == null}">
										(탈퇴한 사용자)
									</c:when>
									<c:otherwise>
										${noticeListViewDto.memberNickname}
									</c:otherwise>
								</c:choose>
							</td>
							<td>${noticeListViewDto.getWtimeString()}</td>
							<td>${noticeListViewDto.noticeRead}</td>
						</tr>
						</c:forEach>
					</tbody>
				</c:otherwise>
			</c:choose>
		</table>
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