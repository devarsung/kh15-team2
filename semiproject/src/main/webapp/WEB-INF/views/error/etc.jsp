<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container">
	<div class="cell center">
		<h1>일시적인 오류가 발생 했습니다</h1>
		<p>
			확인 후 다시 한 번 실행해주세요<br>
			${message}
		</p>	
	</div>
</div>

 <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>