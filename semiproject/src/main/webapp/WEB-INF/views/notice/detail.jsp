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
     	display:inline-block;
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
        <h1>${noticeDto.noticeTitle}</h1>
    </div>
    	<div class="cell ">
            <div class="cell">
                <input type="hidden" name="noticeNo" value="${noticeDto.noticeNo}">
                
            </div>
            <div class="cell right ">
           <label>           
                수정시각( ${noticeDto.getEtimeString()})
           </label>

           <label>
           
              작성시각(${noticeDto.getWtimeString()})<br>
           </label>
              <label></label>
               Name:(${noticeDto.memberNickname})
      		  
      		  <label>
      		   조회수:${noticeDto.noticeRead}
      		  </label>
           
            </div>
    	</div>
    
    <div class="textarea mt-20 ">
        ${noticeDto.noticeContent}
    </div>
  <div class="cell">
  <a href="/" class="btn btn-neutral w-25 me-20">메인페이지</a>
 <a href="/notice/list" class="btn btn-btn-neutral w-25">공지목록</a> 
	  </div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>   

