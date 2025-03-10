<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<link rel="stylesheet" type="text/css" href="/css/mypage-tab.css">

<div class="">
	<ul class="mypage-tab">
		<li class="${param.menu eq 'home' ? 'active' : ''}"><a href="/mypage/home">내정보</a></li>
		<li><a href="/mypage/myReview">나의 리뷰</a></li>
		<li><a href="/mypage/myReply">나의 댓글</a></li>
		<li class="${param.menu eq 'myLikePlace' ? 'active' : ''}">
			<a href="/mypage/myLikePlace"><i class="fa-heart red fa-regular"></i> 여행지</a>
		</li>
		<li class="${param.menu eq 'myLikeReview' ? 'active' : ''}">
			<a href="/mypage/myLikeReview"><i class="fa-heart red fa-regular"></i> 리뷰</a>
		</li>
	</ul>
</div>