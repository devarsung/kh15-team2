<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

    <!-- google font -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

    <!-- font awesome cdn -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    
    <link rel="stylesheet" type="text/css" href="/css/commons.css">
    <!-- <link rel="stylesheet" type="text/css" href="./css/test.css"> -->
    <style>

    </style>

    <!-- jQuery cdn -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type = "text/javascript">
      
    </script>
</head>
<body>
   <div class="container w-800" >
        <div class="cell center">
            <h1>마이페이지</h1>
        </div>
        <div class=" cell mt-50 center">
            <img name=memberProfile src="/images/defaultProfile.png" style="border-radius: 50%; width: 300px; height: 300px;">
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
           <a href="change" class="btn btn-positive float-left me-10">개인정보 변경</a>
            <a href="#" class="btn btn-positive float-left">비밀번호 변경</a>
            <a href="exit" class="btn btn-negative float-right">회원탈퇴</a>

        </div>

    </div>
</body>
</html>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>