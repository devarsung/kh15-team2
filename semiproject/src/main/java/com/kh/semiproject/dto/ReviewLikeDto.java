package com.kh.semiproject.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class ReviewLikeDto {
	private int reviewNo;
	private int likeCount;//후기 좋아요수
	
	private String reviewTitle;
	private String reviewWriter;
	private Timestamp reviewWtime;
	private int reviewRead;
	//private Timestamp reviewLikeTime;
}
