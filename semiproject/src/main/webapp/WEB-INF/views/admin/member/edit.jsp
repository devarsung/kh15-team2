<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-800">
	<form action="edit" method="post" autocomplete="off">
		
	    <div class="cell center">
	        <h1>"testuser1" 정보 수정</h1>
	    </div>
	    <div class="cell mt-50 center">
	        <img src="https://placehold.co/150x150" style="border-radius: 50%; width: 300px; height: 300px;">
	    </div>
	    <div class="cell">
	        <table class="table table-border">
	            <tr>
	                <th>ID</th>
	                <td class="field">
	                	<input class="field w-100" type="text" value="testuser1" disabled>
	                	<input type="hidden" name="memberId" value="${memberDto.memberId}">
                	</td>
	            </tr>
	            <tr>
	                <th>닉네임</th>
	                <td>
	                	<input class="field w-100" type="text" name="memberNickname" value="${memberDto.memberNickname}">
                	</td>
	            </tr>
	            <tr>
	                <th>생년월일</th>
	                <td>
	                	<input class="field w-100" type="date" name="memberBirth" value="${memberDto.memberBirth}">
	                </td>
	            </tr>
	            <tr>
	                <th>성별</th>
	                <td>
	                	<select class="field w-100" name="memberLevel">
							<option ${memberDto.memberGender == 'M' ? 'selected' : ''} value="M">남자</option>
							<option ${memberDto.memberGender == 'F' ? 'selected' : ''} value="F">여자</option>
						</select>
	                </td>
	            </tr>
	            <tr>
	                <th>연락처</th>
	                <td>
	                	<input class="field w-100" type="tel" name="memberContact" value="${memberDto.memberContact}">
	                </td>
	            </tr>
	            <tr>
	                <th>이메일</th>
	                <td>
	                	<input class="field w-100" type="email" name="memberEmail" value="${memberDto.memberEmail}">
	                </td>
	            </tr>
	            <tr>
	                <th rowspan="3">주소</th>
	                <td>
	                	<input class="field w-25" type="text" name="memberPost" size="6" placeholder="우편번호" value="${memberDto.memberPost}">
	                </td>
	            </tr>
	            <tr>
	                <td>
	                	<input class="field w-100" type="text" name="memberAddress1" size="60" placeholder="기본주소" value="${memberDto.memberAddress1}">
	                </td>
	            </tr>
	            <tr>
	                <td>
	                	<input class="field w-100" type="text" name="memberAddress2" size="60" placeholder="상세주소" value="${memberDto.memberAddress2}">
	                </td>
	            </tr>
	            <tr>
	                <th>등급</th>
	                <td>
	                	<select class="field w-100" name="memberLevel">
							<option ${memberDto.memberLevel == '일반회원' ? 'selected' : ''}>일반회원</option>
							<option ${memberDto.memberLevel == '관리자' ? 'selected' : ''}>관리자</option>
						</select>
	                </td>
	            </tr> 
	        </table>  
	    </div>
	
	    <div class="cell right">
	        <button type="submit" class="btn btn-neutral">회원정보 수정</button>
	    </div>
    </form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>    