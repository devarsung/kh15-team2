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

    <div class="cell">
        <table class="table table-border table-hover">
            <thead>
                <tr>
                    <th>번호</th>
                    <th>후기 제목</th>
                    <th>댓글 내용</th>
                    <th>작성일</th>
                    <th>바로가기</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${list==null}">
                        <tr>
                            <td colspan="5" align="center">작성한 댓글이 없습니다.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="replyDto" items="${list}">
                            <tr>
                                <td>${reply.replyNo}</td>
                                <td>
                                    <a href="/review/detail?reviewNo=${reply.replyOrigin}">후기 보기</a>
                                </td>
                                <td>${reply.replyContent}</td>
                                <td><fmt:formatDate value="${reply.replyWtime}" pattern="yyyy-MM-dd"/></td>
                                <td>
                                    <a href="/review/detail?reviewNo=${reply.replyOrigin}" class="btn btn-primary">
                                        보기
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>