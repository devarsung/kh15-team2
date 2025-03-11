package com.kh.semiproject.dto;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class ReviewPlaceMemberListViewDto {
	
	private int reviewNo;
	private String reviewTitle;
	private int reviewLike;
	private int reviewRead;
	private int reviewStar;
	private Timestamp reviewWtime;
	private String reviewWriter;
	private int reviewPlace;

	private String memberId;
	private String memberNickname;
//	
	private int placeNo;
	private String placeTitle;
	
	//private int totalLikesAndReads;
	public String getWtimeString() {
		LocalDate today = LocalDate.now();
		LocalDateTime wtime = reviewWtime.toLocalDateTime();
		LocalDate wdate = wtime.toLocalDate();
		if(wdate.isBefore(today)) {
			return wdate.toString();
		}
		else {
			return wtime.toLocalTime().format(DateTimeFormatter.ofPattern("HH:mm"));
		}
	}	
	
	public String getEtimeString() {
		LocalDate today = LocalDate.now();
		LocalDateTime wtime = reviewWtime.toLocalDateTime();
		LocalDate wdate = wtime.toLocalDate();
		if(wdate.isBefore(today)) {
			return wdate.toString();
		}
		else {
			return wtime.toLocalTime().format(DateTimeFormatter.ofPattern("HH:mm"));
		}
	}	
}
