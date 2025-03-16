$(function() {
	//readonly로 만들어서 작성한 값만 수정돼서 전송됌
	//상태 변수
	var status = {
		memberNickname: true,
		memberEmail: true,
		memberBirth: true,
		memberContact: true,
		memberAddress: true,
		memberPw: false,
		memberEmailCert: true,
		ok: function() {
					return this.memberNickname
						&& this.memberEmail && this.memberBirth
						&& this.memberContact && this.memberAddress
						&& this.memberPw && this.memberEmailCert;
				},
			};

	//readonly 설정과 해제 
	//이메일 인증 숨김 설정및 나타네기 관리 설정 추가
	$(".editBtn").click(function() {
		var inputFiled = $(this).parent("td").find("input");
	//이메일 인증 버튼 변수
		var checkEmailBtn=$(this).closest("td").find(".checkEmailBtn");
		
		if (inputFiled.prop('readonly')){
			inputFiled.prop('readonly', false).focus();
			
			checkEmailBtn.show();//이메일 인증 버튼 보이기	
		}
		else {
			inputFiled.prop('readonly', true);
			
			checkEmailBtn.hide();//이메일 인증 버튼 숨기기	
		}
	});

	//닉네임 처리 //////////////////////////닉네임url추가
	$("[name=memberNickname]").blur(function() {
		var regex = /^[가-힣0-9]{2,10}$/;
		var isValid = regex.test($(this).val());
		if (isValid) {
			$.ajax({
				url: "/rest/member/checkMemberNickname",
				method: "post",
				data: { memberNickname: $(this).val() },
				success: function(response) {
				    if(response) {
				        $("[name=memberNickname]").removeClass("success fail fail2")
						.addClass("success");
										        status.memberNickname = true;
				    } else {
				        $("[name=memberNickname]").removeClass("success fail fail2")
						.addClass("fail2");
										        status.memberNickname = false;
				    }
				}
			});
		}

		else {
			$("[name=memberNickname]").removeClass("success fail fail2")
				.addClass("fail");
			status.memberNickname = false;
		}
	});

	//이메일 처리
	$("[name=memberEmail]").blur(function() {
		var regex = /^[A-Za-z0-9]+@[A-Za-z0-9.]+$/;
		var isValid = regex.test($(this).val()) && $(this).val().length > 0;
		$(this).removeClass("success fail").addClass(isValid ? "success" : "fail");
		status.memberEmail = isValid
	});

		$(".btn-send-cert").click(function(){
				var email = $("[name=memberEmail]").val();//입력된 이메일 가져옴
				var regex = /^[A-Za-z0-9]+@[A-Za-z0-9.]+$/;
				if (!regex.test(email)) {
				       status.memberEmail = false;
				       return;
				   }

				$.ajax({
					url:"/rest/cert/send",
					method:"post",
					data:{ email : email },
					success:function(response){
						$(".cert-input-wrapper").fadeIn();
						status.memberEmail = true;
						status.memberEmailCert = false; //인증시작시 false막아둠
					
					},
					beforeSend:function(){
						$(".btn-send-cert").prop("disabled", true);
						$(".btn-send-cert").find("span").text("이메일 발송중");
						$(".btn-send-cert").find("i").removeClass("fa-paper-plane")
																.addClass("fa-spinner fa-spin");
					},
					complete:function(){
						$(".btn-send-cert").prop("disabled", false);
						$(".btn-send-cert").find("span").text("인증메일 발송");
						$(".btn-send-cert").find("i").removeClass("fa-spinner fa-spin")
																.addClass("fa-paper-plane");
					}
				});
			});
			
			//인증확인버튼
			$(".btn-confirm-cert").click(function(){
				var certEmail = $("[name=memberEmail]").val();
				var certNumber = $("[name=certNumber]").val();
				var regex = /^[0-9]{8}$/;
				// 🔹 미입력 시 (공백 포함)
				if (certNumber.length === 0) {  
				    status.memberEmailCert = false;  
				    $("[name=certNumber]").removeClass("success fail").addClass("fail");
				    $(".cert-status").text("인증번호를 입력해주세요.").removeClass("success").addClass("fail").show();
				    return;
				}

				// 🔹 숫자 8자리가 아닐 경우
				if (!regex.test(certNumber)) {  
				    status.memberEmailCert = false;  
				    $("[name=certNumber]").removeClass("success fail").addClass("fail2");
				    $(".cert-status").text("인증번호는 8자리 숫자여야 합니다.").removeClass("success").addClass("fail").show();
				    return;
				}


				$.ajax({
					url:"/rest/cert/check",
					method:"post",
					data:{ certEmail : certEmail, certNumber : certNumber },
					success:function(response){//response는 true/false 중 하나
						status.memberEmailCert = response;//결과를 상태값에 적용
						$("[name=certNumber]").removeClass("success fail")
														.addClass(response ? "success" : "fail");
						if(response == true) {
							$(".cert-input-wrapper").hide();
							$(".btn-send-cert").prop("disabled", true)
													.removeClass("btn-neutral")
													.addClass("btn-positive");
							$(".btn-confirm-cert").prop("disabled", true);
							$(".btn-send-cert").find("span").text("인증 완료");
							$(".btn-send-cert").find("i").removeClass("fa-paper-plane")
																	.addClass("fa-thumbs-up");
						}
					}
				});
			});
	//생년월일 처리
	var picker = new Lightpick({
		field: document.querySelector("[name=memberBirth]"),
		format: "YYYY-MM-DD",
		firstDay: 7,
		maxDate: moment(),
	});
	$("[name=memberBirth]").blur(function() {
		var regex = /^(19[0-9]{2}|20[0-9]{2})-((02-(0[1-9]|1[0-9]|2[0-8]))|((0[469]|11)-(0[1-9]|1[0-9]|2[0-9]|30))|((0[13578]|1[02])-(0[1-9]|1[0-9]|2[0-9]|3[01])))$/;
		var isValid = $(this).val().length == 0 || regex.test($(this).val());
		$(this).removeClass("fail").addClass(isValid ? "" : "fail");
		status.memberBirth = isValid;
	});

	//전화번호 처리
	$("[name=memberContact]").on("input", function() {
		var current = $(this).val();
		var convert = current.replace(/[^0-9]+/g, "");
		$(this).val(convert);
	});
	$("[name=memberContact]").blur(function() {
		var regex = /^010[1-9][0-9]{7}$/ 
		var isValid = $(this).val().length == 0 || regex.test($(this).val());
		$(this).removeClass("fail").addClass(isValid ? "" : "fail");
		status.memberContact = isValid;
	});

	//주소 처리
	$("[name=memberPost]").on("input", function() {
		var current = $(this).val();
		var convert = current.replace(/[^0-9]+/g, "");
		$(this).val(convert);
	});
	$("[name=memberPost], [name=memberAddress1], .btn-address-search").click(function() {
		if (!$("[name=memberPost]").prop('readonly') && !$("[name=memberAddress1]").prop('readonly')) {
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
		}
	});
	$("[name=memberAddress2]").blur(function() {
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
	
	$(".btn-address-clear").click(function() {
		$("[name=memberPost]").val("");
		$("[name=memberAddress1]").val("");
		$("[name=memberAddress2]").val("");
		status.memberAddress = true;
	});

	$("[name=memberPw]").blur(function() {
		var isValid = $(this).val().length > 0;
		$(this).removeClass("success fail").addClass(isValid ? "success" : "fail")
		status.memberPw = isValid;
	});

	//폼검사
	$(".form-check").submit(function() {
		$("[name=memberPw]").trigger("blur");
		return status.ok();
	});

	// var beforeSrc = "/attachment/download?attachmentNo=123"; //테스트
	// $("#myPhoto").attr("src", beforeSrc);

	$("[name=memberProfile]").change(function() {
	    console.log("파일 선택됨: ", this.files[0]); // 파일 선택 확인용 로그 ///////////////테스트 완료 선택됨
	});
	///프로필수정
	//버튼클릭
	$("#previewBtn").click(function() {
		$("[name=memberProfile]").trigger("click");
	});
	var backupFile = null
	var beforeSrc = $("#myPhoto").data("before-src");   //테스트

	//파일 선택시 백업 
	$("[name=memberProfile]").change(function() {
		var file = this.files[0];
		// console.log("change");
		//정상 선택
		if (file) {
			var FileTypes = ['image/png', 'image/jpeg']; 
							  if (!FileTypes.includes(file.type)) { //배열 안에 특정 값이 포함되어 있는지 확인하는메서드
							        alert("허용되지 않는 파일 형식입니다.");
							        $(this).val(''); // 초기화
							        return;
							    }
			backupFile = file;
			var reader = new FileReader();
			reader.onload = function(e) {
				$("#myPhoto").attr("src", e.target.result);
				$("#deleteProfile").val("false"); //여기
			}
			reader.readAsDataURL(file);
			return;
			
		}
		//  취소를 눌렀을경우 백업파일있을경우
		if (backupFile) {
			var dataTransfer = new DataTransfer();
			dataTransfer.items.add(backupFile)
			$(".profileInput")[0].files = dataTransfer.files;
			$("#deleteProfile").val("false");
		}
		//backupfile이 있는경우 true 아닐시 false      //여기
		else {
			$("#deleteProfile").val("true");

		}

	});

	$("#deleteBtn").click(function() {
		var choice = window.confirm("프로필을 삭제하시겠습니까?");
		if(choice ==false) return;
		$("#myPhoto").attr("src", "/images/defaultProfile.png"); // 기본 이미지로 변경
		$(".profileInput").val("");
		backupFile = null
		
		//기존 프로필 있던사람 true 없던사람 false
		$("#deleteProfile").val(beforeSrc ? "true" : "false");  //여기
	});



});