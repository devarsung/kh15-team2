$(function(){
    var params = new URLSearchParams(location.search);
    var reviewNo = params.get("reviewNo");

    // 좋아요
    $.ajax({
        url:"/rest/review/check",
        method:"post",
        data: {reviewNo : reviewNo},
        success:function(response){
            $(".fa-heart").removeClass("fa-solid fa-regular")
                .addClass(response.done ? "fa-solid" : "fa-regular");
            $(".heart-count").text(response.count);
        }
    });

    $(".fa-heart").click(function(){
        $.ajax({
            url:"/rest/review/action",
            method:"post",
            data:{reviewNo : reviewNo},
            success:function(response){
                $(".fa-heart").removeClass("fa-solid fa-regular")
                    .addClass(response.done ? "fa-solid" : "fa-regular");
                $(".heart-count").text(response.count);
                console.log($(".fa-heart"));
            }
        })
    });
});

// 리뷰 스타
$(function(){
    $(".reviewStar").score({
        starColor: "#FFE31A",
        editable:false,
        
        display:{
            placeLimit:1,
            textColor:"#d63031",
        },
    });
});

// 댓글
$(function(){
    var params = new URLSearchParams(location.search);
    var reviewNo = params.get("reviewNo");
    //console.log(reviewNo);
    loadList();

    // 댓글 작성
    $(".btn-reply-write").click(function(){
        var replyContent = $(".reply-writebox").val();

        if(replyContent.length==0){
            window.alert("댓글을 입력하세요");
            return;
        }
        $.ajax({
            url:"/rest/reply/write",
            method:"post",
            data:{
                replyOrigin : reviewNo,
                replyContent : replyContent
            },
            success:function(response){
                $(".reply-writebox").val("");
                loadList();
            }
        });
    });

    // 댓글 삭제
    $(document).on("click",".delete-btn",function(){
        var choice = window.confirm("정말 댓글을 삭제하시겠습니까?");
        if(choice == false) return;
        var replyNo = $(this).data("reply-no");
        
        $.ajax({
            url:"/rest/reply/delete",
            method:"post",
            data:{replyNo : replyNo},
            success:function(response){
                loadList();
            }
        });
    });

    // 댓글 수정
    $(document).on("click", ".edit-btn", function(){
    	console.log($(".reply-edit-item"));
    	console.log($(".reply-edit-item").prev(".reply-item"));
    	
    	
        $(".reply-edit-item").prev(".reply-item").show();
        $(".reply-edit-item").remove();

        var template = $("#reply-edit-template").text();
        var html = $.parseHTML(template);

        var replyWriter = $(this).closest(".reply-item").find(".reply-writer").text();
        var replyContent = $(this).closest(".reply-item").find(".reply-content").text();
        var replyWtime = $(this).closest(".reply-item").find(".reply-wtime").text();
        var replyNo = $(this).data("reply-no");

        $(html).find(".reply-writer").text(replyWriter);
        $(html).find(".reply-content").val(replyContent);
        $(html).find(".reply-wtime").text(replyWtime);
        $(html).find(".save-btn").attr("data-reply-no", replyNo);

        $(this).closest(".reply-item").after(html);
        $(this).closest(".reply-item").hide();
    });

    // 댓글 수정 저장
    $(document).on("click", ".save-btn", function(){
        var replyNo = $(this).data("reply-no");
        var replyContent = $(this).closest(".reply-edit-item").find(".reply-content").val();
        if(replyContent.length == 0) {
            window.alert("수정 하시겠습니까?");
            return;
        }

        $.ajax({
            url:"/rest/reply/edit",
            method:"post",
            data:{
                replyNo : replyNo, 
                replyContent : replyContent
            },
            success:function(response){
                loadList();
            }
        });
    });

    // 댓글 수정 취소
    $(document).on("click", ".cancel-btn", function(){
        var choice = window.confirm("취소 하시겠습니까?");
        if(choice == false) return;

        $(this).closest(".reply-edit-item").prev(".reply-item").show();
        $(this).closest(".reply-edit-item").remove();
    });

    var userId = "${sessionScope.userId}";
    var reviewWriter = "${reviewDto.memberNickname}";

    // 댓글 목록
    function loadList(){

        $.ajax({
            url:"/rest/reply/list",
            method:"post",
            data:{ replyOrigin : reviewNo },
            success:function(response){
                $(".reply-wrapper").empty();
                $(response).each(function(){
                    var template = $("#reply-template").text();
                    var html = $.parseHTML(template);
                    var convertTime = moment(this.replyWtime).fromNow();

                    $(html).find(".reply-no").text("(no."+this.replyNo+")");
                    $(html).find(".reply-writer").text(this.memberNickname);
                    $(html).find(".reply-content").text(this.replyContent);
                    $(html).find(".reply-wtime").text(convertTime);
                    $(html).find(".delete-btn").attr("data-reply-no",this.replyNo);
                    $(html).find(".edit-btn").attr("data-reply-no",this.replyNo);

                    if(userId.length == 0 || this.replyWriter != userId) {
                        $(html).find(".edit-btn").remove();
                        $(html).find(".delete-btn").remove();
                    }
                    if(this.replyWriter == null ||  reviewWriter.length == 0 
                        || this.replyWriter !=  reviewWriter) {
                        $(html).find(".owner-badge").remove();
                    } 

                    $(".reply-wrapper").append(html);
                });
                $(".reply-count").text(response.length);
            }
        });
    };
});
