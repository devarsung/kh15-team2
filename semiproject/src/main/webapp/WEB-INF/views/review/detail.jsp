<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

   
    <style>
    .content-box{
        min-height:300px; 
        border:1px solid rgb(192, 192, 192);
    }

    /*댓글입력창*/
    .reply-writebox{
    width: 100%;
    height: 70px;
    min-height:70px;
    resize: none; 
    background-color: #f8f9fa; 
    border: 1px solid #ccc; 
    padding: 10px;
    font-size: 14px;
    outline: none;
    flex-grow: 1;
    }

    .reply-list-box{
    border: 1px solid lightgray; 
    padding: 10px;
    }
    
    .reply-tinyfont{
    font-size:13px;
    color: gray;
    }

    .btns{
     gap:5px; 
     margin-left: auto;
    }

    .edit-btn{
     border: 1px solid rgb(218, 218, 218); 
     background-color: rgb(224, 241, 255);
    }

    .delete-btn{
     border: 1px solid rgb(218, 218, 218); 
     background-color: rgb(255, 224, 224);
    }
     
    .edit-btn:hover,
    .delete-btn:hover{
     filter:brightness(1.05);
     cursor: pointer;
    }
    </style>

    
 

 
    <script src="https://cdn.jsdelivr.net/gh/hiphop5782/score@latest/score.min.js"></script>
    <script type="text/javascript">
    $(function(){
        $(".reviewStar").score({
            starColor: "#FFE31A",
            editable:false,//편집 가능하도록 설정
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
    //댓글목록 스크립트
    $(function(){
        //글번호
        var params = new URLSearchParams(location.search);
        var reviewNo = params.get("reviewNo");

        loadList();
        //댓글작성
        $(".btn-reply-write").click(function(){
            var replyContent = $(".reply-writebox").val();
            if(replyContent.length==0){
                window.alert("내용을 작성하세요");
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
                    $(".reply-writebox").val("");//입력값제거
                    loadList();
                }
            });
        });

        //댓글삭제
        $(document).on("click",".delete-btn",function(){
            var choice = window.confirm("정말 댓글을 삭제하겠습니까?");
            if(choice ==false) return;
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
        //댓글수정
    		$(document).on("click", ".edit-btn", function(){
			
			//기존에 열려있는 모든 수정화면을 제거
			$(".reply-edit-item").prev(".reply-item").show();
			$(".reply-edit-item").remove();
			
			//원본은 놔두고 원본 뒤에다 추가
			var template = $("#reply-edit-template").text();
			var html = $.parseHTML(template);
			
			
			var replyWriter = $(this).closest(".reply-item").find(".reply-writer").text();
			var replyContent = $(this).closest(".reply-item").find(".reply-content").text();
			var replyWtime = $(this).closest(".reply-item").find(".reply-wtime").text();
			var replyNo = $(this).data("reply-no");
			
			$(html).find(".reply-writer").text(replyWriter);
			$(html).find(".reply-content").val(replyContent);
			$(html).find(".reply-wtime").text(replyWtime);
			$(html).find(".btn-reply-save").attr("data-reply-no", replyNo);
			
			$(this).closest(".reply-item").after(html);
			$(this).closest(".reply-item").hide();
		});
        //수정 저장
		$(document).on("click", ".save-btn", function(){
			var replyNo = $(this).data("reply-no");
			var replyContent = $(this).closest(".reply-edit-item").find(".reply-content").val();
			if(replyContent.length == 0) {
				window.alert("내용은 필수입니다");
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
		$(document).on("click", ".cancel-btn", function(){
			//취소를 누르면 현재 수정 영역을 제거하고 앞의 표시 영역을 출력
			var choice = window.confirm("댓글 수정을 취소하시겠습니까?");
			if(choice == false) return;
			
			$(this).closest(".reply-edit-item").prev(".reply-item").show();
			$(this).closest(".reply-edit-item").remove();
		});
		
        
        //댓글목록
        function loadList(){
        $.ajax({
            url:"http://localhost:8080/rest/reply/list",
            method:"post",
            data:{ replyOrigin : reviewNo },
            success:function(response){
                $(".reply-wrapper").empty();
                $(response).each(function(){ //댓글 어떻게 보여줄건지 정합시다..
                    var template = $("#reply-template").text();
                    var html = $.parseHTML(template);
                    var convertTime = moment(this.replyWtime).fromNow();
                    //변환
                    $(html).find(".reply-writer").text(this.replyWriter);
                    $(html).find(".reply-content").text(this.replyContent);
                    $(html).find(".reply-wtime").text(this.replyWtime);
                    $(html).find(".delete-btn").attr("data-reply-no",this.replyNo);
                    $(html).find(".edit-btn").attr("data-reply-no",this.replyNo);

                    $(".reply-wrapper").append(html);
                });
                $(".reply-count").text(reponse.length); //댓글개수
            }
        });
    };
    });
    </script>
<!--댓글 목록/내글이면 수정/삭제btn-->
    <script type="text/template" id="reply-wrapper"> 

        <div class="cell flex-box flex-center reply-list-box reply-item">
            <div class="flex-box flex-vertical flex-center" style="min-width: 150px;"> 
                <div  class="reply-tinyfont">
                    <span class="reply-no">댓글번호</span>
                    <span class="reply-wtime">댓글작성일/수정일</span>
                <h3 class="mt-10 reply-writer">닉네임</h3>
            </div>
            
            <div class="p-10">
                <h5 class="m-0 reply-content reply-input">댓글본문</h5>
            </div>
            
            <!--수정 삭제버튼임..-->
            <div class="felx-box btns">
                <button class="edit-btn"  type="button">
                    <i class="fa-solid fa-pen-to-square"></i>
                </button>
                <button class="delete-btn" type="button">
                    <i class="fa-regular fa-trash-can"></i>
                </button>
            </div>
        </div>

    </script>
     <!--댓글 수정/취소-->
    <script type="text/template" id="reply-edit-template">

        <div class="cell flex-box flex-center reply-list-box reply-edit-item">
            <div class="flex-box flex-vertical flex-center" style="min-width: 150px;"> 
                <div  class="reply-tinyfont">
                    <span class="reply-no">댓글번호</span>
                    <span class="reply-wtime">댓글작성일/수정일</span>
                <h3 class="mt-10 reply-writer">닉네임</h3>
            </div>
            
            <div class="p-10">
                <textarea class="m-0 reply-content"></textarea>
            </div>
            
            <!--저장 취소버튼임..-->
            <div class="felx-box btns">
                <button class="save-btn"  type="button">
                    <i class="fa-solid fa-floppy-disk"></i>
                </button>
                <button class="cancle-btn" type="button">
                    <i class="fa-solid fa-xmark"></i>
                </button>
            </div>
        </div>

    </script>
</head>
<div class="container w-1000">

    <div class="cell center">
        <h1>[${reviewDto.reviewWriter}]님의 후기</h1>
    </div>
    <div class="cell right">
        <i class="fa-solid fa-heart"></i>${reviewDto.reviewLike}|<i class="fa-solid fa-eye"></i> ${reviewDto.reviewRead}|<span class="reply-count"><i class="fa-solid fa-comment-dots"></i>${reviewDto.reviewReply}</span>
    </div>
    <div class="cell right">
    작성일(${reviewDto.reviewWtime})|수정일(${reviewDto.reviewEtime})
    </div>
    <div class="cell p-20">
        <h1>
            ${reviewDto.reviewTitle}<i class="fa-solid fa-pencil"></i>
        </h1>
    </div>
    <div class="cell reviewStar"></div>
    <div class="cell p-20 content-box" >${reviewDto.reviewContent}</div>
    <br>

    <div class="cell left my-0">
        <label>댓글등록</label>
    </div>
    <div class="flex-box align-items"> 
        <div class="cell w-100">
            <textarea class="reply-writebox" placeholder="  댓글을 입력하세요"></textarea>
        </div>
        <div class="cell right inline-flex-box flex-center w-20">
            <button class="btn btn-neutral btn-reply-write">등록하기</button>
        </div>
    </div>

        <div class="cell left my-0">
            <label>댓글목록</label>
        </div>

    <div class="reply-wrapper"></div>


    <div class="cell center">
        <button class="btn btn-neutral mt-20" style="width:200px">목록으로</button>
    </div>

</div>
</body>

</html>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>   
