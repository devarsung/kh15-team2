//에디터 처리
$(function(){
    $("[name=noticeContent]").summernote({
        height:250,//높이(px)
        minHeight:200, //최소높이(px)
        maxHeight:400, //최대높이(px)

        placeholder:"타인에 대한 무분별한 비방 시 예고 없이 삭제될 수 있습니다",

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
