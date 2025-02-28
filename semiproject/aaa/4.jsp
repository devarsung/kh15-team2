<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
  
  
  <!--google font-->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

<!--font awesome cdn-->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
  
   <!-- jQuery-->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    

   <!-- summernote cdn -->
   <link href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.css" rel="stylesheet">
   <script src="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.js"></script>
  
    <div class="container w-500">
        <div class="cell center">
            <h1>공지 리스트</h1>
        </div>
        <div class="cell right">
            <a href="#" class="btn btn-neutral">공지 등록</a>
        </div>
        <div class="cell">
            <table class="table table-border table-stripe">
                <thead>
                    <tr>
                        <th>글번호</th>
                        <th >제목</th>
                        <th>작성일</th>
                    </tr>
                </thead>
                <tbody class="center">
                    <tr>
                        <td>1</td>
                        <td >공지사항</td>
                        <td><fmt:formatDate value="${시간}" 
                                            pattern="y년 M월 d일 a h시 m분 s초"/></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="cell center mt-30">
            &lt; 1 2 3 4 5 6 7 8 9	&gt;
        </div>
        <div class="cell center">
            <form action="list" method="get">
                <select name="column" class="field">
                    <option value="" ${param.column == '' ? 'selected' : ''}>제목</option>
                    <option value="" ${param.column == '' ? 'selected' : ''}>작성자</option>
                </select>
                <input type="text" name="keyword" value="" class="field w-50">
                <button class="btn btn-positive">검색</button>
            </form>
        </div>
    </div>