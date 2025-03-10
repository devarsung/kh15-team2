<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
   .textarea {
        width: 100%;
        height: 12.25em;
        border: none;
        resize: none;
        font-size: 34px;      
     	display: grid;
    	font-weight:500;
    }
      .textarea1 {
        width: 100%;
        border: none;
        resize: none;
       font-size: 36px;         
     	display: grid;
    	font-weight:600;
    }
    </style>

<div class="container w-800">
    <div class="cell center">
        <label class="textarea1 mb-20">
       ${noticeDto.noticeTitle}
        </label>
    </div>
    	<div class="cell">
            <div class="cell">
                게시글 넘버:${noticeDto.noticeNo}
              
            </div>
            <div class="cell textarea2">

              작성시각(${noticeDto.noticeWtime})|<br>
                수정시각( ${noticeDto.noticeEtime})|
               닉네임(${noticeDto.noticeWriter})|
        조회수:${noticeDto.noticeRead}
           
            </div>
    	</div>
    
    <div class="textarea mt-20">
        ${noticeDto.noticeContent}
    </div>
    <div class="cell">
    <a href="list" class="btn btn-neutral w-25">목록!</a>
    <a href="edit?noticeNo=${noticeDto.noticeNo}" class="btn btn-neutral ms-40 w-25">수정!</a>
    </div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>   