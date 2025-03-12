<%@ page language="java" contentType="text/html; charset=UTF-8"
     pageEncoding="UTF-8"%>
 
 <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
 
 <form action="reset" method="post">
 	<input type="hidden" name="memberId" value="${memberId}">
 	<input type="hidden" name="certEmail" value="${certEmail}">
 	<input type="hidden" name="certNumber" value="${certNumber}">
 	
 	<div class="container w-500">
 		<div class="cell center">
 			<h1>비밀번호 재설정</h1>
 		</div>
 		<div class="cell">
 			<label>비밀번호 <i class="fa-solid fa-asterisk red"></i></label>
 			<input type="password" name="memberPw" class="field w-100">
 		</div>
 		<div class="cell">
 			<label>비밀번호 확인 <i class="fa-solid fa-asterisk red"></i></label>
 			<input type="password" class="field w-100 pw-reinput">
 		</div>
 		<div class="cell mt-20">
 			<button type="submit" class="btn btn-positive w-100">
 				<i class="fa-solid fa-floppy-disk"></i>
 				<span>비밀번호 변경</span>
 			</button>
 		</div>
 	</div>
 
 </form>
 
 <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>