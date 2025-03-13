<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script type = "text/javascript">
	 
</script>

<div class="container w-800" >
    <div class="cell center">
        <h1>마이페이지</h1>
    </div>
    
    <jsp:include page="/WEB-INF/views/template/mypage-tab.jsp">
    	<jsp:param name="menu" value="home"/>
    </jsp:include>
    
    <div class=" cell mt-50 center">
     <img name="memberProfile" src="profile?memberId=${memberDto.memberId}" style="border-radius: 50%; width: 300px; height: 300px;box-shadow:0 0 0 1.3px lightgrey;">
        </div>
        <div class="cell mt-30">
            <table class="table table-border table-hover">
                <tr>
                    <th>ID</th>
                <td class="p-10">
                    ${memberDto.memberId}
                </td>
                </tr>
                <tr>
                    <th>닉네임</th>
                <td class="p-10">
                    ${memberDto.memberNickname}
                </td>

                </tr>
                <tr>
                <th>성별</th>
                <td class="p-10">
                    ${memberDto.memberGender}
                </td>
                </tr>
                <tr>
                    <th>생년월일</th>
                <td class="p-10">
                   ${memberDto.memberBirth}
                </td>
                </tr>
                <tr>
                    <th>이메일</th>
                <td class="p-10">
                    ${memberDto.memberEmail}
                </td>
                </tr>
                <tr>
                    <th>연락처</th>
                <td class="p-10">
                    ${memberDto.memberContact}
                </td>
                </tr>
                <tr>
                    <th>주소</th>
                <td class="p-10">
                    ${memberDto.memberPost}<br>
                   ${memberDto.memberAddress1}  ${memberDto.memberAddress2}
                </td>
                </tr>
                <tr>
                    <th>회원가입일</th>
                   <td class="p-10">
			<fmt:formatDate value="${memberDto.memberJoin}" 
										pattern="y년 M월 d일"/>
		</td>
                </tr>
                </table>
    </div>

    <div class="cell float-box">
       <a href="change" class="btn btn-primary float-left me-10">개인정보 변경</a>
        <a href="password" class="btn btn-primary float-left">비밀번호 변경</a>
        <a href="exit" class="btn btn-danger float-right">회원탈퇴</a>

    </div>

</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>