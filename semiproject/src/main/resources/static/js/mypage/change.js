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
		ok: function() {
					return this.memberNickname
						&& this.memberEmail && this.memberBirth
						&& this.memberContact && this.memberAddress
						&& this.memberPw;
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

		

	//readonly 설정과 해제 
	$(".editBtn").click(function() {
		var inputField = $(this).parent("td").find("input");
		if (inputField.prop('readonly')) {
			inputField.prop('readonly', false);
		}
		else {
			inputField.prop('readonly', true);
		}
	});

	//닉네임 처리 //////////////////////////닉네임url추가
	$("[name=memberNickname]").blur(function() {
		var regex = /^[가-힣0-9]{2,10}$/;
		var isValid = regex.test($(this).val());
		if (isValid) {
			$.ajax({
				url: "",
				method: "post",
				data: { memberNickname: $(this).val() },
				success: function(response) {
					$("[name=memberNickname]").removeClass("success fail fail2")
						.addClass(response ? "fail2" : "success");
					status.memberNickname = response ? false : true;
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
		var regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
		var isValid = regex.test($(this).val()) && $(this).val().length > 0;
		$(this).removeClass("success fail").addClass(isValid ? "success" : "fail");
		status.memberEmail = isValid;
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
		var regex = /^010[0-9]{8}$/
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
	$("[name=memberAddress2]").on("input", function() {
		displayClearButton();
	});
	$(".btn-address-clear").click(function() {
		$("[name=memberPost]").val("");
		$("[name=memberAddress1]").val("");
		$("[name=memberAddress2]").val("");
		status.memberAddress = true;
		displayClearButton();
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
			backupFile = file;
			var reader = new FileReader();
			reader.onload = function(e) {
				$("#myPhoto").attr("src", e.target.result);
				$("#profileUpload").val("true");
			}
			reader.readAsDataURL(file);
			return;
		}
		//  취소를 눌렀을경우 백업파일있을경우
		if (backupFile) {
			var dataTransfer = new DataTransfer();
			dataTransfer.items.add(backupFile)
			$(".profileInput")[0].files = dataTransfer.files;
			$("#profileUpload").val("true");
		}
		//backupfile이 있는경우 true 아닐시 false
		else {
			$("#profileUpload").val("false");

		}

	});

	$("#deleteBtn").click(function() {
			var choice = window.confirm("정말 프로필을 삭제하시겠습니까?");
			if(choice ==false) return;
			$("#deleteProfile").val("true"); // 프로필 삭제 여부 설정
			$("#myPhoto").attr("src", "/images/defaultProfile.png"); // 기본 이미지로 변경
		
		
	});



});