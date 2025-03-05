package com.kh.semiproject.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class PlaceDto {
	private int placeNo;
	private String placeTitle;
	private String placeOverview;
	private String placePost;
	private String placeAddress1;
	private String placeAddress2;
	private int placeLike;
	private int placeReview;
	private Timestamp placeWtime;
	private Timestamp placeEtime;
	private String placeRegion;
	private String placeWriter;
	private Double placeLat;
	private Double placeLng;
	private String placeType;
	private int placeFirstImage;
}
