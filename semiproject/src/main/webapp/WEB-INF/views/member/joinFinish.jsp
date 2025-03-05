<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    <div class="container w-600">
        <div class="cell center">
            <h1>회원가입이 완료되었습니다!</h1>
        </div>
        <br>
        <div class="container w-500" style="border:1px solid rgb(163, 163, 163);border-radius: 10px;">
            <div class="cell center">
                <p>홈페이지 둘러보기</p>
                <a href="/place/list" class="btn btn-neutral w-75 ">여행지 둘러보기  <i class="fa-solid fa-map-location"></i></a>  
                <a href="/review/list" class="btn btn-neutral w-75 mt-20">많은 후기 보러가기  <i class="fa-solid fa-feather"></i></a>
                <a href="/" class="btn btn-neutral w-75 my-20">메인으로 가기  <i class="fa-solid fa-house"></i></a>
             </div>
        </div>
    </div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>