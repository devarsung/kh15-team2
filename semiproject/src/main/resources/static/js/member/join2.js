$(function(){
        //상태 변수
        var status = {
            memberId : false,
            memberPw : false,
            memberPwReinput : false,
            memberNickname : false,
            memberBirth : false,
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
		///프로필등록
            //버튼클릭
            $("#previewBtn").click(function () {
                $("[name=memberProfile]").trigger("click");
            });
            var backupFile = null
            //파일 선택시 백업
            $("[name=memberProfile]").change(function(){
                var reader = new FileReader(); 
                var file = this.files[0];
                
                //정상 선택
                if(file){
                 reader.onload = function(e) { 
                 $("#myPhoto").attr("src", e.target.result);
                }
                backupFile = file;
                reader.readAsDataURL(file); 
                return;
            }
              //  취소를 눌렀을경우 백업파일있을경우
                if(backupFile){
                   var inputFile = $("[name=memberProfile]")[0];
                   var dataTransfer = new DataTransfer();
                   dataTransfer.items.add(backupFile) 
                   inputFile.files = dataTransfer.files;
                   return;
                }
            }    
            );		
	    	///프로필 삭제
			$("#deleteBtn").click(function(){
	            $("#myPhoto").attr("src","https://placehold.co/150x150");
                var inputFile = $("[name=memberProfile]")[0];
                $(inputFile).val("");
                return;
			 });

        //아이디 처리 //ajax url추가/////////////////////
 		
 
        $("[name=memberId]").blur(function(){
            var regex = /^[a-z][a-z0-9]{4,19}$/; //정규식
            var isValid = regex.test($(this).val()); 
            if(isValid){   //아이디중복
                $.ajax({
                    url:"/rest/member/checkMemberId",
                    method :"post", 
                    data: {memberId :$(this).val()},
                    success: function(response){
                        $("[name=memberId]").removeClass("success fail fail2")
                                            .addClass(response ? "success" : "fail2");
                        status.memberId = response;
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
            var regex =  /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
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
                    url:"/rest/member/checkMemberNickname",
                    method:"post",
                    data: {memberNickname :$(this).val()},
                    success : function(response){
                        $("[name=memberNickname]").removeClass("success fail fail2")
                                                .addClass(response ? "success":"fail2");
                        status.memberNickname = response;
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
        $("[name=memberGender]").on("blur",function(){
            var isValid = $(this).val() != "";
			 refs/remotes/origin/main
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
            var isValid = $(this).val().length > 0 && regex.test($(this).val()) &&moment($(this).val()).isBefore(picker.maxDate);
			//오늘 태어난 사람도 되긴해..
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
            var regex = /^010[1-9][0-9]{7}$/
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

