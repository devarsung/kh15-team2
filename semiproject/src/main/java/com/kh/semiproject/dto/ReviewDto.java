package com.kh.semiproject.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class ReviewDto {
	private int reviewNo;
	private String reviewTitle;
	private String reviewContent;
	private int reviewLike;
	private int reviewRead;
	private int reviewReply;
	private Timestamp reviewWtime;
	private Timestamp reviewEtime;
	private String reviewWriter;
	private String reviewPlace;
}
