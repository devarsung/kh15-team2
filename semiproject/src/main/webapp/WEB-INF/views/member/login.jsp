<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>



 <form action="login" method="post">
<div class="container w-400">
	<div class="cell center">
		<h1>로그인</h1>
	</div>
	<div class="cell">
		<label>아이디</label>
		 <input type="text" name="memberId" required class="field w-100">
	</div>
	<div class="cell">
		<label>비밀번호</label>
		<input type="password" name="memberPw" required class="field w-100">
	</div>
	<div class="cell mt-20">
		<button type="submit" class="btn btn-positive w-100">로그인하기</button>
	</div>

	
	<c:if test="${param.error != null}">
	<div class="cell center">
		<h2 class="red">로그인 정보가 일치하지 않습니다</h2>
	</div>
	</c:if>
</div>

</form>
   
