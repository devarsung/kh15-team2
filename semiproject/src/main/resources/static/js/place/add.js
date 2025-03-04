/**
 * 여행지 등록: /admin/place/add 페이지의 자바스크립트
 */

$(function() {
	//상태변수
	var status = {
		placeTitle: false,
		firstImage: false,
		placeAddress: false,
		placeLatLng: false,//위도, 경도
		placeRegion: false,
		placeType: false,
		placeOverview: false,
		ok: function() {
			return this.placeTitle && this.firstImage && this.placeAddress
				&& this.placeLatLng && this.placeRegion && this.placeType && this.placeOverview;
		}
	};
	
	//overview 섬머노트
	$("[name=placeOverview]").summernote({
        height: 250,//높이(px)
        minHeight: 200,//최소 높이(px)
        maxHeight: 700,//최대 높이(px)
        toolbar: [
            ["font", ["style", "fontname", "fontsize", "forecolor", "backcolor"]],
            ["style", ["bold", "italic", "underline", "strikethrough"]],
            ["tool", ["ol", "ul", "table", "hr", "fullscreen"]],
            ["acion", ["undo", "redo"]]
        ],
        callback: {
            onlmageUpload: function (files) {
                return;
            },
        },
        disableDragAndDrop: true
		//overview에는 이미지 전혀 추가할 수 없게 처리(대표이미지, 상세이미지가 있기때문)
    });
	
	//주소 api
	$("[name=placePost], [name=placeAddress1], .btn-address-search").click(function() {
		new daum.Postcode({
			oncomplete: function(data) {
				var addr = ''; // 주소 변수
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					addr = data.jibunAddress;
				}

				document.querySelector("[name=placePost]").value = data.zonecode;
				document.querySelector("[name=placeAddress1]").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.querySelector("[name=placeAddress2]").focus();
				checkAddress();
				displayClearButton();
			}
		}).open();
	});
	
	//우편번호 숫자 외의 값 차단
	$("[name=placePost]").on("input", function(){
        var current = $(this).val();
        var convert = current.replace(/[^0-9]+/g, "");
        $(this).val(convert);
    });
	
	function checkAddress() {
		var post = $("[name=placePost]").val();
        var address1 = $("[name=placeAddress1]").val();
		var isValid = post.length > 0 && address1.length > 0;
		$("[name=placePost], [name=placeAddress1]")
		                .removeClass("fail").addClass(isValid ? "" : "fail");
		status.placeAddress = isValid;				
	}
	
    $("[name=placeAddress2]").on("input", function(){
        displayClearButton();
    });
	
    $(".btn-address-clear").click(function(){
		//주소를 모두 지우고 상태변수 false, x버튼 지우기
        $("[name=placePost]").val("");
        $("[name=placeAddress1]").val("");
        $("[name=placeAddress2]").val("");
		checkAddress();
        displayClearButton();
    });
	
    //주소 삭제 버튼을 표시/제거하는 함수
    function displayClearButton() {
        var post = $("[name=placePost]").val();
        var address1 = $("[name=placeAddress1]").val();
        var address2 = $("[name=placeAddress2]").val();
        var exist = post.length > 0 || address1.length > 0 || address2.length > 0;
        if(exist) {
            $(".btn-address-clear").fadeIn();
        }
        else {
            $(".btn-address-clear").fadeOut();
        }
    }
	
	//위도 경도 구하기 버튼
	$(".btn-search-xy").click(function(){
		var post = $("[name=placePost]").val();
        var address1 = $("[name=placeAddress1]").val();
		if(post.length==0 || address1.length==0) {
			checkAddress();
			return;
		}
		
		searchLatLng();
	});
	
	function drawMap(lat, lng) {
		var container = $('#map')[0];//jQuery
		$(container).show();
        var options = {
            center: new kakao.maps.LatLng(37.566395, 126.987778),
            level: 3
        };
		
		var map = new kakao.maps.Map(container, options);
		
		var location = new kakao.maps.LatLng(lat, lng);
        var marker = new kakao.maps.Marker({
            position: location, //위치 설정
        });
		marker.setMap(map);
        map.setCenter(location);
	}
	
	function searchLatLng() {
		var address = $("[name=placeAddress1]").val();
		var regex = /^(?=.*?[가-힣]+).+$/;
    	if(regex.test(address) == false) return;
		
		var geocoder = new kakao.maps.services.Geocoder();
		geocoder.addressSearch(address, function(data, result) {
	        if(result === kakao.maps.services.Status.OK) {//검색 성공
				var lat = Number(data[0].y).toFixed(6);//위도
				var lng = Number(data[0].x).toFixed(6);//경도
				$("[name=placeLat]").val(lat);
				$("[name=placeLng]").val(lng);
				status.placeLatLng = true;
				drawMap(lat, lng);
	    	}
    	});
	}
	
	//유효성 검사
	//제목
	$("[name=placeTitle]").blur(function(){
		var isValid = $(this).val().length > 0;
		$(this).removeClass("fail").addClass(isValid ? "" : "fail");
		status.placeTitle = isValid;
	});
	
	//지역
	$("[name=placeRegion]").on("input", function(){
		var isValid = $(this).val().length > 0;
		$(this).removeClass("fail").addClass(isValid ? "" : "fail");
		status.placeRegion = isValid;
	});
	
	//카테고리
	$("[name=placeType]").on("input", function(){
		var isValid = $(this).val().length > 0;
		$(this).removeClass("fail").addClass(isValid ? "" : "fail");
		status.placeType = isValid;
	});
	
	//설명 overview
	$("[name=placeOverview]").blur(function(){
		var isValid = $(this).val().length > 0;
		$(this).removeClass("fail").addClass(isValid ? "" : "fail");
		status.placeOverview = isValid;
	});
	
	//폼 전송
	$(".form-check").submit(function() {
		return status.ok();
	});
	
	//대표 이미지
	$(".btn-add-first").click(function(){
		$(".firstImage").click();
	});
	
	$(".btn-clean-first").click(function(){
		$(".firstImage").val("");//input값 초기화
		previousFile = null;
		$(".preview-firstImage").find("img").attr("src", "/images/defaultBack.png");
		$(".first-name").text("");
		status.firstImage = false;
	});
	
	var previousFile = null;
	
	$(".firstImage").change(function(){
		var file = this.files[0];
		
		if(file) {
			previousFile = file;
			var reader = new FileReader();
	        reader.onload = function(e) {
	            $(".preview-firstImage").find("img").attr("src", e.target.result);
				$(".first-name").text(file.name);
				status.firstImage = true;
	        };
	        reader.readAsDataURL(file);
			return;
		}
		
		//취소를 눌렀는데 이전에 선택한 파일이 있는 경우
		if(previousFile) {
			var dataTransfer = new DataTransfer();
			dataTransfer.items.add(previousFile);
			$(".firstImage")[0].files = dataTransfer.files;//input값 변경
			//.preiew-firstImage, .first-name, status.firstImage는 그대로 유지됨. 여기서 또 설정할 필요없음
		}
	});
	
	//상세 이미지
	var fileList = [];
	$(".detailImages").change(function(){
		var selectedFiles = this.files;
		for(var i=0; i<selectedFiles.length; i++) {
			fileList.push(selectedFiles[i]);
			showDetailPreview(selectedFiles[i]);
		}
		updateDetailInput();
	});
	
	$(document).on("click", ".btn-close", function(){
        var index = $(this).parent().index();
        fileList.splice(index, 1);

        if(fileList.length > 0) {
            updateDetailInput();
        }
        else {
            $(".detailImages")[0].files = new DataTransfer().files;
        }
        
        $(this).parent().remove();
    });
	
	function updateDetailInput() {
		var dataTransfer = new DataTransfer();
		for(var i=0; i<fileList.length; i++) {
			dataTransfer.items.add(fileList[i]);
		}
		$(".detailImages")[0].files = dataTransfer.files;
	}
	
	function showDetailPreview(file) {
		var reader = new FileReader();
		reader.onload = function(e){
			var template = $("#imgTag").text();
			var html = $.parseHTML(template);
			$(html).find("img").attr("src", e.target.result);
			$(".preview-detailImages").append(html);
		};
		reader.readAsDataURL(file);
	}
});