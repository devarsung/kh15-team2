<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-800">
        <div class="cell center" >
            <h1>공지사항 등록</h1>
        </div>
        
        <form class="form-check" action="add" method="post">
        <div class="cell">
            <label class="p-10">제목</label>
           <input class="field w-100" type="text" name="noticeTitle"  placeholder="공지사항 제목 입력">
        </div>
        <div class="cell my-40">
            <label class="p-10">본문</label>
            <textarea name="noticeContent" ></textarea>
        </div>
        <div class="cell">
            <button type="submit" class="btn btn-positive w-100">작성하기</button>
        </div>
        </form>
    </div>
        

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>   