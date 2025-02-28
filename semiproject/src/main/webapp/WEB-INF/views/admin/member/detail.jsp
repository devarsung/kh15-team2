<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-800">
    <div class="cell center">
        <h1>"${memberDto.memberId}" 정보 상세</h1>
    </div>
    <div class="cell mt-50 center">
        <img src="https://placehold.co/150x150" style="border-radius: 50%; width: 300px; height: 300px;">
    </div>
    <div class="cell">
        <table class="table table-border table-hover">
            <tr>
                <th>ID</th>
                <td>${memberDto.memberId}</td>
            </tr>
            <tr>
                <th>닉네임</th>
                <td>${memberDto.memberNickname}</td>
            </tr>
            <tr>
                <th>생년월일</th>
                <td>${memberDto.memberBirth}</td>
            </tr>
            <tr>
                <th>성별</th>
                <td>${memberDto.memberGender}</td>
            </tr>
            <tr>
                <th>연락처</th>
                <td>${memberDto.memberContact}</td>
            </tr>
            <tr>
                <th>이메일</th>
                <td>${memberDto.memberEmail}</td>
            </tr>
            <tr>
                <th>주소</th>
                <td>
                	[${memberDto.memberPost}]<br>
                	${memberDto.memberAddress1}<br>
                	${memberDto.memberAddress2}<br>
               	</td>
            </tr> 
            <tr>
                <th>등급</th>
                <td>${memberDto.memberLevel}</td>
            </tr> 
            <tr>
                <th>가입일</th>
                <td>${memberDto.memberJoin}</td>
            </tr> 
            <tr>
                <th>최종 로그인일</th>
                <td>${memberDto.memberLogin}</td>
            </tr> 
            <tr>
                <th>최종 비밀번호 변경일</th>
                <td>${memberDto.memberChange}</td>
            </tr>
        </table>  
    </div>

    <div class="cell right">
        <a href="edit?memberId=${memberDto.memberId}" class="btn btn-neutral">회원정보 수정</a>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>