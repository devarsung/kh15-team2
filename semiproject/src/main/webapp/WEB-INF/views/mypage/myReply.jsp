<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-1000">
    <div class="cell center">
        <h1>내가 작성한 댓글</h1>
    </div>

    <jsp:include page="/WEB-INF/views/template/mypage-tab.jsp">
	  	<jsp:param name="menu" value="myReply"/>
	</jsp:include>

    <div class="cell mt-50">
        <table class="table table-border table-hover">
            <thead>
                <tr>
                    <th>번호</th>
                    <th>후기 제목</th>
                    <th>댓글 내용</th>
                    <th>작성일</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty myReplyList}">
                        <tr>
                            <td colspan="4" align="center">작성한 댓글이 없습니다.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="reply" items="${myReplyList}" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td><a href="/review/detail?reviewNo=${reply.replyOrigin}">${reply.reviewTitle}</a></td>
                                <td>${reply.replyContent}</td>
                                <td><fmt:formatDate value="${reply.replyWtime}" pattern="yyyy-MM-dd"/></td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
