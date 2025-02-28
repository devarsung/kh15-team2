<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-800">
    <div class="cell center">
        <h1>"testuser1" 정보 상세</h1>
    </div>
    <div class="cell mt-50 center">
        <img src="https://placehold.co/150x150" style="border-radius: 50%; width: 300px; height: 300px;">
    </div>
    <div class="cell">
        <table class="table table-border table-hover">
            <tr>
                <th>ID</th>
                <td>testuser1</td>
            </tr>
            <tr>
                <th>닉네임</th>
                <td>테스트유저1</td>
            </tr>
            <tr>
                <th>생년월일</th>
                <td>2000-10-10</td>
            </tr>
            <tr>
                <th>성별</th>
                <td>여</td>
            </tr>
            <tr>
                <th>연락처</th>
                <td>010-1234-5678</td>
            </tr>
            <tr>
                <th>이메일</th>
                <td>xx123@g.com</td>
            </tr>
            <tr>
                <th>주소</th>
                <td>서울시 영등포구 이레빌딩</td>
            </tr> 
            <tr>
                <th>등급</th>
                <td>일반회원</td>
            </tr> 
            <tr>
                <th>가입일</th>
                <td>2025-01-11</td>
            </tr> 
            <tr>
                <th>최종 로그인일</th>
                <td>2025-01-01</td>
            </tr> 
            <tr>
                <th>최종 비밀번호 변경일</th>
                <td>2025-01-01</td>
            </tr> 
        </table>  
    </div>

    <div class="cell right">
        <a href="edit?memberId=" class="btn btn-neutral">회원정보 수정</a>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>