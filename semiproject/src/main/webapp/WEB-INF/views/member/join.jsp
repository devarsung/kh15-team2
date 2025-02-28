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
        //상태 변수
        var status = {
            memberId : false,
            memberPw : false,
            memberPwReinput : false,
            memberNickname : false,
            memberBirth : true,
            memberGender : false,
            memberContact: true,
            memberEmail : false,
            memberAddress : true,
            ok : function(){
                return this.memberId && this.memberPw && this.memberPwReinput
                        && this.memberNickname && this.memberBirth
                        && this.memberGender && this.memberContact
                        && this.memberEmail && this.memberAddress;
            },
        };

        //아이디 처리 //ajax url추가/////////////////////
 
 
        $("[name=memberId]").blur(function(){
            var regex = /^[a-z][a-z0-9]{4,19}$/; //정규식
            var isValid = regex.test($(this).val()); 
            if(isValid){   //아이디중복
                $.ajax({
                    url:"/",
                    method :"post", 
                    data: {memberId :$(this).val()},
                    success: function(response){
                        $("[name=memberId]").removeClass("success fail fail2")
                                            .addClass(response ? "fail2" : "success");
                        status.memberId = response ? false : true;
                    }
                    });
                }
            else{
                $("[name=memberId]").removeClass("success fail fail2")
                                    .addClass("fail");
                        status.memberId = false;

            }
        });

        //비밀번호 처리
        $("[name=memberPw]").blur(function(){
            var regex = /^[A-Za-z0-9!@#$]{8,16}$/; 
            var isValid = regex.test($(this).val());
            $(this).removeClass("success fail fail2").addClass(isValid ? "success" : "fail")
            status.memberPw = isValid;
        });
        //비밀번호 확인
        $("#pw-reinput").blur(function(){
            var memberPw = $("[name=memberPw]").val();
            var memberPwReinput = $(this).val();
            $(this).removeClass("success fail fail2");
            if(status.memberPw == false){
                $(this).addClass("fail2");
                status.memberPwReinput = false;
            }
            else if(memberPw != memberPwReinput){
                $(this).addClass("fail");
                status.memberPwReinput = false;
            }
            else{
                $(this).addClass("success")
                    status.memberPwReinput = true;
            }
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

        
        //성별 처리
        $("[name=memberGender]").on("input",function(){
            var isValid = $(this).val().length > 0;
            $(this).removeClass("success fail")
            .addClass(isValid? "success" : "fail");
            status.memberGender = isValid;
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
                        // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                        // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                        // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                        var addr = ''; // 주소 변수
                        var extraAddr = ''; // 참고항목 변수

                        //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                        if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                            addr = data.roadAddress;
                        } else { // 사용자가 지번 주소를 선택했을 경우(J)
                            addr = data.jibunAddress;
                        }

                        // 우편번호와 주소 정보를 해당 필드에 넣는다.
                        document.querySelector("[name=memberPost]").value = data.zonecode;
                        document.querySelector("[name=memberAddress1]").value = addr;
                        // 커서를 상세주소 필드로 이동한다.
                        document.querySelector("[name=memberAddress2]").focus();

                        // 값 설정 이후 주소 삭제 버튼을 표시
                        displayClearButton();
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

            function displayClearButton() {
                var post = $("[name=memberPost]").val();
                var address1 = $("[name=memberAddress1]").val();
                var address2 = $("[name=memberAddress2]").val();

                var exist = post.length > 0 || address1.length > 0 || address2.length > 0;
                if(exist) {
                    $(".btn-address-clear").fadeIn();
                }
                else {
                    $(".btn-address-clear").fadeOut();
                }
            }
        //폼검사
            $(".form-check").submit(function(){
                $("[name],#pw-reinput").trigger("blur");
                return status.ok();
            });

    });





    </script>
</head>
<body>
        
    <form class="form-check" action="" method="post" autocomplete="off">
        <div class="container w-500">
            <div class="cell center">
                <h1>가입 정보 입력</h1>
            </div>
            <div class="cell">
                <label>아이디 <i class="fa-solid fa-asterisk red"></i></label>
                <input type="text" name="memberId" class="field w-100">
                <div class="success-feedback blue"><i class="fa-regular fa-circle"></i>사용 가능한 아이디입니다.</div>
                <div class="fail-feedback red"><i class="fa-solid fa-check"></i>아이디는 알파벳으로 시작한 숫자포함 5~20자리로 만들어 주세요.</div>
                <div class="fail2-feedback red">아이디가 이미 사용중입니다</div>
            </div>
            <div class="cell">
                <label>비밀번호 <i class="fa-solid fa-asterisk red"></i></label>
                <input type="password" name="memberPw" class="field w-100">
                <div class="success-feedback blue"><i class="fa-regular fa-circle"></i>비밀번호가 올바른 형식입니다</div>
                <div class="fail-feedback red"><i class="fa-solid fa-check"></i>알파벳 대문자, 소문자, 숫자, 특수문자를 반드시 한 글자 이상 포함해서 8~16자로 작성하세요</div>
            </div>
            <div class="cell">
                <label>비밀번호 확인 <i class="fa-solid fa-asterisk red"></i></label>
                <input type="password" id="pw-reinput" class="field w-100">
                <div class="success-feedback blue"><i class="fa-regular fa-circle"></i>비밀번호가 일치합니다</div>
                <div class="fail-feedback red"><i class="fa-solid fa-check"></i>비밀번호가 일치하지 않습니다</div>
                <div class="fail2-feedback red"><i class="fa-solid fa-check"></i>비밀번호가 형식에 맞지 않습니다</div>
            </div>
            <div class="cell">
                <label>닉네임 <i class="fa-solid fa-asterisk red"></i></label>
                <input type="text" name="memberNickname" class="field w-100">
                <div class="success-feedback blue"><i class="fa-regular fa-circle"></i>사용 가능한 닉네임 입니다.</div>
                <div class="fail-feedback red"><i class="fa-solid fa-check"></i>닉네임은 한글 또는 숫자 2~10자로 작성하세요</div>
                <div class="fail2-feedback red"><i class="fa-solid fa-check"></i>닉네임이 이미 사용중입니다</div>
            </div>
            <div class="cell">
                <lavel>성별  <i class="fa-solid fa-asterisk red"></i></lavel>
                <select class="field w-100" name="memberGender">
                    <option value="">선택하세요</option>
                    <option>남자</option>
                    <option>여자</option>
                </select>
                <div class="success-feedback blue"></div>
                <div class="fail-feedback red"><i class="fa-solid fa-check"></i>성별을 선택해주세요</div>
            </div>
            <div class="cell">
                <label>e-mail <i class="fa-solid fa-asterisk red"></i></label>
                <input type="email" inputmode="email" name="memberEmail" class="field w-100">
                <div class="success-feedback"><i class="fa-regular fa-circle"></i>올바른 이메일 형식입니다</div>
                <div class="fail-feedback red"><i class="fa-solid fa-check"></i>올바른 형식의 이메일이 아닙니다</div>
            </div>
            <div class="cell">
                <label>생년월일</label>
                <input type="text" name="memberBirth" class="field w-100">
                <div class="fail-feedback red"><i class="fa-solid fa-check"></i>정확한 생년월일을 입력해주세요(ex)2000-02-20</div>
            </div>
            <div class="cell">
                <label>전화번호</label>
                <input type="tel" name="memberContact" class="field w-100">
                <div class="fail-feedback red"><i class="fa-solid fa-check"></i>010으로 시작하는 휴대전화번호를 작성하세요</div>
            </div>
            <div class="cell">
                <label>주소</label>
            </div>
            <div class="cell">
                <input type="text" name="memberPost" size="6" maxlength="6" class="field" placeholder="우편번호" readonly>
                <button type="button" class="btn btn-neutral btn-address-search">
                    <i class="fa-solid fa-magnifying-glass"></i>
                </button>
                <button type="button" class="btn btn-negative btn-address-clear"
                                                                            style="display: none;">
                        <i class="fa-solid fa-trash"></i>
                    </button>
                </div>
                <div class="cell">
                    <input type="text" name="memberAddress1" class="field w-100" placeholder="기본주소" readonly>
                </div>
                <div class="cell">
                    <input type="text" name="memberAddress2" class="field w-100" placeholder="상세주소">
                    <div class="fail-feedback"><i class="fa-solid fa-check"></i>주소는 모두 작성해야 합니다</div>
                </div>
        
                <div class="cell mt-30">
                    <button type="submit" class="btn btn-positive w-100">회원가입</button>
                </div>
            </div>
        </form>
    
    
        </form>
    
</body>
</html>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>