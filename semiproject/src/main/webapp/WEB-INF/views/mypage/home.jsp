<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
        .table{
            height: 5cm;
        }
        a {
        text-decoration: none;
        color: inherit; 
        }
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
            
            <img src="https://placehold.co/150x150" style="border-radius: 50%; width: 300px; height: 300px;">
            </div>
            <div class="cell mt-30">
            <table class="table table-hover">
                <tr>
                    <th>ID</th>
                    <td class="p-10">testuser1</td>
                </tr>
                <tr>
                    <th>닉네임</th>
                    <td class="p-10">테스트유저1</td>
                </tr>
                <tr>
                    <th>성별</th>
                    <td class="p-10">여자</td>
                </tr>
                <tr>
                    <th>생년월일</th>
                    <td class="p-10">2000-10-10</td>
                </tr>
                <tr>
                    <th>이메일</th>
                    <td class="p-10">xx123@g.com</td>
                </tr>
                <tr>
                    <th>연락처</th>
                    <td class="p-10">010-1234-5678</td>
                </tr>
                <tr>
                    <th>주소</th>
                    <td class="p-10">서울시 영등포구 이레빌딩</td>
                </tr> 
            </table>  
        </div>

        <div class="cell float-box">
            <button class="btn btn-positive float-left me-10"><a href="#">개인정보 변경</a></button>
            <button class="btn btn-positive float-left"><a href="#">비밀번호 변경</a></button>
            <button class="btn btn-negative float-right"><a href="#">회원탈퇴</a></button>

        </div>

    </div>


</body>
</html>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>