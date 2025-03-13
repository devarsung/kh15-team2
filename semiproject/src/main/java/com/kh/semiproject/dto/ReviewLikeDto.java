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
public class ReviewLikeDto {
	private int reviewNo;
	private int likeCount;//후기 좋아요수
	
	private String reviewTitle;
	private String reviewWriter;
	private Timestamp reviewWtime;
	private int reviewRead;
	//private Timestamp reviewLikeTime;
	
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