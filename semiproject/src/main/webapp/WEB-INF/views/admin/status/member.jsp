<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- Chart JS cdn -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<!--jQuery cdn-->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/js/chart.js"></script>

<div class="container w-800">
	<div class="cell center">
		<h1>홈페이지 데이터현황</h1>
	</div>
	<div class="cell flex-box">
		<div class="w-50">
			<div class="cell">회원 성별 현황</div>
			<div class="cell">
				<table class="table table-border table-stripe">
					<thead>
						<tr>
							<th>성별</th>
							<th>회원수</th>
						</tr>
					</thead>
					<tbody class="center">
						<c:forEach var="statusVO" items="${memberGenderList}">
							<tr>
								<td>${statusVO.key}</td>
								<td>${statusVO.value}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="cell flex-box">
		<div class="w-50">
			<div class="cell">회원 연령대별 현황</div>
			<div class="cell">
				<table class="table table-border table-stripe">
					<thead>
						<tr>
							<th>연령대</th>
							<th>회원수</th>
						</tr>
					</thead>
					<tbody class="center">
						<c:forEach var="statusVO" items="${memberAgeList}">
							<tr>
								<td>${statusVO.key}</td>
								<td>${statusVO.value}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>