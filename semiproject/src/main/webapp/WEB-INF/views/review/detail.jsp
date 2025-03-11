<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="/css/review-detail.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/gh/hiphop5782/score@latest/score.min.js"></script>

<script type="text/javascript">
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
    console.log(reviewNo);
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
    var reviewWriter = "${memberDto.memberNickname}";

    // 댓글 목록
    function loadList(){
        $.ajax({
            url:"/rest/reply/list",
            method:"post",
            data:{ replyOrigin : reviewNo },
            success:function(response){
                console.log(response);
                $(".reply-wrapper").empty();
                $(response).each(function(){
                    var template = $("#reply-template").text();
                    var html = $.parseHTML(template);
                    var convertTime = moment(this.replyWtime).fromNow();

                    $(html).find(".reply-no").text("(no."+this.replyNo+")");
                    $(html).find(".reply-writer").text(this.replyNickname);
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
</script>

<!-- 댓글 목록/내글이면 수정/삭제 btn -->
<script type="text/template" id="reply-template"> 
    <div class="cell flex-box reply-item"> 
        <div class="w-150 p-10 inline-flex-box" style="min-width: 150px;"> 
            <div class="reply-tinyfont">
                <span class="reply-wtime">댓글작성일/수정일</span>
                <h3 class="mt-10 reply-writer">닉네임</h3>
            </div>
        </div>
        <div class="w-100 p-10">
            <h5 class="m-0 reply-content reply-input">댓글본문</h5>
        </div>
        <div class="w-150 p-10 btns">
            <button class="edit-btn"  type="button">
                <i class="fa-solid fa-pen-to-square"></i>
            </button>
            <button class="delete-btn" type="button">
                <i class="fa-regular fa-trash-can"></i>
            </button>
        </div>
    </div>
</script>

<!-- 댓글 수정/취소 -->
<script type="text/template" id="reply-edit-template">
    <div class="cell flex-box reply-edit-item">
        <div class="w-150 p-10 inline-flex-box" style="min-width: 150px;"> 
            <div class="reply-tinyfont">
                <span class="reply-wtime">댓글작성일/수정일</span>
                <h3 class="mt-10 reply-writer">닉네임</h3>
            </div>
        </div>
        <div class="p-10">
            <textarea class="save-contentBox reply-content"></textarea>
        </div>
        <div class="felx-box btns">
            <button class="save-btn"  type="button">
                <i class="fa-solid fa-floppy-disk"></i>
            </button>
            <button class="cancel-btn" type="button">
                <i class="fa-solid fa-xmark"></i>
            </button>
        </div>
    </div>
</script>

</head>
<div class="container w-1200">
    <div class="cell center">
        <h2>[${reviewDto.reviewWriter}]님의 후기</h2>
    </div>
    <hr style=" box-shadow: 0 0 10px rgba(0,0,0,0.1);">
    <div class="cell right">
        <i class="fa-solid fa-eye"></i> ${reviewDto.reviewRead}| 
        <i class="fa-solid fa-heart"></i>${reviewDto.reviewLike}|
        <i class="fa-solid fa-comment-dots"></i><span class="reply-count"></span>
    </div>
    <div class="cell right">
        작성일(${reviewDto.getWtimeString()})|수정일(${reviewDto.getEtimeString()})
    </div>
    <div class="cell p-20">
        <h1>
            ${reviewDto.reviewTitle}  <i class="fa-solid fa-pencil"></i>
        </h1>
    </div>
    <hr>
    <div class="cell reviewStar" data-rate="${reviewDto.reviewStar}"></div>
    <span class="red">${reviewStar.reviewStar}</span>
    <div class="cell p-20 content-box">${reviewDto.reviewContent}</div>
  
    <div>
        <i class="fa-heart fa-regular red"></i>좋아요<span class="heart-count">${reviewDto.reviewLike}</span>
    </div>
    <br>
    <c:choose>
        <c:when test="${sessionScope.userId != null}">
            <div class="flex-box align-items"> 
                <div class="cell w-100">
                    <textarea class="reply-writebox" placeholder="댓글을 남겨주세요"></textarea>
                </div>
                <div class="cell right inline-flex-box flex-center w-20">
                    <button type="button" class=" btn btn-neutral btn-reply-write">등록하기</button>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="flex-box align-items"> 
                <div class="cell w-100">
                    <textarea class="reply-writebox2" placeholder="로그인후 이용가능합니다"></textarea>
                </div>
                <div class="cell right inline-flex-box flex-center w-20">
                    <button type="button"  class="btn btn-neutral">등록하기</button>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
<hr class="my-30" style=" box-shadow: 0 0 10px rgba(0,0,0,0.1);">
    <c:choose>
        <c:when test="${reviewDto.reviewReply == null}">
            <div class="cell center">    
                댓글이 없습니다
            </div>
        </c:when>
        <c:otherwise>
            <div class="cell left my-0 reply-list">
                <label>댓글목록</label>
            </div>

        </c:otherwise>
    </c:choose>
  <div class="reply-wrapper"></div>
    <div class="cell right">
        <c:if test="${sessionScope.userId != null}">
            <c:if test="${sessionScope.userId == reviewDto.reviewWriter}">
                <a href="/review/edit?reviewNo=${reviewDto.reviewNo}" class="changebtn mt-20" >수정</a>
                <a href="/review/delete?reviewNo=${reviewDto.reviewNo}" class="deletemessage">삭제</a>
            </c:if>
        </c:if>
    </div>

    <div class="cell center">
        <a href="/review/list" class="btn btn-neutral mt-20" style="width:200px">목록으로</a>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
