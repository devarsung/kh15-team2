<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="/css/review-detail.css">

   <script src="https://cdn.jsdelivr.net/gh/hiphop5782/score@latest/score.min.js"></script>
   <script src="/js/review/review-detail.js"></script>
    <script type="text/javascript">
    </script>
<!--댓글 목록/내글이면 수정/삭제btn-->
    <script type="text/template" id="reply-template"> 

        <div class="cell flex-box  reply-item"> 
            <div class="w-150 p-10 inline-flex-box" style="min-width: 150px;"> 
                <div  class="reply-tinyfont">
                    <span class="reply-no">댓글번호</span>
                    <span class="reply-wtime">댓글작성일/수정일</span>
                <h3 class="mt-10 reply-writer">닉네임</h3>
            </div>
            </div>
            <div class="w-100 p-10  ">
                <h5 class="m-0 reply-content reply-input">댓글본문</h5>
            </div>
            
            <!--수정 삭제버튼임..-->
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
     <!--댓글 수정/취소-->
    <script type="text/template" id="reply-edit-template">

        <div class="cell flex-box  reply-edit-item">
            <div class="w-150 p-10 inline-flex-box" style="min-width: 150px;"> 
                <div  class="reply-tinyfont">
                    <span class="reply-no">댓글번호</span>
                    <span class="reply-wtime">댓글작성일/수정일</span>
                <h3 class="mt-10 reply-writer">닉네임</h3>
            </div>
			</div>
            
            <div class="p-10">
                <textarea class="save-contentBox reply-content" "></textarea>
            </div>
            
            <!--저장 취소버튼임..-->
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
   <c:choose>
   	<c:when test="${sessionScope.userId != null}">
    <div class="flex-box align-items"> 
        <div class="cell w-100">
            <textarea class="reply-writebox" placeholder="  댓글을 입력하세요"></textarea>
        </div>
        <div class="cell right inline-flex-box flex-center w-20">
            <button type="button" class=" btn btn-neutral btn-reply-write">등록하기</button>
        </div>
    </div>
 	</c:when>
 	<c:otherwise>
 		<div class="flex-box align-items"> 
        <div class="cell w-100">
            <textarea class="reply-writebox2" placeholder="  로그인후에 작성 가능합니다"></textarea>
        </div>
        <div class="cell right inline-flex-box flex-center w-20">
            <button type="button"  class="btn btn-neutral">등록하기</button>
        </div>
    </div>
    </c:otherwise>
    </c:choose>

        <div class="cell left my-0">
            <label>댓글목록</label>
        </div>

    <div class="reply-wrapper"></div>

    <div class="cell center">
        <a href="/review/list" class="btn btn-neutral mt-20" style="width:200px">목록으로</a>
    </div>

</div>
</body>

</html>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>   
