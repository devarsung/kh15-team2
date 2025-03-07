/**
 * 여행지 등록
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
		placeTel: true,
		placeWebsite: true,
		placeOperate: true,
		placeParking: true,
		ok: function() {
			return this.placeTitle && this.firstImage && this.placeAddress
				&& this.placeLatLng && this.placeRegion && this.placeType && this.placeOverview
				&& this.placeTel && this.placeWebsite && this.placeOperate && this.placeParking;
		}
	};
	
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
				//새주소 선택 -> 주소유효성검사 + 좌표초기화
				checkAddressValid();
				initLatLng();
				deleteMap();
				//값이 입력되었으니 x버튼 표시
				$(".btn-address-clear").fadeIn();
			}
		}).open();
	});
	
	//주소가 변경되면 좌표정보 초기화
	//주소가 변경되는 경우
	//[1] 새 주소 선택
	//[2] x 버튼으로 지웠을 때
	
	//우편번호 숫자 외의 값 차단
	$("[name=placePost]").on("input", function(){
        var current = $(this).val();
        var convert = current.replace(/[^0-9]+/g, "");
        $(this).val(convert);
    });
	
	//주소 유효성 검사
	function checkAddressValid() {
		var post = $("[name=placePost]").val();
        var address1 = $("[name=placeAddress1]").val();
		var isValid = post.length > 0 && address1.length > 0;
		$("[name=placePost], [name=placeAddress1]")
		                .removeClass("fail fail2").addClass(isValid ? "" : "fail");
		status.placeAddress = isValid;			
	}
	
	//좌표 유효성 검사
	function checkLatLngValid() {
		var lat = $("[name=placeLat]").val();
		var lng = $("[name=placeLng]").val();
		var isValid = lat.length > 0 && lng.length > 0;
		$("[name=placeLat], [name=placeLng]")
				                .removeClass("fail").addClass(isValid ? "" : "fail");
		status.placeLatLng = isValid;
	}
	
	//주소 변경되면 좌표 정보 초기화
	function initLatLng() {
		$("[name=placeLat]").val("");
		$("[name=placeLng]").val("");
		checkLatLngValid();
	}
	
	//주소 초기화
    $(".btn-address-clear").click(function(){
        $("[name=placePost]").val("");
        $("[name=placeAddress1]").val("");
		//주소가 변경 됨 -> 주소유효성체크, 좌표초기화
		checkAddressValid();
		initLatLng();
		deleteMap();
		//값이 지워졌으니 x버튼 사라져야함
		$(".btn-address-clear").fadeOut();
    });
	
	//위도 경도 구하기 버튼
	$(".btn-search-xy").click(function(){
		var post = $("[name=placePost]").val();
        var address1 = $("[name=placeAddress1]").val();
		//주소 입력되어있지 않으면 return
		if(post.length==0 || address1.length==0) {
			$("[name=placePost], [name=placeAddress1]").removeClass("fail").addClass("fail2");
			return;
		}
		searchLatLng();
	});
	
	//위도 경도 실제로 구하기
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
				checkLatLngValid();
				drawMap(lat, lng);
	    	}
    	});
	}
	
	//지도
	var map;
	var marker;
	
	//지도 그리기
	function drawMap(lat, lng) {
		var container = $('#map')[0];
		$(container).show();
		
	    var options = {
	        center: new kakao.maps.LatLng(lat, lng),
	        level: 3
	    };
		map = new kakao.maps.Map(container, options);
		
		var location = new kakao.maps.LatLng(lat, lng);
	    marker = new kakao.maps.Marker({
	        position: location, //위치 설정
	    });
		marker.setMap(map);
	}
	
	//지도 지우기
	function deleteMap() {
		if(marker) {
			marker.setMap(null);
			marker = null;
		}
		if(map) {
			map = null;
		}
		
		var mapElement = $("#map")[0];
		$(mapElement).remove();
		
		var newMapElement = $("<div>");
		$(newMapElement).attr("id", "map");
		$(".map-area").append(newMapElement);
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
	$("[name=placeOverview]").on("blur", function(){
		var isValid = $(this).val().length > 0;
		$(this).removeClass("fail").addClass(isValid ? "" : "fail");
		status.placeOverview = isValid;
	});
	
	//폼 전송
	$(".form-check").submit(function() {
		$("[name=placeTitle]").trigger("blur");
		$("[name=placeRegion]").trigger("input");
		$("[name=placeType]").trigger("input");
		$("[name=placeOverview]").trigger("blur");
		checkAddressValid();
		checkLatLngValid();
		checkFirstImageValid();
		
		//선택항목도 체크
		$("[name=placeTel]").trigger("blur");
		$("[name=placeWebsite]").trigger("blur");
		$("[name=placeOperate]").trigger("blur");
	
		return status.ok();
	});
	
	//선택항목 유효성 검사(전화,홈페이지,운영설명 길이 검사)
	//전화번호는 필수는 아니지만 만약 입력한다면 길이와 형식 제한있음
	$("[name=placeTel]").on("input",function(){
        var current = $(this).val();
        var convert = current.replace(/[^0-9]+/g, "");
        $(this).val(convert);
    });
	
    $("[name=placeTel]").blur(function(){
		var empty = $(this).val().length <= 0; //아예 입력하지말거나
		var regex = /^[0-9]{2,3}[0-9]{8}$/
		var pass = regex.test($(this).val());//정규식을 통과했냐
		
		var isValid = empty || pass;
        $(this).removeClass("fail").addClass(isValid ? "" : "fail");
        status.placeTel = isValid;
    });
	
	//웹사이트주소는 필수는 아니지만 입력한다면 길이 제한 있음
	//바이트 문제로 한글 입력 우선 막아둠
	//한글 제외한 문자들 기준 255자, 설정은 우선 태그에서 함(maxlength)
	$("[name=placeWebsite]").on("input",function(){
        var current = $(this).val();
        var convert = current.replace(/[ㄱ-ㅎㅏ-ㅣ가-힣]+/g, "");
        $(this).val(convert);
    });
	
	$("[name=placeWebsite").blur(function(){
		var isValid = $(this).val().length <= 255;
        $(this).removeClass("fail").addClass(isValid ? "" : "fail");
        status.placeWebsite = isValid;
	});
	
	//운영시간 정보도 필수는 아니지만 입력한다면 길이 제한 있음(200자 제한)
	$("[name=placeOperate").on("input", function(){
		var origin = $(this).val();
		var length = $(this).val().length;
		
		while(length > 200) {
			$(this).val(origin.substring(0, length-1));
			length--;
		}
	});
		
	$("[name=placeOperate").blur(function(){
		var isValid = $(this).val().length <= 200;
		$(this).removeClass("fail").addClass(isValid ? "" : "fail");
        status.placeOperate = isValid;
	});
	
	//대표 이미지 유효성 검사
	function checkFirstImageValid() {
		var isValid = $(".firstImage")[0].files.length > 0;
		$(".firstImage").removeClass("fail").addClass(isValid ? "" : "fail");
		$(".preview-firstImage").find("img").css("border", isValid ? "" : "1px solid red");
		status.firstImage = isValid;
	}
	
	//대표 이미지
	$(".btn-add-first").click(function(){
		$(".firstImage").click();
	});
	
	$(".btn-clean-first").click(function(){
		$(".firstImage").val("");//input값 초기화
		previousFile = null;
		$(".preview-firstImage").find("img").attr("src", "/images/defaultBack.png");
		$(".first-name").text("");
		checkFirstImageValid();
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
				checkFirstImageValid();
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
		else {
			checkFirstImageValid();
		}
	});
	
	//상세 이미지
	var fileListMap = new Map();
	var fileCnt = 0;
	
	$(".detailImages").change(function(){
		var selectedFiles = this.files;
		for(var i=0; i<selectedFiles.length; i++) {
			var fileIndex = fileCnt++;
			fileListMap.set(fileIndex, selectedFiles[i]);
			showDetailPreview(fileIndex, selectedFiles[i]);
		}
		updateDetailInput();
	});
	
	$(document).on("click", ".btn-close", function(){
        var index = $(this).parent().data("index");
		fileListMap.delete(index);

		if(fileListMap.size > 0) {
			updateDetailInput();
		}
		else {
			$(".detailImages")[0].files = new DataTransfer().files;
		}		
        
        $(this).parent().remove();
    });
	
	function updateDetailInput() {
		var dataTransfer = new DataTransfer();
		for(var value of fileListMap.values()) {
			dataTransfer.items.add(value);	
		}
		$(".detailImages")[0].files = dataTransfer.files;
	}
	
	function showDetailPreview(index, file) {
		var reader = new FileReader();
		reader.onload = function(e){
			var template = $("#imgTag").text();
			var html = $.parseHTML(template);
			$(html).find("img").attr("src", e.target.result);
			$(html).attr("data-index", index);
			$(".preview-detailImages").append(html);
		};
		reader.readAsDataURL(file);
	}
});