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
	private int placeRead;
	private String placeTel;//문의전화
	private String placeWebsite;//홈페이지
	private String placeParking;//주차가능여부
	private String placeOperate;//운영일,운영시간 등
	
	//문의,홈페이지,주차가능여부,운영일 중 하나라도 있는지 없는지 확인
	public boolean getHasInfo() {
		return this.placeTel != null ||this.placeWebsite != null 
				|| this.placeParking != null || this.placeOperate != null;
	}
}
