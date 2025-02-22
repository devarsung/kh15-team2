<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>



<%-- <h1>로그인 페이지</h1>
<form action="login" method="post">
   *아이디<input type="text" name="memberId" required ><br><br>
   *비밀번호<input type="password" name="memberPw" required ><br><br>         
	
<button >로그인하기</button>
</form>
<c:if test="${param.error !=null}">
<h2 style="color:red">로그인 정보가 일치하지 않습니다</h2>
</c:if> --%>
<!-- if(error라는 파라미터가 있으면 -->


 
    <div class="container w-500">
        <div class="cell center">
            <h1>로그인 페이지</h1>
        </div>
        <div class=" cell center">
        <form class="form-check" action="login" method="post">
            <div class="cell">
                <input class="field  w-75 mt-20" type="text" name="memberId">
            </div>

            <div class="cell">
                <input class="field  w-75  mt-20" type="password" name="memberPw">
            </div>

            <button class="btn btn-positive w-50 mt-30 ">로그인하기</button>
        </form>
    </div>
</div>

