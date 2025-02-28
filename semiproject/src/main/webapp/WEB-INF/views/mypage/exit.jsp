<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
 

    <!--google font-->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

    <!--font awesome cdn-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
        integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />

    <link rel="stylesheet" type="text/css" href="./css/commons.css">
    <!-- <link rel="stylesheet" type="text/css" href="./css/test.css"> -->

    <!-- jQuery cdn-->
    <script src=https://code.jquery.com/jquery-3.7.1.min.js></script>
    <script type="text/javascript">
        $(function(){
            //상태변수
            var status = {
                memberExitCheck : false,
                memberPw : false,
                memberPwReinput : false,
                ok : function(){
                    return this.memberExitCheck && memberPw && memberPwReinput;
                },
            };

            //체크박스처리
            $("[name=memberExitCheck]").change(function(){
                var isValid = $(this).prop("checked");
                $(this).removeClass("fail").addClass(isValid ? "" : "fail")
                status.memberExitCheck = isValid
            });
            //비밀번호 유무처리
            $("[name=memberPw]").blur(function(){
                var isValid = $(this).val().length > 0;
                $(this).removeClass("fail").addClass(isValid ? "": "fail")
                status.memberPw = isValid
            });
            //비밀번호 확인
            $("[name=memberPwReinput]").blur(function(){
                var memberPw = $("[name=memberPw]").val();
                var isValid = $(this).val() == memberPw;
                $(this).removeClass("fail").addClass(isValid ? "" : "fail")
                status.memberPwReinput
            });

            //폼검사
            $(".form-check").submit(function(){
                $("[name]").trigger("blur","checked");
                return status.ok();
            })
        });
    </script>
</head>

<body>
    <div class="container w-500">
        <div class="cell center">
            <h1>회원 탈퇴</h1>
        </div>
        <div class="cell">

            <textarea class="field w-100 target"
                rows="7">주의: 회원 탈퇴를 진행하면, 해당 계정과 관련된 모든 정보는 시스템에서 완전히 삭제됩니다. 삭제된 데이터는 복구할 수 없으며, 회원 탈퇴 후에는 사용자의 모든 개인정보, 구매 내역, 작성한 후기, 게시글 등 모든 정보가 영구적으로 사라집니다. 따라서 중요한 정보나 기록은 미리 백업해 주시기 바랍니다. 탈퇴한 계정에 대한 서비스 이용은 불가능하며, 탈퇴 후 재가입을 하더라도 기존의 데이터는 복원되지 않음을 양해 부탁드립니다. 탈퇴 진행 후에는 해당 계정에 연동된 서비스나 혜택에 대한 접근이 제한될 수 있습니다. 회원 탈퇴를 신중하게 결정하시고, 탈퇴 후 발생할 수 있는 불편사항에 대해 충분히 숙지한 후 진행해 주세요. 만약 탈퇴에 대해 추가적인 문의사항이나 도움이 필요하시면, 언제든지 고객센터로 연락해 주시기 바랍니다. 이 모든 내용을 충분히 숙지하였음을 확인한 후 탈퇴를 진행해 주세요.</textarea>

            <form class="form-check" action="exit" method="post">
                <div class="cell">
                    <input type="checkbox" class="check-item" name = "memberExitCheck"><span class="red">[필수]</span>동의
                    <div class="fail-feedback red"><i class="fa-solid fa-exclamation"></i>필수 동의사항입니다</div>
                </div>

                <div class="cell my-20">
                    <label><span class="red">[필수]</span>비밀번호</label>
                    <input class="field w-100" type="password" name="memberPw">
                    <div class="fail-feedback red"><i class="fa-solid fa-exclamation"></i>필수 입력사항입니다</div>
                </div>

                <div class="cell my-20 mt-10">
                    <label><span class="red">[필수]</span>비밀번번호 재확인</label>
                    <input class="field w-100" type="password" name="memberPwReinput">
                    <div class="fail-feedback"><i class="fa-solid fa-exclamation"></i>비밀번호가 일치하지 않습니다</div>
                </div>

                <div class="cell mt-30">
                    <label>탈퇴사유</label>
                    <textarea class="field w-100 target" rows="7" maxlength="500px" cols="20" placeholder="의견을 남겨주시면 감사하겠습니다"></textarea>
                </div>
                <div class="cell right my-20">
                    <button class="btn btn-neutral w-25 mt-20 mx-10">돌아가기</button>
                    <button class="btn btn-negative w-25 mt-20">회원 탈퇴</button>
                </div>
            </form>
        </div>
        <c:if test="${param.error !=null}">
	    <h3 class = "red"><i class="fa-solid fa-exclamation"></i>비밀번호가 틀렸습니다</h3>
        </c:if>
    </div>
</body>

</html>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>