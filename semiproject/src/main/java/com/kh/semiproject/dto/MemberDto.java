package com.kh.semiproject.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @ AllArgsConstructor
public class MemberDto {
	private String memberId;//아이디
	private String memberPw;//비밀번호
	private String memberNickname;//닉네임
	private String memberBirth;//생년월일
	private String memberGender;//성별
}
