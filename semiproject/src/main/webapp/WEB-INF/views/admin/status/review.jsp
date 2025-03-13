<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- Chart JS cdn -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script type="text/javascript">
$(function(){
	var user = {
		keys: [],
		values: []
	};
	
	var reply = {
		keys: [],
		values: []
	};
	
	findData(".review-user-table", user);
	findData(".review-reply-table", reply);
	
	
	createReplyChart();
	createUserChart();
	
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
		var canvas = document.querySelector("#review-user-chart");
		new Chart(canvas, {
            type: "bar",
            data: {
              labels: user.keys,
              datasets: [
                {
                  data: user.values,
                  label: "유저수",
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
	
	
	
	function createReplyChart() {
		var canvas = document.querySelector("#review-reply-chart");
		new Chart(canvas, {
            type: "doughnut",
            data: {
              labels: reply.keys,
              datasets: [
                {
                  data: reply.values,
                  label: "댓글수",
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
		<h1>후기 데이터현황</h1>
	</div>
	<div class="cell mt-50">
	<!-- 후기 작성 유저 많은수 -->
		<h3>후기 작성 유저</h3>
	</div>
	<div class="cell status-container">
		<div class="status-item chart-area">
			<canvas id="review-user-chart"></canvas>
		</div>
		<div class="status-item table-area">
			<table class="status-table review-user-table">
				<thead>
					<tr>
						<th>유저</th>
						<th>리뷰수</th>
					</tr>
				</thead>
				<tbody class="center">
					<c:forEach var="statusVO" items="${reviewUserList}">
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
	<!-- 댓글많은수 -->
		<h3>후기 댓글 현황</h3>
	</div>
	<div class="cell status-container">
		<div class="status-item chart-area">
			<canvas id="review-reply-chart"></canvas>
		</div>
		<div class="status-item table-area">
			<table class="status-table review-reply-table">
				<thead>
					<tr>
						<th>후기 제목</th>
						<th>댓글수</th>
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
	
		
	
	
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>