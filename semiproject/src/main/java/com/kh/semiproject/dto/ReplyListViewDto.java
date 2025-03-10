package com.kh.semiproject.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class ReplyListViewDto {
	private int replyNo;
	private String replyWriter;
	private int replyOrigin;
	private String replyContent;
	private Timestamp replyWtime;
	private Timestamp replyEtime;
	
	private String memberId;//아이디
	private String memberNickname;//닉네임
}

