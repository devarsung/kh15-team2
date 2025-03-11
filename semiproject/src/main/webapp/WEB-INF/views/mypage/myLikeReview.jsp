<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" type="text/css" href="/css/myLikeReview.css">
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script type="text/javascript">

</script>


<div class="container w-1000">
    <div class="cell center">
        <h1>내가 좋아요한 후기</h1>
    </div>
    
    <jsp:include page="/WEB-INF/views/template/mypage-tab.jsp">
	  	<jsp:param name="menu" value="myLikeReview"/>
	</jsp:include>



    <div class="cell mt-50">
        <table class=" tableStyle">
            <thead>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                	<th>작성일</th>
                    <th>조회수</th>
                    <th>좋아요</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${reviewLikeList.isEmpty()}">
                        <tr>
                            <td colspan="6" align="center">좋아요한 후기가 없습니다.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="review" items="${reviewLikeList}" varStatus="status">
                            <tr>
                                <td class="center">${status.index + 1}</td>
                                <td><a href="/review/detail?reviewNo=${review.reviewNo}" class="titleStyle">${review.reviewTitle}</a></td>
                                <td class="center">${review.reviewWriter}
                                <td class="center"><fmt:formatDate value="${review.reviewWtime}" pattern="yyyy-MM-dd"/></td>
                                <td class="center">${review.reviewRead}</td>
                                <td class="center">${review.likeCount}</td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
    <div class="cell center">
    	<a href="#" class="aStyle">더보기+</a>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>