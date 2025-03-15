//에디터 처리
$(function(){
    $("[name=noticeContent]").summernote({
        height:250,//높이(px)
        minHeight:200, //최소높이(px)
        maxHeight:400, //최대높이(px)

        placeholder:"타인에 대한 무분별한 비방 시 예고 없이 삭제될 수 있습니다",

        //메뉴(toolbar) 설정
        toolbar: [
            //['메뉴명', ['버튼명', '버튼명', ...]]
            ["font", ["style", "fontname", "fontsize", "forecolor", "backcolor"]],
            ["style", ["bold", "italic", "underline", "strikethrough"]],
            ["attach", ["picture"]],
            ["tool", ["ol", "ul", "table", "hr", "fullscreen"]],
            // ["action", ["undo", "redo"]],
        ],

        //상황에 맞는 callback 함수들
        callbacks: {
            onImageUpload: function(files){
                //예상 시나리오
                //1. 서버로 사용자가 선택한 이미지를 업로드
                //  - 이미지는 multipart/form-data 형태여야 한다
                //  - 상황상 form을 쓸 수가 없으므로 ajax를 써야 한다
                //2. 업로드한 이미지에 접근할 수 있는 정보 획득
                //3. 획득한 정보로 <img> 생성
                //4. 에디터에 추가
                //- $("[name=boardContent]").summernote("insertNode", 이미지태그객체);

                //console.log(files);
                if(files.length == 0) return;

                var form = new FormData();//form을 대신할 도구
                for(var i=0; i < files.length; i++) {
                    form.append("attach", files[i]);
                }

                $.ajax({
                    processData: false,//파일업로드를 위해 반드시 필요한 설정
                    contentType: false,//파일업로드를 위해 반드시 필요한 설정
                    url:"/rest/notice/uploads",
                    method:"post",
                    data: form,
                    success:function(response){//첨부파일번호들(List<Integer>)
                        for(var i=0; i < response.length; i++) {
                            var tag = $("<img>").attr("src", "/attachment/download?attachmentNo="+response[i])
                                                         .addClass("summernote-img")
														 .attr("data-attachment-no", response[i]);
                            $("[name=noticeContent]").summernote("insertNode", tag[0]);
                        }
                    }
                });
            },
        },
    });
});
$(function(){
    // 🔹 Summernote 초기화
    $("[name=noticeContent]").summernote({
        height: 250,
        minHeight: 200,
        maxHeight: 400,
        placeholder: "타인에 대한 무분별한 비방 시 예고 없이 삭제될 수 있습니다",
        toolbar: [
            ["font", ["style", "fontname", "fontsize", "forecolor", "backcolor"]],
            ["style", ["bold", "italic", "underline", "strikethrough"]],
            ["attach", ["picture"]],
            ["tool", ["ol", "ul", "table", "hr", "fullscreen"]],
        ]
    });

    var status = {
        noticeTitle: false,
        noticeContent: false,
        ok: function() {
            return this.noticeTitle && this.noticeContent;
        }
    };

    // 🔹 제목 blur 이벤트 (입력 확인)
    $("[name=noticeTitle]").blur(function(){
        var isValid = $(this).val().trim().length > 0;
        status.noticeTitle = isValid;

        $(this).removeClass("success fail").addClass(isValid ? "success" : "fail");
    });

    // 🔹 Summernote 본문 유효성 검사 함수 (수동 실행 가능)
    function checkContentValid() {
        var isValid = !$("[name=noticeContent]").summernote('isEmpty');
        status.noticeContent = isValid;
    }

    // 🔹 Summernote blur 이벤트 (본문 검사)
    $("[name=noticeContent]").on("summernote.blur", function(){
        checkContentValid();
    });

    // 🔹 제출 시 최종 유효성 검사
    $(".form-check").submit(function(event){
        console.clear();

        // 강제로 입력값 유효성 검사 실행
        $("[name=noticeTitle]").trigger("blur");
        checkContentValid(); // Summernote는 직접 실행해야 안정적


        // 유효성 검사 실패 시 제출 막기
        if (!status.ok()) {
            event.preventDefault();
        } 
		else {
        }
    });
});