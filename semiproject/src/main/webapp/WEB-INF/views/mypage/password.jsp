<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
     <script src="/js/mypage/password.js"></script>
    <div class="container w-500">
        <div class="cell center">
            <h1>비밀번호 변경</h1>
        </div>
        <form class="form-check" action="login" method="post" autocomplete="off">
        <div class="cell mt-30">
            <label>기존 비밀번호</label>
            <input class="field w-100" type="password" name="currentPw">
            <div class="fail-feedback red"><i class="fa-solid fa-check"></i>기존 비밀번호를 입력해주세요</div>
        </div>
        <div class="cell">
            <label>신규 비밀번호</label>
            <input class="field w-100" type="password" name="newPw" >
            <div class="success-feedback blue"><i class="fa-regular fa-circle"></i>비밀번호가 올바른 형식입니다</div>
            <div class="fail-feedback red"><i class="fa-solid fa-check"></i>알파벳 대문자, 소문자, 숫자, 특수문자를 반드시 한 글자 이상 포함해서 8~16자로 작성하세요</div>
        </div>
        <div class="cell">
            <label>비밀번호 확인</label>
            <input class="field w-100" type="password" name="reinputPw">
            <div class="success-feedback blue"><i class="fa-regular fa-circle"></i>비밀번호가 일치합니다</div>
            <div class="fail-feedback red"><i class="fa-solid fa-check"></i>비밀번호가 일치하지 않습니다</div>
            <div class="fail2-feedback red"><i class="fa-solid fa-check"></i>비밀번호가 형식에 맞지 않습니다</div>
        </div>
        <button type="submit" class="btn btn-positive w-100 mt-20">비밀번호 변경</button>
    </form>
    </div>
    <c:if test="${param.error == '1'}">
	<h2 style="color:red">비밀번호가 일치하지 않습니다</h2>
	</c:if>
	<c:if test="${param.error == '2'}">
	<h2 style="color:red">같은 비밀번호로는 변경할 수 없습니다</h2>
</c:if>
</body>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>