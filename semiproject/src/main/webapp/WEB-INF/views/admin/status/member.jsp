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

<style>
.status-container {
	display: flex;
	gap: 20px;
}
.status-item {
	flex: 1;
	background: white;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	display: flex;
    justify-content: center;
    align-items: center;
}
.status-table {
	width: 90%;
	border-collapse: collapse;
}
.status-table th,
.status-table td {
	border: 1px solid #dddddd;
	padding: 10px;
	text-align: center;
}
.status-table th {
    background-color: #f8f9fd;
    font-weight: bold;
}
</style>

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
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>