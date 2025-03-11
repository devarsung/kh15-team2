<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
     <link href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.css" rel="stylesheet">
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
        .placeTitle{
            text-decoration: underline;
        }
        </style>
    

    <script src="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.js"></script>
    <script src="/js/review/review-add-summernote.js"></script>
     <script src="https://cdn.jsdelivr.net/gh/hiphop5782/score@latest/score.min.js"></script>
    
 <div class="container w-800">
        <div class="cell center" >
            <h1>후기 수정</h1>
        </div>
        <div class="cell right">
            <h3 class="placeTitle" >${placeDto.placeTitle}  <i class="fa-solid fa-camera"></i></h3>
        </div>
        
        <form class="form-check" action="edit" method="post">
        <input type="hidden" name="reviewNo" value="${reviewDto.reviewNo}">
        <div class="cell">
            <label class="p-10 ">제목</label>
           <input class="field w-100" type="text" name="reviewTitle" value="${reviewDto.reviewTitle}" placeholder="제목 입력">
           <div class="fail-feedback">&nbsp;&nbsp;제목을 작성해주세요</div>
        </div>
        <div class="cell">
            <p>"${placeDto.placeTitle}"의 평점을 남겨주세요</p>
           <div class="reviewStar"  data-max="5" data-rate="${reviewDto.reviewStar}" ></div>
        </div>
        <div class="cell my-40">
            <label class="p-10">본문</label>
            <textarea name="reviewContent">${reviewDto.reviewContent}</textarea>
        </div>
        <div class="cell">
            <button type="submit" class="btn btn-positive w-100" style="height: 50px;">수정하기</button>
        </div>
        </form>
    </div>
    
    <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>   