package com.kh.semiproject.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class ReviewLikeDto {
	private int reviewNo;
	private int likeCount;//후기 좋아요수
}
