package com.kh.semiproject.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class NoticeDto {
	private int noticeNo;
	private String noticeTitle;
	private String noticeContent;
	private Timestamp noticeWtime;
	private Timestamp noticeEtime;
	private String noticeWriter;
	
}
