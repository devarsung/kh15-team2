<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="/css/change.css">
<style>
</style>

<!-- Lightpick 라이브러리 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/css/lightpick.min.css">
<script src="https://cdn.jsdelivr.net/npm/moment@2.30.1/moment.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/lightpick.min.js"></script>
<!-- kakao post api -->
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script src="/js/mypage/change.js"></script>
<!-- jQuery cdn -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
	
</script>
</head>
<body>
	<div class="container w-800">
		<div class="cell center">
			<h1>내 정보 수정</h1>
		</div>
		<form class="form-check" action="change" method="post"
			enctype="multipart/form-data" autocomplete="off">
			<div class="cell mt-50 center img-container">
				<div class="cell mt-50 center img-container">
					<c:choose>
						<c:when test="${empty attachmentNo}">
							<img id="myPhoto" src="/images/defaultProfile.png">
						</c:when>
						<c:otherwise>
							<img id="myPhoto"
								src="/attachment/download?attachmentNo=${attachmentNo}"
								data-before-src="/attachment/download?attachmentNo=${attachmentNo}">
							<button type="button" id="deleteBtn">
								<i class="fa-solid fa-xmark"></i>
							</button>
						</c:otherwise>
					</c:choose>
				</div>
			</div>

			<div class="cell center">
				<!-- 프로필 삭제 여부를 나타내는 hidden input -->
				<input type="hidden" name="deleteProfile" id="deleteProfile"
					value="false">
			</div>
			<div class=" cell center">
				<input type="hidden" name="profileUpload" id="profileUpload"value="false"> 
				<input type="file" name="memberProfile"class="field w-100 profileInput" accept=".png, .jpg"style="display: none;">
				<button type="button" id="previewBtn">프로필 사진 변경</button>
			</div>

			<div class="cell mt-20">
				<table class="table table-border table-hover">
					<tr>
						<th>ID</th>
						<td class="p-10"><input name="memberId" type="text"
							class="field w-75" value="${memberDto.memberId}" readonly>
						</td>
					</tr>
					<tr>
						<th>닉네임</th>
						<td class="p-10"><input name="memberNickname" type="text"
							class="editInput field  w-75" value="${memberDto.memberNickname}"
							readonly>
							<button type="button" class="editBtn">
								<i class="fa-solid fa-pen-to-square"></i>
							</button>
							<div class="success-feedback blue">사용 가능한 닉네임 입니다</div>
							<div class="fail-feedback red">
								<i class="fa-solid fa-check"></i>닉네임은 한글 또는 숫자 2~10자로 작성하세요
							</div>
							<div class="fail2-feedback red">
								<i class="fa-solid fa-check"></i>이미 사용중인 닉네임 입니다
							</div></td>
					</tr>
					<tr>
						<th>성별</th>
						<td class="p-10"><input name="memberGender" type="text"
							class="field  w-75" value="${memberDto.memberGender}" readonly>
						</td>
					</tr>
					<tr>
						<th>생년월일</th>
						<td class="p-10"><input name="memberBirth" type="text"
							class="editInput field  w-75" value="${memberDto.memberBirth}"
							readonly>
							<button type="button" class="editBtn">
								<i class="fa-solid fa-pen-to-square"></i>
							</button>
							<div class="fail-feedback red">
								<i class="fa-solid fa-check"></i>정확한 생년월일을 입력해주세요(ex)2000-02-20
							</div></td>
					</tr>
					<tr>
						<th>이메일</th>
						<td class="p-10"><input name="memberEmail" type="email"
							class="editInput field  w-75" value="${memberDto.memberEmail}"
							readonly>
							<button type="button" class="editBtn">
								<i class="fa-solid fa-pen-to-square"></i>
							</button>
							<div class="success-feedback">올바른 이메일 형식입니다</div>
							<div class="fail-feedback red">
								<i class="fa-solid fa-check"></i>올바른 형식의 이메일이 아닙니다
							</div></td>
					</tr>
					<tr>
						<th>연락처</th>
						<td class="p-10"><input name="memberContact" type="text"
							class="editInput field  w-75" value="${memberDto.memberContact}"
							readonly>
							<button type="button" class="editBtn ">
								<i class="fa-solid fa-pen-to-square"></i>
							</button>
							<div class="fail-feedback red">
								<i class="fa-solid fa-check"></i>010으로 시작하는 휴대전화번호를 작성하세요
							</div></td>
					</tr>
					<tr>
						<th>주소</th>
						<td class="p-10"><input name="memberPost" type="text"
							class="editInput field  w-75" placeholder="우편번호"
							value="${memberDto.memberPost}" readonly>
							<button type="button" class="editBtn">
								<i class="fa-solid fa-pen-to-square"></i>
							</button> <br> <input name="memberAddress1"
							class="editInput field w-75" placeholder="기본주소"
							value="${memberDto.memberAddress1}" readonly> <br> <input
							name="memberAddress2" class="editInput field w-75"
							placeholder="상세주소" value="${memberDto.memberAddress2}" readonly>
							<div class="fail-feedback">
								<i class="fa-solid fa-check"></i>주소는 모두 작성해야 합니다
							</div></td>
					</tr>
					<tr>
						<th><i class="fa-solid fa-asterisk red"></i> 비밀번호 확인</th>
						<td class="p-10"><input name="memberPw" type="password"
							class="field w-50" placeholder="비밀번호를 확인">
							<div class="fail-feedback">
								<i class="fa-solid fa-check"></i>비밀번호를 입력해주세요
							</div></td>
					</tr>
				</table>
			</div>
			<div class="cell right my-30">
				<a href="/mypage/home" class="btn btn-neutral  mx-10">돌아가기</a>
				<button class="btn btn-positive ms-10" type="submit">변경하기</button>
			</div>

		</form>

	</div>


</body>
</html>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
