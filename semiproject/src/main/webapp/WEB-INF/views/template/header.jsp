<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KH관광공사</title>

    <!-- google font -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

    <!-- font awesome cdn -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />

    <link rel="stylesheet" type="text/css" href="/css/commons.css">
    <!-- <link rel="stylesheet" type="text/css" href="/css/test.css"> -->
    
    <style>
       
    </style>
    
    <!-- moment -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.30.1/moment.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.30.1/locale/ko.min.js"></script>
    
    <!-- jQuery cdn -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    
    <script src="/js/checkbox.js"></script>
    <script src="/js/link-confirm.js"></script>
</head>
<body>
    
    <!-- 화면 영역 -->
    <div class="container w-1200">
        <!-- 헤더 영역 -->
        <div class="flex-box p-10">
            <div class="w-25 flex-box flex-center">
                 <a href="/">
                 	<img src="/images/kh.png" width="200">
                 </a>
            </div>
            <div class="w-50 center">
                <h1>KH관광공사</h1>
            </div>
            <div class="w-25 right">

            </div>
        </div>
        
        <!-- 신규 메뉴 영역 -->
        <div>
        	<ul class="menu">
        		<li><a href="/place/list">여행지</a></li>
        		
        		<li><a href="/review/list">후기</a></li>
        		
        		<li><a href="/notice/list">공지사항</a></li>
        		
        		<!-- 백엔드 개발 전 확인을 위해 임시로 빼둠(삭제예정) -->
       			<li><a href="/admin/home">관리자메뉴</a></li>
        		
        		<!-- 회원관련 메뉴는 우측에 -->
        		<!-- 비로그인 시 -->
        		<c:if test="${sessionScope.userId == null}">
        		<li class="menu-end">
        			<a href="/member/login">로그인</a>
        			<ul>
        				<li><a href="/member/join">회원가입</a></li>
        			</ul>
        		</li>
        		</c:if>
        		
        		<!-- 로그인 시 -->
        		<c:if test="${sessionScope.userId != null}">
        		<li class="menu-end">
        			<a href="/mypage/home">${sessionScope.userId}</a>
        			<ul>
	        			<c:if test="${sessionScope.userLevel == '관리자'}">
    	    			<li><a href="/admin/home">관리자메뉴</a></li>
        				</c:if>
        				<li><a href="/member/logout">로그아웃</a></li>
        			</ul>
        		</li>
        		</c:if>
        	</ul>
        </div>

        <!-- 컨텐츠 영역 -->
        <div class="flex-box">
            <div class="flex-fill p-10" style="min-height: 400px;">

	<%-- 
	<div>
		세션ID : ${pageContext.session.id},
		userId : ${sessionScope.userId},
		userLevel : ${sessionScope.userLevel}
	</div> 
	--%>