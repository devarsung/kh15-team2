<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
 
 <script src=https://code.jquery.com/jquery-3.7.1.min.js></script>
    <script type = "text/javascript">
        $(function(){
            var status ={
                memberId : false,
                memberPw : false,
                ok : function(){
                    return this.memberId && this.memberPw;
                },
            };

            $("[name=memberId]").blur(function(){
                var isValid = $(this).val().length > 0
                $(this).removeClass("fail").addClass(isValid ? "" : "fail")
                status.memberId = isValid;
            });

            $("[name=memberPw]").blur(function(){
                var isValid = $(this).val().length > 0
                $(this).removeClass("fail").addClass(isValid ? "" : "fail")
                status.memberPw = isValid;
            });

            $(".form-check").submit(function(){
                $("[name]").trigger("blur");
                return status.ok();
            });
        });   
    </script>
 <div class="container w-500">
        <div class="cell center">
            <h1>로그인</h1>
        </div>
        <form class="form-check" action="login" method="post" autocomplete="off">
        <div class="cell mt-30">
            <label>아이디</label>
            <input class="field w-100" type="text" name="memberId" placeholder="ID입력"
            value="${cookie.saveId.value}">
            <div class="fail-feedback red">ID를 입력해주세요</div>
        </div>
        <div class="cell">
            <label>비밀번호</label>
            <input class="field w-100" type="password" name="memberPw" placeholder="PW입력">
            <div class="fail-feedback red">비밀번호를 입력해주세요</div>
        </div>
        
        <div class="cell">
         <label>
        <input type="checkbox"  name="remember" 
        ${cookie.saveId !=null ?'checked':''}>
        <span>아이디 저장</span>
        </label>
        </div>
        
        <div class="cell">
        <button class="btn btn-positive w-100 mt-20">로그인하기</button>
        </div>
    </form>
        <a href="findPw" style="">비밀번호를 잊으셨나요?</a>
    	<c:if test="${param.error != null}">
	<div class="cell center">
		<h3 class="red"><i class="fa-solid fa-triangle-exclamation"></i>로그인 정보가 일치하지 않습니다</h3>
	</div>
	</c:if>
    </div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
