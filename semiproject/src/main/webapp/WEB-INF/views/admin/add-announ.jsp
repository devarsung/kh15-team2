<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>



<jsp:include page="/WEB-INF/views/template/experiment.jsp"></jsp:include>

	
	

	<form enctype="application/x-www-form-urlencoded"></form>
    <div class="container w-800">
        <div class="cell center">
            <h1>공지 작성</h1>
        </div>
        
        <form action="" method="post">
        <div class="cell center">
           
            <input class="field w-100" type="text" name="" placeholder="제목">
        </div>
        
            <div class="cell my-40">
            <textarea name="boardContent"></textarea>
        </div>

        <div class="cell">
            <button type="submit" class="btn btn-positive w-100">작성하기</button>
        </div>
        </form>
    </div>