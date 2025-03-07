

$(function(){
    //상태 변수
    var status = {
            reviewTitle : false,
            reviewContent : false,
            ok : function(){
                return this.reviewTitle && this.reviewContent;
            },
        };
    $("[name=reviewContent]").summernote({
        height:300,//높이(px)
        minHeight:200, //최소높이(px)
        maxHeight:600, //최대높이(px)
        placeholder:"리뷰 내용을 작성해주세요",
        toolbar: [
            ["font", ["style", "fontname", "fontsize", "forecolor", "backcolor"]],
            ["style", ["bold", "italic", "underline", "strikethrough"]],
            ["attach", ["picture"]],
            ["tool", ["ol", "ul", "table", "hr", "fullscreen"]],

        ],
  
        callbacks: {
            onImageUpload: function(files){
                if(files.length == 0) return;
                
                var form = new FormData();//form을 대신할 도구
                for(var i=0; i < files.length; i++) {
                    form.append("attach", files[i]);
                }
                
                $.ajax({
                    processData: false,
                    contentType: false,
                    url:"/rest/review/uploads",
                    method:"post",
                    data: form,
                    success:function(response){
                        for(var i=0; i < response.length; i++) {
                            var tag = $("<img>").attr("src", "/attachment/download?attachmentNo="+response[i])
                            .addClass("summernote-img")  //식별자 알아보기위한클래스
                            .attr("data-attachment-no", response[i]); //추출을위한
                            $("[name=reviewContent]").summernote("insertNode", tag[0]);
                        }
                    }
                });
            },
        },
    });
    $("[name=reviewTitle]").blur(function(){
        var isValid = $(this).val().length > 0;
        $(this).removeClass("fail").addClass(isValid ? "" : "fail");
        status.reviewTitle = isValid;
    });
    $("[name=reviewContent]").blur(function(){
        var isValid = $(this).val().length > 0;
        if(!isValid){
            $(".note-placeholder").css("color","#d63031");
            status.reviewContent = false;
        };
        status.reviewContent = isValid;
    });
    $(".form-check").submit(function(){
        $("[name]").trigger("blur");
        return status.ok();
    });
});

//페이지 이탈
$(function(){
	$("[name=reviewContent]").on("summernote.change", function(){
		checkInputState();		
	});
	$("[name=reviewTitle]").on("input", function(){
		checkInputState();
	});	
	$(".form-check").submit(function(){
		$(window).off("beforeunload");
		return true;
	});
	
	function checkInputState() {
		var titleEmpty = $("[name=reviewTitle]").val().length == 0;
		var contentEmpty = $("[name=reviewContent]").val().length == 0;
		var isEmpty = titleEmpty && contentEmpty;
		
		if(isEmpty) {
			$(window).off("beforeunload");
		}
		else {
			$(window).off("beforeunload");
			$(window).on("beforeunload", function(){ return false; });
		}
	}
    $(".reviewStar").score({
            starColor: "#FFE31A",
            editable:true,//편집 가능하도록 설정
            integerOnly:false,//별을 정수 개수로만 선택하도록 설정
            send:{//전송옵션
                sendable:true,//전송 가능
                name:"reviewStar",//전송될 이름 설정
            },
            display:{
                showNumber:true,
                placeLimit:1,
                textColor:"#d63031",
            },
        });
});