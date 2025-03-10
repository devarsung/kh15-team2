package com.kh.semiproject.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class ReviewPlaceMemberListViewDto {
	private String memberId;
	private String memberNickname;
	
	private int reviewNo;
	private String reviewTitle;
	
	private int placeNo;
	private String placeTitle;
	
}
