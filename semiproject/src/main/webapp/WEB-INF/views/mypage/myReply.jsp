<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<jsp:include page="/WEB-INF/views/template/mypage-tab.jsp">
  	<jsp:param name="menu" value="myReply"/>
</jsp:include>

<div class="container w-1000">
    <div class="cell center">
        <h1>내가 작성한 댓글</h1>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
