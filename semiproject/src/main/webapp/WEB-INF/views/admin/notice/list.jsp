<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script type="text/javascript">
	$(function(){
		$(".form-delete").submit(function(){
			var checkItems = $(".check-item:checked");
			if(checkItems.length == 0) {
				window.alert("항목을 먼저 선택해야 합니다");
				return false;
			}
			return window.confirm("정말 삭제하시겠습니까?");
		});
	});
</script>
<style>
.a-control{
  text-decoration: none;
  color: black;
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
	
	
	<div class="cell">
		<table class="table table-border table-hover table-ellipsis">
			<thead>
				<tr>
				<th>
				<input type="checkbox" class="check-all">
                	</th>
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
							<td>
                				<input type="checkbox" class="check-item" name="noticeNo" value="${noticeListViewDto.noticeNo}">
                			</td>
							<td>${noticeListViewDto.noticeNo}</td>
							<td align="left">
								
							
								<!-- 게시글 제목 -->
								<a class="a-control" href="detail?noticeNo=${noticeListViewDto.noticeNo}">
									${noticeListViewDto.noticeTitle}
								</a>
								
								<%-- <!-- 댓글 표시 -->
								<c:if test="${noticeListViewDto.noticeReply > 0}">
									<span class="ms-20">
										<i class="fa-solid fa-comment-dots blue"></i>
										${noticeListViewDto.noticeReply}
									</span>
								</c:if> --%>
								
								<!-- 좋아요 표시 -->
								<%-- <c:if test="${noticeListViewDto.noticeLike > 0}">
									&nbsp;&nbsp;
									<i class="fa-solid fa-heart red"></i>
									${noticeListViewDto.noticeLike}
								</c:if> --%>
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
	
	</form>

	
	

	
	<!-- 페이지 네비게이터 -->
	<div class="cell center">
		<jsp:include page="/WEB-INF/views/template/pagination.jsp"></jsp:include>
	</div>
	
	<!-- 검색창 -->
	<div class="cell center">
		<form action="list" method="get">
			<select name="column" class="field">
				<option value="notice_title" ${param.column == 'notice_title' ? 'selected' : ''}>제목</option>
				<option value="notice_writer" ${param.column == 'notice_writer' ? 'selected' : ''}>작성자</option>
			</select>
			<input type="text" name="keyword" value="${param.keyword}" class="field">
			<button class="btn btn-positive">검색</button>
		</form>
	</div>
	
	

</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>