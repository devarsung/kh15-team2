<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h2><a href="myLikePlace">내가 좋아한 여행지 목록</a></h2>

<jsp:include page="/WEB-INF/views/template/mypage-tab.jsp">
  	<jsp:param name="menu" value="myLikePlace"/>
</jsp:include>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>