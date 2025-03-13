<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
	
	<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
	
	<div class="container w-600">
		<div class="cell center">
			<h1>쿠키 다루기</h1>
		</div>
		
		<div class="cell">
		<h2>dummy 쿠키 값:${cookie.dummy.value}</h2>
		</div>
		<div class="cell">
		<form action="create">
			<div class="cell">
			<label>dummy하는 이름의 쿠키에 들어갈 값</label>
				<input type="text" name="dummy" class="field w-100">
		</div>
		<div class="cell">
		<button type="submit" class="btn btn-positive w-100">쿠키생성하기</button>
		</div>
		</form>
	</div>
</div>

    <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>   


