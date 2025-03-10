package com.kh.semiproject.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class PlaceReviewDto {
	private int placeNo;
    private String placeTitle;
    private String placeOverview;
    private int placeFirstImage;
    private double avgReviewStar;
}
