<%@ page language="java" contentType="text/html; charset=UTF-8"
     pageEncoding="UTF-8"%>
 
 <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
 
 <form action="findPw" method="post" autocomplete="off">
 	<div class="container w-500">
 		<div class="cell center">
 			<h1>비밀번호 찾기</h1>
 			<p>비밀번호를 찾기 위한 정보를 입력하세요</p>
 		</div>
 		<div class="cell">
 			<label>아이디 <i class="fa-solid fa-asterisk red"></i></label>
 			<input type="text" name="memberId" class="field w-100">
 		</div>		
 		<div class="cell">
 			<label>이메일 <i class="fa-solid fa-asterisk red"></i></label>
 			<input type="email" inputmode="email" name="memberEmail" class="field w-100">
 		</div>
 		<div class="cell mt-20">
 			<button type="submit" class="btn btn-positive w-100">
 				<i class="fa-solid fa-paper-plane"></i>
 				<span>재설정 메일 보내기</span>
 			</button>
 		</div>
 	</div>
 </form>
 
 <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
 
 