<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<h1>비밀번호 확인</h1>
<p>회원 탈퇴를 위해 비밀번호를 입력해주세요</p>

<form action="exit" method="post">
	<input type="password" name="memberPw" required>
	<button>확인</button>
</form>

<c:if test="${param.error != null}">
	<h2 style="color:red">비밀번호가 일치하지 않습니다</h2>
</c:if>