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
		$(html).find(".save-btn").attr("data-reply-no", replyNo);
		
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
	
       //세션
       var userId = "${sessionScope.userId}";
       var reviewWriter = "${memberDto.memberNickname}";
       //댓글목록
       function loadList(){
       $.ajax({
           url:"/rest/reply/list",
           method:"post",
           data:{ replyOrigin : reviewNo },
           success:function(response){
           	console.log(response);
               $(".reply-wrapper").empty();
               $(response).each(function(){ //댓글 어떻게 보여줄건지 정합시다..
                   var template = $("#reply-template").text();
                   var html = $.parseHTML(template);
                   var convertTime = moment(this.replyWtime).fromNow();
                   //변환
                   $(html).find(".reply-no").text("(no."+this.replyNo+")");
                   $(html).find(".reply-writer").text(this.replyWriter);
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
               $(".reply-count").text(reponse.length); //댓글개수 
           }
       });
   };
   });