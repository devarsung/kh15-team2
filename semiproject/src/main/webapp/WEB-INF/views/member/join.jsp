<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

    <!-- Lightpick 라이브러리 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/css/lightpick.min.css">
    <script src="https://cdn.jsdelivr.net/npm/moment@2.30.1/moment.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/lightpick.min.js"></script>

    <!-- kakao post api -->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="/js/member/join3.js"></script>
    <!-- jQuery cdn -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
   <style>
   	 #previewBtn, #deleteBtn{
            border: 1px solid rgb(163, 163, 163);
            background-color: white;
        }
        #previewBtn:hover , #deleteBtn:hover{
            box-shadow: 0 0 2px black;
            cursor: pointer;
        }
   </style>
   <script type = "text/javascript">
    </script>
</head>
<body>
        
    <form class="form-check" action="join" method="post" enctype="multipart/form-data" autocomplete="off">
        <div class="container w-500">
            <div class="cell center">
                <h1>가입 정보 입력</h1>
            </div>
            <div class="cell center">
            <input  type="file" name="memberProfile" class="field w-100" accept=".png, .jpg" style="display: none;">
	        </div>
	        <div class=" cell mt-50 center">
	            <img id="myPhoto" src="https://placehold.co/150x150" style="border-radius: 50%; width: 300px; height: 300px;">
	        </div>
	        <div class="cell center">
	             <button type="button" id="previewBtn" >프로필 사진 등록</button>
	        	<button type="button" id="deleteBtn" ><i class="fa-solid fa-xmark"></i></button>
	        </div>
            <div class="cell">
                <label>아이디 <i class="fa-solid fa-asterisk red"></i></label>
                <input type="text" name="memberId" class="field w-100">
                <div class="success-feedback blue"><i class="fa-regular fa-circle"></i>사용 가능한 아이디입니다.</div>
                <div class="fail-feedback red"><i class="fa-solid fa-check"></i>아이디는 알파벳으로 시작한 숫자포함 5~20자리로 만들어 주세요.</div>
                <div class="fail2-feedback red">이미 사용중인 아이디입니다</div>
            </div>
            <div class="cell">
                <label>비밀번호 <i class="fa-solid fa-asterisk red"></i></label>
                <input type="password" name="memberPw" class="field w-100">
                <div class="success-feedback blue"><i class="fa-regular fa-circle"></i>비밀번호가 올바른 형식입니다</div>
                <div class="fail-feedback red"><i class="fa-solid fa-check"></i>알파벳 대문자, 소문자, 숫자, 특수문자를 반드시 한 글자 이상 포함해서 8~16자로 작성하세요</div>
            </div>
            <div class="cell">
                <label>비밀번호 확인 <i class="fa-solid fa-asterisk red"></i></label>
                <input type="password" id="pw-reinput" class="field w-100">
                <div class="success-feedback blue"><i class="fa-regular fa-circle"></i>비밀번호가 일치합니다</div>
                <div class="fail-feedback red"><i class="fa-solid fa-check"></i>비밀번호가 일치하지 않습니다</div>
                <div class="fail2-feedback red"><i class="fa-solid fa-check"></i>비밀번호가 형식에 맞지 않습니다</div>
            </div>
            <div class="cell">
                <label>닉네임 <i class="fa-solid fa-asterisk red"></i></label>
                <input type="text" name="memberNickname" class="field w-100">
                <div class="success-feedback blue"><i class="fa-regular fa-circle"></i>사용 가능한 닉네임 입니다.</div>
                <div class="fail-feedback red"><i class="fa-solid fa-check"></i>닉네임은 한글 또는 숫자 2~10자로 작성하세요</div>
                <div class="fail2-feedback red"><i class="fa-solid fa-check"></i>이미 사용중인 닉네임 입니다</div>
            </div>
            <div class="cell">
                <label>성별  <i class="fa-solid fa-asterisk red"></i></label>
                <select class="field w-100" name="memberGender">
                    <option value="">선택하세요</option>
                    <option value="M">남자</option>
                    <option value="F">여자</option>
                </select>
                <div class="success-feedback blue"></div>
                <div class="fail-feedback red"><i class="fa-solid fa-check"></i>성별을 선택해주세요</div>
            </div>
            
            
            <div class="cell">
                <label style="display:block;">이메일 <i class="fa-solid fa-asterisk red"></i></label>
 	        	<input type="email" inputmode="email" name="memberEmail" class="field">
	             <div class="success-feedback"><i class="fa-regular fa-circle"></i>올바른 이메일 형식입니다</div>
	 	    	 <div class="fail-feedback red"><i class="fa-solid fa-check"></i>올바른 형식의 이메일이 아닙니다</div>
 	        	<button type="button" class="btn btn-neutral btn-send-cert">
 	        	<i class="fa-solid fa-paper-plane"></i>
 	        	<span>인증메일 발송</span>
 	        	</button>
 	    </div>
 	    <div class="cell cert-input-wrapper" style="display:none;">
 	    	<input type="text" inputmode="numeric" class="field"
 	    				name="certNumber" placeholder="인증번호 입력">
 	    	<button type="button" class="btn btn-positive btn-confirm-cert">
 	    		<i class="fa-solid fa-check"></i>
 	    		<span>인증 확인</span>
 	    	</button>
                <div class="success-feedback"><i class="fa-regular fa-circle"></i>인증번호가 일치합니다</div>
                <div class="fail-feedback red"><i class="fa-solid fa-check"></i>인증번호가 일치하지않습니다</div>
            </div>
            
            
            
            
            
            <div class="cell">
                <label>생년월일<i class="fa-solid fa-asterisk red"></i></label>
                <input type="text" name="memberBirth" class="field w-100">
                <div class="fail-feedback red"><i class="fa-solid fa-check"></i>정확한 생년월일을 입력해주세요(ex)2000-02-20</div>
            </div>
            <div class="cell">
                <label>전화번호</label>
                <input type="tel" name="memberContact" class="field w-100">
                <div class="fail-feedback red"><i class="fa-solid fa-check"></i>010으로 시작하는 휴대전화번호를 작성하세요</div>
            </div>
            <div class="cell">
                <label>주소</label>
            </div>
            <div class="cell">
                <input type="text" name="memberPost" size="6" maxlength="6" class="field" placeholder="우편번호" readonly>
                <button type="button" class="btn btn-neutral btn-address-search">
                    <i class="fa-solid fa-magnifying-glass"></i>
                </button>
                <button type="button" class="btn btn-negative btn-address-clear"
                                                                            style="display: none;">
                        <i class="fa-solid fa-trash"></i>
                    </button>
                </div>
                <div class="cell">
                    <input type="text" name="memberAddress1" class="field w-100" placeholder="기본주소" readonly>
                </div>
                <div class="cell">
                    <input type="text" name="memberAddress2" class="field w-100" placeholder="상세주소">
                    <div class="fail-feedback"><i class="fa-solid fa-check"></i>주소는 모두 작성해야 합니다</div>
                </div>
        
                <div class="cell mt-30">
                    <button type="submit" class="btn btn-positive w-100">회원가입</button>
                </div>
            </div>
        </form>
    
    
        </form>
    
</body>
</html>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>