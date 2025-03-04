package com.kh.semiproject.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class PlaceLikeDto {
	 private int placeNo;
	 private int likeCount;//여행지 좋아요 수
}
