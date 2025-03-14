package com.kh.semiproject.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class MemberDto {
	private String memberId;// 아이디
	private String memberPw;// 비밀번호
	private String memberNickname;// 닉네임
	private String memberBirth; // 생년월일
	private String memberGender;// 성별
	private String memberContact;// 전화번호
	private String memberEmail;// 이메일
	private String memberPost;// 우편번호
	private String memberAddress1;// 기본주소
	private String memberAddress2;// 상세주소
	private String memberLevel;// 회원등급
	private Timestamp memberJoin;// 회원가입일
	private Timestamp memberLogin;// 최종로그인일
	private Timestamp memberChange;// 비밀번호변경일
}
