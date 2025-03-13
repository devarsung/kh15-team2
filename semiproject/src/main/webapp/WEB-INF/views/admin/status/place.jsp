<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- Chart JS cdn -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script type="text/javascript">
$(function(){
	var type = {
		keys: [],
		values: []
	};
	
	var region = {
		keys: [],
		values: []
	};
	
	var review = {
			keys: [],
			values: []
		};
	
	findData(".place-type-table", type);
	findData(".place-region-table", region);
	findData(".place-review-table", review);
	
	
	createTypeChart();
	createRegionChart();
	createReviewChart();
	
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
	
	
	function createUserChart() {
		var canvas = document.querySelector("#place-type-chart");
		new Chart(canvas, {
            type: "bar",
            data: {
              labels: type.keys,
              datasets: [
                {
                  data: type.values,
                  label: "종류별",
                  backgroundColor:  [
                	  "#82ca9d",
                	  "#00a3af",
                	  "#6b8e23",
                	  "#7a4b7e",
                	  "#d1b2ff",
                	  ],
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
	
	
	
	function createRegionChart() {
		var canvas = document.querySelector("#place-region-chart");
		new Chart(canvas, {
            type: "doughnut",
            data: {
              labels: region.keys,
              datasets: [
                {
                  data: region.values,
                  label: "지역별",
                <!--  backgroundColor: "#82ca9d", -->
                  backgroundColor:  [
                	  "#82ca9d",
                	  "#4a6e63",
                	  "#f1f5f0 ",
                	  "#f2e9d8",
                	  "#ff6f61",
                	  "#f4d03f",
                	  "#00a3af",
                	  "#6b8e23",
                	  "#7a4b7e",
                	  "#d1b2ff",
                	  ],
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
		function createTypeChart() {
			var canvas = document.querySelector("#place-type-chart");
			new Chart(canvas, {
	            type: "doughnut",
	            data: {
	              labels: type.keys,
	              datasets: [
	                {
	                  data: type.values,
	                  label: "종류별",
	                <!--  backgroundColor: "#82ca9d", -->
	                  backgroundColor:  [
	                	  "#82ca9d",
	                	  "#4a6e63",
	                	  "#f1f5f0 ",
	                	  "#f2e9d8",
	                	  "#ff6f61",
	                	  "#f4d03f",
	                	  "#00a3af",
	                	  "#6b8e23",
	                	  "#7a4b7e",
	                	  "#d1b2ff",
	                	  ],
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
	function createReviewChart() {
		var canvas = document.querySelector("#place-review-chart");
		new Chart(canvas, {
            type: "bar",
            data: {
              labels: review.keys,
              datasets: [
                {
                  data: review.values,
                  label: "후기별",
                <!--  backgroundColor: "#82ca9d", -->
                  backgroundColor:  [
                	  "#82ca9d",
                	  "#4a6e63",
                	  "#f1f5f0 ",
                	  "#f2e9d8",
                	  "#ff6f61",
                	  "#f4d03f",
                	  "#00a3af",
                	  "#6b8e23",
                	  "#7a4b7e",
                	  "#d1b2ff",
                	  ],
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
		<h1>여행지 데이터현황</h1>
	</div>
	<div class="cell mt-50">
		<h3>여행지 종류 현황</h3>
	</div>
	<div class="cell status-container">
		<div class="status-item chart-area">
			<canvas id="place-type-chart"></canvas>
		</div>
		<div class="status-item table-area">
			<table class="status-table place-type-table">
				<thead>
					<tr>
						<th>여행지 종류</th>
						<th>갯수</th>
					</tr>
				</thead>
				<tbody class="center">
					<c:forEach var="statusVO" items="${placeTypeList}">
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
		<h3>여행지 지역 현황</h3>
	</div>
	<div class="cell status-container">
		<div class="status-item chart-area">
			<canvas id="place-region-chart"></canvas>
		</div>
		<div class="status-item table-area">
			<table class="status-table place-region-table">
				<thead>
					<tr>
						<th>여행지 지역</th>
						<th>갯수</th>
					</tr>
				</thead>
				<tbody class="center">
					<c:forEach var="statusVO" items="${placeRegionList}">
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
		<h3>여행지 후기 현황</h3>
	</div>
	<div class="cell status-container">
		<div class="status-item chart-area">
			<canvas id="place-review-chart"></canvas>
		</div>
		<div class="status-item table-area">
			<table class="status-table place-review-table">
				<thead>
					<tr>
						<th>여행지 후기</th>
						<th>갯수</th>
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
	
	</div>
	
		
	
	
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>