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
	createGenderChart();
	createAgeChart();
	
	function findData(table, object) {
		//모듈화를 위해 구하긴 했는데 차트 설정 옵션 많으면 value만 있어도 될 듯
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
		var canvas = document.querySelector("#gender-chart");
		new Chart(canvas, {
            type: "pie",
            data: {
              labels: gender.keys,
              datasets: [
                {
                  data: gender.values,
                  label: "회원수",
                  backgroundColor: ["#FD6384","#18A0F6"],
                  borderWidth: 1///테두리 두께(디자인 속성)
                },
              ]
            },
            options: {
              scales: {
                y: {
                  beginAtZero: true
                }
              }
            }
        });
	}
	
	function createAgeChart() {
		var canvas = document.querySelector("#age-chart");
		new Chart(canvas, {
            type: "bar",
            data: {
              labels: age.keys,
              datasets: [
                {
                  data: age.values,
                  label: "회원수",
                  backgroundColor: "#82ca9d",
                  borderWidth: 1//테두리 두께(디자인 속성)
                },
              ]
            },
            options: {
              scales: {
                y: {
                  beginAtZero: true
                }
              }
            }
        });
	}
});
</script>

<div class="container w-800">
	<div class="cell center">
		<h1>홈페이지 데이터현황</h1>
	</div>
	<div class="cell flex-box">
		<div class="">
			<canvas id="gender-chart"></canvas>
		</div>
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
		<div class="">
			<canvas id="age-chart"></canvas>
		</div>
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