<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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
                <tr>
                    <td>testuser1</td>
                    <td>
                    	<%-- <a href="detail?memberId=${memberDto.memberId}">${memberDto.memberNickname}</a> --%>
                    	<a href="detail?memberId=">신짱구</a>
                    </td>
                    <td>2000-10-10</td>
                    <td>010-1234-5678</td>
                    <td>xx123@g.com</td>
                    <td>2025-01-01</td>
                    <td>일반회원</td>
                </tr>
                <tr>
                    <td>testuser1</td>
                    <td>
                    	<%-- <a href="detail?memberId=${memberDto.memberId}">${memberDto.memberNickname}</a> --%>
                    	<a href="detail?memberId=">신짱구</a>
                    </td>
                    <td>2000-10-10</td>
                    <td>010-1234-5678</td>
                    <td>xx123@g.com</td>
                    <td>2025-01-01</td>
                    <td>일반회원</td>
                </tr>
                <tr>
                    <td>testuser1</td>
                    <td>
                    	<%-- <a href="detail?memberId=${memberDto.memberId}">${memberDto.memberNickname}</a> --%>
                    	<a href="detail?memberId=">신짱구</a>
                    </td>
                    <td>2000-10-10</td>
                    <td>010-1234-5678</td>
                    <td>xx123@g.com</td>
                    <td>2025-01-01</td>
                    <td>일반회원</td>
                </tr>
                <tr>
                    <td>testuser1</td>
                    <td>
                    	<%-- <a href="detail?memberId=${memberDto.memberId}">${memberDto.memberNickname}</a> --%>
                    	<a href="detail?memberId=">신짱구</a>
                    </td>
                    <td>2000-10-10</td>
                    <td>010-1234-5678</td>
                    <td>xx123@g.com</td>
                    <td>2025-01-01</td>
                    <td>일반회원</td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>   