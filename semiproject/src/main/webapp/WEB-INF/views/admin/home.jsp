<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.square-container {
    display: grid;
    grid-template-columns: repeat(3, 200px);
    grid-gap: 1px;
}
.square-btn {/* 
    display: flex;
    justify-content: center;
    align-items: center; */
    text-align: center;
    line-height: 200px;
    width: 200px;
    height: 200px;
    color: white;
    text-decoration: none;
    font-size: 20px;
    font-weight: bold;
    transition: background 0.3s;
    /* box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);  없는게 나은듯*/
}
.square-btn:hover {
    /* 1=원래색, 0.5= 많이 진해짐,  0=검은색 , 0.9, 0.8정도가 적당한듯*/
    filter: brightness(0.9);
}
.square-btn.first-pink {
	background-color: #f1d1d2;
}
.square-btn.second-pink {
	background-color: #faf1f2;
	color: #636e72;/* 텍스트 글자는 회색으로 */
}
</style>

<div class="container w-800">
    <div class="cell center">
		<h1><i class="fa-solid fa-user-tie"></i> 관리자 홈</h1>
	</div>
    
    <div class="cell flex-box flex-center my-40">
		<div class="square-container">
	        <a href="/admin/notice/list" class="square-btn first-pink"><i class="fa-solid fa-bullhorn"></i> 공지관리</a>
	        <a href="/admin/place/list" class="square-btn second-pink"><i class="fa-solid fa-mountain-sun"></i> 여행지관리</a>
	        <a href="/admin/member/list" class="square-btn first-pink"><i class="fa-solid fa-users"></i> 회원관리</a>
	        <a href="/admin/status/member" class="square-btn second-pink"><i class="fa-solid fa-chart-simple"></i> 현황1</a>
	        <a href="/admin/status/review" class="square-btn first-pink"><i class="fa-solid fa-chart-line"></i> 현황2</a>
	        <a href="/admin/status/place" class="square-btn second-pink"><i class="fa-solid fa-chart-pie"></i> 현황3</a>
    	</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>