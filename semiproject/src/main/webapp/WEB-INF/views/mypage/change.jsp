<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

    <!-- google font -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

    <!-- font awesome cdn -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    
    <link rel="stylesheet" type="text/css" href="./css/commons.css">
    <!-- <link rel="stylesheet" type="text/css" href="./css/test.css"> -->
    <style>
        table {
        height: 300px;
        table-layout: fixed;
        width: 100%;
        overflow: hidden;
        }

        table td:nth-child(1) { /* 1열 ^_^ */
            width: 20%;
        }

        table td:nth-child(2) {
            width: 80%;
        }

        .editBtn{
            border : 1px solid rgb(230, 230, 230);
            background-color: white;
        }

        .editBtn:hover{
            box-shadow: 0 0 2px black;
            cursor: pointer;
        }
        #previewBtn{
            border: 1px solid rgb(163, 163, 163);
            background-color: white;
        }
        #previewBtn:hover{
            box-shadow: 0 0 2px black;
            cursor: pointer;
        }

        .editInput[readonly] {
        background-color: #ffffff; 
        color: #363636; 
        cursor: default; 
        border: 1px solid #ffffff;
        transition: background-color 0.3s ease, border 0.3s ease; 
        }


    </style>

<!-- Lightpick 라이브러리 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/css/lightpick.min.css">
<script src="https://cdn.jsdelivr.net/npm/moment@2.30.1/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/lightpick.min.js"></script>
 <!-- kakao post api -->
 <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <!-- jQuery cdn -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type = "text/javascript">

        $(function(){
            //readonly로 만들어서 작성한 값만 수정돼서 전송됌
            //상태 변수
            var status = {
                memberProfile : true,
                memberNickname : true,
                memberEmail : true,
                memberBirth : true,
                memberContact : true,
                memberAddress : true,
                ok : function(){
                    return  this.memberProfile && this.memberNickname
                            && this.memberEmail && this.memberBirth
                            && this.memberContact && this.memberAddress;
                },
            };

            //readonly 설정과 해제 
            $(".editBtn").click(function(){
                var inputField = $(this).parent("td").find("input");
                if (inputField.prop('readonly')) {
                    inputField.prop('readonly', false);
                } 
                else {
                    inputField.prop('readonly', true);
                }
            });

            //프로필변경 버튼 클릭시 파일선택창
            $("#previewBtn").click(function () {
                $("[name=memberProfile]").trigger("click");
            });

            $("[name=memberProfile]").change(function(){
                var reader = new FileReader(); //파일을 읽읅수 있게 해주는 객체 !!중요!!

                 reader.onload = function(e) {  //이게 reader로 다 읽은후에 실행하는 콜백함수다
                $("#myPhoto").attr("src", e.target.result);
            };
            //1. e - 파일을 다 읽은 후 전달하는 객체
            //2. e.target은 fileReader의 객체
            //3. e.target.result는 파일을 다 읽은 후 결과.
            //즉 filereader을 통해 콜백함수 지정해놓고 파일을 다 읽은후 프로필에 프리뷰가능.
                reader.readAsDataURL(this.files[0]);  //순서가 헷갈려^_^ 비동기라 파일 다읽은후 콜백함수 부름
            });


              //닉네임 처리 //////////////////////////닉네임url추가
                $("[name=memberNickname]").blur(function(){
                    var regex = /^[가-힣0-9]{2,10}$/;
                    var isValid = regex.test($(this).val());
                    if(isValid){
                        $.ajax({
                            url:"",
                            method:"post",
                            data: {memberNickname :$(this).val()},
                            success : function(response){
                                $("[name=memberNickname]").removeClass("success fail fail2")
                                                        .addClass(response ? "fail2":"success");
                                status.memberNickname = response ? false : true;
                            }
                        });
                    }

                    else{
                        $("[name=memberNickname]").removeClass("success fail fail2")
                                                .addClass("fail");
                                status.memberNickname = false;
                    }
                });

                //이메일 처리
                $("[name=memberEmail]").blur(function(){
                    var regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                    var isValid = regex.test($(this).val()) && $(this).val().length > 0;
                    $(this).removeClass("success fail").addClass(isValid ? "success" : "fail");
                    status.memberEmail = isValid ;
                });

                //생년월일 처리
                var picker = new Lightpick({
                    field : document.querySelector("[name=memberBirth]"),
                    format : "YYYY-MM-DD",
                    firstDay: 7,
                    maxDate : moment(),
                });
                $("[name=memberBirth]").blur(function(){
                    var regex = /^(19[0-9]{2}|20[0-9]{2})-((02-(0[1-9]|1[0-9]|2[0-8]))|((0[469]|11)-(0[1-9]|1[0-9]|2[0-9]|30))|((0[13578]|1[02])-(0[1-9]|1[0-9]|2[0-9]|3[01])))$/;
                    var isValid = $(this).val().length == 0 || regex.test($(this).val());
                    $(this).removeClass("fail").addClass(isValid ? "" : "fail");
                    status.memberBirth = isValid;
                    });

                 //전화번호 처리
                $("[name=memberContact]").on("input",function(){
                    var current = $(this).val();
                    var convert = current.replace(/[^0-9]+/g, "");
                    $(this).val(convert);
                });
                $("[name=memberContact]").blur(function(){
                    var regex = /^010[0-9]{8}$/
                    var isValid = $(this).val().length ==0 || regex.test($(this).val());
                    $(this).removeClass("fail").addClass(isValid ? "" : "fail");
                    status.memberContact = isValid;
                });

                //주소 처리
        $("[name=memberPost]").on("input", function(){
                var current = $(this).val();
                var convert = current.replace(/[^0-9]+/g, "");
                $(this).val(convert);
            });
            $("[name=memberPost], [name=memberAddress1], .btn-address-search").click(function(){
                new daum.Postcode({
                    oncomplete: function(data) {
                        // daum api
                        var addr = ''; 
                        var extraAddr = ''; 
                        if (data.userSelectedType === 'R') { 
                            addr = data.roadAddress;
                        } else {
                            addr = data.jibunAddress;
                        }

                        document.querySelector("[name=memberPost]").value = data.zonecode;
                        document.querySelector("[name=memberAddress1]").value = addr;
                        document.querySelector("[name=memberAddress2]").focus();
                    }
                }).open();
            });
            $("[name=memberAddress2]").blur(function(){
                var memberPost = $("[name=memberPost]").val();
                var memberAddress1 = $("[name=memberAddress1]").val();
                var memberAddress2 = $("[name=memberAddress2]").val();

                var isEmpty = memberPost.length == 0 && memberAddress1.length == 0 && memberAddress2.length == 0;
                var isFill = memberPost.length > 0 && memberAddress1.length > 0 && memberAddress2.length > 0;
                var isValid = isEmpty || isFill;
                $("[name=memberPost], [name=memberAddress1], [name=memberAddress2]")
                        .removeClass("fail").addClass(isValid ? "" : "fail");
                status.memberAddress = isValid;
            });
            $("[name=memberAddress2]").on("input", function(){
                displayClearButton();
            });
            $(".btn-address-clear").click(function(){
                $("[name=memberPost]").val("");
                $("[name=memberAddress1]").val("");
                $("[name=memberAddress2]").val("");
                status.memberAddress = true;
                displayClearButton();
            });

        //폼검사
            $(".form-check").submit(function(){
                console.log(status.ok())
                return status.ok();
            });


                
            

   
        });
      
    </script>
</head>
<body>
    <div class="container w-800" >
        <div class="cell center">
            <h1>프로필 변경</h1>
        </div>
        <form class="form-check" action="change" method="post" enctype="multipart/form-data" autocomplete="off">
        <div class="cell center">
            <input  type="file" name="memberProfile" class="field w-100" accept=".png, .jpg" style="display: none;">
        </div>
        <div class=" cell mt-50 center">
            <img id="myPhoto" src="https://placehold.co/150x150" style="border-radius: 50%; width: 300px; height: 300px;">
        </div>
        <div class="cell center">
             <button type="button" id="previewBtn" >프로필 사진 변경</button>
        </div>
            <div class="cell mt-20">
                <table class="table table-hover">
                    <tr>
                        <th>ID</th>
                    <td class="p-10">
                        <input name="memberId" type="text" class="field w-50" value="${memberDto.memberId}" readonly>
                    </td>
                    </tr>
                    <tr>
                        <th>닉네임</th>
                    <td class="p-10">
                        <input name="memberNickname" type="text" class="editInput field  w-50" value="${memberDto.memberNickname}" readonly>
                    <button type="button" class="editBtn"><i class="fa-solid fa-pen-to-square"></i></button>
                        <div class="success-feedback blue">사용 가능한 닉네임 입니다</div>
                        <div class="fail-feedback red"><i class="fa-solid fa-check"></i>닉네임은 한글 또는 숫자 2~10자로 작성하세요</div>
                        <div class="fail2-feedback red"><i class="fa-solid fa-check"></i>닉네임이 이미 사용중입니다</div>
                    </td>

                    </tr>
                    <tr>
                    <th>성별</th>
                    <td class="p-10">
                        <input name="memberGender" type="text" class="field  w-50" value="${memberDto.memberGender}" readonly>
                    </td>
                    </tr>
                    <tr>
                        <th>생년월일</th>
                    <td class="p-10">
                        <input name="memberBirth"type="text" class="editInput field  w-50" value="${memberDto.memberBirth}" readonly>
                        <button type="button" class="editBtn"><i class="fa-solid fa-pen-to-square"></i></button>
                        <div class="fail-feedback red"><i class="fa-solid fa-check"></i>정확한 생년월일을 입력해주세요(ex)2000-02-20</div>
                    </td>
                    </tr>
                    <tr>
                        <th>이메일</th>
                    <td class="p-10">
                        <input name="memberEmail"type="email" class="editInput field  w-50" value="${memberDto.memberEmail}" readonly>
                        <button type="button" class="editBtn"><i class="fa-solid fa-pen-to-square"></i></button>
                        <div class="success-feedback">올바른 이메일 형식입니다</div>
                        <div class="fail-feedback red"><i class="fa-solid fa-check"></i>올바른 형식의 이메일이 아닙니다</div>
                    </td>
                    </tr>
                    <tr>
                        <th>연락처</th>
                    <td class="p-10">
                        <input name="memberContact"type="text" class="editInput field  w-50" value="${memberDto.memberContact}" readonly>
                        <button type="button" class="editBtn "><i class="fa-solid fa-pen-to-square"></i></button>
                        <div class="fail-feedback red"><i class="fa-solid fa-check"></i>010으로 시작하는 휴대전화번호를 작성하세요</div>
                    </td>
                    </tr>
                    <tr>
                        <th>주소</th>
                    <td class="p-10">
                        <input name="memberPost"type="text" class="editInput field  w-50" placeholder="우편번호"  value="${memberDto.memberPost}" readonly>
                        <button type="button" class="editBtn"><i class="fa-solid fa-pen-to-square"></i></button>
                        <br>
                        <input name="memberAddress1" class="editInput field " placeholder="기본주소" value="${memberDto.memberAddress1}"readonly>
                        <input name="memberAddress2" class="editInput field " placeholder="상세주소" value="${memberDto.memberAddress2}" readonly>
                        <div class="fail-feedback"><i class="fa-solid fa-check"></i>주소는 모두 작성해야 합니다</div>
                    </td>
                    </tr>
                    </table>
                    </div>
                    <div class="cell right my-30">
                        <a href="#"><button class="btn btn-neutral" type="button">이전으로</button></a>
                        <button class="btn btn-positive ms-10" type="submit">변경하기</button>
                    </div>
                    
                    </form>

    </div>


</body>
</html>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
