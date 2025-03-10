<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h2><a href="myLikeReview">내가 좋아한 리뷰 목록</a></h2>

<jsp:include page="/WEB-INF/views/template/mypage-tab.jsp">
  	<jsp:param name="menu" value="myLikeReview"/>
</jsp:include>

${reviewLikeList}

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>