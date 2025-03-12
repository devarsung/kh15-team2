<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<div class="container w-1000">
	<div class="cell center">
		<h1>홈페이지 데이터현황</h1>
	</div>
	
	<div class="cell mt-50">
		<h3>회원 성별 현황</h3>
	</div>
	<div class="cell status-container">
		<div class="status-item chart-area">
			<canvas id="gender-chart"></canvas>
		</div>
		<div class="status-item table-area">
			<table class="status-table gender-table">
				<thead>
					<tr>
						<th>placeRevfiew</th>
						<th>reviewReply</th>
					</tr>
				</thead>
				<tbody class="center">
					<c:forEach var="statusVO" items="${placeReviewList}">
						<tr>
							<td class="chart-key">${statusVO.key}</td>
							<td class="chart-value">${statusVO.value}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	
	
	<div class="cell mt-50">
		<h3>회원 연령대별 현황</h3>
	</div>
	<div class="cell status-container">
		<div class="status-item chart-area">
			<canvas id="age-chart"></canvas>
		</div>
		<div class="status-item table-area">
			<table class="status-table age-table">
				<thead>
					<tr>
						<th>연령대</th>
						<th>회원수</th>
					</tr>
				</thead>
				<tbody class="center">
					<c:forEach var="statusVO" items="${reviewReplyList}">
						<tr>
							<td class="chart-key">${statusVO.key}</td>
							<td class="chart-value">${statusVO.value}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>
	<div class="cell mt-50">
		<h3>여행지 좋아요 현황</h3>
	</div>
	<div class="cell status-container">
		<div class="status-item chart-area">
			<canvas id="age-chart"></canvas>
		</div>
		<div class="status-item table-area">
			<table class="status-table age-table">
				<thead>
					<tr>
						<th>연령대</th>
						<th>회원수</th>
					</tr>
				</thead>
				<tbody class="center">
					<c:forEach var="statusVO" items="${placeLikeList}">
						<tr>
							<td class="chart-key">${statusVO.key}</td>
							<td class="chart-value">${statusVO.value}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>
	<div class="cell mt-50">
		<h3>여행지 조회수 현황</h3>
	</div>
	<div class="cell status-container">
		<div class="status-item chart-area">
			<canvas id="age-chart"></canvas>
		</div>
		<div class="status-item table-area">
			<table class="status-table age-table">
				<thead>
					<tr>
						<th>연령대</th>
						<th>회원수</th>
					</tr>
				</thead>
				<tbody class="center">
					<c:forEach var="statusVO" items="${placeReadList}">
						<tr>
							<td class="chart-key">${statusVO.key}</td>
							<td class="chart-value">${statusVO.value}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>
	<div class="cell mt-50">
		<h3>후기 좋아요 현황</h3>
	</div>
	<div class="cell status-container">
		<div class="status-item chart-area">
			<canvas id="age-chart"></canvas>
		</div>
		<div class="status-item table-area">
			<table class="status-table age-table">
				<thead>
					<tr>
						<th>연령대</th>
						<th>회원수</th>
					</tr>
				</thead>
				<tbody class="center">
					<c:forEach var="statusVO" items="${reviewLikeList}">
						<tr>
							<td class="chart-key">${statusVO.key}</td>
							<td class="chart-value">${statusVO.value}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>
	<div class="cell mt-50">
		<h3>후기 조회수 현황</h3>
	</div>
	<div class="cell status-container">
		<div class="status-item chart-area">
			<canvas id="age-chart"></canvas>
		</div>
		<div class="status-item table-area">
			<table class="status-table age-table">
				<thead>
					<tr>
						<th>연령대</th>
						<th>회원수</th>
					</tr>
				</thead>
				<tbody class="center">
					<c:forEach var="statusVO" items="${reviewReadList}">
						<tr>
							<td class="chart-key">${statusVO.key}</td>
							<td class="chart-value">${statusVO.value}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>