<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-1000">
    <div class="cell center mb-50">
        <h1>회원 목록 및 검색</h1>
    </div>
    <!-- 검색창 -->
	<div class="cell right">
        <form action="list" method="get" autocomplete="off">
            <select name="column" class="field">
                <option value="member_id">아이디</option>
				<option value="member_nickname">닉네임</option>
				<option value="member_birth">생년월일</option>
				<option value="member_contact">연락처</option>
				<option value="member_email">이메일</option>
            </select>
            <input type="search" name="keyword" class="field" value="">
            <button type="submit" class="btn btn-neutral">검색</button>
        </form>
    </div>
    
    <div class="cell center">
        <table class="table table-border table-hover">
            <thead>
                <tr>
                	<th>아이디</th>
                    <th>닉네임</th>
                    <th>생년월일</th>
                    <th>연락처</th>
                    <th>이메일</th>
                    <th>가입일</th>
                    <th>등급</th>
                </tr>
            </thead>
            <tbody>
            	<c:choose>
            		<c:when test="${list.isEmpty()}">
            			<tr >
							<td colspan="7">검색 결과가 없습니다</td>
						</tr>
            		</c:when>
            		<c:otherwise>
            			<c:forEach var="memberDto" items="${list}">
            				<tr>
			                    <td>${memberDto.memberId}</td>
			                    <td>
			                    	<a href="detail?memberId=${memberDto.memberId}">${memberDto.memberNickname}</a>
			                    </td>
			                    <td>${memberDto.memberBirth}</td>
			                    <td>${memberDto.memberContact}</td>
			                    <td>${memberDto.memberEmail}</td>
			                    <td>
			                    	<fmt:formatDate value="${memberDto.memberJoin}" pattern="yyyy-MM-dd"/>
			                    </td>
			                    <td>${memberDto.memberLevel}</td>
			                </tr>
            			</c:forEach>
            		</c:otherwise>
            	</c:choose>
            </tbody>
        </table>
    </div>
</div>

<!-- 페이지 네비게이터 -->
	<div class="cell center">
		<jsp:include page="/WEB-INF/views/template/pagination.jsp"></jsp:include>
	</div>
	
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>   