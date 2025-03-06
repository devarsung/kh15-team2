<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
     <link href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.css" rel="stylesheet">
 <style>
   <style>
        .note-editor{
            border : 1px solid #b6b6b6 !important
        }
        .note-editable{
            background-color: white !important;
        }
        .field.fail,
        .field.fail2{
             border : 1px solid #b6b6b6;
        }
     </style>
     </style>
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.js"></script>
    <script src="/js/review-add-summernote.js"></script>
    
   
     <div class="container w-800">
        <div class="cell center" >
            <h1>리뷰 작성</h1>
        </div>
        
        <form class="form-check" action="add" method="post">
        <div class="cell">
            <label class="p-10">제목</label>
           <input class="field w-100" type="text" name="reviewTitle"  placeholder="제목 입력">
           <div class="fail-feedback">&nbsp;&nbsp;제목을 작성해주세요</div>
        </div>
        <div class="cell my-40">
            <label class="p-10">본문</label>
            <textarea name="reviewContent" ></textarea>
        </div>
        <div class="cell">
            <button type="submit" class="btn btn-positive w-100" style="height: 50px;">작성하기</button>
        </div>
        </form>
    </div>
    
    
    
    <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>   