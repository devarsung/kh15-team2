<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-800">
    <div class="cell center">
        <h1>관리자 홈</h1>
    </div>
    
    <div class="cell">
    	<a href="/admin/member/list">회원관리</a>
    	<a href="/admin/place/list">여행지관리</a>
    	<a href="/admin/notice/list">공지관리</a>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>