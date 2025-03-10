<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    
     <link href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.css" rel="stylesheet">

 <script src="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.js"></script>
    <script src="/js/admin-notice-add-summernote.js"></script>

      <div class="container w-800">
        <div class="cell center" >
            <h1>수정</h1>
        </div>
        
        <form class="form-check" action="edit" method="post">
  <input type="hidden" name="noticeNo" value="${noticeDto.noticeNo}">
        <div class="cell">
            <label class="p-10">제목</label>
           <input class="field w-100" type="text" name="noticeTitle"  placeholder="제목 입력"
           value="${noticeDto.noticeTitle}">
           <div class="fail-feedback">&nbsp;&nbsp;제목을 작성해주세요</div>
        </div>
        <div class="cell my-40">
            <label class="p-10">본문</label>
            <textarea name="noticeContent">${noticeDto.noticeContent}</textarea>
        </div>
        <div class="cell">
            <button  class="btn btn-positive w-100" style="height: 50px;">작성하기</button>
        </div>
        </form>
    </div>
 
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>       
