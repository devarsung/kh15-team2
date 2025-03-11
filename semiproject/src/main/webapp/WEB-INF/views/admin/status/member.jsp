<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- Chart JS cdn -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script type="text/javascript">
$(function(){
	var gender = {
		keys: [],
		values: []
	};
	
	var age = {
		keys: [],
		values: []
	};
	
	findData(".gender-table", gender);
	findData(".age-table", age);
	
	function findData(table, object) {
		var keyElements = $(table).find(".chart-key");
		$(keyElements).each(function(){
			var key = $(this).text();
			object.keys.push(key);	
		});
		
		var valueElements = $(table).find(".chart-value");
		$(valueElements).each(function(){
			var value = $(this).text();
			object.values.push(value);
		});
	}
	
	function createGenderChart() {
		
	}
	
	function createAgeChart() {
		
	}
	
});
</script>

<div class="container w-800">
	<div class="cell center">
		<h1>홈페이지 데이터현황</h1>
	</div>
	<div class="cell flex-box">
		<div class="w-50">
			<div class="cell">회원 성별 현황</div>
			<div class="cell">
				<table class="table table-border table-stripe gender-table">
					<thead>
						<tr>
							<th>성별</th>
							<th>회원수</th>
						</tr>
					</thead>
					<tbody class="center">
						<c:forEach var="statusVO" items="${memberGenderList}">
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
	<div class="cell flex-box">
		<div class="w-50">
			<div class="cell">회원 연령대별 현황</div>
			<div class="cell">
				<table class="table table-border table-stripe age-table">
					<thead>
						<tr>
							<th>연령대</th>
							<th>회원수</th>
						</tr>
					</thead>
					<tbody class="center">
						<c:forEach var="statusVO" items="${memberAgeList}">
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
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>